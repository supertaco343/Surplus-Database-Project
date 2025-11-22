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
	'Surplus Database' as title;
	
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
	:item_name is not null
	and :description is not null
	and :brief_desc is not null
	and :norm_price is not null
	and :norm_price_by_and_reason is not null
	and :current_price is not null
	and :current_price_by_and_reason is not null
	and :tags is not null;

select 'form' as component,
	'New Item' as title,
	'Add Item' as validate,
	false as autocomplete;
	
select 'item_name' as name,
	'Name of item:' as label,
	true as required;
select 'description' as name,
	'Description:' as label,
	'textarea' as type,
	true as required;
select 'brief_desc' as name,
	'Brief Description:' as label,
	true as required;
select 'norm_price' as name,
	'Normal Price:' as label,
	true as required;
select 'norm_price_by_and_reason' as name,
	'Who set the normal price, and why:' as label,
	'textarea' as type,
	true as required;
select 'current_price' as name,
	'Current Price:' as label,
	true as required;
select 'current_price_by_and_reason' as name,
	'Who set the current price, and why:' as label,
	'textarea' as type,
	true as required;
select 'tags' as name,
	'Tags:' as label,
	true as required;


select 'table' as component,
	true as sort,
	true as search,
	'List of Items:' as title,
	'Search by name' as search_placeholder;
select item_name as 'Name',
	brief_desc as 'Brief Description',
	current_price as 'Price',
	tags as 'Tags'
from items;
