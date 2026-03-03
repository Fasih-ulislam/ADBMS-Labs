----------------------------------------------------------------
-- FUNCTIONs
----------------------------------------------------------------

-- get average rating of an animal
create or replace function get_avg_rating (
   p_animal_id in number
) return number as
   v_avg_rating number(
      4,
      2
   );
   v_species    varchar2(100);
begin
   select species_name
     into v_species
     from bonsai_animals
    where animal_id = p_animal_id;

   select round(
      avg(rating),
      2
   )
     into v_avg_rating
     from testimonials
    where animal_id = p_animal_id;

   if v_avg_rating is null then
      dbms_output.put_line('No reviews yet for: ' || v_species);
      return 0;
   end if;

   dbms_output.put_line('Average rating for '
                        || v_species
                        || 'is : '
                        || v_avg_rating || ' / 5');
   return v_avg_rating;
exception
   when no_data_found then
      dbms_output.put_line('ERROR: Animal ID '
                           || p_animal_id || ' not found.');
      return -1;
   when others then
      dbms_output.put_line('UNEXPECTED ERROR: ' || sqlerrm);
      return -1;
end get_avg_rating;
/

-- TESTING
declare
   v_result number;
begin
   v_result := get_avg_rating(1);
   v_result := get_avg_rating(5);
end;
/