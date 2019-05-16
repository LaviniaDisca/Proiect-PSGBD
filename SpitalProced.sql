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


--afisarea pacientilor care se afla sub tratament la un moment dat

ALTER TABLE tratamente
    RENAME COLUMN durata TO data_sfarsit_tratament; -- to match the database!!!!!
    
    
create or replace procedure getPacientsStillTreated(c1 OUT SYS_REFCURSOR)
is
begin

   open c1 for
   SELECT p.* FROM pacienti p join tratamente t on p.id_pacient=t.id_pacient where sysdate <t.data_sfarsit_tratament  ;
 
end;


/
select * from tratamente;
/
update tratamente set durata=durata-data_inceput_tratament;


select * from login_info where id_medic='MD599';

select * from medici;


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




