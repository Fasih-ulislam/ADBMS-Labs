----------------------------------------------------------------
-- TRIGGER
----------------------------------------------------------------

-- blocking any booking for a tutorial in the past
create or replace trigger trg_no_past_booking before
   insert on bookings
   for each row
declare
   v_schedule_date date;
   v_tutorial_type varchar2(100);
begin
   select t.schedule_date,
          wt.title
     into
      v_schedule_date,
      v_tutorial_type
     from tutorials t
     join workshop_types wt
   on t.type_id = wt.type_id
    where t.tutorial_id = :new.tutorial_id;


   if v_schedule_date < trunc(sysdate) then
      raise_application_error(
         -20001,
         'BOOKING DENIED: Tutorial "'
         || v_tutorial_type
         || '" was scheduled on '
         || to_char(
            v_schedule_date,
            'DD-MON-YYYY'
         )
         || ' and has already passed.'
      );
   end if;

exception
   when no_data_found then
      raise_application_error(
         -20002,
         'BOOKING DENIED: Tutorial does not exist.'
      );
end trg_no_past_booking;
/

-- TESTING
begin
   insert into bookings values ( 99,
                                 1,
                                 1,
                                 sysdate ); -- invalid and should be blocked
end;
/