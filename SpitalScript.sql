DROP table sectii cascade constraints
/
DROP table saloane cascade constraints
/
DROP table sali_operatie cascade constraints
/
DROP table medici cascade constraints
/
DROP table pacienti cascade constraints
/
DROP table medicamente cascade constraints
/
DROP table tratamente cascade constraints
/
DROP table fisa_pacienti cascade constraints
/
drop table repartizare cascade constraints
/
drop table detalii_medic cascade constraints
/
DROP TABLE operatii cascade constraints
/
DROP TABLE asignare_salon cascade constraints
/
DROP TABLE atribuire_pacient cascade constraints
/
DROP TABLE spitalizare cascade constraints
/
DROP TABLE internari cascade constraints
/


CREATE TABLE sectii (
id_sectie varchar2(20) NOT NULL Primary Key,
nume_sectie varchar2(30) NOT NULL
)
/

CREATE TABLE saloane(
id_salon varchar2(20) NOT NULL Primary Key,
numar_salon int,
etaj int,
capacitate int
)
/
create table asignare_salon (
id_salon varchar2(20) NOT NULL,
id_sectie varchar2(20) NOT NULL,
constraint  fk_asignare_salon_id_sectie FOREIGN KEY (id_sectie) REFERENCES sectii(id_sectie),
constraint  fk_asignare_salon_id_salon FOREIGN KEY (id_salon) REFERENCES saloane(id_salon)
)
/

CREATE TABLE sali_operatie (
id_sala varchar2(5) NOT NULL Primary Key,
numar_sala int
)
/
create table repartizare(

id_sectie varchar2(20) NOT NULL,
id_sala varchar2(20) NOT nULL,
constraint  fk_repartizare_id_sectie FOREIGN KEY (id_sectie) REFERENCES sectii(id_sectie),
constraint  fk_repartizare_id_sala FOREIGN KEY (id_sala) REFERENCES sali_operatie(id_sala)
)
/

CREATE TABLE medici (
id_medic varchar2(20) NOT NULL PRIMARY KEY,
nume varchar2(20),
prenume varchar2(20)
)
/
create table detalii_medic(
id_medic varchar2(20) NOT NULL,
id_sectie varchar2(20) NOT NULL,
inceput_tura varchar2(20),
sfarsit_tura varchar2(20),
constraint  fk_detalii_medic_id_sectie FOREIGN KEY (id_sectie) REFERENCES sectii(id_sectie),
constraint  fk_detalii_medic_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic)
)
/
create table operatii (
id_sala varchar2(20) NOT nULL,
id_medic varchar2(20),
data_inceput_operatie date,
ora_inceput_operatie varchar2(50),
durata_operatie number,
constraint  fk_operatii_id_sala FOREIGN KEY (id_sala) REFERENCES sali_operatie(id_sala),
constraint  fk_operatii_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic)
)
/
CREATE TABLE pacienti (
id_pacient varchar2(20) NOT NULL Primary Key,
nume varchar2(30),
prenume varchar2(30),
data_nastere date
)

/
create table atribuire_pacient (
id_pacient varchar2(20),
id_salon varchar2(20) NOT NULL,
constraint fk_atrb_pacient_id_pacient FOREIGN KEY (id_pacient) REFERENCES pacienti(id_pacient),
constraint  fk_atrb_pacient_id_salon FOREIGN KEY (id_salon) REFERENCES saloane(id_salon)
)

/
create table internari(
id_internare varchar2(20) NOT NULL Primary Key,
data_internare varchar2(20),
data_externare varchar2(20)
)
/
create table spitalizare(
id_pacient varchar2(20),
id_internare varchar2(20) not null,
constraint fk_spitalizare_id_internare FOREIGN KEY (id_internare) REFERENCES internari(id_internare),
constraint fk_spitalizare_id_pacient FOREIGN KEY (id_pacient) REFERENCES pacienti(id_pacient)
)
/

CREATE TABLE fisa_pacienti (
id_fisa varchar2(20) NOT NULL Primary Key,
id_pacient varchar2(20),
id_medic varchar2(20),
boala varchar2(30),
constraint fk_fisa_pacienti_id_pacient FOREIGN KEY (id_pacient) REFERENCES pacienti(id_pacient),
constraint fk_fisa_pacienti_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic)
)

/

CREATE TABLE medicamente (
id_medicament varchar2(5) NOT NULL Primary Key,
denumire varchar2(200),
stoc varchar2(15)
)
/

CREATE TABLE    TRATAMENTE (
id_pacient varchar2(20),
id_medic varchar2(20),
data_inceput_tratament date,
data_sfarsit_tratament date ,
id_med1 varchar2(20),
id_med2 varchar2(20),
id_med3 varchar2(20),
id_med4 varchar2(20),
id_med5 varchar2(20),
id_med6 varchar2(20),
id_med7 varchar2(20),
id_med8 varchar2(20),
constraint fk_tratamente_id_pacient FOREIGN KEY (id_pacient) REFERENCES pacienti(id_pacient),
constraint fk_tratamente_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic),
constraint fk_tratamente_id_med1 FOREIGN KEY (id_med1) REFERENCES medicamente(id_medicament),
constraint fk_tratamente_id_med2 FOREIGN KEY (id_med2) REFERENCES medicamente(id_medicament),
constraint fk_tratamente_id_med3 FOREIGN KEY (id_med3) REFERENCES medicamente(id_medicament),
constraint fk_tratamente_id_med4 FOREIGN KEY (id_med4) REFERENCES medicamente(id_medicament),
constraint fk_tratamente_id_med5 FOREIGN KEY (id_med5) REFERENCES medicamente(id_medicament),
constraint fk_tratamente_id_med6 FOREIGN KEY (id_med6) REFERENCES medicamente(id_medicament),
constraint fk_tratamente_id_med7 FOREIGN KEY (id_med7) REFERENCES medicamente(id_medicament),
constraint fk_tratamente_id_med8 FOREIGN KEY (id_med8) REFERENCES medicamente(id_medicament)
)
/
 create or replace type vc_arr as table of varchar2(32000);
 /
 create or replace type num_arr as table of number;
 /

DECLARE
  --SECTII
   nume_sectie vc_arr:=vc_arr('Cardiologie','Medicina Generala','Neurologie','Ortopedie','Pediatrie','Oncologie','Chirurgie Plastica','Ginecologie','Radiologie','Terapie Intensiva','Anestezie','Gastroenterologie','Dermatologie','ORL','Oftalmologie','Hemologie','Reumatologie','Imunologie','Urologie','UPU');
   
   --SALI OPERATIE
   v_id_sala sali_operatie.id_sala%type;
   v_nr_sala sali_operatie.numar_sala%type;
   
   --OPERATII
   v_data_inceput_operatie operatii.data_inceput_operatie%type;
    v_ora_inceput_operatie operatii.ora_inceput_operatie%type;
   v_durata_operatie operatii.durata_operatie%type;
   
   --SALOANE
   v_id_salon saloane.id_salon%type;
   v_nr_salon saloane.numar_salon%type;
   v_etaj_salon saloane.etaj%type;
   v_capacitate_salon saloane.capacitate%type;
   
   --INTERNARI
   v_id_internare internari.id_internare%type;
   v_data_internare internari.data_internare%type;
   v_data_externare internari.data_externare%type;
   
   --DETALII MEDIC
   v_inceput_tura detalii_medic.inceput_tura%type;
   v_sfarsit_tura detalii_medic.sfarsit_tura%type;
   v_id_sec detalii_medic.id_sectie%type;
   
    --MEDICI
   nume_medic vc_arr:=vc_arr('Lysaght','Meredith','Minichi','Devonish','Garvagh','Lawton','Painswick','Haye','Dwyer','Corris','Astin','Paulazzi','Ochterlony','Grima','Zapater','Plumm','Purnell','Getley','Stairs','McClymond','Smallman','Binion','Winpenny','Balderstone','Goodered','Screeton','Vergo','Jesson','Corran','Salzberger','Poag','Rebert','Francois','Paszek','Archard','Bridie','Wolver','Gynn','Pattrick','Kemster','Schimaschke','Blakebrough','Toffoletto','Dunton','Garrique','Inmett','Largen','Godfroy','Janek','Rive','Skillern','Kennington','Jurca','Francie','Hattam','Aimable','Spicer','Kinnear','Toombs','Ennals','Brownlie','Woodhouse','Mowsdale','Corroyer','Bracken','Jervois','Kubu','Danzelman','Sealove','Cawood','Frammingham','Ivanyutin','Thieme','Fey','Nana','Tolchar','Matyasik','Skipp','Pavlenko','Sarson','Sinnocke','Iredale','Askey','Southon','Saterweyte','Dugall','Mackelworth','Angus','Stolz','Emery','Bonanno','Scamp','Tolle','Jills','Kille','Buxy','Debell','Roan','Slot','Presman','Kinnon','Crowhurst','Petracci','Brik','Scarasbrick','Lightning','Wathey','Halfhyde','Wimmers','Eleshenar','Cosgriff','Carek','Covington','Bouldon','MacGauhy','Vasechkin','Espinet','Edgington','Soutter','Skinner','Curmi','Conlon','Creasey','Altoft','Colvill','Packwood','Froome','Sancraft','Escott','Garland','Sexty','Middlemiss','Gartenfeld','Gillcrist','Dury','Bidnall','Philippon','Arthey','Bernardot','Ginty','Dobbison','McLugaish','Dybell','Penney','Cousins','Halliwell','Noad','Trowbridge','Maypother','Face','Frankham','Bogie','Heeps','Ferrer','Michell','Giercke','Schiersch','Jaquin','Monkley','Danter','Westoll','Negro','Vogeler','Liffey','Drews','Stockport','Sinclar','Vogt','Filon','Gave','Frankton','Bernollet','Maddern','Aron','Razoux','Aiskrigg','Gallichiccio','Bondy','Rex','Gullefant','Lace','Storch','Waberer','Gammie','Herley','Timothy','Cossor','Daveridge','Cordobes','Gussin','Furze','Filipyev','Gardener','Jore','Nilles','Wandrack','Eaken','Gilman','Willmot','Elsmor','Marioneau','Bardsley','Hake','Matyashev','Whaley','Stanislaw','Pucker','Pile','Batchelor','Kervin','Lissandri','Quarton','Royans','Blare','Travers','Gollin','Phalip','Breffitt','Coot','Wagstaffe','Winkett','Pryell','Kobke','Gonnard','Coggins','Baggot','Aizlewood','Baynon','Ragsdale','Shaplin','Spadazzi','Tampin','Stivey','Chestney','Rekes','Feveryear','Du Hamel','Cakebread','Kalberer','Cromblehome','Sleford','Billows','Lettson','Deverille','Thurlbeck','Reeds','McGinnis','Di Bartolomeo','Kuhnt','Giovannilli','Rigard','Blazi','Kenealy','Beach','Selley','Tuhy','Miller','Landy','Elacoate','Hassur','Thom','Bellee','Gawthorpe','Geraldez','Enderle','Pellamont','Scarsbrooke','Whybrow','Jewsbury','Mion','Davidzon','Trigg','Kmietsch','Petrosian','Hukins','Saddler','Debnam','Beagley','Urwen','Burghill','Mollindinia','Sellan','Abthorpe','Lobell','Farrah','Gadie','Tyt','Laste','Voelker','Raddin','Bourdon','McCurtin','Lunge','Wincom','Sabatier','Clelland','Colls','Aries','Peddie','Attwill','Twitty','Rowter','Stanion','Pitrelli','Spall','Baford','Comfort','Pargeter','Mathey','Horick','Castana','Deeming','Basilone','Andraud','Jaulmes','Garden','Tuminini','Vynall','Guilliland','Aspinwall','Bastistini','Macieiczyk','Manssuer','Fere','Doorly','Wadie','Gartan','Kivits','Marfield','Hauxwell','Archbutt','Lambie','Rodear','Nuzzetti','McRorie','Snelling','Bowton','Spatoni','Iannelli','Inger','Rosie','McVanamy','Lammin','Marlowe','Oury','Birkinshaw','Anthonies','Bortolozzi','Sturley','Asman','McMeyler','Crook','Glayzer','Fyall','Paolazzi','Marian','Peterffy','Yeell','Dupree','Errey','Ells','Redler','Bauchop','Jenkison','Herreros','Impey','Sprowle','Blankau','Joynt','Pyson','Hallworth','Maciak','Yaakov','Mitrikhin','Ummfrey','Seamark','Sancho','Peasgood','Anthiftle','Barchrameev','Askew','Bertlin','Calley','Fashion','Tailby','Clears','Prati','Berrygun','Noke','Cotterill','Matthews','Dominick','Frankland','Fulkes','Salling','Cohan','Cameli','Playfoot','Betts','Championnet','Ring','Farens','Hamor','Lehrle','Yakhin','Caen','Wooles','Cleever','Nesfield','Monk','Robbel','Sussams','Van','Whebell','Goffe','Broggio','Lewry','McClosh','Cheale','Killich','Gregson','Kording','Battin','Mabbutt','Woodgate','Chittim','Concannon','Ghiraldi','Calder','Ottawell','Sirl','Buckland','Glide','Slyford','Broadbridge','Powney','Delahunt','Maund','Andino','Riglesford','Lumb','Maclaine','Reddy','Hallwood','Yakhin','McCreath','Pollett','Roslen','Sawbridge','Saldler','Olenin','Randall','Hugle','MacMarcuis','Parkinson','Toffel','Henrichs','Spolton','Boodell','Rossin','Argontt','Sabey','Camm','Barnfather','Trippitt','Mankor','Hedge','Clementet','Sier','McGrill','McDonnell','Bettison','Dobell','Engelmann','Dunridge','Bispham','Lage','Wheatley','Metheringham','Tythe','Etches','Kleehuhler','Natwick','Paybody','Yelyashev','Tankard','Summerley','Needham','Caramuscia','Zukierman','Pregal','Blaik','MacGeffen','Thaxton','Judkins','Caudrelier','Dignon','Pioch','Djordjevic','Pelfer','McMillan','Signoret','Devanney','Waltering','Ladbury','Aggio','Cummins','Udey','Mathonnet','Carverhill','Williamson','Berrigan','Swine','Hanscombe','Climson','Kinsey','Tovey','Tollow','McGrath','Trevan','Plowright','Moakler','Bertot','Jiru','Prue','Girard','Colhoun','Larby','Dubs','Copins','Pryer','Moroney','De Haven','Ablewhite','Verman','Remnant','Atkin','Bollard','Sulman','Lovstrom','Dainter','Niset','Etches','Bellsham','Parlor','Hughlin','Soares','Stollwerck','Lowson','Quinion','Toland','Roskelley','Tettley','Lenney','Bagworth','Gibbieson','Pimlett','Gilhoolie','Ballach','Peterkin','Hubeaux','Abbay','McLernon','Schoular','Robel','Bleackley','Tuckett','Williams','Emmanuel','Boler','Bealing','Columbell','Calles','Vaar','Lickorish','Boar','Waldren','Duncklee','Brasener','Mozzetti','Tremlett','Yurocjkin','Lathaye','Littlechild','Elsworth','Backshill','McCunn','Burberye','Edy','Cutting','Ormston','Scothorn','Roseburgh','Neenan','Tattersall','Bennen','Gallafant','Mowne','Perone','Harner','Kirsche','Shallcrass','Sawl','Irnis','Rotherham','Lacoste','Antosch','Jahnig','Marsland','Souch','Raggatt','Howlin','Santer','Templar','Treverton','Gaffon','Condliffe','Bonehill','Utridge','Semaine','Kruschev','Jenson','Bohan','McCay','Merwede','Spieght','Camamill','Edwardson','Hovey','Bourget','Birdsey','Crimes','Zouch','Senten','Jelf','Ramelot','Osbourne','Firle','Mycroft','Huitson','Valler','Solomon','Thody','Harman','Chalk','Jaquet','Nanninini','Ausiello','Ribchester','Pidon','Karoly','Teeney','Flowers','MacClancey','Wallwork','Desesquelle','Pitkeathley','Tacon','Cromblehome','Veighey','Ambroziak','Kitt','Karlqvist','Gianettini','Roggers','Nickels','Grimsey','Fynan','Impey','Goudge','Seath','Pammenter','Kynnd','Cokely','Sampson','Loudon','McCraw','Gallandre','Rampton','Petrillo','Bingell','Parkeson','Surgey','Grzelczyk','Mephan','Jerzak','Hunsworth','Hosburn','Marklew','Aisman','Cadany','Vaun','Byrd','Bessett','Piffe','Tomkys','Chataignier','Tomaszewski','Blance','Purslow','Sandwick','Cody','Fasse','Umbert','Abbis','Casford','Northridge','Cathesyed','Duly','Fosher','Annesley','Freezer','Hoyes','Lapidus','Venard','Whytock','Gheorghie','Fosse','Remirez','MacGregor','Blakesley','Durtnel','Mustchin','Rapley','Martinot','Bilovsky','Savell','Sherreard','Sommers','Eads','Dallosso','Elliman','Arnaldo','Blinkhorn','Bisacre','Brodeau','Rankling','Browett','Ridgeway','Cranson','Amesbury','Degoe','Morit','Jirka','Airds','Brettel','Gasgarth','Lehrer','Gossage','Wolton','Knibb','Blenkinsopp','Carlan','Snead','Denisovich','Syres','Lusk','Scheu','Wolfendell','Lansdowne','Caldes','Herrero','Crottagh','Rushbrooke','Razoux','Rickert','Hews','De Hailes','Sirmon','Lockley','Hildred','Palleske','Pummery','Troy','Chiechio','Moan','Blue','Cicchetto','Symers','Henstridge','Cushelly','Mutimer','Gheeorghie','Heustace','Bezley','Savery','Lampbrecht','Hallt','Morilla','Crinson','De Simone','Bone','Turbard','Osgodby','Lurcock','Petrescu','Jeanenet','Campe','Byrd','Le feuvre','Dealy','Philbin','Fannon','Sandys','Seiler','Comino','Ellingsworth','Reinard','Mushrow','Jerke','Stickney','Le Strange','Pechacek','Rosbotham','Cacacie','Axelbee','Madison','Normansell','Penton','Ottewell','Yanukhin','World','Ruddiforth','Rowlings','Pavett','Lillistone','Caser','Jobern','Merrall','Danilchev','Goundrill','Grimsdyke','Pfeifer','Darrow','Clacey','Karus','Wohlers','Sucre','Nealon','Garretts','Briiginshaw','Thackwray','Todman','Collingridge','Millgate','Epinoy','Sacchetti','Castagne','Mortlock','Verrill','Ranald','Biaggi','Vreede','Leopard','Boxer','Wavell','Mildmott','Saberton','Gerrietz','Oles','Nassie','Wadelin','Sellick','Davidavidovics','de Zamora','Ascough','Teasey','Mowsdell','Valentim','Biddiss','Dearden','Olin','Hallagan','Ingrey','McJarrow','Lechelle','Giggs','Pennyman','Nathan','Lilleycrop','Trewartha','Mayhew','Genner','Marland','Yaus','Bleibaum','Coulling','Lathom','Deeming','Liver','Meron','Alderton','Ekell','Denisovich','Ruppele','Hinkens','Rapinett','Pavlishchev','Hazelgreave','Nimmo','Bolter','Glacken','Sleet','Caudle','Darrell','Ackroyd','Overlow','Kummerlowe','Dallow','Pescod','McCree','Jevons','Angell','Hughs','Wenzel','Smaleman','Hampson','Spencock','Divina','Syder','Fauning','Sellan','Marioneau','Gerrans','Tomasian','Stirrip','Cheeke','Van der Baaren','Mann','Linham','Windross','Sall','Falck','Gostridge','Rutland','Benedyktowicz','Crowch','Pinor','Brunetti','Garling','Basterfield','Wauchope','Jephson','Cuttin','Meenehan','Elstone','McPhelim','Harraway','Perello','Eglinton','Abthorpe','Sartain','MacKean','Blasiak','Mordin','Sterrick','Lalonde','Souch','Westoll','Makeswell','Redd','Sabie','Schiersch','Lufkin','Gouley','Bronot','Dwelley','Carsberg','Water','Calvey','Anselm','Garlicke','Derington','Bevans','Loudon','Kitcatt','Wrefford','Grewe','Hast','Iacivelli','Brede','Pilmore','Pirouet','Sheehan','Milesap','Shercliff','Jossum','Wulfinger','Westwood','Vasyagin');
   prenume_medic vc_arr:=vc_arr('Merna','Christophorus','Roddy','Estevan','Shane','Jarrid','Livvy','Palmer','Jerri','Marji','Suzi','Olivette','Adolph','Valaria','Odetta','Giacomo','Gordie','Marius','Theodoric','Brennan','Ofilia','Riane','Sella','Leicester','Erl','Mac','Fabio','Bren','Ogdan','Mariejeanne','Brice','Ricky','Radcliffe','Nikolai','Simone','Robinia','Gabi','Brnaby','Dianna','Tore','Oswell','Ellswerth','Daisie','Renado','Dar','Lucias','Mattheus','Arly','Kati','Chariot','Mickie','Curtis','Johann','Lee','Hobey','Brit','Thacher','Normie','Joanne','Nicola','Lillis','Eadmund','Kylie','Preston','Pet','Darnall','Robinson','Yoshi','Briana','Nanete','Humbert','Rosette','Brita','Larina','Linell','Deni','Pebrook','Charil','Mella','Scott','Ogdon','Ugo','Scarlett','Forrester','Claudio','Gladi','Martina','Mallorie','Findlay','Jenelle','Hamlen','Shirline','Erna','Ricardo','Artus','Lucho','Eadmund','Natalina','Elissa','Anson','Marissa','Carling','Bibbye','Billie','Guido','Heywood','Hercule','Donalt','Fairfax','Pammy','Emelina','Frasier','Gelya','Adella','Burt','Mohammed','Selestina','Darline','Genni','Ignace','Cleo','Addison','Edithe','Pascal','Evania','Tallie','Melba','Brande','Ella','Gustavo','Tucker','Stern','Lenette','Lon','Gavin','Dyanne','Bryana','Janenna','Jeanine','Debee','Charley','Barris','Theodosia','Pail','Jorry','Ives','Roby','Louise','Nonah','Kalie','Heloise','Olag','Rafa','Skippie','Annecorinne','Wilbert','Nicky','Pebrook','Liliane','Ebeneser','Meta','Charmion','Julius','Jennette','Simon','Mallissa','Ermanno','Kimbell','Rica','Roberta','Helaine','Allianora','Margot','Karlotte','Ave','Ingrid','Bendite','Jsandye','Kial','Kristofer','Rani','Beryl','Ofelia','Daven','Andy','Rancell','Link','Tiffy','Kinnie','Dyan','Eilis','Nadine','Jamesy','Skipp','Ailey','Natassia','Verney','Faber','Miriam','Alexina','Flossy','Stanly','Glenn','Fairlie','Reginald','Javier','Cammi','Carce','Randy','Aubrey','Melany','Sissie','Adham','Lucilia','Dido','Jacquie','Orton','Felice','Malina','Budd','Gaylene','Ethelyn','Dud','Moses','Lyda','Becki','Elinor','Madlen','Tatum','Norbie','Bernard','Roddie','Tate','Libbie','Mala','Jessy','Angie','Fianna','Tera','Berthe','Godfry','Catarina','Viva','Andeee','Esmeralda','Lacy','Britteny','Lambert','Susanna','Dorthea','Baxter','Samantha','Sylvan','Alec','Jodee','Merci','Drusi','Sly','Waly','Mitchel','Wendy','Marena','Dorise','Meris','Pia','Xenos','Leonanie','Tanny','Fielding','Gertruda','Catherine','Marcie','Vivyanne','Eddi','Brendis','Humbert','Kerianne','Gaby','Piper','Dody','Wayne','Logan','Blane','Beauregard','Mignon','Alvina','Carlin','Joli','Cori','Bryn','Reginauld','Karlie','Nonah','Starla','Yehudi','Chrysa','Elsey','Judon','Franciska','Doti','Roanne','Lavinia','Johnathan','Angeline','Riordan','Melinde','Elga','Shayne','Tammie','Shea','Bernard','Vladamir','Moira','Nessie','Langston','Alvina','Erny','Carmelita','Gabriel','Toddy','Donovan','Gunter','Augustine','Lorne','Marge','Slade','Sheffie','Parnell','Clemente','Erie','Tanney','Arlette','Sven','Tana','Kelci','Broderick','Naomi','Vladamir','Latashia','Ashlen','Lauraine','Lari','Freida','Jephthah','Cristina','Brietta','Gregg','Shaine','Jillane','Agata','Carole','Nancee','Leanor','Adriana','Silva','Noach','Eachelle','Mattie','Natalie','Elladine','Abdul','Kleon','Malena','Zorine','Nathanial','Wilow','Gray','Kaine','Denys','Allene','Flory','Sadye','Filippo','Gilberto','Moises','Britney','Othello','Elwira','Laurent','Trina','Esdras','Gusti','Karylin','Candra','Jed','Lyle','Jessie','Alexandro','Gustavo','Catlin','Mack','Felita','Derk','Carry','Louis','Cirilo','Eugen','Kristal','Valery','Arden','Barbra','Cecilla','Giulio','Sharyl','Ernie','Langsdon','Sandra','Lani','Henri','Merrill','Jeramie','Rozele','Annecorinne','Carma','Raffarty','Karie','Hollie','Alleyn','Pete','Kilian','Don','Cristine','Skipton','Wendeline','Lorine','Evangelin','Lloyd','Adrianne','Genny','Pieter','Winny','Waiter','Chanda','Shirlene','Rorke','Jacquie','Christabella','Guido','Giffard','Ansell','Germaine','Linette','Vonni','Olga','Guido','Hynda','Zelig','Rufe','Effie','Salem','Fayette','Magdalene','Eirena','Dacy','Pooh','Danica','Jean','Shermy','Dorthea','Emanuele','Belia','Irvine','Chlo','Estrella','Peggi','Lucias','Ina','Sharleen','Berri','Cathrine','Eward','Mathias','Marcella','Vittorio','Alvy','Ellery','Helena','Wit','Reinaldo','Consalve','Rafa','Cameron','Kerby','Maggi','Rayshell','Ange','Pryce','Adel','Giusto','Perri','Cindy','Legra','Delores','Cloris','Ellerey','Aylmar','Felisha','Benni','Pascale','Amity','Ruthy','Joanie','Dov','Catherina','Genni','Jocko','Veronique','Ivy','Adel','Anthiathia','Marcelo','Buiron','Nyssa','Gusella','Kelci','Flynn','Vale','Con','Gilburt','Emmy','Ewart','Stefanie','Anna','Rakel','Judye','Stefa','Frankie','Constance','Meris','Richie','Madelaine','Jordan','Enrico','Hestia','Kristina','Brianna','Huntlee','Ginelle','Robers','Ikey','Ediva','Annemarie','Prent','Cathe','Cindie','Diahann','Karry','Rhianna','Codi','Georgia','Noni','Jessy','Luis','La verne','Judith','Matthaeus','Ophelie','Amber','Nanice','Shayna','Britni','Clareta','Padgett','Eleni','Hamlen','Donaugh','Kori','Marieann','Lorianne','Pamela','Claire','Morly','Tamas','Theodore','Elayne','Agata','Bessy','Jonathon','Owen','Kippy','Karin','Duncan','Daria','Alfons','Giorgia','James','Sibley','Seymour','Papageno','Farrand','Cassandra','Aurilia','Kiley','Jere','Virgina','Devondra','Fax','Mario','Regina','Agathe','Tiphani','Ingar','Simon','Merrily','Anthiathia','Cobbie','Edyth','Babita','Garey','Evelina','Maryanna','Quintus','Leon','Nina','Merola','Bryce','Karole','Tamarah','Talia','Henka','Zacharie','Elroy','Howie','Patrica','Cecily','Philipa','Tomasina','Beryl','Allistir','Gabbie','Geoffrey','Darby','Adolpho','Emerson','Karl','Jaymie','Torin','Sandye','Brody','Dino','Maddi','Elfrida','Jorrie','Birdie','Emelita','Daphne','Jerrold','Tiebold','Mella','Leoine','Shaylah','Malissia','Goddart','Bastien','Gabey','Jamie','Lenora','Whittaker','Jacques','Zonnya','Daveen','Case','Binny','Cullen','Reg','Tish','Stacie','Tiena','Bo','Ross','Mellicent','Jasun','Simone','Jed','Huberto','Ellary','Rosalynd','Kalil','Artur','Davie','Ella','Devy','Marie-jeanne','Artemus','Gerry','Henriette','Valentijn','Ailyn','Meg','Carolan','Cora','Mira','Garik','Magdalene','Gerik','Turner','Emerson','Antoine','Kathrine','Heywood','Keefe','Nikos','Milt','Barbee','Petunia','Libbey','Fredrick','Elenore','Ginnifer','Waylan','Siobhan','Celinka','Audy','Cassondra','Bobbee','Muffin','Gerrie','Linnell','Gram','Juliette','Duncan','Charin','Sampson','Fabio','Wang','Hersch','Mattheus','Noam','Melisa','Hobart','Maurie','Joseph','Roshelle','Sharlene','Pancho','Astrid','Joeann','Akim','Rafael','Norine','Othelia','Querida','Baillie','Talia','Maure','Tanney','Benedikta','Carmelina','Leigh','Nadia','Becky','Averil','Claiborne','Maryl','Dulsea','Blanch','Kippie','Lindon','Matti','Leena','Darline','Aldwin','Janeva','Dominica','Ondrea','Andrea','Marylee','Joseito','Nadeen','Robby','Ogden','Brodie','Golda','Sally','Christal','Justinn','Elbertine','Mathian','Barnie','Codee','Willetta','Brice','Almeria','Berty','Yorgos','Zulema','Wilfred','Ward','Stanley','Robbert','Sallyann','Irwinn','Ami','Delaney','Justis','Berne','Corinne','Roseline','Zilvia','Saba','Dilan','Arvie','Leese','Jonas','Frasquito','Debbi','Augustine','Prent','Benny','Timmy','Rene','Erich','Grete','Nicolea','Brina','Heindrick','Erwin','Dorise','Standford','Rosina','Dianemarie','Zenia','Tonnie','Alexandros','Byran','Gunner','Frankie','Teddy','Denys','Valaree','Dela','Carr','Grissel','Con','Shelba','Giorgio','Jules','Marcella','Karyl','Harbert','Lynea','Victor','Tomaso','Gertie','Dianne','Georgeanna','Gabby','Seumas','Jaymee','Faye','Gratiana','Melly','Merridie','Avigdor','Joella','Dex','Kacy','Michaeline','Stu','Noby','Amii','Jorie','Di','Rita','Lanita','Riannon','Pet','Matty','Garrett','Constance','Karina','Marti','Meris','Estell','Oneida','Essa','Rosita','Amble','Ricard','Louisette','Towney','Federico','Mellicent','Humfried','Sibilla','Delainey','Rebekah','Emmey','Yolane','Reinhard','Jaquenette','Mandi','Fancie','Trixie','Oby','Andrea','Leanor','Seline','Blanche','Andra','Sean','Brooks','Ashleigh','Richmound','Emmalynne','Cammy','Winthrop','Suzette','Cherie','Violetta','Llywellyn','Sherm','Russ','Niles','Dennet','Stearn','Obadiah','Ardisj','Helaina','Hamil','Gisele','Rabi','Rochelle','Serene','Gareth','Sonja','Darya','Sherilyn','Jacki','Guido','Adrianne','Cyndy','Allin','Yanaton','Kellina','Giulietta','Hailee','Torrence','Gerladina','Ebony','Paloma','Blinni','Fee','Brannon','Morrie','Harvey','Briney','Anabella','Boycey','Seana','Jonis','Rodolph','Jessee','Maisey','Yasmeen','Aeriel','Rutger','Howie','Paulina','Gael','Krisha','Tabor','Mahmoud','Hedvige','Filippo','Kristofer','Filberto','Stanley','Debi','Eloise','Stephannie','Matthew','Jenifer','Selina','Elianore','Kessia','Carolyn','Courtenay','Daune','Jeniece','Diane','Marika','Rutger','Manya','Gilemette','Darin','Jackson','Rubia','Michaela','Terra','Shirley','Nathalia','Berte','Mimi','Morris','Raynor','Karlik','Chickie','Guthrie','Randi');
   
   v_id_medic medici.id_medic%type;
   v_nume_medic medici.nume%type;
   v_prenume_medic medici.prenume%type;
   
   --PACIENTI
   
   nume_pacient vc_arr:=vc_arr('Naisbitt','Karpf','Pepys','Reddie','Silkston','Bernth','Borlease','Smidmoor','Gordon-Giles','MacPaik','Ruddick','Tuckett','Goldstein','Furniss','Muller','Roberds','Archbould','McKeeman','Biset','Muckian','Rewcastle','McCoish','Peidro','Heddon','Quartley','Mancer','Sunners','Wolffers','Knott','Sheldrick','Kastel','Helleckas','Garron','Ruthen','Semens','Colleran','Tritten','Dryden','Itscovitz','Glynne','Hoggin','Truett','Petrello','Docherty','Kann','Leggett','Henlon','Vittore','Grishukhin','Goldspink','Mains','Denes','Pelling','McKeevers','Clapison','MacGuffie','Pechard','Botha','Saintpierre','Frankel','Tamblingson','Jillings','Southwell','Harston','Penley','Stoppard','Ox','Gehrels','Gashion','Jury','Tort','Hawker','Knibb','Dunstall','Izzard','Dunderdale','Duffitt','Harrhy','Dachs','MacMechan','Bodega','Bedell','Kyrkeman','Jumel','Pasby','Frankling','Cartmail','Milkin','Balducci','Bringloe','Tottle','Anyon','Mongeot','Eidler','Rawkesby','McCaster','Brayshaw','Lefeuvre','McCurry','Fraczek','Crasford','Lennox','Liddard','Jeary','Lathwood','Berg','Do','Marco','Domingues','Utteridge','Benedettini','Beauvais','Quickenden','Cecchetelli','Newson','Richford','Ingerman','Steely','Aberkirdo','Dowderswell','Clunie','Orris','Osler','Golston','Anster','Dugood','Dikels','Bayfield','Swinney','Whatley','Lysons','Rickards','Rolston','Billham','Towle','Tilsley','Schonfelder','Daws','Zielinski','Auchinleck','Balchen','Brignall','Pierse','Slatcher','Heaney','Deboo','Yeude','Kinsley','Farmiloe','Jelleman','Snepp','Cassella','Campana','Faldoe','Rolston','Egiloff','Wimmers','Codi','Barstow','Boyde','Montgomery','Swaile','Buswell','Barwell','Shadbolt','Andress','Toogood','Zannini','Shadbolt','Cargon','Kumaar','Bonner','Ledgard','Cluatt','Murrill','Jefferson','Spiers','Suckling','Rollinson','Carrigan','Casserly','Esposita','Tomkowicz','Dorsett','Rosentholer','Egleton','Reddle','Waything','Petyankin','Daen','Struss','Pettus','Perell','Thewlis','Oldcote','Cowdrey','Pember','Mullany','Tonna','Killiner','Benitti','Lloyds','Parslow','Boyall','McNeilley','Matijasevic','Maltby','Hugueville','Critchlow','Galey','Aspin','Pauwel','Kiddell','Strowlger','Mc Caughen','Marchbank','Lifsey','Jellicorse','Embling','Scibsey','Twinberrow','Klimkowski','Longland','Kingham','Shillingford','Bratten','Corss','Ickov','Ayrs','Fike','Lynn','Westwick','Crapper','Mapplebeck','Drohan','Hawe','Overstall','Burdfield','Henrych','Tomczykowski','Search','Beseke','Upcraft','Gedney','Gowers','Juris','Vivien','Thirsk','Massimo','Crossthwaite','Rolston','Bingley','Foffano','Poundford','Harroway','Pugh','Pourveer','Brushneen','Smallsman','Jeannet','Bunney','Grundy','Longhorne','Holburn','Studman','Dandison','Alexis','McConnal','Pressey','Dallow','Dives','Dmytryk','Matthaus','Faudrie','Maynell','Bickers','McMorran','Palfreman','Fear','Lockless','Davidsen','Dalyell','Gaspard','Keetley','Greschik','Cardall','Backhouse','Stannering','Vedntyev','Dewdeny','Legrand','Bagnell','Pashan','Zmitruk','Goodband','Marshal','Jeeks','Shedd','Longridge','Sturror','Atty','Standish-Brooks','McNea','Gutherson','Killeley','Blair','Monni','Vannah','Raiker','Curless','Kingwell','Whewell','Sinton','Blinco','Cunniff','Penzer','Elven','Menis','Warters','Greated','Jennions','Dignall','Avrasin','Charnley','Shellibeer','Pepys','Cayzer','Strooband','Clews','Banisch','Carrabott','Zincke','Elkin','Stoven','Klemensiewicz','Brandino','Lindup','Scimoni','Meah','Rawstorn','Bastable','Padson','McNevin','Boissieux','Moiser','Verne','Maudling','Normanvill','Matskiv','Duffet','Norcross','Poter','Sprason','Setter','Le Surf','Mc Grath','Bester','Bleby','Reolfi','Pizzie','Petre','Woodwind','Janicijevic','Kochel','Bruford','Jerzak','Greeno','Manuaud','Macbane','Kobsch','Weetch','Blinerman','Blackey','Mawford','Balmann','Cardillo','Ellwand','Fidgett','Keener','Gapper','Abbett','MacGillacolm','de Leon','McIntosh','Skoof','Burberry','Barthrup','McAughtrie','Shotbolt','Iseton','Blachford','Dacks','Dalliston','Wathan','Harwin','Thow','Coult','Gilbertson','Graser','Sterley','Purchon','Bellam','Stable','Dabney','Tallis','Rosenfelder','Stelle','Wardel','Maraga','Clyne','Lewin','Reschke','Lewsey','Fiske','Kernock','Isac','Savile','Maevela','Zum Felde','McCadden','Hyam','Ondrasek','Burrel','Itzcovich','Guillond','Snoddon','Severns','Falloon','Gilchrist','Linskey','Gadsden','Kittoe','Baynham','Mebes','Glasebrook','Bosley','Cheel','Soldner','Denyakin','Tapin','Frill','Cocozza','Assiratti','Utley','Herrieven','Bake','Treble','Kike','Matejka','Cleator','Scanlin','Breadon','McCarrick','Yancey','Kas','Quarrington','Telfer','McNiven','Offner','Housecroft','McCurdy','Kolczynski','Jollie','Antonoyev','Bealton','Maps','Bowick','Cockren','Shannahan','Greetland','Corter','McEwan','Colleck','Lethem','Bramich','Ryam','Giroldi','Abbie','Brunton','Biswell','Bittleson','Josling','Bowles','Slamaker','California','Dennington','Wharlton','Claiton','Kitchingman','Serraillier','Jinkins','Eshmade','Bellinger','Tames','Kilbane','Townby','Baskwell','Laugier','Whiskerd','Rablen','Tipper','Lemary','Rieger','Gimlet','Gagan','Joules','Crim','Eagleton','Hanna','Cubley','Cullip','Barti','Parrin','Ionn','Segge','Rachuig','Gosalvez','Braban','Baise','Bockmaster','Flintoft','MacKessock','Paladino','Wooler','Padgett','Fuggle','Blaymires','Gethouse','Hanaford','Branca','Jiggins','Catford','Roze','Sewall','Yannikov','Crenage','Windaybank','Elnough','Decort','Aldrin','Roby','Quakley','Patridge','Janosevic','Minmagh','Bracknell','Whether','Gawthrope','Edinburgh','Garbott','Martinovsky','Tobias','Pidler','Roddick','McFfaden','Cotterrill','Boyda','Scanlan','Smy','Deaton','Fontaine','Bellord','Thorndycraft','Cattroll','Donnachie','Snaden','Morat','Pargeter','Renn','Tibb','Paschke','Shankle','Benoey','Coneybeer','Trynor','Burdfield','Dainter','Frogley','Vannuccini','Defrain','Schruyers','Crossdale','Gavriel','Ibbeson','Esson','Sola','Grimbaldeston','Jann','Scrogges','Janda','Theobalds','Luxen','Jackling','Devanney','Leveridge','Houson','Nuzzti','Syder','Sauven','Jacobssen','Gwioneth','Deares','Westcot','Scrivens','Lovatt','Orro','Mosco','Whorlow','Hollyard','Aujean','Scurrell','Anders','Masseo','Patrickson','Roelofsen','Standeven','Grandin','Millberg','Casey','Lowis','Lotze','Mellings','Golsthorp','Cousen','Yapp','Rutley','Joyson','Dessent','Dumbare','Castillou','Cinderey','Rooke','Mattacks','Antwis','Hundy','Marzella','Pineaux','Gisburne','Ferfulle','Dorton','Womersley','Edmott','Titman','Merida','Tytler','Brabbins','Arderne','Straneo','Whitcombe','Greenwell','Broszkiewicz','Orro','Perazzo','Askin','Giacopetti','Dawbury','Gagg','Towns','Gilliard','Samber','Camelli','Ardley','Streatfield','Easey','Ducham','Britten','Boutcher','MacChaell','Chillistone','Pohls','Walbridge','Iacobassi','Maccree','Posselow','Bydaway','Panchen','Bodell','Stackbridge','Bielfelt','Tregale','Dillicate','Schneidau','Mc Menamin','Ritson','Perocci','Hallede','Borsnall','Vayro','Yakovlev','Riddock','Craythorn','Pashba','Adnett','Reedie','Onion','Pittham','Ettritch','Tanswill','Divell','Ferrarini','Pine','Stocken','Anetts','Bloschke','Schwandermann','Ryton','Donativo','Holhouse','Bickerstaff','Colbron','Iiannone','Covill','Rabbet','Durtnal','Rosborough','McMurrugh','Shipston','Enocksson','Molloy','Skyme','Eldrett','Holworth','Akitt','Bereford','Bridgstock','Meryett','Guillotin','Bonder','Olek','Gavey','Beedie','Kinig','Brelsford','Phonix','Crates','Leel','Adamkiewicz','Luthwood','Tolomelli','Rubenczyk','Diggles','Shearn','Beckingham','Bradnick','Yesinov','Huntley','Still','Melpuss','Moyles','Siege','Yousef','Mikalski','Denton','Cottam','Murt','Snoad','Attwater','McNellis','Shotboulte','Dionisetto','Francisco','Traut','Gepson','Hargroves','Beste','Dunning','Whittuck','Mastrantone','Feander','Fancett','Szymanowski','Rands','Beasley','Cumes','Wortman','Croizier','Mortel','Maryon','Gulleford','Procter','Mylchreest','Hinkes','Austins','Lightoller','Kemson','Angelini','Hamments','Stovell','Rickhuss','Blazi','Wilcinskis','Ridgley','Eacle','Spalding','Bratty','Thornally','Argile','Helliker','Crimp','Hammerich','Meryett','Balnaves','Garratty','Rebillard','Hounihan','Dunbar','Maccaddie','Mollene','Dowbakin','Wainscoat','Fishleigh','Radborne','Beseke','Zuanazzi','Stearn','Yurmanovev','Willbond','Seavers','McVeagh','MacShirie','Carrell','Malt','Toal','Masser','Summerlie','Colam','Lilley','Harniman','Moyler','Petera','Coatsworth','Hogsden','Phillp','Athowe','Coltart','Sigsworth','Moylan','Martinelli','Beagles','Ortsmann','Lethbrig','Kindle','Broadway','Orgel','Van Ross','Erickson','Scathard','Detheridge','Toy','Bartelot','Sneyd','Cordeau]','Gurrado','Sterrie','Kincaid','Ogers','Bovaird','Barraclough','Cuskery','Sumpner','Staniforth','Fairhead','Hadwick','Middlewick','Goor','Lamp','Blampied','Coppo','Musico','Peel','Pixton','Troubridge','Kingshott','Silversmidt','Duke','Leisk','Bedrosian','Dingley','Baylis','Mangin','Stelli','Spira','Blaxall','Pauleau','Braunfeld','Tresvina','Sturzaker','Willisch','Domenge','Haworth','Lewknor','Stiggles','Henriet','Assender','Channer','Bromage','Prowse','Cossum','Houlridge','Tinham','Wardhough','Sarsfield','Murphy','MacNess','McInulty','Blaszczak','Nutkins','McTerlagh','Polley','Northfield','Lightwood','Manderson','Segge','Gleadhall','Rolston','Hallam','Traise','Sinnett','Naile','Bonaire','Kubera','McLean','Espinal','Drew','Zanetto','Challiss','Senter','Mose','Boorman','Thorouggood','Annetts','McQueen','Oulet','Schaumann','De Simoni','Marner','Snookes','Dunbabin','Castillou','Conklin','Sheen','Ribou','McCrainor','Mac Giany','Fellgatt','Alleway','McGlaud','Clausner','Mathieson','Borit','Skate','Feeham','Haggerston','Beesley','Mongan','Pahlsson','Andrelli','Ealden','Von Brook','Bridgman','Wimlet','Robertelli','Sclanders','Louca','Wilcock','Belvin','Lauxmann','Hutchinges','Heball','Shepherdson','Putterill','Pettipher','Gillogley','Yearns','Warrack','Job','Bezant','Mowsdale','Feasey','Benedetti','Sansom','Keems','Busen','Campa','Toke','Lownie','Tumility','Smeeton','Shuard','Espinay','Ferreri','Olivia','Belton','Firmage','Blumfield','Aveson');
   prenume_pacient vc_arr:=vc_arr('Zacharias','Wren','Charil','Micky','Kandace','Corilla','Codi','Craggie','Abdul','Frederick','Bradly','Padget','Corette','Alphonse','Leisha','Gaylor','Tremayne','Rouvin','Karena','Hatti','Christan','Coralie','Olympe','Honoria','Garek','Corri','Murial','Aprilette','Sloan','Yard','Larine','Babbette','Lonni','Frederica','Trey','Charmane','Ruthi','Emily','Darelle','Patten','Valera','Kessia','Bay','Gwynne','Egor','Cherianne','Clovis','Newton','Dorine','Flint','Olwen','Rheba','Shaun','Cyb','Roderick','Marco','Zaria','Bearnard','Marita','Sinclair','Kippar','Kaylee','Ward','Lazarus','Lowell','Lynette','Cathleen','Shea','Fredrika','Morena','Jacquelyn','Whitney','Ingrim','Risa','Carmine','Kent','Josselyn','Antin','Chane','Marena','Barnabas','Iorgo','Kienan','Willie','Margeaux','Michael','Keelby','Caye','Allx','Cathi','Biron','Zolly','Aubrey','Carolan','Burr','Bailie','Devin','Pamelina','Patty','Marvin','Brynne','Jacquetta','Osbourne','Jerad','Terrence','Nicolea','Miquela','Alethea','Mandie','Kenny','Kenton','Nettle','Zoe','Avrit','Xever','Stanwood','Morie','Maurise','Nanci','Marja','Flin','Betteann','Yasmin','Dorolice','Ardys','Sax','Joletta','Town','Torrence','Gabriell','Phillip','Matt','Randall','Calley','Adlai','Charla','Moira','Martie','Ingra','Jeanne','Hew','Urbain','Gregg','Enrique','Giustino','Sophi','Jesus','Breena','Seymour','Olvan','Tomkin','Muriel','Doreen','Karmen','Helenelizabeth','Karoly','Farleigh','Harlen','Lucian','Buddy','Carolan','Torrey','Golda','Julianna','Ignatius','Chelsea','Editha','Elberta','Inness','Audry','Daniella','Derril','Roma','Thibaut','Gustave','Kalindi','Rozalie','Babette','Tatiana','Trude','Kissie','Benito','Delcine','Sibylla','Correna','Thorstein','Allyson','Dimitri','Laird','Garik','Mavis','Doll','Erek','Nelie','Sophronia','Simmonds','Pinchas','Ashlee','Nicole','Sky','Farlay','Rustie','Arvin','Marlee','Suzy','Gill','Christi','Delly','Idaline','Aubrey','Tara','Rozalie','Cathryn','Dani','Archibald','Maxine','Lotti','Lyndsay','Shayna','Harwell','Hyman','Pammi','Claire','Elmira','Nelli','Madelena','Rutter','Julie','Julissa','Rhea','Raeann','Quintin','Ellette','Norah','Ettore','Sheelah','Eloise','Allegra','Elsinore','Cleopatra','Rolf','Neilla','Clim','Delcina','Casie','Fenelia','Lib','Eustacia','Barbara','Jaimie','Mollee','Waiter','Guss','Tadeo','Nora','Ericka','Cassaundra','Andonis','Con','Dannel','Harbert','Barbi','Hester','Sallyanne','Melinda','Dasi','Vere','Merrill','Chrotoem','Camellia','Guendolen','Addy','Ambros','Codie','Dulcie','Donny','West','Alexandre','Jorry','Anneliese','Ken','Hedwiga','Vinny','Arleen','Sonya','Taite','Boone','Clarisse','Mandy','Jereme','Kattie','Cris','Wilburt','Ashlen','Simonne','Pearle','Allen','Dorene','Val','Leonidas','Julina','Kat','Brear','Winne','Priscella','Emery','Averill','Thedrick','Alain','Mona','Harrie','Lenna','Yvor','Lorin','Bertie','Benny','Mora','Bernardine','Courtnay','Paul','Giavani','Natalya','Tess','Inna','Corrie','Daphene','Essie','Maynord','Jobie','Laverne','Wyatan','Bert','Tomlin','Patsy','Tobit','Frasquito','Stacy','Eartha','Winnie','Kandace','Margette','Angelica','Carmelle','Thain','Andre','Debera','Lars','Deanna','Jaimie','Hashim','Aubrey','Monty','Marthena','Hurley','Lelia','Karim','Stephen','Levy','Ailsun','Tonia','Kalli','Yolane','Boonie','Ingrid','Barbara','Goldy','Grange','Etienne','Clemmie','Savina','Christel','Brittni','Nonna','Antonetta','Ailina','Franny','Livvie','Mabel','Tyne','Kat','Amby','Moishe','Lilly','Stephine','Vance','Codie','Urbain','Merci','Monroe','Odette','Jackqueline','Daryl','Gizela','Caria','Lilian','Tanner','Ryley','Codie','Maddie','Johnette','Cecelia','Berri','Ev','Hernando','Dorry','Brandtr','Mame','Walden','Jolie','Robina','Jackson','Sky','Minnie','Jena','Opalina','Gilberta','Tulley','Salvatore','Timothee','Tymon','Lynnelle','Cecelia','Francis','Marilee','Lexis','Monique','Rowena','Cecilla','Gweneth','Kasper','Ginny','Napoleon','Janette','Olenka','Irena','Brandon','Minda','Ruthy','Leanor','Carie','Jaimie','Sara','Doloritas','Rodina','Lalo','Ad','Betsy','Aubree','Ola','Renie','Case','Norma','Giffer','Kati','Terza','Calida','Brooks','Kristi','Hebert','Brannon','Oren','Donovan','Harper','Charmaine','Artemis','Netty','Wilbur','Tommie','Juliane','Jack','Gabie','Meredith','Oralie','Kele','Mady','Thedrick','Hurleigh','Derick','Constanta','Cinderella','Alexandrina','Libbi','Harrie','Townsend','Rafaela','Siobhan','Baryram','Vyky','Loy','Mable','Ofella','Gustav','Inge','Ezechiel','Maurits','Oriana','Glenna','Karol','Durant','Kathe','Perkin','Tawnya','Abrahan','Eunice','Evanne','Killy','Luigi','Barry','Sophronia','Nathanial','Margy','Saba','Ludwig','Pinchas','Sergei','Winnah','Silva','Aggi','Freddie','Deana','Claudetta','Boigie','Guendolen','Fidelity','Kyla','Banky','Christa','Abie','Beatrice','Miller','Lyndy','Brandon','Wilbur','Chantal','Teodorico','Orelle','Welby','Niki','Loralyn','Riva','Cosmo','Celestyn','Midge','Bette-ann','Abbe','Vannie','Dell','Missie','Eran','Amargo','Margery','Franky','Noel','Johnathan','Libbi','Ardyce','Malinde','Willey','Danny','Marvin','Emma','Clementine','Cari','Anetta','Doy','Ogden','Rubi','Hortense','Padget','Kingsly','Nerte','Johnath','Lorain','Linc','Jilleen','Matias','Tera','Bevan','Sascha','Natalya','Tiffie','Sarina','Luciana','Milt','Deloris','Pet','Madalyn','Leon','Joela','Dael','Whit','Penni','Bride','Felicia','Welby','Benedetto','Joyous','Sherilyn','Darby','Bo','Burr','Lilas','Annmarie','Rutherford','Janie','Lind','Maribel','Mychal','Thea','Katy','Mignonne','Filmer','Royce','Dasha','Urbain','Dennet','Owen','Amie','Melonie','Ulrika','Lissy','Ardisj','Susie','Rey','Doralin','Markus','Delcine','Titos','Winnie','Pate','Anne','Giulia','Theodosia','Brendon','Morena','Flem','Randi','Julia','Gale','Desiri','Emmy','Dodie','Mabelle','Janaya','Othello','Dal','Frank','Nancee','Lenard','Staffard','Dewitt','Demetre','Mandy','Fraser','Blakeley','Kaleb','Annadiana','Anatole','Amy','Yard','Mariele','Zora','Dorry','Ward','Willem','Waring','Boonie','Jacinthe','Phillis','Duff','Meghann','Dominica','Lorin','Rosana','Leona','Ruperta','Victoria','Brok','Chiquita','Cariotta','Kally','Jo-anne','Dacie','Delmore','Mohandis','Valeria','Elmer','Rheba','Gerard','Letisha','Reggis','Odo','Harbert','Fanchon','Uta','Maddi','Irena','Buffy','Staci','Kacie','Darwin','Brandise','Jennette','Emmye','Carmen','Vivyanne','Marlon','Annie','Mil','Fleming','Peta','Adelind','Joyann','Concettina','Lisha','Charleen','Eirena','Cristy','Lars','Amalia','Pet','Katya','Frederique','Nanice','Lolita','Eleen','Sonya','Sutherlan','Irita','Malia','Waneta','Rinaldo','Donn','Elga','Jamal','Lorne','Suzi','Nicki','Chrisy','Benyamin','Dede','Hewet','Avivah','Melitta','Manuel','Matthus','Ephraim','Godfry','Eimile','Silas','Karine','Pietrek','Dilly','Barbabas','Claude','Freddie','Fonz','Lin','Vinni','Jean','Collette','Maritsa','Dael','Urban','Jennie','Erica','Gillie','Geri','Bronny','Moyra','Flossy','Hercules','Maximilianus','Niles','Dex','Valma','Byran','Korry','Cati','Amelita','Quintilla','Allayne','Ellyn','Markos','Nevile','Ramon','Durante','Alleen','Gerhard','Alfie','Emmye','Hasty','Callida','Whittaker','Fayina','Chev','Lotte','Westley','Lebbie','Tarah','Prue','Madison','Friedrick','Cynthie','Filbert','Fidel','Aguie','Elvyn','Charlotte','Tony','Jilly','Jo','Belia','Laurene','Marylee','Prince','Katharine','Gale','Ware','William','Sosanna','Denni','Evangelina','Erin','Spike','Rosanne','Sandy','Stacy','Merle','Vitia','Cindie','Clevie','Helaina','Iolande','Stan','Ursula','Ash','Marlo','Tammie','Dorelia','Farrell','Mira','Englebert','Sergio','Nicola','Leopold','Rosemarie','Valentino','Cam','Vi','Harman','Ninnette','Winny','Juliann','Noel','Jobyna','Gussie','Andrei','Lusa','Othilia','Rubia','Jedd','Dag','Nevsa','De witt','Joelie','Tasia','Bernelle','Vernice','Orsa','Colver','Travers','Papageno','Agnella','Shalna','Dale','Jordain','Elfie','Gaven','Patricio','Gan','Cosmo','Gard','Jehanna','Nikita','Lilia','Diann','Nikita','Drusie','Dylan','Zack','Melina','Cobby','Annabella','Georgeanna','Anna-diana','Norene','Burlie','Britni','Lewiss','Leif','Aloin','Felipa','Ax','Bonnibelle','Leyla','Nelson','Pinchas','Andie','Hedwiga','Barbabra','Inge','Maurizio','Juliette','Cristin','Analiese','Kennedy','Lemuel','Nadean','Marris','Danya','Gerda','Orbadiah','Jean','Valaria','Devan','Mahalia','Christy','Jeremiah','Robinetta','Fredericka','Cart','Mickie','Clarinda','Bernette','Yolane','Winifield','Berkie','Erina','Bambie','Chryste','Luelle','Donall','Bunni','Ruben','Yetta','Harriot','Clayborne','Yehudit','Raina','Raffaello','Tad','Roy','Edithe','Dynah','Georgeanna','Salomo','Pace','Gawain','Wood','Ingaberg','Neville','Gawain','Lynnet','Lelia','Gayleen','Sue','Shanon','Archibald','Marlowe','Perceval','Mavra','Debee','Annissa','Bettina','Kenyon','Quintus','Buckie','Clarita','Josephine','Allisun','Dario','Edy','Malanie','Risa','Tisha','Pete','Hermine','Aimee','Cherilynn','Spenser','Celinka','Osgood','Richmound','Laureen','Clarita','Antoine','Reuben','Sonya','Sophi');
   
   v_id_pacient pacienti.id_pacient%type;
   v_nume_pacient pacienti.nume%type;
   v_prenume_pacient pacienti.prenume%type;
   v_data_nastere date;
   
   --FISA PACIENT
   lista_boli vc_arr:= vc_arr('Abazie', 'Abces dentar','Abces pulmonar','Abces renal', 'Absintism','Acarioz?','Accident vascular','Acondroplazie','Acromegalie','Adenom','Adenom de prostat?','Aerofagie','Afakie','Afazie','Alcoolism','Amigdalit?','Anemie','Anorexie','Apendicit','Artrit?','Bagasoz?','Balanit?','Balanopostit?','Balonare','Bâlbâial?','Boala Alzheimer','Boala Addison','Boala Batten','Boala Bazin','Boala Boeck','Bron?it? acut?','Bron?it? cronic?','Bruceloz?','Cancer esofagian','Cancer de col uterin','Cancer gastric','Cancer limfatic','Cancer mamar','Cancer nazofaringian','Cancer ovarian','Cancerul pancreatic','Cancer de piele','Cancer de prostat?','Cancer testicular','Cancer de vezic?','Cancer mamar','Cancer pulmonar','Depresie','Diabet insipid','Diabet zaharat','Diaree','Epilepsie','Ebola','Gonoree','Grip?','Hemoragie','Hepatit? viral?','Hepatit?','Impoten??','Indigestie','Infarct miocardic','Infarct pulmonar','Infarct renal','Migren?','Obezitate','Paralizie cerebral?','Peritonita','Rabie','Scorbut');
   
   v_id_fisa  fisa_pacienti.id_fisa%type;
   v_boala fisa_pacienti.boala%type;
   
   --MEDICAMENTE
   denumire_medicament vc_arr:=vc_arr('siltuximab','foscarnet sodium','Magnesium Salicylate Tetrahydrate','Hydrocodone Bitartrate And Acetaminophen','zolpidem tartrate','CHLOROXYLENOL','Antimonium crudum','Argentum nitricum' ,'Carbo vegetabilis','Chelidonium majus','Cinchona officinalis','Graphites','Hydrastis canadensis','Ipecacuanha','Kali carbonicum','Lycopodium clavatum','Nux vomica','Pulsatilla','paroxetine hydrochloride','hydrocodone bitartrate and acetaminophen','Miconazole nitrate','RISPERIDONE','Sodium Nitrite and Sodium Thiosulfate','Venlafaxine Hydrochloride','Atenolol','MOXIFLOXACIN HYDROCHLORIDE','Eastern White Pine','Acetaminophen','green bell pepper','simvastatin','Turpentine','BENZALKONIUM CHLORIDE','CLONIDINE HYDROCHLORIDE','Propantheline Bromide','topiramate','penciclovir','TRICLOSAN','Benzoyl Peroxide','rye','Tolnaftate','Potassium Chloride','benzoyl peroxide','chastetree, oatstraw, potassium hydrate, common salt, cuttle fish','THYROID, PORCINE','Doxycycline','clindamycin phosphate','Aluminum Sesquichlorohydrate','SALICYLIC ACID','Chlorpromazine Hydrochloride','alcohol','ETHYL ALCOHOL','juniperus virginiana pollen','Desmopressin acetate','metoclopramide','ZINC OXIDE','Sulfamethoxazole and Trimethoprim','Aluminum Zirconium Tetrachlorohydrex GLY','AVOBENZONE, HOMOSALATE, OCTISALATE, OCTOCRYLENE, OXYBENZONE','permethrin','ALCOHOL','levalbuterol hydrochloride','Fluocinonide','Aureobasidium pullulans','Paroxetine Hydrochloride','SODIUM MONOFLUOROPHOSPHATE','drospirenone and ethinyl estradiol','Pigweed Spiny','Cerebellum Thalamus A Aurum','Diclofenac Sodium and Misoprostol','fexofenadine hydrochloride','Mineral oil, petrolatum, phenylephrine hcl','ATORVASTATIN CALCIUM','Lisinopril and Hydrochlorothiazide','fenofibrate','methylprednisolone','Levothyroxine Sodium','calcium polycarbophil','Escitalopram Oxalate','pioglitazone','petrolatum','Triclosan','Colocynthis, Antimonium tartrate, Kali carbonate, Bryonia, Nux vomica','Tolnaftate','50 Remedy Kit','Magnesium Salicylate Tetrahydrate','Oxygen','Iceberg Lettuce','Lorazepam','Benzalkonium chloride','Tizanidine','ziprasidone hydrochloride','ribavirin','Levetiracetam','Alcohol','Amoxicillin','House Dust','MENTHOL, PRAMOXINE HYDROCHLORIDE','Mirtazapine','Inflammation I','Bumetanide','temazepam','Calcitriol','Neomycin sulfate, Polymyxin B Sulfate, and Dexamethasone','Glyburide','olanzapine','Eucalyptol, Menthol,Methyl Salicylate, Thymol','Docusate sodium','Ibuprofen','ANTHOXANTHUM ODORATUM POLLEN, DACTYLIS GLOMERATA POLLEN, LOLIUM PERENNE POLLEN, PHLEUM PRATENSE POLLEN, and POA PRATENSIS POLLEN','Isoniazid','Acetaminophen, Dextromethorphan HBr, Doxylamine succinate','Methylene Blue','Arizona Cypress','Sulfacetamide Sodium and Sulfur','Dextromethorphan Hydrobromide, GUAIFENESIN','Guaifenesin, Dextromethrophan HBR','Octinoxate and Titanium dioxide','Oxymorphone Hydrochloride','Sennosides','Benzoyl Peroxide','Docusate Sodium','PREGABALIN','Latanoprost','rizatriptan benzoate','glyburide','Sulfadiazine','Octinoxate, Octisalate, Oxybenzone, and Titanium Dioxide','SODIUM FLUORIDE','Ceftriaxone','ATORVASTATIN CALCIUM','Hand Wash','HYDROQUINONE','CycloSPORINE','Midazolam HCl','TRICLOSAN','ACONITUM NAPELLUS, HYPERICUM PERFORATUM, LYCOPODIUM CLAVATUM SPORE','PHOSPHORUS, TOXICODENDRON PUBESCENS LEAF, and CLAVICEPS PURPUREA SCLEROTIUM','nicotine','Coffee','picea pungens pollen','Glycopyrrolate','morphine sulfate','Hydrocodone Bitartrate and Acetaminophen','Sodium Fluoride','Lisinopril','nifedipine','loperamide HCl','Benztropine Mesylate','Oxcarbazepine','Baclofen','Bupropion Hydrochloride','Morphine Sulfate','Topiramate','LISINOPRIL AND HYDROCHLOROTHIAZIDE','Sennosides A and B','Short Ragweed Pollen','Metronidazole','Nicotine Polacrilex','OCTINOXATE, OXYBENZONE','calendula officinalis, thuja occidentalis','Lisinopril','ketorolac tromethamine','Treatment Set TS340053','PRAVASTATIN SODIUM','Lorazepam','Hydrocodone Bitartrate and Acetaminophen','Glyburide','metoprolol tartrate','SALICYLIC ACID','Aquilegia vulgaris, Avena sativa, Chamomilla, Coffea cruda, Cypripedium pubescens','Humulus lupulus, Hypericum perforatum, Kali phosphoricum,','BENZOCAINE','benzocaine','Neostigmine Methylsulfate','Sodium Fluoride','TETRACYCLINE HYDROCHLORIDE','ZONISAMIDE','OCTINOXATE and TITANIUM DIOXIDE','docusate sodium and sennosides','Oxygen','Naproxen','Fexofenadine Hydrochloride','TITANIUM DIOXIDE, ZINC OXIDE','Methylergonovine Maleate','Dextromethorphan Hydrobromide and Guaifenesin','LORATADINE','Strawberry','Tolnaftate','Oxytocin','Amethyst Rosa Clear Skin','Hydromorphone Hydrochloride','OCTINOXATE, OXYBENZONE, OCTISALATE, AVOBENZONE','Paroxetine','Ranitidine','Pyrithione Zinc','Aesculus Hippocastanum Bark, Aconitum Napellus, Colchicum Autumnale Bulb, Hypericum Perforatum','Magnesium Phosphate','Dibasic Trihydrate, Lead, Toxicodendron Pubescens Leaf, Arnica Montana','HYDROGEN PEROXIDE','nebivolol hydrochloride','Aspirin','INTERLEUKIN-8','TITANIUM DIOXIDE, OCTINOXATE','Atorvastatin Calcium','Nicotine Polacrilex','Alcohol','Acetaminophen, Chlorpheniramine maleate, Pseudoephedrine HCl','fluticasone propionate and salmeterol','aluminum zirconium tetrachlorohydrex gly','Ondansetron hydrochloride','ETHYL ALCOHOL','Tretinoin','Ezetimibe/Simvastin','DEXTROMETHORPHAN HYDROBROMIDE, PHENYLEPHRINE HYDROCHLORIDE','dextromethorphan hydrobromide, guaifenesin, phenylephrine hydrochloride','Glycerin, Hypromelloses, Polyethylene Glycol 400, Tetrahydrozoline Hydrochloride, and Zinc Sulfate','Hydrocodone Polistirex and Chlorpheniramine Polistirex','diltiazem hydrochloride','Pseudoephedrine Hydrochloride','OCTINOXATE','HYDROCODONE, ACETAMINOPHEN, .GAMMA.-AMINOBUTYRIC ACID','HYDROCODONE BITARTRATE AND ACETAMINOPHEN','not applicable','AGRAPHIS NUTANS','Carelessweed','TOLNAFTATE','Short Ragweed Pollen','Salicylic Acid','Bicalutamide','fentanyl','TRICLOSAN','Psorinum , Staphisagria , Viola tri','Bromfenac Ophthalmic Solution, 0.09%','PINE NEEDLE OIL (PINUS SYLVESTRIS) SAMBUCUS NIGRA FLOWER CALENDULA OFFICINALIS FLOWER ECHINACEA ANGUSTIFOLIA','Gabapentin','ZINC OXIDE','Aconitum Napellus, Gnaphalium Polycephalum, Ledum Palustre, Magnesia Phosphorica, Rhus Toxicodendron','Acetaminophen','capsaicin','LISINOPRIL AND HYDROCHLOROTHIAZIDE','Hydrocortisone','Onion','ziprasidone hydrochloride','Guaifenesin and Codeine Phosphate','Trimethobenzamide Hydrochloride','Articaine Hydrochloride and Epinephrine Bitartrate','Lisinopril','ibuprofen','atenolol','Venlafaxine Hydrochloride','Menthol','Treatment Set TS334946','Methylphenidate Hydrochloride','Chloroquine Phosphate','Zinc oxide','irbesartan and hydrochlorothiazide','PENICILLIUM CHRYSOGENUM','Levothyroxine Sodium','Duloxetine','Torsemide','Guaifenesin and Codeine Phosphate','Butabarbital Sodium','Amlodipine Besylate','Methenamine Hippurate','Ibuprofen','Octinoxate and Titanium dioxide','lacosamide','CEFOXITIN SODIUM','darbepoetin alfa','TENOFOVIR DISOPROXIL FUMARATE','Acetaminophen','Titanium Dioxide','Titanium Dioxide','lansoprazole','Titanium Dioxide, Ethylhexyl Methoxycinnamate, Ethylhexyl Salicylate, Zinc Oxide','Olanzapine and Fluoxetine','perampanel','Penicillin V Potassium','Hydrocortisone','Glycerin, Hypromelloses, Polyethylene Glycol 400, Tetrahydrozoline Hydrochloride, and Zinc Sulfate','Avobenzone, Homosalate, Octisalate and Octocrylene','Acetaminophen','hydrocodone bitartrate','octinoxate and oxybenzone','Hydromorphone HCl','Aspirin and Caffeine','OXYGEN','Camphor Menthol Menthyl Salicylate','Sumatriptan','Benzalkonium chloride','colistin sulfate, neomycin sulfate, thonzonium bromide, and hydrocortisone acetate','Acetaminophen, Doxylamine Succinate, Phenylephrine HCl','Titanium Dioxide and Zinc oxide','Acetaminophen, Phenylephrine HCl','Warfarin Sodium','POTASSIUM CHLORIDE','Famotidine','Titanium Dioxide and Zinc Oxide','Bacitracin Zinc, Neomycin Sulfate, Polymyxin B Sulfate','Triclosan','hydrochlorothiazide','TITANIUM DIOXIDE and OCTINOXATE','OCTINOXATE','White Petrolatum','Clorazepate Dipotassium','permethrin','Arsenicum Album, Bryonia, Cuprum Aceticum, Drosera, Ipecacuanha, Kali Carbonicum, Phosphorus','Diphenhydramine HCl, Zinc acetate','Octinoxate and Titanium Dioxide','sildenafil citrate','Desipramine Hydrochloride','LIDOCAINE HYDROCHLORIDE','Dextroamphetamine Saccharate, Amphetamine Aspartate, Dextroamphetamine Sulfate and Amphetamine Sulfate','Doxylamine succinate','Niacinamide, Adenosine','Salicylic Acid','Hydrochlorothiazide','MICONAZOLE NITRATE','varenicline tartrate','Aspirin','Octocrylene and Octinoxate','Ampicillin','Buspirone Hydrochloride','NITROFURANTOIN','Menthol','repaglinide','TITANIUM DIOXIDE','warfarin sodium','Dextroamphetamine Sulfate','Nystatin','Salicylic Acid','ALCOHOL','Octinoxate, Oxybenzone','Isoniazid','Loratadine and pseudoephedrine sulfate','Triclosan','Warfarin Sodium','Octinoxate and Zinc Oxide','Hydrocodone Bitartrate and Acetaminophen','Zinc Oxide','White Hickory','lorazepam','ibuprofen','Acetaminophen','Warfarin Sodium','Nicotine polacrilex','Metformin Hydrochloride','POTASSIUM CHLORIDE','Titanium Dioxide and Zinc Oxide','Lisinopril','Levetiracetam','Gabapentin','Meclizine HCl','Flumazenil','THYROIDINUM, RHAMNUS FRANGULA, FUCUS VESICULOSUS, KALI IODATUM','topiramate','Antifungal Liquid Spray','Olanzapine','Aluminum zirconium tetrachlorohydrex gly','venlafaxine hydrochloride','Cefuroxime Axetil','Hydrocodone Bitartrate and Acetaminophen','Salsalate','Fosinopril Sodium and Hydrochlorothiazide','Levothyroxine Sodium','oxycodone hydrochloride and acetaminophen','ceftazidime','Alcohol','mineral/vitamin supplement','Chloroxylenol','Treatment Set TS329678','SALICYLIC ACID','Midazolam HCl','Clonidine','OCTINOXATE, OXYBENZONE','Ibuprofen','topiramate','Belladonna, Conium Maculatum, Dulcamara, Ferrum Phosphoricum, Hepar Sulphuris Calcareum, Kali Bichromicum','Dimenhydrinate','Allopurinol','ALCOHOL','aspirin','Maple, Hard Acer saccharum','Toothpaste','metformin hydrochloride','Hydrocodone bitartrate and acetaminophen','TOXICODENDRON VERNIX LEAFY TWIG','Losartan Potassium','HEPARIN SODIUM','Ibuprofen','Nitroglycerin','Alendronate Sodium','Octinoxate, Octisalate, Zinc Oxide, Titanium Dioxide','Metoprolol tartrate','Aspergillus Mixture','Birch','warfarin sodium','clarithromycin','Amoxicillin','Aluminum Zirconium Trichlorohydrex Gly','Fludeoxyglucose F-18','Venlafaxine Hydrochloride','hydroquinone','Isosorbide Dinitrate','Clotrimazole','ENALAPRIL MALEATE','Bermuda Grass Smut','divalproex sodium','LEVETIRACETAM','Metoclopramide Hydrochloride','Lidocaine Hydrochloride','Torsemide','Octinoxate','Sugar Beet','GLIMEPIRIDE','CHAMOMILLA, CALCAREA PHOSPHORICA, COFFEA CRUDA, BELLADONNA','Zinc Oxide','Titanium dioxide and Zinc oxide','ETHYL ALCOHOL','Sweet Corn','SODIUM CHLORIDE','Bahia Grass','acremonium strictum','Lisinopril','Nicotine Polacrilex','Triclosan','Lisinopril and Hydrochlorothiazide','Alprazolam','valacyclovir hydrochloride','Nitrous Oxide','pyrithione zinc','Galantamine','Amitriptyline Hydrochloride','Acetaminophen','imipramine hydrochloride','Tall Ragweed','Tetrofosmin','Echinacea angustifolia','Iodium, Adrenalinum, Argentum metallicum','Oxygen','telmisartan and hydrochlorothiazide','Ferrum Quartz','chlorhexidine gluconate and isopropyl alcohol','Zinc Oxide','Neomycin sulfate, Polymyxin B Sulfate, and Dexamethasone','Sildenafil citrate','benzalkonium chloride','lansoprazole','Diphenhydramine HCl','Levofloxacin','Menthol','Equisetum Viscum','OCTINOXATE','PREDNISONE','Anticoagulant Citrate Phosphate Dextrose (CPD) Solution and ADSOL Preservation Solution','Fluconazole','Ropinirole Hydrochloride','Octinoxate and Titanium Dioxide','Ranitidine Hydrochloride','Alcohol','Norethindrone','AVOBENZONE, OCTOCRYLENE, OXYBENZONE','Sotalol Hydrochloride','Oxycodone Hydrochloride','Duloxetine Hydrochloride','TC 99M MEDRONATE','Amoxicillin and Clavulanate Potassium','Guaifenesin','Acetaminophen','Ofloxacin','Arsenicum album, Asarum europaeum, Avena sativa, Bryonia, Capsicum annuum, Carbo vegetabilis','Carvedilol','ALUMINUM CHLOROHYDRATE','Mineral oil','Avobenzone, Homosalate, Octinoxate, Octisalate, Octocrylene, Oxybenzone','Timolol Maleate','Polyethylene glycol, Propylene glycol','Petrolatum','Alendronate Sodium','Ranitidine','paroxetine hydrochloride','Vinorelbine','verapamil hydrochloride','Avobenzone, Homosalate, Octisalate, Octocrylene and Oxybenzone','Ibuprofen','oxycodone hydrochloride','Trout','Bisacodyl','Citalopram','Acetaminophen, Chlorpheniramine maleate, Phenylephrine HCl','Hydralazine Hydrochloride','ethyl alcohol','calendula officinalis, thuja occidentalis','Acetaminophen, Dextromethorphan Hydrobromide, Guaifenesin, Phenylephrine Hydrochloride','Etodolac','Sulfur Colloid','methyl salicylate, menthol, capsaicin','Green Ash','Bisacodyl','Apis Mellifica, Carbolicum Acidum, Ledum Palustre','Loperamide Hydrochloride','BARIUM SULFATE','titanium dioxide','OCTINOXATE, OCTISALATE, and ZINC OXIDE','memantine hydrochloride','Metoprolol succinate','Piperonly Butoxide, Pyrethrum Extract','Ferric Oxide Red, Zinc Oxide, and Pramoxine Hydrochloride','Salicylic Acid','Acetaminophen and Diphenhydramine Citrate','loratadine and pseudoephedrine','oxycodone hydrochloride and acetaminophen','azithromycin dihydrate','Water Hemp','docusate sodium','Sirolimus','Octinoxate and Titanium dioxide','ONION','BENZALKONIUM CHLORIDE','Dextromethorphan Hydrobromide, Guaifenesin','Salicylic Acid','acarbose','Lisinopril','Iceberg Lettuce','Benzalkonium Chloride','Aspirin','OTC ANTIPRESPIRANT DRUG PRODUCT','Arsenicum album, Chelidonium majus, Coccus cacti','Echinacea angustifolia, Hydrastis canadensis, Lycopodium clavatum,','ALUMINUM SESQUICHLOROHYDRATE','ERYTHROMYCIN ETHYLSUCCINATE AND SULFISOXAZOLE ACETYL','leucovorin calcium','Glipizide','PRAMIPEXOLE DIHYDROCHLORIDE','clonidine hydrochloride','SAFFLOWER OIL, SOYBEAN OIL, and EGG PHOSPHOLIPIDS','Tetrahydrozoline HCI','Cimetidine Hydrochloride Oral Solution','Acetaminophen, Dextromethorphan Hydrobromide, Doxylamine Succinate','Nortriptyline Hydrochloride','Losartan Potassium and Hydrochlorothiazide','SODIUM MONOFLUOROPHOSPHATE','ANTIMONIUM CRUDUM','Dock Sour Sheep Sorrel','OCTINOXATE, OCTISALATE','topiramate','Octinoxate Titanium Dioxide','Witch Hazel','Aluminum Zirconium Tetrachlorohydrex GLY','Acetaminophen, Chlorpheniramine Maleate, Dextromethorphan Hydrobromide, Phenylephrine Hydrochloride','HUMAN IMMUNOGLOBULIN G','ISodium Chloride','linezolid','Sodium Chloride','PHOMA HERBARUM','Omeprazole','Mafenide acetate','Aluminum Zirconium Tetrachlorohydrex GLY','Menthol','ANASTROZOLE','clindamycin','ACETAMINOPHEN, DIPHENHYDRAMINE HYDROCHLORIDE','amoxicillin and clavulanate potassium','clorazepate dipotassium','OCTINOXATE, TITANIUM DIOXIDE','Medulla Arnica','Daily moisturizing','doxycycline hyclate','STAR ANISE','Dextromethorphan Hydrobromide and Guaifenesin','GABAPENTIN','Sodium Fluoride','POTASSIUM CARBONATE','Omeprazole','Octinoxate and Titanium Dioxide','Coal Tar','amlodipine besylate and benazepril hydrochloride','Ibuprofen','Bumetanide','Estradiol','AVOBENZONE HOMOSALATE OCTISALATE OCTOCRYLENE OXYBENZONE','Benzocaine','Docusate sodium','Famciclovir','Thyroid Stimulating Hormone (Bovine)','Triclosan','Green Pea','Arnica Nettle Essence','Clonidine Hydrochloride','Duloxetine hydrochloride','Ponderosa Pine','menthol, methyl salicylate','Fosinopril Sodium and Hydrochlorothiazide','Salicylic Acid','telmisartan','Levetiracetam','Feather Mix','lamotrigine','hepatitis A vaccine, inactivated','Carbamazepine','Alternaria alternata','Nifedipine','RANITIDINE','Magnesium Chloride','oxcarbazepine','Sodium Fluoride','Levomefolate Calcium and Algal Powder','cetrorelix acetate','zinc oxide','Norethindrone','Avobenzone, Octinoxate, Octisalate, Oxybenzone','Luffa, Hydrastis Canadensis, Mercurius Sulph. Rub, Allium Cepa, Natrum Muriticum, Phosphorus, Eupatorium Perf, Sticta','dextran 70, hypromellose 2910','Amoxicillin','Hydroxyurea','OCTINOXATE and TITANIUM DIOXIDE','liothyronine sodium, LEVOTHYROXINE SODIUM','pyrithione zinc','BENZALKONIUM CHLORIDE','thiamine hydrochloride','Olanzapine','Mineral Oil','cilostazol','MOSCHUS MOSCHIFERUS MUSK SAC RESIN','Disulfiram','Acetaminophen, Caffeine','isopropyl alcohol','TITANIUM DIOXIDE, OCTINOXATE','Fusarium oxysporum','In-111 DTPA','TIZANIDINE HYDROCHLORIDE','Bupropion Hydrochloride','Chrysosplenium Chamomilla','White Poplar','Salicylic Acid','Betamethasone Valerate','polyethylene glycol 400 and Propylene Glycol','OCTINOXATE, TITANIUM DIOXIDE, and ZINC OXIDE','Glipizide and Metformin Hydrochloride','Apis Mell.','DIAZEPAM','Magnesium Hydroxide','Ipratropium Bromide','Brazil Nut Bertholletia excelsa','Oxygen','Nortriptyline Hydrochloride','NOT APPLICABLE','Hydrocodone Bitartrate And Acetaminophen','Benzoin Resin','glimepiride','ibuprofen','glipizide','acetaminophen and codeine phosphate','Hydrocortisone Valerate','EUCALYPTOL THYMOL','Imipramine Hydrochloride','Enteric Aspirin','Aluminum hydroxide, Magnesium hydroxide, Simethicone','Midazolam hydrochloride','moxifloxacin hydrochloride','Acetaminophen and Phenyltoloxamine Citrate','Memantine Hydrochloride','Acetazolamide','Miller Moth','Sodium Citrate','acetaminophen, dextromethorphan Hbr, Phenylephrine HCl','Aconitum napellus, Arnica Montana, Arsenicum album, Bellis Perennis, Cartilago suis, Causticum, Chamomilla, Coffea cruda,','ingenol mebutate','GENTAMICIN SULFATE','Phosphorus comp.','Oxymetazoline Hydrochloride','BUPIVACAINE HYDROCHLORIDE','DOPAMINE HYDROCHLORIDE','Octinoxate and Oxybenzone','Erythromycin Ethylsuccinate','Octinoxate and Titanium Dioxide','Enoxaparin Sodium','Bacitracin','Aluminum Zirconium Tetrachlorohydrex Gly','tobramycin','Cefuroxime Sodium','Lisinopril','OCTINOXATE, TITANIUM DIOXIDE','epoetin alfa','Sumatriptan Succinate','Aluminum Chlorohydrate','Clotrimazole','somatropin','Ergotamine Tartrate and Caffeine','Pseudoephedrine Hydrochloride','clonidine hydrochloride','sertraline hydrochloride','Benzoyl Peroxide','Trazodone Hydrochloride','VALACYCLOVIR HYDROCHLORIDE','FUROSEMIDE','Venlafaxine','pink salmon','Benzalkonium Chloride','Octinoxate and Oxybenzone','Minocycline Hydrochloride','Alprazolam','TITANIUM DIOXIDE, OCTINOXATE, ZINC OXIDE','calcium carbonate','OCTINOXATE','Methadone Hydrochloride','Oxygen','TITANIUM DIOXIDE, OCTINOXATE, ZINC OXIDE','Erythromycin Ethylsuccinate','Losartan Potassium','metaxalone','Avobenzone, Octisalate, Oxybenzone and Octocrylene','Divalproex Sodium','Hydroxyzine Hydrochloride','Alcohol','Lamotrigine','Ragweed, Giant Ambrosia trifida','lansoprazole, amoxicillin and clarithromycin','Triclosan','Octinoxate, Octisalate, Avobenzone','zolpidem tartrate','dextromethorphan polistirex','Piperacillin and Tazobactam','amlodipine besylate and atorvastatin calcium','OCTINOXATE','Fentanyl Citrate','Cilostazol','ropinirole hydrochloride','Allantoin','Standardized Grass Pollen, Timothy','Ranitidine','Irbesartan','Aspen','Titanium Dioxide, Octinoxate, Zinc Oxide','Nabumetone','dibasic sodium phosphate, monobasic sodium phosphate','Bacitracin Zinc, Neomycin Sulfate, Polymyxin B Sulfate, and Pramoxine Hydrochloride','Salicylic Acid','Alcohol','Desoximetasone','White Oak','acetaminophen, dextromethorphan hydrobromide, guaifenesin, and phenylephrine hydrochloride','povidine iodine','Triclosan','Amlodipine besylate and Atorvastatin calcium','Acetaminophen','Lidocaine HCl and Hydrocortisone Acetate','Oxygen','Ofloxacin','BACITRACIN ZINC','Fluoxetine Hydrochloride','Meclizine Hydrochloride','Dextromethorphan Hydrobromide, Guaifenesin, Phenylephrine Hydrochloride','Benzoyl Peroxide 10%','Octinoxate, Octisalate, Avobenzone','Clorazepate Dipotassium','Dextroamphetamine Saccharate and Amphetamine Aspartate and Dextroamphetamine Sulfate and Amphetamine Sulfate','Benzocaine','meclizine hydrochloride','Ibuprofen, Pseudoephedrine Hydrochloride','Octinoxate and Titanium dioxide','AMITRIPTYLINE HYDROCHLORIDE','Standardized Mite, Dermatophagoides farinae, Scratch or Bulk, 30000 AU per mL','OXYGEN','Ethyl Alcohol','Tobramycin','Argentum nitricum 12X, Arnica montana, radix 30X, Arum maculatum 12X, Calcarea carbonica 30X, Phosphorus 30X','Avobenzone, Octisalate, Octocrylene, and Oxybenzone','Calcitriol','clobetasol propionate','Titanium dioxide','Benzalkonium Chloride, Lidocaine Hydrochloride','Benzalkonium chloride','Warfarin Sodium','Coenzyme Q-10, Cyanocobalamin, Folic acid, L-carnitine, Taurine, Biotin, Proline,','pioglitazone hydrochloride','Titanium Dioxide','Pulmo Tartarus 6/8','Sertraline Hydrochloride','Regular Strength','Nabumetone','ACETAMINOPHEN, ASPIRIN AND CAFFEINE','Naproxen Sodium','Benzoyl Peroxide','lactic acid, l-','Triamterene and hydrochlorothiazide','Glycerin','Aspergillus terreus','Amoxicillin','Pyrithione Zinc','Disopyramide Phosphate','Zinc Oxide','Cyclobenzaprine Hydrochloride','Acetaminophen','lorcaserin hydrochloride','cefotaxime sodium','Enalapril Maleate','Phytolacca decandra, Trifolium pratense, Xanthoxylum fraxineum, Arsenicum album,','Methenamine, Sodium Phosphate Monobasic, Phenyl Salicylate, Methylene Blue, Hyoscyamine Sulfate','RIFAMPIN, ISONIAZID, PYRAZINAMIDE','Ranitidine','benzocaine','PREDNISONE','Thuja Occidentalis','Sodium Fluoride and Hydrofluoric Acid','Medicated Foot Powder','Glimepiride','acetylcysteine','Air','ETHYL ALCOHOL','cinacalcet hydrochloride','Camphor, Menthol, Methyl salicylate','Bismuth subsalicylate','Helium','menthol, methyl salicylate','simvastatin','Avobenzone, Octinoxate, Octisalate, Octocrylene, Oxybenzone','OCTINOXATE, OCTISALATE, OXYBENZONE, and TITANIUM DIOXIDE','testosterone','BETHANECHOL CHLORIDE','Aspirin','BENZOCAINE, BUTAMBEN, TETRACAINE HYDROCHLORIDE','Valsartan and Hydrochlorothiazide','theophylline anhydrous','Naproxen Sodium','Hydroxyzine','SALICYLIC ACID','Pantoprazole Sodium','Sennosides and Docusate Sodium','Fexofenadine Hydrochloride','Dronedarone','ATAZANAVIR SULFATE','Nicotine polacrilex','GLYCERIN','Aspergillus niger','Amitriptyline Hydrochloride','cisplatin','Povidone-iodine','Telmisartan and Amlodipine','Duloxetine hydrochloride','Erythromycin Ethylsuccinate','Acetaminophen','Eucalyptus','Piperonyl butoxide, Pyrethrum extract','mometasone furoate and formoterol fumarate dihydrate','OCTINOXATE, TITANIUM DIOXIDE','Nortriptyline Hydrochloride','KETOROLAC TROMETHAMINE','Acetaminophen','anastrozole','Famotidine','Black Willow','Standardized Grass Pollen, Ryegrass','Saline','Irbesartan and Hydrochlorothiazide','Coumarinum, Phenyl Isothicyanate, Intestine, Ascorbic Acid, Coenzyme A, Coenzyme Q 10, Colon, Lung','Cilostazol','Ziprasidone Hydrochloride','Zolpidem Tartrate','Octinoxate','Menthol','levonorgestrel','Famotidine','Cefazolin','OCTINOXATE, OCTISALATE, OCTOCRYLENE, ENSULIZOLE, TITANIUM DIOXIDE, OXYBENZONE','HYDROQUINONE','Acetaminophen and Codeine Phosphate','Isosorbide Mononitrate','varenicline tartrate','Octinoxate, Oxybenzone, Titanium Dioxide','LAMOTRIGINE','Oxygen-Nitrogen Mixture','Drospirenone and ethinyl estradiol','Pyrithione Zinc','avobenzone, homosalate, octisalate, octocrylene','Tramadol Hydrochloride','OCTINOXATE','Ethyl Alcohol','Imipramine Hydrochloride','Desoximetasone','Sertraline Hydrochloride','chloroxylenol','Pyrilamine Maleate and Phenylephrine Hydrochloride','Dimenhydrinate','Bismuth Subsalicylate','DEXTROSE MONOHYDRATE','Polymyxin B Sulfate and Bacitracin Zinc','clobetasol propionate','ropinirole','LISINOPRIL AND HYDROCHLOROTHIAZIDE','Amino Acids','Fluoxetine','Oxcarbazepine','Sodium Fluoride','Zolpidem Tartrate','Azathioprine','carbachol','Fluconazole','morphine sulfate','SODIUM FLUORIDE','acetylcysteine','CEFACLOR','Aspirin','risperidone','Bacitraycin','amoxicillin','Lithium Carbonate','Heparin Sodium','Titanium Dioxide and Zinc Oxide','Avobenzone, Homosalate, Octisalate, Octocrylene, and Oxybenzone','Nitroglycerin','Pollens - Weeds, Dock/Sorrel Mix','Docusate Sodium','Cedar Red','Fludeoxyglucose F-18','memantine hydrochloride','Gabapentin','Pramipexole Dihydrochloride','acetaminophen, dextromethorphan Hbr, Phenylephrine HCl','Dexamethasone','Beech','TOLNAFTATE','Treatment Set TS349358','PREDNISONE','MIDAZOLAM HYDROCHLORIDE','Octinoxate and Oxybenzone','HEPARIN SODIUM','zinc acetate','Quinidine Gluconate','Levetiracetam','Phenytoin Sodium','spironolactone','Mineral oil, Petrolatum, Phenylephrine HCl, Shark liver oil','Birch','SALICYLIC ACID','diphenhydramine hydrochloride and zinc acetate','Aluminum Zirconium Tetrachlorohydrex GLY','Clonidine','prednisone','Glycerin','carbidopa and levodopa','Sodium Pyruvate, Inosine, Adenine, Sodium Phosphate, Dibasic, and Sodium Phosphate, Monobasic, Monohydrate','Menthol, Camphor, Methyl Salicylate','bisacodyl','Hydroxyzine Hydrochloride','Aluminum Chlorohydrate','Dextromethorphan Hydrobromide, Guaifenesin, Phenylephrine Hydrochloride','cimetidine','Capecitabine','Nafcillin Sodium','Olanzapine','risperidone','Amlodipine besylate','Amlodipine Besylate','Glyburide (micronized) and Metformin Hydrochloride','ALCOHOL','Omeprazole','Potassium Chloride','bacillus firmus','TRIAMCINOLONE ACETONIDE','LIDOCAINE, MENTHOL','Stannous Fluoride','fluticasone propionate and salmeterol','cetirizine hydrochloride','glyburide','Homosalate, Octinoxate, Octisalate, Oxybenzone, Titanium Dioxide, and Zinc Oxide','Loperamide Hydrochloride','Bacitracin Zinc','AVOBENZONE, OCTINOXATE, OCTISALATE, OCTOCRYLENE','Venlafaxine Hydrochloride','Arnica Nettle Burn and Bite Special Order','Econazole Nitrate','ferrous gluconate, folic acid, cyanocobalamin, ascorbic acid and docusate sodium','ATORVASTATIN CALCIUM','Levothyroxine sodium','tetradecyl hydrogen sulfate (ester)','hyoscyamine sulfate','chlorthalidone','methylprednisolone','California Pepper Tree','DIMETHICONE','Octinoxate and Titanium dioxide','Metoprolol Tartrate','Ibuprofen','Amnion 30','Probenecid','fenofibric acid','SODIUM FLUORIDE and POTASSIUM NITRATE','Titanium Dioxide and Octinoxate','morphine sulfate','ALCOHOL','norgestimate and ethinyl estradiol','AVOBENZONE, HOMOSALATE, OCTISALATE, OCTOCRYLENE','Amlodipine Besylate and Benazepril Hydrochloride','Doxazosin Mesylate','Sumatriptan Succinate','Phytonadione','water','CARBOXYMETHYLCELLULOSE SODIUM, GLYCERIN','Oxycodone and Acetaminophen','Ketoprofen','coagulation factor ix (recombinant)','Alcoscrub Foam','OCTINOXATE, OXYBENZONE');
   
   v_stoc medicamente.stoc%type;
     v_id_med1 medicamente.id_medicament%type;
     v_id_med2 medicamente.id_medicament%type;
     v_id_med3 medicamente.id_medicament%type;
     v_id_med4 medicamente.id_medicament%type;
     v_id_med5 medicamente.id_medicament%type;
     v_id_med6 medicamente.id_medicament%type;
     v_id_med7 medicamente.id_medicament%type;
     v_id_med8 medicamente.id_medicament%type;
   
   --TRATAMENTE
   v_data_sfarsit_tratament tratamente.data_sfarsit_tratament%type;
   v_data_inceput_tratament tratamente.data_inceput_tratament%type;
  
   v_contor int := 1;
   id_sectie_rep vc_arr;
   id_sala_rep vc_arr;
   id_medic_rep vc_arr;
   id_pacient_rep vc_arr;
   id_meds_rep vc_arr;
   id_salon_rep vc_arr;
   id_internare_rep vc_arr;
   data_tratam internari.data_internare%type;
   v_shift number(2);
   v_hour varchar2(5);
   v_nr_meds number(1);
   v_lista_dim number(5);
   
BEGIN

    select id_sectie  bulk collect into id_sectie_rep
   from sectii;
   select id_pacient bulk collect into id_pacient_rep from pacienti;
      select id_medic  bulk collect into id_medic_rep
   from medici;
       select id_medicament  bulk collect into id_meds_rep
      from medicamente;
      select id_salon bulk collect into id_salon_rep from saloane;
   select id_sala bulk collect into id_sala_rep
   from sali_operatie;
   select id_internare bulk collect into id_internare_rep from internari;
   
     --Sectii
   
   for v_i in 1..20 loop
      insert into sectii(id_sectie,nume_sectie) values (v_i, nume_sectie(v_i));
   end loop;
   
   --Sali operatie
   DBMS_output.put_line('Inserare sali operatie');
   
   for v_i in 1..100 loop
      v_nr_sala := v_contor;
      v_id_sala := 'S'||to_char(v_i);
      insert into sali_operatie(id_sala,numar_sala) values (v_id_sala,v_nr_sala);
      if (v_contor = 5) then v_contor := 1;
      else v_contor := v_contor + 1;
      end if;
    end loop;
   v_contor := 1;


   --Repartizare
   
   for v_i in 1..20 loop
     for v_j in 1..5 loop
       insert into repartizare(id_sectie, id_sala) values(id_sectie_rep(v_i), id_sala_rep(v_contor));
       v_contor := v_contor + 1;
       end loop;
   end loop;
   v_contor := 1;
   
   --Pacienti
     for v_i in 1..1000000 loop
        v_nume_pacient := nume_pacient(DBMS_RANDOM.VALUE(1,nume_pacient.count));
        v_prenume_pacient := prenume_pacient(DBMS_RANDOM.VALUE(1,prenume_pacient.count));
        v_data_nastere := to_date('01-01-1040', 'DD-Mon-YYYY')+trunc(dbms_random.value(1,366*70)); 
        v_id_pacient := 'P' || to_char(v_i);
        insert into pacienti(id_pacient,nume,prenume,data_nastere) values (v_id_pacient,v_nume_pacient,v_prenume_pacient,v_data_nastere);
    end loop;

     --Saloanee
   
   v_etaj_salon := 1;
   v_capacitate_salon := 5;
   for v_i in 1..400 loop
      v_nr_salon := v_i;
      v_id_salon := 'S'||to_char(v_i);
      insert into saloane(id_salon,numar_salon,etaj,capacitate) values (v_id_salon,v_nr_salon,v_etaj_salon,v_capacitate_salon);
      if( v_i mod 40 = 0) then
          v_etaj_salon := v_etaj_salon + 1;
          end if;
    end loop;


   --Asignare SALON
       
       for v_i in 1..20 loop
          for v_j in 1..20 loop
             insert into asignare_salon(id_salon,id_sectie) values (id_salon_rep(v_contor),id_sectie_rep(v_i));
              v_contor := v_contor + 1;
          end loop;
       end loop;
       v_contor := 1;


       
      --ATRIBUIRE PACIENT
       
          for v_i in 1..400 loop
             if (v_i mod 5 = 0 ) then
               insert into atribuire_pacient(id_pacient,id_salon) values (id_pacient_rep(v_i),id_salon_rep(v_i));
             else
               insert into atribuire_pacient(id_salon) values (id_salon_rep(v_i)); 
             end if;
          end loop;

    
    
     --MEDICI
   
   for v_i in 1..1000000 loop
        v_nume_medic := nume_medic(DBMS_RANDOM.VALUE(1,nume_medic.count));
        v_prenume_medic := prenume_medic(DBMS_RANDOM.VALUE(1,prenume_medic.count));
        v_id_medic := 'MD'||to_char(v_i);
        insert into medici(id_medic,nume,prenume) values (v_id_medic,v_nume_medic,v_prenume_medic);
    end loop;
   
    --Detalii_medic
   
    
      for v_i in 1..1000000  loop
         v_shift := trunc(DBMS_RANDOM.VALUE(1,4));
         if(v_shift = 1) then
            v_inceput_tura := '07:00:00';
            v_sfarsit_tura := '15:00:00';
         elsif( v_shift = 2) then
            v_inceput_tura := '15:00:00';
            v_sfarsit_tura := '23:00:00';
            else 
                v_inceput_tura := '23:00:00';
                v_sfarsit_tura := '07:00:00';
        end if;
        v_id_sec := trunc(DBMS_RANDOM.VALUE(1,20));
        insert into detalii_medic(id_medic,id_sectie,inceput_tura,sfarsit_tura) values (id_medic_rep(v_i),id_sectie_rep(v_id_sec),v_inceput_tura,v_sfarsit_tura);
    end loop;

    
   --OPERATII
      for v_i in 1..100 loop
         v_data_inceput_operatie := to_date('01-01-2011', 'DD-MM-YYYY')+trunc(dbms_random.value(1,366*70)); 
         v_ora_inceput_operatie := trunc(dbms_random.value(1,24));
         v_durata_operatie := trunc(dbms_random.value(1,48));
         insert into operatii(id_sala,id_medic,data_inceput_operatie,ora_inceput_operatie,durata_operatie) values (id_sala_rep(v_i),id_medic_rep(v_i),v_data_inceput_operatie,v_ora_inceput_operatie,v_durata_operatie);
      end loop;


      
    --Fisa pacient
      
      for v_i in 1..1000000 loop
         v_id_fisa := to_char(v_i);
         v_boala := lista_boli(trunc(dbms_random.value(1,lista_boli.count)));
         insert into fisa_pacienti(id_fisa,id_pacient,id_medic,boala) values (v_id_fisa,id_pacient_rep(v_i),id_medic_rep(v_i),v_boala);
      end loop;

       --INTERNARI
     
     for v_i in 1..1000000 loop
        v_id_internare := to_char(v_i);
        v_data_internare := to_date('01-01-2010', 'DD-MM-YYYY')+ trunc(dbms_random.value(1,366*8));
        v_data_externare := to_date(v_data_internare,'DD-MM-YYYY') + trunc(dbms_random.value(1,366*9));
        if(v_data_externare > sysdate) then
           v_data_externare := 'Prezent';
         end if;
        insert into internari(id_internare,data_internare,data_externare) values (v_id_internare,v_data_internare,v_data_externare);
     end loop;

     -- SPITALIZARE
      for v_i in 1..1000000 loop
         if( v_i mod 6 = 3) then
            insert into spitalizare(id_pacient,id_internare) values (id_pacient_rep(v_i),id_internare_rep(v_i));
         else
           insert into spitalizare(id_internare) values (id_internare_rep(v_i));
         end if;
      end loop;
           
      
  --Medicamente
     
     for v_i in 1..950 loop
        v_stoc := to_char(v_i + 71);
        insert into medicamente(id_medicament, denumire,stoc) values (v_i, denumire_medicament(v_i),v_stoc);
     end loop;
  
  --Tratamente

      v_lista_dim := id_meds_rep.count;
     for v_i in 1..1000 loop
       v_nr_meds := trunc(dbms_random.value(1,9));
       
       begin
       select data_internare into data_tratam from internari i join spitalizare s on s.id_internare = i.id_internare where s.id_pacient = id_pacient_rep(v_i) and s.id_pacient is not null ;
       
       exception
         when NO_DATA_FOUND then
             data_tratam := '0';
        end;
        
      if(data_tratam <> '0') then
       v_data_inceput_tratament := to_date(data_tratam, 'DD-MM-YYYY')+ trunc(dbms_random.value(1,10));
       v_data_sfarsit_tratament := to_date(v_data_inceput_tratament, 'DD-MM-YYYY')+ trunc(dbms_random.value(1,30));
       
       if (v_nr_meds = 1) then 
        v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
        v_id_med2 := null;
        v_id_med3 := null;
        v_id_med4 := null;
        v_id_med5 := null;
        v_id_med6 := null;
        v_id_med7 := null;
        v_id_med8 := null;
       
       end if;
       
         if (v_nr_meds = 2) then 
             v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
             v_id_med2:=trunc(dbms_random.value(1,v_lista_dim));
             v_id_med3 := null;
             v_id_med4 := null;
             v_id_med5 := null;
             v_id_med6 := null;
             v_id_med7 := null;
             v_id_med8 := null;
       end if;
       
        if (v_nr_meds = 3) then 
                 v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
                 v_id_med2:=trunc(dbms_random.value(1,v_lista_dim));
                 v_id_med3:=trunc(dbms_random.value(1,v_lista_dim));
                 v_id_med4 := null;
                 v_id_med5 := null;
        v_id_med6 := null;
        v_id_med7 := null;
        v_id_med8 := null;
                 
       end if;
       
        if (v_nr_meds = 4) then 
                  v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
                  v_id_med2:=trunc(dbms_random.value(1,v_lista_dim));
                  v_id_med3:=trunc(dbms_random.value(1,v_lista_dim));
                  v_id_med4:=trunc(dbms_random.value(1,v_lista_dim));
                  v_id_med5 := null;
        v_id_med6 := null;
        v_id_med7 := null;
        v_id_med8 := null;
       end if;
       
        if (v_nr_meds = 5) then 
                v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med2:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med3:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med4:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med5:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med6 := null;
        v_id_med7 := null;
        v_id_med8 := null;
                
       end if;
       
        if (v_nr_meds = 6) then 
                v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med2:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med3:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med4:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med5:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med6:=trunc(dbms_random.value(1,v_lista_dim));
                 v_id_med7 := null;
        v_id_med8 := null;
       end if;
       
        if (v_nr_meds = 7) then 
                v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med2:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med3:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med4:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med5:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med6:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med7:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med8 := null;
       end if;
       
        if (v_nr_meds = 8) then 
                v_id_med1:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med2:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med3:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med4:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med5:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med6:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med7:=trunc(dbms_random.value(1,v_lista_dim));
                v_id_med8:=trunc(dbms_random.value(1,v_lista_dim));
       end if;
      
      insert into tratamente(id_pacient,id_medic,data_inceput_tratament,data_sfarsit_tratament,id_med1,id_med2,id_med3,id_med4,id_med5,id_med6,id_med7,id_med8) values
                             (id_pacient_rep(v_i),id_medic_rep(v_i),v_data_inceput_tratament,v_data_sfarsit_tratament,v_id_med1,v_id_med2,v_id_med3,v_id_med4,v_id_med5,v_id_med6,v_id_med7,v_id_med8);
     end if;
     
      end loop; 

   
END;
