--creating a new item, should only be accessible to admins and database editors

set isUsername = (select username from usersession where id = sqlpage.cookie('session'));
set isadmin = (select is_admin from users where $isUsername = username);
set iseditor = (select is_editor from users where $isUsername = username);

select 'redirect' as component,
	'Login.sql?error2' as link
where $isUsername is null;

select 'redirect' as component,
	'Login.sql?error3' as link
where $isadmin == false and $iseditor == false;
--above is the login check(s)


select 'shell' as component,
	'Surplus Database' as title,
	JSON('{"title":"Pages","submenu":[
		{"link":"/index.sql", "title":"Home"},
		{"link":"/Search.sql", "title":"Search"},
		{"link":"/Edit_Items.sql", "title":"Edit Items"},
		{"link":"/Edit_Users.sql", "title":"Edit Users"},
	]}') as menu_item;
	
/*create table if not exists testitems(
	id integer primary key autoincrement,
	itemname text not null,
	description text not null,
	brief_desc text not null,
	norm_price text not null,
	norm_price_by_and_reason text not null,
	current_price text not null,
	current_price_by_and_reason text not null
);*/ --USED FOR TESTING, must change all table stuff to be the test table when trying to use it

insert into items (item_name, description, brief_desc, norm_price, norm_price_by_and_reason, current_price, current_price_by_and_reason, tags) 
select 
	:item_name,
	:description,
	:brief_desc,
	:norm_price,
	:norm_price_by_and_reason,
	:current_price,
	:current_price_by_and_reason,
	:tags
where
	$edit is null
	and :item_name is not null
	and :description is not null
	and :brief_desc is not null
	and :norm_price is not null
	and :norm_price_by_and_reason is not null
	and :current_price is not null
	and :current_price_by_and_reason is not null
	and :tags is not null;
	
update items
set 
	item_name = :item_name,
	description = :description,
	brief_desc = :brief_desc,
	norm_price = :norm_price,
	norm_price_by_and_reason = :norm_price_by_and_reason,
	current_price = :current_price,
	current_price_by_and_reason = :current_price_by_and_reason,
	tags = :tags
where
	id = $edit
	and :item_name is not null
	and :description is not null
	and :brief_desc is not null
	and :norm_price is not null
	and :norm_price_by_and_reason is not null
	and :current_price is not null
	and :current_price_by_and_reason is not null
	and :tags is not null;

delete from items where id = $delete;

select 'form' as component,
	'New/Change Item' as title,
	'Add/Edit Item' as validate,
	false as autocomplete;
	
select 'item_name' as name,
	'Name of item:' as label,
	(select item_name from items where id = $edit) as value,
	true as required;
select 'description' as name,
	'Description:' as label,
	'textarea' as type,
	(select description from items where id = $edit) as value,
	true as required;
select 'brief_desc' as name,
	'Brief Description:' as label,
	(select brief_desc from items where id = $edit) as value,
	true as required;
select 'norm_price' as name,
	'Normal Price:' as label,
	(select norm_price from items where id = $edit) as value,
	true as required;
select 'norm_price_by_and_reason' as name,
	'Who set the normal price, and why:' as label,
	'textarea' as type,
	(select norm_price_by_and_reason from items where id = $edit) as value,
	true as required;
select 'current_price' as name,
	'Current Price:' as label,
	(select current_price from items where id = $edit) as value,
	true as required;
select 'current_price_by_and_reason' as name,
	'Who set the current price, and why:' as label,
	'textarea' as type,
	(select current_price_by_and_reason from items where id = $edit) as value,
	true as required;
select 'tags' as name,
	'Tags:' as label,
	(select tags from items where id = $edit) as value,
	true as required;


select 'table' as component,
	true as sort,
	true as search,
	'List of Items:' as title,
	'Edit' as markdown,
	'Remove' as markdown,
	'Search by name' as search_placeholder;
select item_name as 'Name',
	brief_desc as 'Brief Description',
	current_price as 'Price',
	'[Edit](?edit=' || id|| ')' as Edit,
	'[🗑️](?delete=' || id || ')' as Remove
	--tags as 'Tags'
from items;
