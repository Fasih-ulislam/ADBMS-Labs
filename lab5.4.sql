declare
   v_employee_id  hr.employees.employee_id%type := &empolyee_id;
   v_e_first_name hr.employees.first_name%type;
   v_manager_id   hr.departments.manager_id%type;
   v_m_first_name hr.employees.first_name%type;
begin
   select e.first_name,
          m.first_name,
          e.manager_id
     into
      v_e_first_name,
      v_m_first_name,
      v_manager_id
     from hr.employees e
     join hr.employees m
   on m.employee_id = e.manager_id
    where e.employee_id = v_employee_id;

   dbms_output.put_line('Employee ID: '
                        || v_employee_id
                        || ' | Employee Name: '
                        || v_e_first_name
                        || 'Manager ID: '
                        || v_manager_id
                        || ' | Manager Name: ' || v_m_first_name);

exception
   when no_data_found then
      dbms_output.put_line('No employee with id ' || v_employee_id);
   when others then
      dbms_output.put_line('An error ocurred');
end;