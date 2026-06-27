/*
 * Copyright (c) 2026 Aritra Banerjee. All Rights Reserved.
 Written by Aritra Banerjee
 * Not allowed to be copied
 */

--table for the refresh token design of JWT

--a separate table for the refresh tokens is req instead of a single column as the user may log into 
--from several devices and each login will overwrite the previous one if for one column only so we 
--need a separate table so as to allow 1 user_id refer to several logins and their refresh tokens
create table refresh_tokens(

	 id bigserial,
	 user_id bigint not null references users(id) on delete  cascade,
	 device_name varchar(512),
	 token_hash varchar(512),
	 expires_at timestamptz,
	 is_revoked boolean,
	 
	 primary key(id)
	
);

--for tokens they will be read and refreshed in interval, so that needs to be fast
--we need to look up the token hashes and as they are unique for every user we can 
--create an unique index
create unique index index_refresh_tokens_hash on refresh_tokens(token_hash);

--also when the user logs out of all devices we need to disable all the refresh_tokens for that
--id hence we need an index on user_id as well
create index index_refresh_tokens_user_id on refresh_tokens(user_id);




/*
 * End of file
 * Written by Aritra Banerjee
 * Not allowed to be copied
 */
