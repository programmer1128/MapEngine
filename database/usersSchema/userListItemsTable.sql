--this table is referenced by the user_list table to hold the items of each list
--the contents of this table is refered by the foreign key list_id which is the id of the list
--in the user_list table

--so every list in the user list table is related to several of it's entries or items in this table

create table user_list_items(

	 --primary key
	 id bigserial unique not null,
	 --foreign key of the table
	 list_id bigint unique not null references user_lists(id) on delete cascade,
	 
	 --place name of stored place in list
	 place_name varchar(255) not null,
	 place_description text,
	 
	 --sort position used with double precision to enable dynamic sorting of places
	 --acc to user
	 sort_position DOUBLE PRECISION NOT null,
	 
	 geom geometry(point,436) not null,
	 
	 place_photo_url varchar(512),
	 
	 created_at timestamptz default now()
	 
);

--to load the items instantly
create index idx_user_list_items on user_list_items(list_id);

--to load the coordinates of the items instantly on the UI map for a particular list
create index index_user_list_items_geom on user_list_items using GIST (geom);

--index to sort the items list if the user wants
CREATE INDEX idx_user_list_items_sort ON user_list_items(list_id, sort_position);
