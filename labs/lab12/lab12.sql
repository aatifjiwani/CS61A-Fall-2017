.read sp17data.sql
.read fa17data.sql

CREATE TABLE obedience AS
  SELECT seven, denero, hilfinger FROM students;

CREATE TABLE smallest_int AS
  SELECT time, smallest FROM students WHERE smallest > 18 
    ORDER BY smallest LIMIT 20;

CREATE TABLE greatstudents AS
  SELECT sp17.date, sp17.color, sp17.pet, fa17.number, sp17.number FROM sp17students AS sp17, students as fa17 
  WHERE sp17.date = fa17.date and sp17.color = fa17.color and
  sp17.pet = fa17.pet;

CREATE TABLE sevens AS
  SELECT stu.seven FROM students AS stu, checkboxes AS ch
  WHERE stu.time = ch.time and stu.number = 7 and 
  ch.'7' = 'True';

CREATE TABLE matchmaker AS
  SELECT first.pet, first.song, first.color, second.color
  FROM students AS first, students AS second
  WHERE first.pet = second.pet and first.song = second.song and
  first.time < second.time;
