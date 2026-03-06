declare
   cursor c_jobs is
   select job_id,
          job_title
     from hr.jobs;

   v_job_id    hr.jobs.job_id%type;
   v_job_title hr.jobs.job_title%type;
   v_job_type  varchar2(100);
begin
   open c_jobs;
   loop
      fetch c_jobs into
         v_job_id,
         v_job_title;
      exit when c_jobs%notfound;
      if instr(
         v_job_title,
         'Manager'
      ) > 0 then
         v_job_type := 'Leadership Role';
      elsif instr(
         v_job_title,
         'Engineer'
      ) > 0
      or instr(
         v_job_title,
         'Developer'
      ) > 0 then
         v_job_type := 'Technical Role';
      else
         v_job_type := 'Other Role';
      end if;

      dbms_output.put_line('ID: '
                           || v_job_id
                           || ' | Title: '
                           || v_job_title
                           || ' | Job Type: ' || v_job_type);
   end loop;
   close c_jobs;
exception
   when others then
      dbms_output.put_line('An error occurred: ' || sqlerrm);
end;