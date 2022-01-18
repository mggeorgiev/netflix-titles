-- netflix.netflix_titles_csv definition

-- Drop table

/*directors*/

-- DROP TABLE netflix.temp_directors_to_titles;

CREATE TABLE netflix.temp_directors_to_titles (
	id SERIAL primary key,
	director varchar(208) null,
	show_id varchar(5) NULL
);

do $$
declare 
   counter integer := 1;
begin
   while counter < 50 loop
		insert into netflix.temp_directors_to_titles (director, show_id)
		select split_part(director,',',1), show_id from netflix.netflix_titles_csv where split_part(director,',',1) <> '';
	  counter := counter + 1;
   end loop;
end$$;

begin transaction;
	update netflix.temp_directors_to_titles set director = regexp_replace(director, '^\s', '', 'g');
commit;

-- DROP TABLE netflix.directors;

CREATE TABLE netflix.directors (
	id SERIAL primary key,
	director varchar(208) null
);

insert into netflix.directors (director)
select distinct director from netflix.temp_directors_to_titles;

with cte as (
	select 
		d.id as newid
		,dtt.director as old_director
		,d.director 
		,dtt.id as oldid 
	from netflix.directors d 
	join netflix.temp_directors_to_titles dtt on d.director = dtt.director
	)
UPDATE netflix.temp_directors_to_titles 
set director = cte.newid
from cte
join netflix.temp_directors_to_titles dtt2 on dtt2.id = cte.oldid;


CREATE TABLE netflix.directors_to_titles (
	id SERIAL primary key,
	director varchar(208) null,
	show_id varchar(5) NULL
);




ALTER TABLE netflix.directors_to_titles ALTER COLUMN director TYPE int4 USING director::int4;
ALTER TABLE netflix.directors_to_titles ADD CONSTRAINT directors_to_titles_fk FOREIGN KEY (director) REFERENCES netflix.directors(id);

/*actors*/

DROP TABLE netflix.actors_to_titles;

CREATE TABLE netflix.actors_to_titles (
	id SERIAL primary key,
	actor varchar(208) null,
	show_id varchar(5) NULL
);


do $$
declare 
   counter integer := 1;
begin
   while counter < 50 loop
      insert into netflix.actors_to_titles (actor, show_id)
	  select split_part("cast",',',counter), show_id from netflix.netflix_titles_csv where split_part("cast",',',counter) <> '';
	  counter := counter + 1;
   end loop;
end$$;

begin transaction;
	update netflix.actors_to_titles set actor = regexp_replace(actor, '^\s', '', 'g');
commit;


DROP TABLE netflix.actors;

CREATE TABLE netflix.actors (
	id SERIAL primary key,
	actor varchar(208) null
);

insert into netflix.actors (actor)
select distinct actor from netflix.actors_to_titles;

with cte as (
	select 
		a.id as newid
		,att.actor as old_director
		,a.actor 
		,att.id as oldid 
	from netflix.actors a 
	join netflix.actors_to_titles att on a.actor = att.actor 
	)
UPDATE netflix.actors_to_titles 
set actor = cte.newid
from cte
join netflix.actors_to_titles att2 on att2.id = cte.oldid;

-- update netflix.actors_to_titles nt
-- set actor = (select id from netflix.actors a where a.actor = nt.actor )
-- where id between 0 and 999


ALTER TABLE netflix.actors_to_titles ALTER COLUMN actor TYPE int4 USING actor::int4;
ALTER TABLE netflix.actors_to_titles ADD CONSTRAINT actors_to_titles_fk FOREIGN KEY (actor) REFERENCES netflix.actors(id);


/*show_type*/