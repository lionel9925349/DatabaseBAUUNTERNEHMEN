-- PROJEKT BAUUNTERNEHMEN --

/* 
    Ein  Teilprojekt   hat für Attribut einen Teilprojektnr , eine  Teilprojektname ,eien Budget, 
    eine arbeitsstundenschätzung,teilprojektsAnfang und teilprojektsEnde

*/

create table teilprojekt(
tpnr serial primary key,
tpname varchar(30),
budget money,
arbeitsstundenschätzung integer,
tpAnfang date,
tpEnde date    
);

-- Anbei die Insert into von Teilprojekt

insert into teilprojekt (tpname,budget,arbeitsstundenschätzung,tpAnfang,tpEnde) values ('db strasse',350200,90,'2022-05-12','2023-10-15');
insert into teilprojekt (tpname,budget,arbeitsstundenschätzung,tpAnfang,tpEnde) values ('sparkase strasse',450200,190,'2022-10-16','2023-01-25');
insert into teilprojekt (tpname,budget,arbeitsstundenschätzung,tpAnfang,tpEnde) values ('volksbank strasse',550200,180,'2022-05-12','2023-10-15');
insert into teilprojekt (tpname,budget,arbeitsstundenschätzung,tpAnfang,tpEnde) values ('commerzbank strasse',250200,40,'2022-11-15','2023-07-25');
insert into teilprojekt (tpname,budget,arbeitsstundenschätzung,tpAnfang,tpEnde) values ('targo strasse',750200,70,'2023-05-02','2024-11-11');


/* 
    Beim Unserem Projekt arbeiten viele Mitarbeiter , bei den wir die folgende Informationen erfassen möchten  maNr , AnstellungArt, die NAme
    die Strasse die HAusNr die Plz und zuletzt die position

*/

create table mitarbeiter (
maNr serial primary key,
maAnstellungNr integer,    
maName varchar(30),
maStr varchar(30),
maHnr integer,
maPlz integer,
maPosition varchar(30)  ,
constraint m_maAnstellungNr foreign key (maAnstellungNr)    references anstellungsart (anstellungsartNr)
);


-- Insert Into Von Mitarbeiter--

insert into mitarbeiter (maAnstellungNr,maName,maStr,maHnr,maPlz,maPosition) values(1,'noumi','eichendorfrigstr',32,35394,'Wachposten');
insert into mitarbeiter (maAnstellungNr,maName,maStr,maHnr,maPlz,maPosition) values(1,'fally','kirchestr',42,35345,'Wachposten');
insert into mitarbeiter (maAnstellungNr,maName,maStr,maHnr,maPlz,maPosition) values(2,'müller','bergstr',32,35394,'Arbeiter');
insert into mitarbeiter (maAnstellungNr,maName,maStr,maHnr,maPlz,maPosition) values(2,'meyer','hadolpgstr',3,60318,'Arbeiter');
insert into mitarbeiter (maAnstellungNr,maName,maStr,maHnr,maPlz,maPosition) values(2,'metz','dunkelstr',82,35394,'Arbeiter');
insert into mitarbeiter (maAnstellungNr,maName,maStr,maHnr,maPlz,maPosition) values(3,'rein','eichendorfrigstr',32,35394,'supervisor');
insert into mitarbeiter (maAnstellungNr,maName,maStr,maHnr,maPlz,maPosition) values(3,'tenoir','eichendorfrigstr',32,35394,'supervisor');



/*
 Damit wir wiessen , was für einen Vertrag einen Mitarbeiter Hat , erfassen wir die Anstellungsart
*/
create table anstellungsart(
anstellungsartNr serial primary key,
bezeichnung varchar (30)
);

-- Insert into von anstellungsart
insert into anstellungsart (bezeichnung) values ('vollzeit');
insert into anstellungsart (bezeichnung) values ('teilzeit');
insert into anstellungsart (bezeichnung) values ('mini_job');


/*
    jeden tag kann einen Mitarbieter seine erbrachte_arbeitszeit eingeben und das wird auch jeder Projekt gamacht werden
*/
create table erbrachte_arbeitszeit(
    erbrachteArbeitszeitNr serial primarokokoky key,
    tpnr integer,
    maNr integer,
    stunden integer ,
    constraint e_tpnr foreign key (tpnr) references teilprojekt(tpnr),
    constraint e_manr foreign key (maNr) references mitarbeiter(maNr)                                                             
);

--insert into von erbrachte_arbeitszeit

insert into erbrachte_arbeitszeit(tpnr,maNr,stunden) values (1,2,7);
insert into erbrachte_arbeitszeit(tpnr,maNr,stunden) values (1,2,78);
insert into erbrachte_arbeitszeit(tpnr,maNr,stunden) values (1,1,1);
insert into erbrachte_arbeitszeit(tpnr,maNr,stunden) values (1,2,5);
insert into erbrachte_arbeitszeit(tpnr,maNr,stunden) values (2,1,5);
insert into erbrachte_arbeitszeit(tpnr,maNr,stunden) values (3,1,8);
insert into erbrachte_arbeitszeit(tpnr,maNr,stunden) values (1,7,8);




/*
    Jeder Projekt benötigt Material und diese haben eine Name und Kosten
*/
create table material(
    matNr serial primary key,
    tpnr integer ,
    kosten money,
    menge integer,
    mname varchar(30),
    lieferNr integer ,
    constraint  m_tpnr foreign key (tpnr) references teilprojekt(tpnr),
    constraint  m_lieferNr foreign key (lieferNr) references lieferung(lieferungNr)

);

alter table material add column menge;

drop table material
-- insert into von Material

insert into material (tpnr,kosten,menge,mname,lieferNr) values(1,4800, 5,'Holz',1);
insert into material (tpnr,kosten,menge,mname,lieferNr) values(1,800,8,'Holz',1);
insert into material (tpnr,kosten,menge ,mname,lieferNr) values(1,4588,4,'Rohstoffe',1);
insert into material (tpnr,kosten,menge ,mname,lieferNr) values(3,89,60,'kiesel',2);
insert into material (tpnr,kosten,menge ,mname,lieferNr) values(2,78,4,'Kleber',3);
insert into material (tpnr,kosten,menge ,mname,lieferNr) values(2,253,40,'glas',1);
insert into material (tpnr,kosten,menge ,mname,lieferNr) values(1,550325,2,'gold',2);


/*
    Diese Material werden in eine Lieferung enthalten bei denen es eine Lieferung_preis gibt und der zugehöriger Projekt
*/


create table lieferung(
    lieferungNr serial primary key,
    lieferungName  varchar (30),
    Lieferung_menge integer,
    lieferung_preis money,
    lieferantNr integer ,
    tpNr integer,
    constraint l_lieferant foreign key (lieferantNr) references lieferanten(lieferantenNr),
    constraint l_tpnr foreign key (tpNr) references teilprojekt(tpNr)
);


--insert into lieferung

insert into lieferung (lieferungName,lieferung_preis,lieferantNr,tpNr) values ('Hilsstoffe',45,1,1);
insert into lieferung (lieferungName,lieferung_preis,lieferantNr,tpNr) values ('Baugrupp',45,2,1);
insert into lieferung (lieferungName,lieferung_preis,lieferantNr,tpNr) values ('werkzeugsHilfe',45,1,2);
insert into lieferung (lieferungName,lieferung_preis,lieferantNr,tpNr) values ('Metall',45,1,3);
insert into lieferung (lieferungName,lieferung_preis,lieferantNr,tpNr) values ('Kunstoff',45,1,3);

/*
    jede Lieferung wird von einem Lieferant zugestellt 
*/

create  table lieferanten(
lieferantenNr  serial primary key,
lieferantenName varchar(30),
lieferantenStr varchar(30),
lieferantenHnr integer,
lieferantsteuerId integer);

-- insert into von lieferanten

insert into lieferanten(lieferantenName,lieferantenStr,lieferantenHnr,lieferantsteuerId) values ('UPS' , 'eichendorfring',99,4567);
insert into lieferanten(lieferantenName,lieferantenStr,lieferantenHnr,lieferantsteuerId) values ('DHl' , 'sternstrasse',85,4785);
insert into lieferanten(lieferantenName,lieferantenStr,lieferantenHnr,lieferantsteuerId) values ('Hermes' , 'gottstrasse',09,4887);


/*
     es kann bei einem Projekt einen Unfall passieren und das muss erfasst werden
*/


create table unfall (
    unfalleNr serial primary key,
    tpnr integer ,
    maNr integer,
    bezeichnung varchar(30),
    folge varchar(30),
    constraint u_tpnr foreign key (tpnr) references teilprojekt(tpnr),
    constraint u_maNr foreign key (maNr) references mitarbeiter(maNr)
);

-- insert into Unfall

insert into unfall (tpnr,maNr,bezeichnung,folge) values (1,2,'Verletzung','mittlere Beinverletzung');

---- Erweiterung --------------------------------------

/*
    Einen Buchaltung Verwaltet  die einzelne Projekt und sorgt dafür , dass jeder Projekt genug Geld für seine Baustelle 
*/

create table Buchaltung (
   bnr serial primary key ,
   buchaltersName varchar (30),
   tpnr  integer ,
   guthaben integer ,
   constraint b_tpnr foreign key (tpnr) references teilprojekt(tpnr)
 
);

/*
    Einen Projekt kann eine Maschine Bedarf haben 

*/

create table MaschineBedarf (
    MachineNr serial primary key,
    MaschineName varchar(30)
   
    )

create table Projet_maschine(
    pmNr serial primary key,
    tpnr integer,
    MachineNr int,
    datum date,
    constraint Pmaschine_tpnr foreign key (tpnr) references teilprojekt(tpnr), 
    constraint pmaschine_masch foreign key (MachineNr) references MaschineBedarf(MachineNr)
)   

insert into Projet_maschine (tpnr,MachineNr,datum) values (1,2,'2022-10-05');
insert into Projet_maschine (tpnr,MachineNr,datum) values (1,3,'2022-07-18');
insert into Projet_maschine (tpnr,MachineNr,datum) values (2,1, '2022-11-12');
insert into Projet_maschine (tpnr,MachineNr,datum) values (2,4,'2022-11-17');
insert into Projet_maschine (tpnr,MachineNr,datum) values (1,2,'2023-02-10');
insert into Projet_maschine (tpnr,MachineNr,datum) values (1,2,'2024-01-01');
 
  

insert into MaschineBedarf (MaschineName) values ('Automatik Ufo');
insert into MaschineBedarf (MaschineName) values ('Fk Füller');
insert into MaschineBedarf (MaschineName) values ('Uni K');
insert into MaschineBedarf (MaschineName) values ('Fk Füller ');
insert into MaschineBedarf (MaschineName) values ('wkz wechselwagen');

select * from MaschineBedarf

drop table MaschineBedarf

/*
      
*/

create table 

---------------------------------------------------------------------------------------------------------


     ---  Erste Frage ----
  
   /*
        Wann wird die Raumstation voraussichtlich fertiggestellt sein? (Errechenbar mit bisheriger Arbeitszeit / Woche und Restzeit der Projekte)
   */
   
   --- Antwort ---
    
    select(select SUM(arbeitsstundenschätzung) as summ
    from teilprojekt)
     -
    (select SUM(stunden) as summ
     from erbrachte_arbeitszeit )
     
     
     ----  Zweite Frage ---
     
     
   /*
        • Welches Baumaterial wird besonders oft benötigt?
   */
   
   
   --- Antwort ---

    select mname 
    from material 
    where  menge in (select max (menge) from material)

    
    --- Dritte Frage --- 

    /*
        • Wie viele Teilprojekte sind abgeschlossen?
    */
    
    
    --- Antwort ---
    
        select distinct  tpname
        from teilprojekt
		join erbrachte_arbeitszeit using (tpnr)
		where  teilprojekt.arbeitsstundenschätzung - (  select sum(stunden) from erbrachte_arbeitszeit )  <= 0  
    

    --- Vierte Frage ---
    /*
        wir wiessen , dass bei jedem Projekt mindestens 3 Mitarbeiter arbeiten sollte und jetzt möchte wir wiesse bei welchem Projekt weniger als 3 Mitarbeiter gibt
        
    */
    
    
    --- Antwort --
    
    select tpname from teilprojekt left join erbrachte_arbeitszeit using (tpnr)  group by tpname having count(manr) < 3

    ---  Frage nr 5 ---

    /*
     die Mitarbeiter die viel gearbeitet hat und die stunden 
    */
    
    --- Antwort ---
    
    select  maname, max(stunden) as summ from erbrachte_arbeitszeit join mitarbeiter using(maNr) group by  maname, stunden  order by summ desc limit 1

           
     --- Frage nr 6 ---

        /*
            liste aller Mitarbeiter , die schon mehr als 40 stunden gearbeiter haben , dann kriegen Sie für die Überstunde 10% mehr Geld
            
        */
    
        --- Antwort ---
        
        select manr ,maname
        from mitarbeiter join erbrachte_arbeitszeit using (manr)
        group by manr ,maname
        having sum(erbrachte_arbeitszeit.stunden) > 40


    --- Frage 7 ---
    
    /*
    
        der Unternehmen möchten wiessen , bei welchem Projekt einen Unfall gehabt wird , und welche Mitarbeiter ,das betrifft
    
    */

    --- Antwort ---
    
    select distinct unfall.tpnr , tpname , unfall.manr , folge , maname
    from unfall join mitarbeiter using (manr) join erbrachte_arbeitszeit using (tpnr)  join teilprojekt using(tpnr)
 

    --- Frage 8 ---
    
    /*
        Der größte Supervisor möchte  die Liste alle Teilprojekt mit gesamte kosten von Material und Gesamte Kosten Von Lieferung  noch dazu brauchen wir das Budget,
       
        
    */

    
    --- ANtwort ---
    
        select tpname, material.tpnr,  sum(kosten) as koste , sum(lieferung_preis)  as liefer ,teilprojekt.budget
           from material , lieferung ,teilprojekt
           where material.tpnr = lieferung.tpnr and material.tpnr = teilprojekt.tpnr 
           group by material.tpnr, teilprojekt.budget,tpname          
  
  
  --- Frage 9 ---
  
  
  
    /*
        
        wir möchten wiessen , welche Teilprojekte noch kein Mitarbeiter hat , damit wir dort Mitarbeiter Zuweisen können
    
    */
  
   --- Antwort ---
   
        select tpname 
        from teilprojekt 
        left join erbrachte_arbeitszeit using(tpnr) 
        where erbrachte_arbeitszeit.stunden  is Null

  
      
     --- Frage  10 ---
     
    /*
        welcher Mitarbeiter hat einen Unfall gehabt , damit er mehr Geld für die ENtschuldigung kriegen 
    */
    
    
    --- Antwort --
    
    select maname from mitarbeiter join unfall using(manr) 
  
  
    --- Frage 11 ---- 
    
    /*
         welche Material wird in welcher Projekt benutzt 
    */
    
    --- Antwort ---

     select distinct tpname , MaschineName
    from teilprojekt join Projet_maschine using (tpnr) join MaschineBedarf using (MachineNr)
  

  
  