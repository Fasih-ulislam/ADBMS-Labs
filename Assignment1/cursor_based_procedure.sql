----------------------------------------------------------------
-- CURSOR PROCEDURES
----------------------------------------------------------------
create or replace procedure tutorial_attendance_report as

   cursor c_tutorials is
   select t.tutorial_id,
          wt.title as workshop_title,
          c.city_name,
          t.schedule_date,
          t.max_capacity
     from tutorials t
     join workshop_types wt
   on t.type_id = wt.type_id
     join cities c
   on t.city_id = c.city_id
    order by t.schedule_date;

   v_booking_count number;
   v_slots_left    number;
begin
   dbms_output.put_line('==============================================');
   dbms_output.put_line('       TUTORIAL ATTENDANCE REPORT            ');
   dbms_output.put_line('==============================================');
   for rec in c_tutorials loop

      select count(*)
        into v_booking_count
        from bookings
       where tutorial_id = rec.tutorial_id;

      v_slots_left := rec.max_capacity - v_booking_count;
      dbms_output.put_line('----------------------------------------------');
      dbms_output.put_line('Tutorial ID   : ' || rec.tutorial_id);
      dbms_output.put_line('Workshop      : ' || rec.workshop_title);
      dbms_output.put_line('City          : ' || rec.city_name);
      dbms_output.put_line('Date          : ' || to_char(
         rec.schedule_date,
         'DD-MON-YYYY'
      ));
      dbms_output.put_line('Capacity      : ' || rec.max_capacity);
      dbms_output.put_line('Booked        : ' || v_booking_count);
      dbms_output.put_line('Slots Left    : ' || v_slots_left);
      if v_slots_left = 0 then
         dbms_output.put_line('Status        : Fully Booked');
      elsif v_slots_left <= 3 then
         dbms_output.put_line('Status        : Almost Full');
      else
         dbms_output.put_line('Status        : Available');
      end if;

   end loop;

   dbms_output.put_line('==============================================');
   dbms_output.put_line('            END OF REPORT                   ');
   dbms_output.put_line('==============================================');
exception
   when others then
      dbms_output.put_line('ERROR generating report: ' || sqlerrm);
end tutorial_attendance_report;
/

-- TESTING
begin
   tutorial_attendance_report;
end;
/