----------------------------------------------------------------
-- PROCEDURES
----------------------------------------------------------------

-- book a customer into a tutorial
create or replace procedure book_customer (
   p_customer_id in number,
   p_tutorial_id in number
) as
   v_current_bookings number;
   v_max_capacity     number;
   v_duplicate        number;
begin
   select count(*)
     into v_duplicate
     from bookings
    where customer_id = p_customer_id
      and tutorial_id = p_tutorial_id;

   if v_duplicate > 0 then
      dbms_output.put_line('ERROR: Customer with id '
                           || p_customer_id
                           || ' is already booked for the Tutorial ' || p_tutorial_id);
      return;
   end if;

   select max_capacity
     into v_max_capacity
     from tutorials
    where tutorial_id = p_tutorial_id;

   select count(*)
     into v_current_bookings
     from bookings
    where tutorial_id = p_tutorial_id;

   if v_current_bookings >= v_max_capacity then
      dbms_output.put_line('ERROR: The Tutorial '
                           || p_tutorial_id
                           || ' is fully booked currently. Max capacity was: ' || v_max_capacity);
      return;
   end if;

   insert into bookings (
      booking_id,
      customer_id,
      tutorial_id,
      booking_date
   ) values ( (
      select nvl(
         max(booking_id),
         0
      ) + 1
        from bookings
   ),
              p_customer_id,
              p_tutorial_id,
              sysdate );

   commit;
   dbms_output.put_line('SUCCESS: Booking confirmed.');
   dbms_output.put_line('  Customer ID : ' || p_customer_id);
   dbms_output.put_line('  Tutorial ID : ' || p_tutorial_id);
   dbms_output.put_line('  Slot '
                        ||(v_current_bookings + 1)
                        || ' of '
                        || v_max_capacity || ' filled.');

exception
   when no_data_found then
      dbms_output.put_line('ERROR: Tutorial ID '
                           || p_tutorial_id || ' does not exist.');
   when others then
      rollback;
      dbms_output.put_line('UNEXPECTED ERROR: ' || sqlerrm);
end book_customer;
/

-- TESTING
begin
   book_customer(
      3,
      4
   );  -- valid (once)
   book_customer(
      1,
      1
   );  -- duplicate
end;
/