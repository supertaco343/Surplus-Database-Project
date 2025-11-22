--used for displaying more details about a specific item.  
--for normal users, admin/editor one seperate

set isUsername = (select username from usersession where id = sqlpage.cookie('session'));

select 'redirect' as component,
	'Login.sql?error2' as link
where $isUsername is null;
--above is the login check(s)

select 'shell' as component,
	'Surplus Database' as title,
	JSON('{"title":"Pages","submenu":[
		{"link":"/index.sql", "title":"Home"},
		{"link":"/Search.sql", "title":"Search"},
		{"link":"/Edit_Items.sql", "title":"Edit Items"},
		{"link":"/Edit_Users.sql", "title":"Edit Users"},
	]}') as menu_item;

--select 'hero' as component,
--	item_name as title from items where id = $id;
--below looks better imo, but going to leave this here

select 'title' as component,
	true as center,
	item_name as contents from items where id = $id;

select 'text' as component,
	'Description:' as title;
select description as contents from items where id = $id;

select 'text' as component,
	'Price:' as title;
select current_price as contents from items where id = $id;

select 'text' as component,
	'Who set the price, and why:' as title;
select current_price_by_and_reason as contents from items where id = $id;

select 'text' as component,
	'Tags:' as title;
select tags as contents from items where id = $id;


/*select 'card' as component;

select 
  item_name as title,
  brief_desc as description,
  'Price: $' || current_price as subtitle
from items
where id = $id;*/  --not in use, but here if i want to use it later
