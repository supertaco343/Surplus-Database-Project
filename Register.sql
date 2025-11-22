--form for registering, this is sent into the database for an admin to approve/disapprove
select 'shell' as component,
	'Surplus Database' as title,
	'Login' as menu_item;
	
select 'form' as component, 
	'Register' as title,
	'Register' as validate;
	--'create_user.sql' as action;

select 'text' as type, 
	'Username' as name, 
	true as required;
select 'password' as type, 
	'Password' as name, 
	true as required;
select 'text' as type,
	'Person_Name' as name,
	'Name' as label,
	true as required;
select 'text' as type, 
	'User_Type' as name, --could possibly make this into a json thing to only select 'user', 'admin', and 'editor'
	'User Type' as label,
	true as required;

insert into newusers (username, password_hash, person_name, user_type)
select :Username, 
	sqlpage.hash_password(:Password),
	:Person_Name,
	:User_Type
where :Username is not null
	and :Password is not null
	and :Person_Name is not null
	and :User_Type is not null;



--below is currently unused, might remove later

select 'alert' as component,
	'danger' as color,
	'Unable to register' as title,
	'Sorry, you could not register, please try again, or contact an admin for assistance.' as description
where $error is not null;

--need to also make this a pop up instead of sitting at the bottom of the page the entire time.  
select 'alert' as component,
	'black' as color, --need to check/change the color
	'Registered' as title,
	'Thank you, your request has been submitted, contact an admin for quicker approval.' as description
where $error is null and $reg is not null;
