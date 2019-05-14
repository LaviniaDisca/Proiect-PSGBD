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

create or replace procedure getLoginInfo(c1 OUT SYS_REFCURSOR, IN_username login_info.username%type, IN_password login_info.user_pass%type) is

begin

   open c1 for
   SELECT * FROM login_info where username = IN_username  and user_pass = IN_password;
 
end;


select * from login_info where id_medic='MD599';

select * from medici;


