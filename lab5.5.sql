declare
   v_employee_id hr.employees.employee_id%type := &empolyee_id;
   v_first_name  hr.employees.first_name%type;
   v_last_name   hr.employees.last_name%type;
   v_hire_date   hr.employees.hire_date%type;
begin
   select first_name,
          last_name,
          hire_date
     into
      v_first_name,
      v_last_name,
      v_hire_date
     from hr.employees
    where employee_id = v_employee_id;

   dbms_output.put_line('ID: '
                        || v_employee_id
                        || ' | Name: '
                        || v_first_name
                        || ' '
                        || v_last_name
                        || ' | Years worked: ' || round(months_between(
      sysdate,
      v_hire_date
   ) / 12));

exception
   when no_data_found then
      dbms_output.put_line('No employee with id ' || v_employee_id);
   when others then
      dbms_output.put_line('An error ocurred');
end;