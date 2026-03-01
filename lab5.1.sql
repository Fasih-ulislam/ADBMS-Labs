declare
   v_employee_id     hr.employees.employee_id%type := &empolyee_id;
   v_first_name      hr.employees.first_name%type;
   v_last_name       hr.employees.last_name%type;
   v_salary          hr.employees.salary%type;
   v_department_id   hr.departments.department_id%type;
   v_department_name hr.departments.department_name%type;
begin
   select first_name,
          last_name,
          salary,
          department_id
     into
      v_first_name,
      v_last_name,
      v_salary,
      v_department_id
     from hr.employees
    where employee_id = v_employee_id;

   select department_name
     into v_department_name
     from hr.departments
    where department_id = v_department_id;

   dbms_output.put_line('ID: '
                        || v_employee_id
                        || ' ,Name: '
                        || v_first_name
                        || ' '
                        || v_last_name
                        || ' ,Salary: '
                        || v_salary
                        || ' ,Department: ' || v_department_name);

exception
   when no_data_found then
      dbms_output.put_line('No employee with id ' || v_employee_id);
   when others then
      dbms_output.put_line('An error ocurred');
end;