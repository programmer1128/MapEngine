--table for the user lists

--this table is for storing the lists created by the user of the places in the map
--since the user can create many lists apart from defualt, it is optimised design to
--separate the lists and their contents into 2 tables referenced by their unique is_default

--the user list table contains the name of the lists the user has saved along with the list_description
--the tables are referenced by foreign key user_id of the users table.
create table user_lists(

	 id bigserial unique not null,
	 
	 --id in user_list is referenced by foreign key user_id of user table
	 user_id bigint not null references users(id) on delete cascade,
	 
	 list_name varchar(255) not null,
	 list_description text,
	 is_default boolean default false,
	 
	 created_at timestamptz default now(),
	 updated_at timestamptz default now()

);

--to load the lists instantly for a user we create indices for the user lists
---referenced by the user id

create index user_id_list_index on user_lists (user_id);