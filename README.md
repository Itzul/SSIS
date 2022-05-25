
## Flyg med SSIS 
### FlightData i USA från 2003-2008 - Datafångst, migrering och förädling 

### Itzul L. Vergara 
______________________


### Bakgrund: 

"Ni har fått data som innehåller alla kommersiella inrikesflygningar i USA mellan 2003-2008; totalt cirka 4GB data. Studentportalen klarar inte så mycket data, så jag lade upp datat här istället: *http://www.skg.nu/AirlineData.zip* (denna web har inget certifikat, så den klarar tyvärr inte krypterad https). Tänk på att ni alltså behöver utrymme att lagra csv-filerna både när de hämtas och packas upp, men då de även ska tankas in i databasen så måste det även finnas utrymme för databas och dess mdf- och ldf-filer...

..."
#### Mikael Lönnroos
<img width="482" alt="image" src="https://user-images.githubusercontent.com/19158658/169914851-f742a6f4-8294-41fa-a96c-0404cbccce75.png">

#### *Olika källor:*
* https://carlson-hoo.medium.com/data-expo-2009-airline-on-time-performance-analysis-bb2e5bcf3042 
* http://stat-computing.org/dataexpo/2009/the-data.html
 
______

### Intro

#### Package

* START
* 0.Databaser
* I.SourceSystems
* II.StagingArea
* III.DW

#### SSIS delen består av tre olika DB:

* I.SourceSystems
* II.StagingArea
* III.DW

För varje DB skapade jag ett *package* i SSIS med sina respektiva *dataflow*.  
OBS! Path av Data är: C:\Airlines\Airlines och för SuppData är: C:\Airlines\Suppdata

Det finns två pakage till. Package START som initiera allt samt 0. Databaser som inehåller koden som skapa DB och tabeller:
#### START 
<img width="330" alt="image" src="https://user-images.githubusercontent.com/19158658/170233610-a8252da4-15fd-4099-b4a7-ac700b39a302.png">

#### 0.Databaser
<img width="152" alt="image" src="https://user-images.githubusercontent.com/19158658/170234161-9ff3ec50-cf9d-4b21-8db6-eade3fcc255a.png">



### I.SourceSystems
#### Första steg: hämta data!

<img width="493" alt="image" src="https://user-images.githubusercontent.com/19158658/169915301-934cb825-f1d7-43d0-bfbf-39e553d37851.png">
Arkivet består av sex stora filer utan format som fungerar som csv-filer och motsvarar åren 2003-2008 med ungefär 42 miljoner rader. Det finns också tre små csv-filer bestående av information om flygplatser, flygplan och carrier.


I varje *package* började jag med en *Truncate table* för att undvika dubbletter. Efter det skapade jag en *ForeachLoop* som anropar tabeller genom åren. I den här delen använde jag *suggest type* för att räkna och bestämma vilken *datatype* jag skulle använda. Totalt undersökes 200,000 rader för att nå lite mer noggrannhet.  
Efter det körde jag samtidigt de andra tabellerna för att effektivisera processen. Jag gjorde en extra process i Data-plane för den tabellen hade citattecken i några kolumner medan andra inte hade det. Då behövde jag hantera *Flat File Connection Manager Editor* *column delimiter: Mixed.* Men den räckte inte och för att testa datan skapades en *flat file* med dem som inte följde strukturen genom att *redirect row*. Sedan valdes de igen  och jag fixade datatyperna och raderade citattecken om dem forfarande fanns kvar. Likadan process gjorde jag med Carrier. Obs! Man behöver inte skapa en till .txt file, men jag ville prova det. 

<img width="433" alt="image" src="https://user-images.githubusercontent.com/19158658/169920051-95f9a011-10d5-4b5a-93c9-ceafdc67d6e1.png">

### II.StagingArea
#### Andra steget: Transformera data!

<img width="590" alt="image" src="https://user-images.githubusercontent.com/19158658/169920256-fef8f6eb-55b9-47ab-974e-e165a4eb8f05.png">


I varje *package* började jag med en *Truncate table* som undviker dubbletter. Efter det hämtade jag data från SourceSystems DB och började redigera enligt inlämningsuppgiften:

<img width="660" alt="image" src="https://user-images.githubusercontent.com/19158658/169990096-b04d5cd2-92d4-43d6-9e12-43b140a5189d.png">

Jag ritade några boxar för att tydliggöra min process och jag försökte att i varje Package hålla en struktur med nivåer för att ha ordning. Grön box är transformationer, blå box är conditional split och lila är ”NA”- tabell. 

Jag satte igång transformationen genom att kontrollera *CancellationCode* i *Derived Column*. Först nu kontrollerades alla null-värde och konverterades till ”N” och sen kontrollerades alla ”NA” till ”N”(Jag kunde göra det i samma element men jag ville göra så för att kunna använda *Data viewer* och kolla att allt stämde). Efter det använde jag *conditional split* för att filtrera, de som hade Null eller NA skulle gå till ”NA-Tabell” (lila boxen). 
  
  *CRSDepTime, CRSArrTime, ArrTime, och DepTime* förvandlades till datatyp TIME samt datum DATE och jag ville också att ha dem som INT för att kunna använda dem som en PK i nästa steg. Då först kontrollerades att de hade korrekt längd och att de var String (för att jag ville addera ':' i *Derived Column* och en ifsats med substring för att ha den rätta strukturen innan jag konverterade till tidtype). Jag gjorde något likande med Datum, som hanterades samtidigt som tidtype (men istället för att addera ':' adderade jag '-' så att datumet blev yyyy-mm-dd). De som hade en annan struktur  plockades till min slasktabell "NA".
   Efter det var min data  redo att skapa en ny tabell som var grunden till Faktatabell. Det var tid att transformera och fingöra de andra tabellerna som  användes  som dimensioner i nästa steg. I Carrier data  kontrollerade jag att alla NULL-VÄRDE ändrades till 'NA'. Jag bytte namn från kolumn Code till CarrierID för att tydliggöra nästa steg med PK och FK. Jag hanterade på samma sätt Airport data och bytte namn på några kolumner till: 
   
   <img width="482" alt="image" src="https://user-images.githubusercontent.com/19158658/170046928-340fefbd-0437-4700-a80a-22c88a2e3eee.png">

I Planedata skedde samma process och jag bytte några år som hade 'NONE' till 'NA'. RoutesData var en ny tabell som kom fram med hjälp av två Sqlcomander. Efter det upptäckte jag att mina null-värde i CancellationCode inte hade ändrats till "N" så jag behövde skriva en kod till i det element som heter "Detaljer" och nu var jag redo! 


### III.DW
#### Sista steg: StarSchema!


<img width="773" alt="image" src="https://user-images.githubusercontent.com/19158658/170050750-b59a8156-423f-4fe0-912d-a052bb5d1646.png">

Jag började som vanligt att tömma tabellerna och den här gången  behövde jag radera  PK som jag  framkallade när jag skapade nya tabeller. Jag använde  *Sequence Container* för att kunna optimera processen med Factatabell och Dimensioner. Processen började med FactaTabell som  inte hade RoutesID så då behövde jag använda en *Lookup* för att addera till FactaTabell kolumnen *RoutesID* Efter det lagrade jag tabellen som *FactFlights* och skapade en till kolumn med  *Indentity(1,1)*. Jag skapade  DimDate med SQLkod. För att kunna göra en bra DimRoutes använde jag två *lookup* med Airports. Första lookup var för att hantera ursprung och andra var för att hantera destinationer.  
När jag  trodde att var redo började jag framkalla *Foreing keys* men upptäckte jag att DimPlanes inte var  klar, dvs att inte alla *
flygplan* var i Factatabell och därför kunde jag inte skapa en relation mellan dem. Då kunde jag använda *Lookup* men det var enklare att skriva koden
Jag skapade en tabell i DB StagingArea och sen adderade jag kolumner för att kunna göra en *union* med min gamla tabell *Planes* och framkallade den nya tabellen som DimRoutes som hade koppling med min Faktatabell. Jag skrev några rader för att identifiera den nya datan som inte var med i DimPlane. Sedan  framkallade jag alla mina FK med SQLkoden och mitt StarSchema ser ut så här: 
<img width="713" alt="image" src="https://user-images.githubusercontent.com/19158658/170056624-95b59c1c-ebe7-4c8a-bfd2-f0c6a27ace36.png">

#### Då är vi redo för SSAS!
