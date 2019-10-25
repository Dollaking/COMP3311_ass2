-- COMP3311 19T3 Assignment 2
-- Written by <<insert your name here>>

-- Q1 Which movies are more than 6 hours long? 

create or replace view Q1(title)
as
...
;


-- Q2 What different formats are there in Titles, and how many of each?

create or replace view Q2(format, ntitles)
as
...
;


-- Q3 What are the top 10 movies that received more than 1000 votes?

create or replace view Q3(title, rating, nvotes)
as
..
;


-- Q4 What are the top-rating TV series and how many episodes did each have?

create or replace view Q4(title, nepisodes)
as
...
;


-- Q5 Which movie was released in the most languages?

create or replace view Q5(title, nlanguages)
as
...
;


-- Q6 Which actor has the highest average rating in movies that they're known for?

create or replace view Q6(name)
as
...
;

-- Q7 For each movie with more than 3 genres, show the movie title and a comma-separated list of the genres


create or replace view Q7(title,genres)
as
...
;

-- Q8 Get the names of all people who had both actor and crew roles on the same movie

create or replace view Q8(name)
as
...
;

-- Q9 Who was the youngest person to have an acting role in a movie, and how old were they when the movie started?

create or replace view Q9(name,age)
as
...
;

-- Q10 Write a PLpgSQL function that, given part of a title, shows the full title and the total size of the cast and crew

create or replace function
	Q10(partial_title text) returns setof text
as $$
...
$$ language plpgsql;

