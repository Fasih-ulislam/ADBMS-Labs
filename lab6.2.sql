declare
   cursor c_country is
   select country_id,
          country_name
     from countries;
   v_c_id   countries.country_id%type;
   v_c_name countries.country_name%type;
   v_c_type varchar(200);
begin
   open c_country;
   dbms_output.put_line('==================================================');
   dbms_output.put_line('              COUNTRIES BASED ON GDP              ');
   dbms_output.put_line('==================================================');
   loop
      fetch c_country into
         v_c_id,
         v_c_name;
      exit when c_country%notfound;
      if v_c_name in ( 'United States of America',
                       'Denmark',
                       'Japan' ) then
         v_c_type := 'Developed Country';
      elsif v_c_name in ( 'India',
                          'Canada',
                          'Brazil' ) then
         v_c_type := 'Emerging Economy';
      else
         v_c_type := 'Developing Country';
      end if;

      dbms_output.put_line('ID: '
                           || v_c_id
                           || ' | Name: '
                           || v_c_name
                           || ' | Country type: ' || v_c_type);
   end loop;
   close c_country;
exception
   when others then
      dbms_output.put_line('An error occured');
end;