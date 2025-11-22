--serves as the index of the site, 
delete from usersession where id = sqlpage.cookie('session');
select 'cookie' as component, 'session' as name, true as remove;

select 'shell' as component,
	'Surplus Database' as title;
	
select 'alert' as component,
	'Hello, and welcome to the Surplus database!  Please select one of the options below:' as description,
	true as important,
	'brown' as color;
	
--select 'button' as component;
select 'Login' as title,
	'Login' as link;
	
--select 'button' as component;
select 'Register' as title,
	'Register' as link;
	
--select 'button' as component;
select 'Contact' as title,
	'Contact' as link;
