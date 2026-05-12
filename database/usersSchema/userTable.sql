--user table schema design

create table users(

	id bigserial,
	username varchar(50) unique not null,
	password varchar(255),
	email varchar(255) unique not null,
	
	oauth_provider varchar(255),
	oauth_id varchar(255),
	first_name varchar(255),
	last_name varchar(255),
	created_at timestamptz default now(),
	updated_at timestamptz default now(),
	
	primary key(id)
);

--for the outh login, every row will be scanned for the user so we can create 
--index on it for faster checks

create index idx_user_oauth on users (oauth_provider,oauth_id);
