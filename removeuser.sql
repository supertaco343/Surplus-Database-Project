--removes the user, mainly used for those removing themselves

set isUsername = (select username from usersession where id = sqlpage.cookie('session'));

select 'redirect' as component,
	'Login.sql?error2' as link
where $isUsername is null;

--removes the user from the session table, and removes the current cookie from their browser (must be done before removing the user)
delete from usersession where id = sqlpage.cookie('session');
select 'cookie' as component, 'session' as name, true as remove;

delete from users where username = $isUsername;

select 'redirect' as component, 'index.sql' as link;
