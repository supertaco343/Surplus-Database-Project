
-- redirection to login page if the password or username is incorrect
select 'authentication' as component,
	'Login.sql?error' as link,
	(select password_hash from users where username = :Username) as password_hash,
	:Password as password;

-- code above will do its check, then if the user is authenticated, then lower will execute
insert into usersession (id, username)
values (sqlpage.random_string(32), :Username)
returning
	'cookie' as component,
	'session' as name,
	id as value,
	false as secure;  --this part can be removed if/when it is using https

-- the users browser will now have a cookie named 'session_token' that can be checked later
select 'redirect' as component, 'Search.sql' as link;
