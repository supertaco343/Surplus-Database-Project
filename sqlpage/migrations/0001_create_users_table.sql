-- table for current approved users
create table users (
	username text primary key,
	password_hash text not null,
	person_name text not null default 'N/A',
	is_admin boolean not null default false,
	is_editor boolean not null default false
);

-- Creates an initial user with the username `admin` and the hashed password `admin'
insert into users (username, password_hash, is_admin) values ('admin', '$argon2id$v=19$m=19456,t=2,p=1$4lu3hSvaqXK0dMCPZLOIPg$PUFJSB6L3J5eZ33z9WX7y0nOH6KawV2FdW0abMuPE7o', true);
 -- Creates an initial editor with the username 'editor' and the hashed password 'editor'
insert into users (username, password_hash, is_editor) values ('editor', '$argon2id$v=19$m=19456,t=2,p=1$51vUUSilqNkliUxbNlm+3Q$mKVxTbULGifqfUyTNamFxKqn7Q1m9+0nJUk+HaD3P/w', true);
-- creates an initial user with the username 'user' and the hashed password 'user'
insert into users (username, password_hash) values ('user', '$argon2id$v=19$m=19456,t=2,p=1$4fA0g78nrfqcE02nqVG8UQ$9tRiDHfgaYtqxsArku4Jz/zKuFJf7e5Ply64Yk+BFoU');
-- all 3 defaults should be removed after initially starting a new database for security.  here for easy testing and initial setup

-- table for new users to register themselves, new users must be approved by an admin (admin only sees username and usertype)
create table newusers (
	id integer primary key autoincrement,
	username text not null,
	password_hash text not null,
	person_name not null,
	user_type text not null
);

--4 test users for adding back into the userbase, passwords are the same as username
insert into newusers (username, password_hash, person_name, user_type) values ('testadmin', '$argon2id$v=19$m=19456,t=2,p=1$R42+5VIxWwL7I8yiZpOtTA$fqBpLRgvmlJxraJM2tTLqJM6KX0wo+tdhCxPdexP4/M', 'steve', 'admin');
insert into newusers (username, password_hash, person_name, user_type) values ('testeditor', '$argon2id$v=19$m=19456,t=2,p=1$eH+jF1xOluQq4w9blfBIJw$5jFI72NmMQwc87u3F0WxJV5/vupzlmM+ePq4XCIu7sI', 'jobs', 'editor');
insert into newusers (username, password_hash, person_name, user_type) values ('testuser', '$argon2id$v=19$m=19456,t=2,p=1$s5utx1wXYuVbVoJfOkU9qg$qvbxgZUGuZtV6YOMTwT7hGTC6uvxidIRVw5icWgoNVc', 'bill', 'user');
insert into newusers (username, password_hash, person_name, user_type) values ('testremove', '$argon2id$v=19$m=19456,t=2,p=1$FTnuETJz4cfsczdnPRTswA$1UDLePdEnIIHsnc1VBfQ85dKFeUtqDmqqnl9MRfflKE', 'idk', 'remove');

-- table for the actual items, currently has id (not seen/used by users), name of the item, description of the item, normal price, who priced it and why, current/temporary price, and who set the current/temp price and why
create table items (
	id integer primary key autoincrement,
	item_name text not null,
	description text not null,
	brief_desc text not null,
	norm_price text not null,
	norm_price_by_and_reason text not null,
	current_price text not null,
	current_price_by_and_reason text not null,
	tags text not null
);

insert into items (item_name, description, brief_desc, norm_price, norm_price_by_and_reason, current_price, current_price_by_and_reason, tags) values ('testitem1', 'testdesc1', 'testbriefdesc1', 'normprice1', 'normpricebyandreason1', 'currentprice1', 'currentpriceandreason1', 'testtag11, testtag12');
insert into items (item_name, description, brief_desc, norm_price, norm_price_by_and_reason, current_price, current_price_by_and_reason, tags) values ('testitem2', 'testdesc2', 'testbriefdesc2', 'normprice2', 'normpricebyandreason2', 'currentprice2', 'currentpriceandreason2', 'testtag21, testtag22');
insert into items (item_name, description, brief_desc, norm_price, norm_price_by_and_reason, current_price, current_price_by_and_reason, tags) values ('testitem3', 'testdesc3', 'testbriefdesc3', 'normprice3', 'normpricebyandreason3', 'currentprice3', 'currentpriceandreason3', 'testtag31, testtag32');

create table usersession (
	id text primary key,
	username text not null references users(username),
	created_at timestamp not null default current_timestamp
);
