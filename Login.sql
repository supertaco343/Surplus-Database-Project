--serves as the login page

delete from usersession where id = sqlpage.cookie('session');
select 'cookie' as component, 'session' as name, true as remove;

select 'shell' as component,
	'Surplus Database' as title,
	'Register' as menu_item;
		
select 'form' as component, 
	'Login' as title, 
	'create_session.sql' as action,
	'Login' as validate;
select 'Username' as name, 
	true as required;
select 'password' as type, 
	'Password' as name, 
	true as required;

select 'alert' as component,
	'danger' as color,
	'Your username or password is incorrect' as title,
	'Sorry, you could not log in, please try again, or contact an admin for assistance.' as description
where $error is not null;  --error for being unable to login from the login page

select 'alert' as component,
	'danger' as color,
	'You are not logged in' as title,
	'You are not currently logged in, please login to view this page.' as description
where $error2 is not null;  --error for not being logged in when trying to go to a page

select 'alert' as component,
	'danger' as color,
	'You do not have permission to view this page' as title,
	'Your user account is not permitted to view this page, please contact an admin for assistance.' as description
where $error3 is not null;  --error for trying to access a page that "above their credentials"
