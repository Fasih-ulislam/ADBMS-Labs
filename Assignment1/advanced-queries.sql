/* 
================================================================================
BONSAI PETS: ADVANCED SQL QUERIES (TASK 4)
================================================================================
*/

-- 1. ANALYTICAL QUERY (GROUP BY / HAVING)
-- Goal: Find cities that are popular (more than 2 total bookings across all workshops).
select c.city_name,
       count(b.booking_id) as total_bookings
  from cities c
  join tutorials t
on c.city_id = t.city_id
  join bookings b
on t.tutorial_id = b.tutorial_id
 group by c.city_name
having count(b.booking_id) > 2
 order by total_bookings desc;


-- 2. ANALYTICAL QUERY (GROUP BY / HAVING)
-- Goal: Identify categories with an average price exceeding 10,000 PKR (Premium Categories).
select ac.category_name,
       round(
          avg(ba.price),
          2
       ) as average_price,
       count(ba.animal_id) as species_count
  from animal_categories ac
  join bonsai_animals ba
on ac.category_id = ba.category_id
 group by ac.category_name
having avg(ba.price) > 10000;


-- 3. SUBQUERY-BASED QUERY
-- Goal: Find customers who have engaged with the booking system but have not yet provided testimonial feedback.
select first_name,
       last_name,
       email
  from customers
 where customer_id in (
   select customer_id
     from bookings
)
   and customer_id not in (
   select customer_id
     from testimonials
);


-- 4. WINDOW FUNCTION (RANK)
-- Goal: Rank each animal by price within its specific category (e.g., Ranking all Kittens against each other).
select ba.species_name,
       ac.category_name,
       ba.price,
       rank()
       over(partition by ba.category_id
            order by ba.price desc
       ) as category_price_rank
  from bonsai_animals ba
  join animal_categories ac
on ba.category_id = ac.category_id;


-- 5. MULTI-TABLE JOIN QUERY
-- Goal: Generate a master attendance list showing the Customer, Workshop Title, Location, and Date.
select cust.first_name
       || ' '
       || cust.last_name as full_name,
       wt.title as workshop_topic,
       c.city_name,
       t.schedule_date
  from bookings b
  join customers cust
on b.customer_id = cust.customer_id
  join tutorials t
on b.tutorial_id = t.tutorial_id
  join workshop_types wt
on t.type_id = wt.type_id
  join cities c
on t.city_id = c.city_id
 order by t.schedule_date asc;