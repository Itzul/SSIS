
## Flygga i SSIS med FlightData i USA från 2003-2008
## Datafångst, migrering och förädling 

### Itzul L. Vergara 
### Lärare: Mikael Lönnroos
______________________


### "Background: 

Ni har fått data som innehåller alla kommersiella inrikesflygningar i USA mellan 2003-2008; totalt cirka 4GB data. Studentportalen klarar inte så mycket data, så jag lade upp datat här istället: *http://www.skg.nu/AirlineData.zip* (denna web har inget certifikat, så den klarar tyvärr inte krypterad https). Tänk på att ni alltså behöver utrymme att lagra csv-filerna både när de hämtas och packas upp, men då de även ska tankas in i databasen så måste det även finnas utrymme för databas och dess mdf- och ldf-filer...

..."

<img width="482" alt="image" src="https://user-images.githubusercontent.com/19158658/169914851-f742a6f4-8294-41fa-a96c-0404cbccce75.png">

#### *Olika källor:*
* https://carlson-hoo.medium.com/data-expo-2009-airline-on-time-performance-analysis-bb2e5bcf3042 
* http://stat-computing.org/dataexpo/2009/the-data.html
 
______

### Intro

#### SSIS delen står delat i tre olika DB:

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








