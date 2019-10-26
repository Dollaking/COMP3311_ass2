-- COMP3311 19T3 Assignment 2
-- Written by Aven Au

-- Q1 Which movies are more than 6 hours long? 

create or replace view Q1(title)
as
select main_title from Titles where runtime > 360 AND format = 'movie'
;


-- Q2 What different formats are there in Titles, and how many of each?

create or replace view Q2(format, ntitles)
as
select format, count(*)
from Titles
group by format
;

-- Q3 What are the top 10 movies that received more than 1000 votes?

create or replace view Q3(title, rating, nvotes)
as
select main_title, rating, nvotes
from Titles
where nvotes > 1000
	AND format = 'movie'
order by rating DESC, main_title ASC
limit 10
;


-- Q4 What are the top-rating TV series and how many episodes did each have?
create or replace view topTvRating(rating)
as
select rating
from Titles
where nvotes > 1
AND (format = 'tvSeries' or format = 'tvMiniSeries')
order by rating DESC, main_title ASC
limit 1
;

create or replace view Q4(title, nepisodes)
as
select t.main_title, cast(count(e.episode) as double precision)
from Titles t, topTvRating d, Episodes e
where t.rating = d.rating
	and (t.format = 'tvSeries' or t.format = 'tvMiniSeries')
	and (e.parent_id = t.id)
group by main_title
;

-- Q5 Which movie was released in the most languages?

create or replace view Q5MostLanguage(title, nLan)
as
select m.main_title,count(distinct(a.language))
from aliases a, titles m
where m.id = a.title_id
	and m.format = 'movie'
group by m.main_title
order by count(distinct(a.language)) DESC
limit 1
;

create or replace view Q5Top20(title, nlan)
as 
select m.main_title, count(distinct(a.language))
from aliases a, titles m
where m.id = a.title_id
	and m.format = 'movie'
group by m.main_title
order by count(distinct(a.language)) DESC
limit 20;
;

create or replace view Q5(title, nlanguages)
as
select m.title, m.nlan
from Q5Top20 m, Q5MostLanguage h
where m.nlan = h.nlan
;

-- Q6 Which actor has the highest average rating in movies that they're known for? 
-- May Need to fix case where there is more than 1

create or replace view Q6QActors(name_id, rating)
as
select k.name_id, (sum(t.rating)/count(distinct(k.title_id)))
from known_for k, actor_roles a, titles t
where t.id = k.title_id
	and t.format = 'movie'
group by k.name_id
having count(distinct(k.title_id)) > 1
;

create or replace view Q6TopRating(name_id, rating)
as 
select a.name_id, a.rating
from Q6QActors a
where a.rating is not null
order by a.rating DESC
;

create or replace view Q6(name)
as
select n.name
from Q6TopRating q, names n
where q.name_id = n.id
limit 1
;

-- Q7 For each movie with more than 3 genres, show the movie title and a comma-separated list of the genres

create or replace view Q7countgenre(title, ngenres)
as
select t.id, t.format, count(distinct(g.genre))
from titles t, title_genres g
where t.format = 'movie'
	and t.id = g.title_id
group by t.id, t.format
having count(distinct(g.genre)) > 3
;

create or replace view Q7names(name, id)
as
select t.main_title, g.title
from titles t, Q7countgenre g
where t.id = g.title
order by t.main_title
;


create or replace view Q7(title,genres)
as
select a.name, STRING_AGG (g.genre, ',' order by g.genre) genrelist
from Q7names a, title_genres g
where g.title_id = a.id
group by a.name
;

/*
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
*/
