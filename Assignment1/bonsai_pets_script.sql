----------------------------------------------------------------
-- DROP STATEMENTS
----------------------------------------------------------------
drop table testimonials cascade constraints;
drop table bookings cascade constraints;
drop table tutorials cascade constraints;
drop table workshop_types cascade constraints;
drop table diy_kits cascade constraints;
drop table bonsai_animals cascade constraints;
drop table animal_categories cascade constraints;
drop table customers cascade constraints;
drop table cities cascade constraints;

----------------------------------------------------------------
-- CREATE TABLE STATEMENTS
----------------------------------------------------------------

create table cities (
   city_id   number primary key,
   city_name varchar2(50) not null unique
);

create table animal_categories (
   category_id   number primary key,
   category_name varchar2(50) not null unique
);

create table workshop_types (
   type_id     number primary key,
   title       varchar2(100) not null unique,
   description varchar2(500)
);

create table customers (
   customer_id number primary key,
   first_name  varchar2(50) not null,
   last_name   varchar2(50) not null,
   email       varchar2(100) unique not null,
   phone       varchar2(15),
   reg_date    date default sysdate
);

create table bonsai_animals (
   animal_id    number primary key,
   species_name varchar2(100) not null,
   category_id  number
      references animal_categories ( category_id ),
   price        number(10,2) not null check ( price > 0 ),
   image_path   varchar2(255),
   stock_level  number not null check ( stock_level >= 0 )
);

create table diy_kits (
   kit_id      number primary key,
   kit_name    varchar2(100) not null,
   price       number(10,2) not null,
   stock_level number not null
);

create table tutorials (
   tutorial_id   number primary key,
   type_id       number
      references workshop_types ( type_id ),
   schedule_date date not null,
   max_capacity  number default 20,
   city_id       number
      references cities ( city_id )
);

create table bookings (
   booking_id   number primary key,
   customer_id  number
      references customers ( customer_id ),
   tutorial_id  number
      references tutorials ( tutorial_id ),
   booking_date date default sysdate
);

create table testimonials (
   testimonial_id number primary key,
   customer_id    number
      references customers ( customer_id ),
   animal_id      number
      references bonsai_animals ( animal_id ),
   review_text    clob,
   rating         number(1) check ( rating between 1 and 5 )
);

----------------------------------------------------------------
-- DATA INSERTION
----------------------------------------------------------------

insert into cities values ( 1,
                            'Karachi' );
insert into cities values ( 2,
                            'Lahore' );
insert into cities values ( 3,
                            'Islamabad' );
insert into cities values ( 4,
                            'Rawalpindi' );
insert into cities values ( 5,
                            'Peshawar' );

insert into animal_categories values ( 1,
                                       'Cat' );
insert into animal_categories values ( 2,
                                       'Rabbit' );
insert into animal_categories values ( 3,
                                       'Exotic' );
insert into animal_categories values ( 4,
                                       'Bird' );
insert into animal_categories values ( 5,
                                       'Reptile' );

insert into workshop_types values ( 1,
                                    'Kitten Pruning',
                                    'Learn how to maintain the size of your Bonsai Kitten.' );
insert into workshop_types values ( 2,
                                    'Habitat Setup',
                                    'Design a miniature world for your pet.' );
insert into workshop_types values ( 3,
                                    'Feeding Techniques',
                                    'Proper nutrition and feeding schedules for miniature animals.' );
insert into workshop_types values ( 4,
                                    'Grooming Basics',
                                    'Essential grooming techniques for small breed animals.' );
insert into workshop_types values ( 5,
                                    'Health Monitoring',
                                    'Identifying signs of stress and illness in bonsai animals.' );

-- CUSTOMERS
insert into customers values ( 1,
                               'Ayesha',
                               'Malik',
                               'ayesha.malik@gmail.com',
                               '0311-1234567',
                               to_date('2024-01-10','YYYY-MM-DD') );
insert into customers values ( 2,
                               'Bilal',
                               'Ahmed',
                               'bilal.ahmed@outlook.com',
                               '0322-2345678',
                               to_date('2024-01-15','YYYY-MM-DD') );
insert into customers values ( 3,
                               'Sara',
                               'Khan',
                               'sara.khan@yahoo.com',
                               '0333-3456789',
                               to_date('2024-02-01','YYYY-MM-DD') );
insert into customers values ( 4,
                               'Usman',
                               'Raza',
                               'usman.raza@gmail.com',
                               '0344-4567890',
                               to_date('2024-02-14','YYYY-MM-DD') );
insert into customers values ( 5,
                               'Hina',
                               'Farooq',
                               'hina.farooq@gmail.com',
                               '0355-5678901',
                               to_date('2024-02-20','YYYY-MM-DD') );
insert into customers values ( 6,
                               'Zain',
                               'Ul Haq',
                               'zain.ulhaq@hotmail.com',
                               '0366-6789012',
                               to_date('2024-03-05','YYYY-MM-DD') );
insert into customers values ( 7,
                               'Nadia',
                               'Sheikh',
                               'nadia.sheikh@gmail.com',
                               '0377-7890123',
                               to_date('2024-03-12','YYYY-MM-DD') );
insert into customers values ( 8,
                               'Omar',
                               'Javed',
                               'omar.javed@outlook.com',
                               '0388-8901234',
                               to_date('2024-03-18','YYYY-MM-DD') );
insert into customers values ( 9,
                               'Fatima',
                               'Siddiqui',
                               'fatima.siddiqui@gmail.com',
                               '0399-9012345',
                               to_date('2024-04-02','YYYY-MM-DD') );
insert into customers values ( 10,
                               'Hassan',
                               'Mirza',
                               'hassan.mirza@gmail.com',
                               '0300-0123456',
                               to_date('2024-04-10','YYYY-MM-DD') );
insert into customers values ( 11,
                               'Mariam',
                               'Tariq',
                               'mariam.tariq@yahoo.com',
                               '0301-1234567',
                               to_date('2024-04-22','YYYY-MM-DD') );
insert into customers values ( 12,
                               'Faisal',
                               'Qureshi',
                               'faisal.qureshi@gmail.com',
                               '0302-2345678',
                               to_date('2024-05-01','YYYY-MM-DD') );

-- BONSAI_ANIMALS
insert into bonsai_animals values ( 1,
                                    'Bonsai Persian',
                                    1,
                                    25000,
                                    'persian.jpg',
                                    5 );
insert into bonsai_animals values ( 2,
                                    'Teacup Bunny',
                                    2,
                                    12000,
                                    'bunny.jpg',
                                    8 );
insert into bonsai_animals values ( 3,
                                    'Miniature Siamese',
                                    1,
                                    28000,
                                    'siamese.jpg',
                                    3 );
insert into bonsai_animals values ( 4,
                                    'Pygmy Hedgehog',
                                    3,
                                    9500,
                                    'hedgehog.jpg',
                                    6 );
insert into bonsai_animals values ( 5,
                                    'Nano Parrot',
                                    4,
                                    18000,
                                    'parrot.jpg',
                                    4 );
insert into bonsai_animals values ( 6,
                                    'Dwarf Lop Rabbit',
                                    2,
                                    14000,
                                    'lop.jpg',
                                    7 );
insert into bonsai_animals values ( 7,
                                    'Micro Maine Coon',
                                    1,
                                    32000,
                                    'mainecoon.jpg',
                                    2 );
insert into bonsai_animals values ( 8,
                                    'Tiny Chameleon',
                                    5,
                                    22000,
                                    'chameleon.jpg',
                                    3 );
insert into bonsai_animals values ( 9,
                                    'Miniature Cockatiel',
                                    4,
                                    15000,
                                    'cockatiel.jpg',
                                    5 );
insert into bonsai_animals values ( 10,
                                    'Bonsai Angora',
                                    2,
                                    16000,
                                    'angora.jpg',
                                    4 );
insert into bonsai_animals values ( 11,
                                    'Pocket Bearded Dragon',
                                    5,
                                    19500,
                                    'dragon.jpg',
                                    2 );

-- DIY_KITS
insert into diy_kits values ( 1,
                              'Starter Habitat Kit',
                              3500,
                              20 );
insert into diy_kits values ( 2,
                              'Grooming Essentials Pack',
                              2200,
                              35 );
insert into diy_kits values ( 3,
                              'Miniature Garden Set',
                              4800,
                              15 );
insert into diy_kits values ( 4,
                              'Feeding Station Kit',
                              1800,
                              40 );
insert into diy_kits values ( 5,
                              'Bonsai Cat Care Bundle',
                              5500,
                              10 );
insert into diy_kits values ( 6,
                              'Rabbit Burrow Kit',
                              3200,
                              18 );
insert into diy_kits values ( 7,
                              'Bird Perch and Play Kit',
                              2700,
                              22 );
insert into diy_kits values ( 8,
                              'Reptile Terrarium Starter',
                              6000,
                              8 );
insert into diy_kits values ( 9,
                              'Exotic Pet Wellness Kit',
                              4200,
                              12 );
insert into diy_kits values ( 10,
                              'Complete Bonsai Pet Bundle',
                              8500,
                              6 );

-- TUTORIALS
insert into tutorials values ( 1,
                               1,
                               to_date('2024-05-01','YYYY-MM-DD'),
                               15,
                               1 );
insert into tutorials values ( 2,
                               1,
                               to_date('2024-05-05','YYYY-MM-DD'),
                               15,
                               2 );
insert into tutorials values ( 3,
                               2,
                               to_date('2024-05-10','YYYY-MM-DD'),
                               20,
                               3 );
insert into tutorials values ( 4,
                               3,
                               to_date('2024-05-15','YYYY-MM-DD'),
                               20,
                               1 );
insert into tutorials values ( 5,
                               4,
                               to_date('2024-05-20','YYYY-MM-DD'),
                               25,
                               4 );
insert into tutorials values ( 6,
                               5,
                               to_date('2024-06-01','YYYY-MM-DD'),
                               20,
                               2 );
insert into tutorials values ( 7,
                               2,
                               to_date('2024-06-05','YYYY-MM-DD'),
                               15,
                               5 );
insert into tutorials values ( 8,
                               3,
                               to_date('2024-06-10','YYYY-MM-DD'),
                               20,
                               3 );
insert into tutorials values ( 9,
                               1,
                               to_date('2024-06-15','YYYY-MM-DD'),
                               15,
                               4 );
insert into tutorials values ( 10,
                               4,
                               to_date('2024-06-20','YYYY-MM-DD'),
                               25,
                               1 );

-- BOOKINGS
insert into bookings values ( 1,
                              1,
                              1,
                              to_date('2024-04-20','YYYY-MM-DD') );
insert into bookings values ( 2,
                              2,
                              1,
                              to_date('2024-04-21','YYYY-MM-DD') );
insert into bookings values ( 3,
                              3,
                              2,
                              to_date('2024-04-22','YYYY-MM-DD') );
insert into bookings values ( 4,
                              4,
                              3,
                              to_date('2024-04-25','YYYY-MM-DD') );
insert into bookings values ( 5,
                              5,
                              3,
                              to_date('2024-04-26','YYYY-MM-DD') );
insert into bookings values ( 6,
                              6,
                              4,
                              to_date('2024-04-28','YYYY-MM-DD') );
insert into bookings values ( 7,
                              7,
                              5,
                              to_date('2024-05-02','YYYY-MM-DD') );
insert into bookings values ( 8,
                              8,
                              6,
                              to_date('2024-05-10','YYYY-MM-DD') );
insert into bookings values ( 9,
                              9,
                              7,
                              to_date('2024-05-12','YYYY-MM-DD') );
insert into bookings values ( 10,
                              10,
                              8,
                              to_date('2024-05-15','YYYY-MM-DD') );
insert into bookings values ( 11,
                              11,
                              9,
                              to_date('2024-05-20','YYYY-MM-DD') );
insert into bookings values ( 12,
                              12,
                              10,
                              to_date('2024-05-22','YYYY-MM-DD') );

-- TESTIMONIALS
insert into testimonials values ( 1,
                                  1,
                                  1,
                                  'Absolutely love my Bonsai Persian! So tiny and adorable.',
                                  5 );
insert into testimonials values ( 2,
                                  2,
                                  2,
                                  'The Teacup Bunny is precious. Delivery was smooth.',
                                  4 );
insert into testimonials values ( 3,
                                  3,
                                  3,
                                  'Miniature Siamese is a little diva! Worth every rupee.',
                                  5 );
insert into testimonials values ( 4,
                                  4,
                                  4,
                                  'Pygmy Hedgehog is unique. Takes getting used to but lovely.',
                                  3 );
insert into testimonials values ( 5,
                                  5,
                                  5,
                                  'Nano Parrot talks already! Incredible experience.',
                                  5 );
insert into testimonials values ( 6,
                                  6,
                                  6,
                                  'Dwarf Lop is so fluffy. Kids are obsessed.',
                                  4 );
insert into testimonials values ( 7,
                                  7,
                                  7,
                                  'Micro Maine Coon is majestic. A bit pricey but worth it.',
                                  4 );
insert into testimonials values ( 8,
                                  8,
                                  8,
                                  'Tiny Chameleon changes color beautifully. Very exotic choice.',
                                  5 );
insert into testimonials values ( 9,
                                  9,
                                  9,
                                  'Cockatiel is very tame and friendly. Great for beginners.',
                                  4 );
insert into testimonials values ( 10,
                                  10,
                                  10,
                                  'Angora rabbit is incredibly soft. Happy with the purchase.',
                                  5 );

commit;