begin
   for rec in (
      select employee_id,
             first_name,
             last_name,
             salary
        from hr.employees
   ) loop
      dbms_output.put_line('ID: '
                           || rec.employee_id
                           || ' | Name: '
                           || rec.first_name
                           || ' '
                           || rec.last_name
                           || ' | Bonus: ' ||(rec.salary * 0.20));
   end loop;
end;