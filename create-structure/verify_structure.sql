select 
	max(show_id)
	,max("type")
	,max(title)
	,max(director)
	, max("cast")
	, max(country)
	from (
		select 
			char_length(show_id) as show_id
			,character_length("type") as "type"
			,character_length(title) as title
			,character_length(director) as director
			,char_length("cast") as "cast"
			,char_length(country) as country 
		from netflix_titles_csv ntc
	) subq