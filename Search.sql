--Searching for items, clicking on an item will take you to the display item page with that item
--for normal users

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


select 'table' as component,
	true as sort,
	true as search,
	'Name' as markdown,
	'List of Items:' as title,
	'Search by name' as search_placeholder;
select '[' || item_name || '](' || 'Display_item.sql?id=' || id || ')' as 'Name',
	brief_desc as 'Brief Description',
	current_price as 'Price',
	tags as 'Tags'
from items;

--will need to add ability to click on items to take you to the view item page
