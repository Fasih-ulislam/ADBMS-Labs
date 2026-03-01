declare
   v_employee_id hr.employees.employee_id%type := &empolyee_id;
   v_first_name  hr.employees.first_name%type;
   v_last_name   hr.employees.last_name%type;
   v_salary      hr.employees.salary%type;
begin
   select first_name,
          last_name,
          salary
     into
      v_first_name,
      v_last_name,
      v_salary
     from hr.employees
    where employee_id = v_employee_id;

   dbms_output.put_line('ID: '
                        || v_employee_id
                        || ' | Name: '
                        || v_first_name
                        || ' '
                        || v_last_name
                        || ' | Annual Salary: ' || v_salary * 12);

exception
   when no_data_found then
      dbms_output.put_line('No employee with id ' || v_employee_id);
   when others then
      dbms_output.put_line('An error ocurred');
end;