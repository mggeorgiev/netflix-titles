-- netflix.netflix_titles_csv definition

-- Drop table

DROP TABLE netflix.directors;

CREATE TABLE netflix.directors (
	id SERIAL primary key,
	director varchar(208) null,
	show_id varchar(5) NULL
);

insert into netflix.directors (director, show_id)
select split_part(director,',',1), show_id from netflix.netflix_titles_csv where split_part(director,',',1) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',2), show_id from netflix.netflix_titles_csv where split_part(director,',',2) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',3), show_id from netflix.netflix_titles_csv where split_part(director,',',3) <> '';