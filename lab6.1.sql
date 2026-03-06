declare
   v_employee_id   employees.employee_id%type := &employee_id;
   v_first_name    employees.first_name%type;
   v_last_name     employees.last_name%type;
   v_salary        employees.salary%type;
   v_hire_date     employees.hire_date%type;
   v_employee_type varchar(100);
begin
   select first_name,
          last_name,
          salary,
          hire_date
     into
      v_first_name,
      v_last_name,
      v_salary,
      v_hire_date
     from employees
    where employee_id = v_employee_id;

   if months_between(
      sysdate,
      v_hire_date
   ) < 12 then
      v_employee_type := 'New Employee';
   elsif months_between(
      sysdate,
      v_hire_date
   ) < 60 then
      v_employee_type := 'Experienced Employee';
   else
      v_employee_type := 'Senior Employee';
   end if;

   dbms_output.put_line('ID: '
                        || v_employee_id
                        || ' | Name: '
                        || v_first_name
                        || ' '
                        || v_last_name
                        || ' | Salary: '
                        || v_salary
                        || ' | Hire Date: '
                        || v_hire_date
                        || ' | Employee Type: ' || v_employee_type);

exception
   when no_data_found then
      dbms_output.put_line('No employee with id ' || v_employee_id);
   when others then
      dbms_output.put_line('An error ocurred');
end;