
## Flygga i SSIS med FlightData i USA från 2003-2008
## Datafångst, migrering och förädling 

### Itzul L. Vergara 
______________________


### "Background: 

Ni har fått data som innehåller alla kommersiella inrikesflygningar i USA mellan 2003-2008; totalt cirka 4GB data. Studentportalen klarar inte så mycket data, så jag lade upp datat här istället: *http://www.skg.nu/AirlineData.zip* (denna web har inget certifikat, så den klarar tyvärr inte krypterad https). Tänk på att ni alltså behöver utrymme att lagra csv-filerna både när de hämtas och packas upp, men då de även ska tankas in i databasen så måste det även finnas utrymme för databas och dess mdf- och ldf-filer...

..."
#### Mikael Lönnroos
<img width="482" alt="image" src="https://user-images.githubusercontent.com/19158658/169914851-f742a6f4-8294-41fa-a96c-0404cbccce75.png">

#### *Olika källor:*
* https://carlson-hoo.medium.com/data-expo-2009-airline-on-time-performance-analysis-bb2e5bcf3042 
* http://stat-computing.org/dataexpo/2009/the-data.html
 
______

### Intro

#### SSIS delen består av tre olika DB:

* I.SourceSystems
* II.StagingArea
* III.DW

För varje DB skappade en package i SSIS med sina respektiva *dataflow*. Åtminstone  finns det  en  package till som skappar hela DB och tabeller innan de blir kallat för de andra package, den package har varit dopt som "0.Databaser" och man måste köra den innan man anropar på dem andra package. 


### I.SourceSystems
#### Första steg: hämta data!

<img width="493" alt="image" src="https://user-images.githubusercontent.com/19158658/169915301-934cb825-f1d7-43d0-bfbf-39e553d37851.png">
Arkivet består av sex stora filer utan format som fungerar som csv-filer och motsvarar till året 2003-2008 med ungefar 42 milljoner rader. Det finns också tre små csv-filer som behåller information om flygplatser, aeroplanen och carrier.


I varje *package* börjar jag med en *Truncate table* som undviker dubbletter. Efter det skapade jag en *ForeachLoop* som anropar tabeller med året. I den här delen använder jag suggest type också för att räkna och bestämma vilken Datatype ska jag använda. Undersökes 200,000 rader för att nå lite mer noggrannhet.  
Efter det kör jag samtidigt de andra tabellerna för att effektivisera processen. Jag gjorde extra processen i Data-plane för att den tabellen hade citation tecken i några kolumner men andra hade inte det. Då behövde jag hantera *Flat File Connection Manager Editor* column delimiter: Mixed. Men den räckte inte och för att prova skapade en *flat file* med de som flöjde inte strukturen genom att *redirect row* och tog de igen och fixa datatyper och radera citationstecken om den fanns förfarande. Likadan process gjorde jag med Carrier. Obs! Man behöver inte skapa en till .txt file, men jag ville prova den. 

<img width="433" alt="image" src="https://user-images.githubusercontent.com/19158658/169920051-95f9a011-10d5-4b5a-93c9-ceafdc67d6e1.png">

### II.StagingArea
#### Andra steg: Transform data!

<img width="590" alt="image" src="https://user-images.githubusercontent.com/19158658/169920256-fef8f6eb-55b9-47ab-974e-e165a4eb8f05.png">


I varje *package* börjar jag med en *Truncate table* som undviker dubbletter.Efter det ska jag hämta data från SourceSystems DB och börjar redigera enligt inlämningsuppgiften:

<img width="660" alt="image" src="https://user-images.githubusercontent.com/19158658/169990096-b04d5cd2-92d4-43d6-9e12-43b140a5189d.png">

Jag ritade några boxer för att tydligt förklara min process och jag försökte i varje Package hålla en struktur med nivåer för att ha lite ordning i processen. Grönbox är transformationer, blåbox är conditional split och violeta är ”NA”- tabell. 

Jag igångsatte transformationen med att kontrollera *CancellationCode* i *Derived Column*. Först kontrollerade alla null-värde och konverterade till ”N” och sen kontrollerade alla ”NA” till ”N”(Jag kunde göra det i samma element men jag ville så för att kunna använda *Data viewer* och kolla att allt stämmer)  Efter det använde jag *conditional split* för att filtrera, de som hade Null eller NA skulle gå till ”NA-Tabell” (violetaboxen). 
  
  *CRSDepTime, CRSArrTime, ArrTime, och DepTime* ska blir data typ TIME samt Date ska bli date och jag vill också att ha den som INT för att kunna anvädna den som en PK i nästa steg. Då blir först kontrollera att de har korrekt längt och att de är String (för att jag vill addera ':' i Derived Column och en ifsats med substring för att ha rätt strukturen innan jag konverterade till tidtype). Jag gjorde något likande med Date, som hanterade samtidigt som tidtype (men istället för att addera ':' jag adderade '-' då datumet blev yyyy-mm-dd). De som hade andra strukturen var plockat till min slask tabell "NA".
   Efter det min data var redo att skapa en ny tabell som kommer att använda sig som Factatabell. Det var tid att transformera och fingöra de andra tabeller som kommer att använda sig som dimensioner i nästa steg. I Carrier data jag kontrollerade att alla NULL-VÄRDE var ändras till 'NA'. Jag byte nämn från column Code till CarrierID för att tydligtgöra nästa steg med PK och FK. Jag hanterade på samma sätt Airport data och byte namn på några kolumner till: 
   
   <img width="482" alt="image" src="https://user-images.githubusercontent.com/19158658/170046928-340fefbd-0437-4700-a80a-22c88a2e3eee.png">

I Planedata var lite samma process. Jag byte några år som hade 'NONE' till 'NA'. RoutesData var en ny tabell som kom fram med hjälp av två Sqlcomander: *SELECT DISTINCT Origin, Dest AS Destination, Distance FROM DataFlight.* Jag lagrade en ny tabell som hette: "Routes" och sen skapade en till Sqlcommand som gjorde en kolumn till med identity för att kunna indexera den:*"ALTER TABLE Routes ADD RouteID int identity(1,1.)* Efter det jag var redo för att skappa min StarSchema i  en ny DB DW, men uptäkte jag att mina null-värde i CancellationCode hade inte ändrats till "N" då behövde skriva en code till: "" för att ändra de, i den element som heter "Detaljer" och nu var jag redo! 

### III.DW
#### Sista steg: StarSchema!


<img width="773" alt="image" src="https://user-images.githubusercontent.com/19158658/170050750-b59a8156-423f-4fe0-912d-a052bb5d1646.png">

Sista steget var min favorit! Jag började som vanligt att tomma tabellerna och den har gången jag behövde innan dess radera också PK som kommer jag att framkalla när jag skapar nya tabeller. Jag använder också Sequence Container för att kunna optimisera processen med Factatabell och Dimensioner. Processen börjades med FactaTabell som hade inte RoutesID då behövde använda en *Lookup* för att addera till min  kära FactaTabell kolumnen *RoutesID* Efter det lagrade jag tabellen som *FactFlights* och skapade en till kolumn som gjorde jag innan med Routes *Indentity(1,1)*. Jag skapade en tabell tid som DimDate med SQLcode, som kommer att använda sig i SSAS process. För att kunna göra en bra DimRoutes använde jag två *lookup* med Airports. Första lookup var för att hantera ursprung och andra var för att hantera målet.  
När jag  trodde att var redo började framkalla *Foreing keys* men uptäkte jag att DimPlanes var inte klar, dvs inte alla *
flygplan* var i Factatabell och därför jag kunde inte skapa en relation mellan de. Då kunde använda *Lookup* men det var enklare skriva coden: *Select Tailnumber into DimPlaneO from FactFlight a where Tailnumber IS NULL OR
not exists (select 1 from StagingArea.dbo.PlaneData b where b.TailNumber= a.Tailnumber)* Jag skapade en tabell i DB StagingArea och sen adderade jag kolumner för att kunna göra en *union* med min gamla tabel *Planes* och framkallade den nya tabell som DimRoutes som kunde ha koppling med min Factatabell. Jag skrev några rader för att identifiera den nya data som var inte i DimPlane i Ownertype hittade tex. på "Privat" osv. Efter det framkallade alla mina FK med coden och min StarSchema ser ut så här: 
<img width="713" alt="image" src="https://user-images.githubusercontent.com/19158658/170056624-95b59c1c-ebe7-4c8a-bfd2-f0c6a27ace36.png">

#### Då är vi redo till SSAS!
