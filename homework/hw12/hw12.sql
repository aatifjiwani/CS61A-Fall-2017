CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size FROM dogs AS d, sizes AS s
  WHERE d.height > s.min and d.height <= s.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_height AS
  SELECT p.child FROM parents AS p, dogs AS d
  WHERE p.parent = d.name
  ORDER BY -d.height;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
    with
        siblings(first, second) as (
            select a.child, b.child from 
            parents as a, parents as b where a.parent = b.parent 
            and a.child != b.child and a.child < b.child
        )
  SELECT a.first || " and " || a.second || " are " || b.size || " siblings"
  FROM siblings AS a, size_of_dogs AS b, size_of_dogs AS c WHERE
  a.first = b.name and a.second = c.name and b.size = c.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks AS
    with 
        num_dogs(lst, num, tot, max) as (
            select a.name, 1, a.height, a.height from dogs as a union
            select lst || ", " || b.name, num + 1, tot + b.height, b.height from dogs as b, num_dogs where num < 4 and max < b.height
        )
  SELECT a.lst, a.tot FROM num_dogs as a WHERE a.tot > 170 and a.num = 4 ORDER BY a.tot;
