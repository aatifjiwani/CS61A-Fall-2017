CREATE TABLE flights AS
  SELECT "SFO" AS departure, "LAX" AS arrival, 97 AS price UNION
  SELECT "SFO"             , "AUH"           , 848         UNION
  SELECT "LAX"             , "SLC"           , 115         UNION
  SELECT "SFO"             , "PDX"           , 192         UNION
  SELECT "AUH"             , "SEA"           , 932         UNION
  SELECT "SLC"             , "PDX"           , 79          UNION
  SELECT "SFO"             , "LAS"           , 40          UNION
  SELECT "SLC"             , "LAX"           , 117         UNION
  SELECT "SEA"             , "PDX"           , 32          UNION
  SELECT "SLC"             , "SEA"           , 42          UNION
  SELECT "SFO"             , "SLC"           , 97          UNION
  SELECT "LAS"             , "SLC"           , 50          UNION
  SELECT "LAX"             , "PDX"           , 89               ;

CREATE TABLE main_course AS
  SELECT "turkey" AS meat, "cranberries" AS side, 2000 AS calories UNION
  SELECT "turducken"     , "potatoes"           , 4000             UNION
  SELECT "tofurky"       , "cranberries"        , 1000             UNION
  SELECT "tofurky"       , "stuffing"           , 1000             UNION
  SELECT "tofurky"       , "yams"               , 1000             UNION
  SELECT "turducken"     , "turducken"          , 9000             UNION
  SELECT "turkey"        , "potatoes"           , 2000             UNION
  SELECT "turkey"        , "bread"              , 1500             UNION
  SELECT "tofurky"       , "soup"               , 1200             UNION
  SELECT "chicken"       , "cranberries"        , 2500             UNION
  SELECT "turducken"     , "butter"             , 10000            UNION
  SELECT "turducken"     , "more_butter"        , 15000                 ;

CREATE TABLE pies AS
  SELECT "pumpkin" AS pie, 500 AS calories UNION
  SELECT "apple"         , 400             UNION
  SELECT "chocolate"     , 600             UNION
  SELECT "cherry"        , 550                  ;

CREATE TABLE products AS
  SELECT "phone" AS category, "uPhone" AS name, 99.99 AS MSRP, 4.5 AS rating UNION
  SELECT "phone"            , "rPhone"        , 79.99        , 3             UNION
  SELECT "phone"            , "qPhone"        , 89.99        , 4             UNION
  SELECT "games"            , "GameStation"   , 299.99       , 3             UNION
  SELECT "games"            , "QBox"          , 399.99       , 3.5           UNION
  SELECT "computer"         , "iBook"         , 112.99       , 4             UNION
  SELECT "computer"         , "wBook"         , 114.29       , 4.4           UNION
  SELECT "computer"         , "kBook"         , 99.99        , 3.8                ;

CREATE TABLE inventory AS
  SELECT "Hallmart" AS store, "uPhone" AS item, 99.99 AS price UNION
  SELECT "Targive"          , "uPhone"        , 100.99         UNION
  SELECT "RestBuy"          , "uPhone"        , 89.99          UNION

  SELECT "Hallmart"         , "rPhone"        , 69.99          UNION
  SELECT "Targive"          , "rPhone"        , 79.99          UNION
  SELECT "RestBuy"          , "rPhone"        , 75.99          UNION

  SELECT "Hallmart"         , "qPhone"        , 85.99          UNION
  SELECT "Targive"          , "qPhone"        , 88.98          UNION
  SELECT "RestBuy"          , "qPhone"        , 87.98          UNION

  SELECT "Hallmart"         , "GameStation"   , 298.98         UNION
  SELECT "Targive"          , "GameStation"   , 300.98         UNION
  SELECT "RestBuy"          , "GameStation"   , 310.99         UNION

  SELECT "Hallmart"         , "QBox"          , 399.99         UNION
  SELECT "Targive"          , "QBox"          , 390.98         UNION
  SELECT "RestBuy"          , "QBox"          , 410.98         UNION

  SELECT "Hallmart"         , "iBook"         , 111.99         UNION
  SELECT "Targive"          , "iBook"         , 110.99         UNION
  SELECT "RestBuy"          , "iBook"         , 112.99         UNION

  SELECT "Hallmart"         , "wBook"         , 117.29         UNION
  SELECT "Targive"          , "wBook"         , 119.29         UNION
  SELECT "RestBuy"          , "wBook"         , 114.29         UNION

  SELECT "Hallmart"         , "kBook"         , 95.99          UNION
  SELECT "Targive"          , "kBook"         , 96.99          UNION
  SELECT "RestBuy"          , "kBook"         , 94.99               ;

CREATE TABLE stores AS
  SELECT "Hallmart" AS store, "50 Lawton Way" AS address, 25 AS Mbs UNION
  SELECT "Targive"          , "2 Red Circle Way"        , 40        UNION
  SELECT "RestBuy"          , "1 Kiosk Ave"             , 30             ;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

CREATE TABLE schedule AS
  with
    list_flights(direction, cost,first_flight, last_flight, num) as (
        select a.departure || ", " || a.arrival, a.price, a.departure, a.arrival, 1 from flights as a union
        select direction || ", " || second.arrival, cost + second.price, first_flight, second.arrival, num + 1 from flights as second, list_flights where second.departure = last_flight and num < 2
    )
  SELECT direction,cost FROM list_flights where first_flight = "SFO" and last_flight = "PDX" ORDER BY cost
  ;

CREATE TABLE number_of_options AS
  SELECT count(DISTINCT meat) from main_course;

CREATE TABLE calories AS
    with 
        num_meals(cals) as (
            select a.calories + b.calories from main_course as a, pies as b
        )
  SELECT count(cals) FROM num_meals WHERE cals < 2500;

CREATE TABLE healthiest_meats AS
    with 
        num_meals(animal_meat, cals) as (
            select a.meat, a.calories + b.calories from main_course as a, pies as b
        )
  SELECT animal_meat, min(cals) FROM num_meals GROUP BY animal_meat HAVING cals < 2500;

CREATE TABLE average_prices AS
  SELECT category, avg(MSRP) FROM products GROUP BY category;

CREATE TABLE lowest_prices AS
  SELECT store, item, min(price) FROM inventory GROUP BY item;

CREATE TABLE shopping_list AS
    with 
        best_prod(prod) as (
            select name FROM products GROUP BY category HAVING min(MSRP/rating)
        )
  SELECT prod, store FROM best_prod,lowest_prices WHERE prod=item;

CREATE TABLE total_bandwidth AS
    with 
        bandwith(loc, tot) as (
            select a.store, a.Mbs from stores as a, shopping_list as b where a.store = b.store
        )
  SELECT sum(tot) FROM bandwith;
