drop table login_info
/
create table login_info
( 
   id_medic varchar2(100) not null primary key,
   username varchar2(100) not null,
   user_pass varchar2(100) not null
)
/


create or replace procedure info
is

  v_uname login_info.username%type;
  v_upass login_info.user_pass%type;
  
  cursor c1 is
   select id_medic,nume,prenume from medici;
   
begin
   
   
   for c1_record in c1 loop
      v_uname := c1_record.prenume||'.'||c1_record.nume;
      v_upass := c1_record.nume||'.'||c1_record.id_medic;
      insert into login_info (id_medic, username, user_pass) values (c1_record.id_medic, v_uname, v_upass);
    end loop;
   
end;

/
exec info;
/



create or replace procedure getLoginInfo(c1 OUT SYS_REFCURSOR, IN_username IN login_info.username%type, IN_password IN login_info.user_pass%type) is

begin

   open c1 for
   SELECT * FROM login_info where username = IN_username  and user_pass = IN_password;
 
end;

/




--afisarea pacientilor care sufera de o anumita boala

create or replace procedure getPacientsSuffDisease(c1 OUT SYS_REFCURSOR, IN_boala IN fisa_pacienti.boala%type )
is
begin

   open c1 for
   SELECT p.* FROM pacienti p join fisa_pacienti f on p.id_pacient=f.id_pacient where f.boala = IN_boala ;
 
end;
/

create or replace procedure getPacientsStillTreated(c1 OUT SYS_REFCURSOR)
is
begin

   open c1 for
   SELECT p.* FROM pacienti p join tratamente t on p.id_pacient=t.id_pacient where sysdate <t.data_sfarsit_tratament  ;
 
end;


/
select * from tratamente;
/
--update tratamente set durata=durata-data_inceput_tratament;


select * from login_info where id_medic='MD599';

select * from pacienti;


--display doctor's name

    
create or replace procedure getUsername(c1 OUT SYS_REFCURSOR,IN_id IN medici.id_medic%type)
is
begin

   open c1 for
   SELECT  nume,prenume FROM medici where id_medic = IN_id ;
 
end;

/
create or replace procedure getDoctorNum(c1 OUT SYS_REFCURSOR)
is
begin

   open c1 for
   SELECT count(*) as "num" FROM medici ;
 
end;
/

create or replace procedure getDoctorsbySpec(c1 OUT SYS_REFCURSOR)
is
begin

   open c1 for
   SELECT  s.nume_sectie as "sect", count(m.id_medic) as "med" FROM medici m join detalii_medic d on d.id_medic=m.id_medic join sectii s on d.id_sectie=s.id_sectie
   group by d.id_sectie, s.nume_sectie order by 1;
 
end;
/

--   afisarea numarului de internari a unui pacient

create or replace procedure getNbHospitalizations(c1 OUT SYS_REFCURSOR,IN_id_pacient IN pacienti.id_pacient%type)
is
begin

   open c1 for
   SELECT  count(s.id_internare) as "numInternari" FROM spitalizare s
   where s.id_pacient = IN_id_pacient
   group by s.id_internare;
 
end;


select * from medici where id_medic = 'MD1000001';


/
create or replace procedure getShifts(c1 OUT SYS_REFCURSOR,IN_id IN medici.id_medic%type)
is
begin

   open c1 for
   SELECT  med.id_medic as "Id_med", med.nume as "nume", med.prenume as "prenume",s.inceput_tura as "inceput", s.sfarsit_tura as "sfarsit" 
   FROM medici med join detalii_medic s on s.id_medic=med.id_medic
   where med.id_medic = IN_id ;
 
end;
/

create or replace procedure updateShifts(IN_id IN detalii_medic.id_medic%type, IN_inceput IN detalii_medic.inceput_tura%TYPE, IN_sfarsit IN detalii_medic.sfarsit_tura%TYPE )
is
begin
   UPDATE detalii_medic
   set inceput_tura =  IN_inceput,
   sfarsit_tura = IN_sfarsit
   where id_medic = IN_id ;
 
end;
/

create or replace procedure geNextMedId(c1 OUT SYS_REFCURSOR)
is 
begin
    open c1 for
    select 'MD'||(to_char(to_number(substr(med.id_medic,3))+1)) as "new_id" from medici med
    group by med.id_medic
    having to_number(substr(med.id_medic,3))=(select max(to_number(substr(med1.id_medic,3))) from medici med1);
end;

/

create or replace procedure getWardId(c1 OUT SYS_REFCURSOR, IN_name in sectii.nume_sectie%TYPE)
is 
begin
    open c1 for
    select id_sectie as "id" from sectii where nume_sectie=IN_name;
end;

/
create or replace procedure AddMEd (IN_id IN medici.id_medic%TYPE, IN_nume IN medici.nume%TYPE, IN_prenume IN medici.prenume%TYPE, 
IN_sectie in detalii_medic.id_sectie%TYPE, IN_inceput IN detalii_medic.inceput_tura%TYPE, IN_sfarsit IN detalii_medic.sfarsit_tura%TYPE )
is
begin

insert into medici (id_medic, nume, prenume) values (IN_id, IN_nume, IN_prenume);
insert into detalii_medic(id_medic, id_sectie, inceput_tura, sfarsit_tura) values (IN_id, IN_sectie, IN_inceput, IN_sfarsit);

end;
<<<<<<< HEAD
/
create or replace procedure deleteMed(IN_id IN medici.id_medic%TYPE)
is
begin
execute immediate 'ALTER TABLE detalii_medic
        DROP CONSTRAINT fk_detalii_medic_id_medic';
execute immediate 'ALTER TABLE operatii
        DROP CONSTRAINT fk_operatii_id_medic';
execute immediate 'ALTER TABLE fisa_pacienti
        DROP CONSTRAINT fk_fisa_pacienti_id_medic';
execute immediate 'ALTER TABLE tratamente
        DROP CONSTRAINT fk_tratamente_id_medic';
delete from medici where id_medic= IN_id;
delete from detalii_medic where id_medic= IN_id;
execute immediate 'ALTER TABLE detalii_medic
ADD CONSTRAINT fk_detalii_medic_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic)';
execute immediate 'ALTER TABLE operatii
ADD CONSTRAINT fk_operatii_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic)';
execute immediate 'ALTER TABLE fisa_pacienti
ADD CONSTRAINT fk_fisa_pacienti_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic)';
execute immediate 'ALTER TABLE tratamente
ADD CONSTRAINT fk_tratamente_id_medic FOREIGN KEY (id_medic) REFERENCES medici(id_medic)';
end;
/
=======

/





