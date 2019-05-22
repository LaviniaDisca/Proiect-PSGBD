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

create or replace procedure getNextMedId(c1 OUT SYS_REFCURSOR)
is 
begin
    open c1 for
    select 'MD'||(to_char(to_number(substr(med.id_medic,3))+1)) as "new_id" from medici med
    group by med.id_medic
    having to_number(substr(med.id_medic,3))=(select max(to_number(substr(med1.id_medic,3))) from medici med1);
end;
/

create or replace procedure getNextPatientId(c1 OUT SYS_REFCURSOR)
is 
begin
    open c1 for
    select 'P'||(to_char(to_number(substr(p.id_pacient,2))+1)) as "new_id" from pacienti p
    group by p.id_pacient
    having to_number(substr(p.id_pacient,2))=(select max(to_number(substr(p1.id_pacient,2))) from pacienti p1);
end;
/

create or replace procedure getNextPatientFileId(c1 OUT SYS_REFCURSOR)
is 
begin
    open c1 for
    select (to_char(to_number(f.id_fisa)+1)) as "new_id" from fisa_pacienti f
    group by f.id_fisa
    having to_number(f.id_fisa)=(select max(to_number(f1.id_fisa)) from fisa_pacienti f1);
end;

/
create or replace procedure getWardId(c1 OUT SYS_REFCURSOR, IN_name in sectii.nume_sectie%TYPE)
is 
begin
    open c1 for
    select id_sectie as "id" from sectii where nume_sectie=IN_name;
end;

/
create or replace procedure AddMed (IN_id IN medici.id_medic%TYPE, IN_nume IN medici.nume%TYPE, IN_prenume IN medici.prenume%TYPE, 
IN_sectie in detalii_medic.id_sectie%TYPE, IN_inceput IN detalii_medic.inceput_tura%TYPE, IN_sfarsit IN detalii_medic.sfarsit_tura%TYPE )
is
begin

insert into medici (id_medic, nume, prenume) values (IN_id, IN_nume, IN_prenume);
insert into detalii_medic(id_medic, id_sectie, inceput_tura, sfarsit_tura) values (IN_id, IN_sectie, IN_inceput, IN_sfarsit);

end;
/

create or replace procedure AddPatient (IN_id IN pacienti.id_pacient%TYPE, IN_nume IN pacienti.nume%TYPE, IN_prenume IN pacienti.prenume%TYPE, 
IN_data_nastere in pacienti.data_nastere%TYPE, IN_boala in fisa_pacienti.boala%type, IN_fisa in fisa_pacienti.id_fisa%type)
is

begin

insert into pacienti (id_pacient, nume, prenume, data_nastere) values (IN_id, IN_nume, IN_prenume, IN_data_nastere);
insert into fisa_pacienti(id_fisa, id_pacient, boala) values (IN_fisa, IN_id, IN_boala);

end;
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

create or replace procedure dischargePatient(IN_id IN pacienti.id_pacient%TYPE)
is
begin
        
delete from pacienti where id_pacient = IN_id;
delete from fisa_pacienti where id_pacient = IN_id;

end;
/
drop index pacient_id_asigSal_ix;

CREATE INDEX pacient_id_atrbPac_ix ON atribuire_pacient (id_pacient);
/
CREATE INDEX salon_id_atrbPac_ix ON atribuire_pacient (id_salon);
/
CREATE INDEX salon_id_asigSal_ix ON asignare_salon (id_salon);
/
CREATE INDEX sectie_id_asigSal_ix ON asignare_salon (id_sectie);
/
CREATE INDEX sectie_id_repartizare_ix ON repartizare (id_sectie);
/
CREATE INDEX sala_id_repartizare_ix ON repartizare (id_sala);
/
CREATE INDEX sala_id_operatii_ix ON operatii (id_sala);
/
CREATE INDEX medic_id_operatii_ix ON operatii (id_medic);
/
CREATE INDEX pacient_id_fisa_ix ON fisa_pacienti (id_pacient);
/
CREATE INDEX medic_id_fisa_ix ON fisa_pacienti (id_medic);
/
CREATE INDEX pacient_id_spitalizare_ix ON spitalizare (id_pacient);
/
CREATE INDEX internare_id_spitalizare_ix ON spitalizare (id_internare);
/
CREATE INDEX pacient_id_tratamente_ix ON tratamente (id_pacient);
/
CREATE INDEX medic_id_tratamente_ix ON tratamente (id_medic);
/
CREATE INDEX med1_id_tratamente_ix ON tratamente (id_med1);
/
CREATE INDEX med2_id_tratamente_ix ON tratamente (id_med2);
/
CREATE INDEX med3_id_tratamente_ix ON tratamente (id_med3);
/
CREATE INDEX med4_id_tratamente_ix ON tratamente (id_med4);
/
CREATE INDEX med5_id_tratamente_ix ON tratamente (id_med5);
/
CREATE INDEX med6_id_tratamente_ix ON tratamente (id_med6);
/
CREATE INDEX med7_id_tratamente_ix ON tratamente (id_med7);
/
CREATE INDEX med8_id_tratamente_ix ON tratamente (id_med8);

/
-- afisarea saloanelor libere pe o sectie


create or replace procedure getFreeSalon(c1 OUT SYS_REFCURSOR, IN_name in sectii.nume_sectie%TYPE)
is 
begin
    open c1 for
   
 select sl.id_salon as "salon"  FROM sectii s join asignare_salon sig on s.id_sectie=sig.id_sectie join saloane sl on sl.id_salon=sig.id_salon 
                                                                join atribuire_pacient apac on apac.id_salon=sl.id_salon      
   where s.nume_sectie = IN_name and sl.capacitate >
   ( select count(apac2.id_pacient) from saloane sl2 join atribuire_pacient apac2 on apac2.id_salon=sl2.id_salon where sl.id_salon=sl2.id_salon  group by apac2.id_pacient )
   order by 1;

end;


-- afisarea saloanelor ocupate pe o sectie

create or replace procedure getOccupiedSalon(c1 OUT SYS_REFCURSOR, IN_name in sectii.nume_sectie%TYPE)
is 
begin
    open c1 for
   
 select sl.id_salon as "salon"  FROM sectii s join asignare_salon sig on s.id_sectie=sig.id_sectie join saloane sl on sl.id_salon=sig.id_salon 
                                                                join atribuire_pacient apac on apac.id_salon=sl.id_salon      
   where s.nume_sectie = IN_name and sl.capacitate =
   ( select count(apac2.id_pacient) from saloane sl2 join atribuire_pacient apac2 on apac2.id_salon=sl2.id_salon where sl.id_salon=sl2.id_salon  group by apac2.id_pacient )
   order by 1;

end;

/


create or replace procedure getWardbyId(c1 OUT SYS_REFCURSOR, IN_id IN medici.id_medic%TYPE)
is 
begin
open c1 for
    select s.nume_sectie as "nume" from sectii s join detalii_medic leg on leg.id_sectie=s.id_sectie join medici med on med.id_medic=leg.id_medic
    where med.id_medic=IN_id;
end;


/
create or replace procedure getNextMedsId(c1 OUT SYS_REFCURSOR)
is 
begin
    open c1 for
    select (to_char(to_number(m.id_medicament)+1)) as "new_id" from medicamente m
    group by m.id_medicament
    having to_number(m.id_medicament)=(select max(to_number(m1.id_medicament)) from medicamente m1);
end;

/

create or replace procedure AddMeds (IN_id IN medicamente.id_medicament%TYPE, IN_nume IN medicamente.denumire%TYPE, IN_stoc medicamente.stoc%type)
is

begin

insert into medicamente (id_medicament, denumire, stoc) values (IN_id, IN_nume, IN_stoc);

end;

/

create or replace procedure checkStock (c1 OUT SYS_REFCURSOR)
is

begin

    open c1 for
    select denumire,stoc from medicamente
    order by denumire;
end;
/

--get med id by name

create or replace procedure getMedId(c1 OUT SYS_REFCURSOR, IN_name in medicamente.denumire%type)
is

begin

    open c1 for
    select id_medicament from medicamente
    where denumire = IN_name;
end;


/

create or replace procedure addTreatment (IN_id_patient in pacienti.id_pacient%type, IN_id_doctor in medici.id_medic%type, IN_data_start in tratamente.data_inceput_tratament%type,
IN_data_finish in tratamente.data_sfarsit_tratament%type, IN_med1 in tratamente.id_med1%type, IN_med2 in tratamente.id_med2%type, IN_med3 in tratamente.id_med3%type,
IN_med4 in tratamente.id_med4%type, IN_med5 in tratamente.id_med5%type, IN_med6 in tratamente.id_med6%type, IN_med7 in tratamente.id_med7%type,
IN_med8 in tratamente.id_med8%type)
is
  v_m1 tratamente.id_med1%type;
  v_m2 tratamente.id_med2%type;
  v_m3 tratamente.id_med3%type;
  v_m4 tratamente.id_med4%type;
  v_m5 tratamente.id_med5%type;
  v_m6 tratamente.id_med6%type;
  v_m7 tratamente.id_med7%type;
  v_m8 tratamente.id_med8%type;
begin
  if(IN_med2 <> '-') then
     if(IN_med3 <> '-') then
         if(IN_med4 <> '-') then
            if(IN_med5 <> '-') then
               if(IN_med6 <> '-') then
                  if(IN_med7 <> '-') then
                      if(IN_med8 <> '-') then
                         v_m1 := IN_med1;
                         v_m2 := IN_med2;
                         v_m3 := IN_med3;
                         v_m4 := IN_med4;
                         v_m5 := IN_med5;
                         v_m6 := IN_med6;
                         v_m7 := IN_med7;
                         v_m8 := IN_med8;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med2;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med3;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med4;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med5;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med6;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med7;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med8;
                      else
                         v_m1 := IN_med1;
                         v_m2 := IN_med2;
                         v_m3 := IN_med3;
                         v_m4 := IN_med4;
                         v_m5 := IN_med5;
                         v_m6 := IN_med6;
                         v_m7 := IN_med7;
                         v_m8 := null;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med2;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med3;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med4;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med5;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med6;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med7;
                      end if;
                  else
                         v_m1 := IN_med1;
                         v_m2 := IN_med2;
                         v_m3 := IN_med3;
                         v_m4 := IN_med4;
                         v_m5 := IN_med5;
                         v_m6 := IN_med6;
                         v_m7 := null;
                         v_m8 := null;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med2;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med3;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med4;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med5;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med6;
                     end if;
               else
                         v_m1 := IN_med1;
                         v_m2 := IN_med2;
                         v_m3 := IN_med3;
                         v_m4 := IN_med4;
                         v_m5 := IN_med5;
                         v_m6 := null;
                         v_m7 := null;
                         v_m8 := null;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med2;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament= IN_med3;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med4;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med5;
                end if;
            else
                   v_m1 := IN_med1;
                         v_m2 := IN_med2;
                         v_m3 := IN_med3;
                         v_m4 := IN_med4;
                         v_m5 := null;
                         v_m6 := null;
                         v_m7 := null;
                         v_m8 := null;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med2;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament= IN_med3;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med4;
             end if;
          else
                         v_m1 := IN_med1;
                         v_m2 := IN_med2;
                         v_m3 := IN_med3;
                         v_m4 := null;
                         v_m5 := null;
                         v_m6 := null;
                         v_m7 := null;
                         v_m8 := null;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med2;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament= IN_med3;
            end if;
        else
                         v_m1 := IN_med1;
                         v_m2 := IN_med2;
                         v_m3 := null;
                         v_m4 := null;
                         v_m5 := null;
                         v_m6 := null;
                         v_m7 := null;
                         v_m8 := null;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med2; 
         end if;
    else
                       v_m1 := IN_med1;
                         v_m2 := null;
                         v_m3 := null;
                         v_m4 := null;
                         v_m5 := null;
                         v_m6 := null;
                         v_m7 := null;
                         v_m8 := null;
                         update medicamente m set m.stoc = to_char(to_number(m.stoc)-1) where id_medicament = IN_med1;
    end if;

   insert into tratamente (id_pacient, id_medic, data_inceput_tratament, data_sfarsit_tratament, id_med1, id_med2, id_med3, id_med4, id_med5, id_med6, id_med7, id_med8) 
    values (IN_id_patient, IN_id_doctor, IN_data_start, IN_data_finish, v_m1, v_m2, v_m3, v_m4, v_m5, v_m6, v_m7, v_m8);

end;
/

-- check if stock is under 50

create or replace procedure checkLowStock (c1 OUT SYS_REFCURSOR)
is

begin

    open c1 for
    select denumire,stoc from medicamente
    where to_number(stoc) < 50
    order by denumire;   

end;
/

create or replace procedure updateStock(IN_id_med in medicamente.id_medicament%type,IN_new_stock in medicamente.stoc%type)
is
begin
   update medicamente set stoc = to_char(to_number(IN_new_stock)) where id_medicament = IN_id_med;
end;
/

create or replace function bookOR (IN_id_medic in medici.id_medic%type) return varchar2
is
v_id_sala operatii.id_sala%type;
v_sum num_arr := num_arr();
v_day num_arr := num_arr();
V_done varchar2(5);
v_result sali_operatie.id_sala%type;
 cursor c1 is
    select sala.id_sala from sali_operatie sala join operatii op on sala.id_sala=op.id_sala 
    where  (op.data_inceput_operatie + v_day(ROWNUM)) < sysdate;
begin
    select (op.durata_operatie + to_number(op.ora_inceput_operatie)) bulk collect into v_sum  from operatii op;
    
    for i in v_sum.first..v_sum.last loop
      if(v_sum(i) >= 24) then
        v_day(i) := 1;
      elsif (v_sum(i) >= 48) then
       v_day(i) :=  2;
      end if;
    end loop;
    
    v_result := '0';
    for c1_record in c1 loop
       if v_done <> 'Done' then
        select sala.id_sala  into v_result
        from repartizare re join  sali_operatie sala on re.id_sala=sala.id_sala join operatii op on sala.id_sala=op.id_sala join medici m on m.id_medic = op.id_medic join detalii_medic det on det.id_medic = m.id_medic
          where re.id_sectie = det.id_sectie and sala.id_sala = c1_record.id_sala;
          if(v_result <> '0') then
             v_done := 'Done';
          end if;
        end if;
     end loop;     
     
    RETURN v_result;
end;
/

create or replace procedure addTimeOR(IN_id_medic in medici.id_medic%type, IN_data_inceput_operatie in operatii.data_inceput_operatie%type,
IN_ora in operatii.ora_inceput_operatie%type, IN_durata in operatii.durata_operatie%type)
is
v_sala sali_operatie.id_sala%type;

begin
    v_sala := bookOR(IN_id_medic);
    insert into operatii (id_sala, id_medic, data_inceput_operatie, ora_inceput_operatie, durata_operatie)
      values (v_sala, IN_id_medic, IN_data_inceput_operatie, IN_ora, IN_durata);
end;