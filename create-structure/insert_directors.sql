insert into netflix.directors (director, show_id)
select split_part(director,',',1), show_id from netflix.netflix_titles_csv where split_part(director,',',1) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',2), show_id from netflix.netflix_titles_csv where split_part(director,',',2) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',3), show_id from netflix.netflix_titles_csv where split_part(director,',',3) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',4), show_id from netflix.netflix_titles_csv where split_part(director,',',4) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',5), show_id from netflix.netflix_titles_csv where split_part(director,',',5) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',6), show_id from netflix.netflix_titles_csv where split_part(director,',',6) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',7), show_id from netflix.netflix_titles_csv where split_part(director,',',7) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',8), show_id from netflix.netflix_titles_csv where split_part(director,',',8) <> '';

insert into netflix.directors (director, show_id)
select split_part(director,',',9), show_id from netflix.netflix_titles_csv where split_part(director,',',9) <> '';

select distinct director from netflix.directors d 