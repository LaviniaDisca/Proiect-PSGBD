create table login_info
(  username varchar2(100) not null,
   user_pass varchar2(100) not null
)
/
drop table login_info
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
      insert into login_info (username, user_pass) values (v_uname, v_upass);
    end loop;
   
end;

/
exec info;

select * from login_info;

