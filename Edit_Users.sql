--editing user data, should only be accessed by admins

set isUsername = (select username from usersession where id = sqlpage.cookie('session'));
set isadmin = (select is_admin from users where $isUsername = username);

select 'redirect' as component,
	'Login.sql?error2' as link
where $isUsername is null;

select 'redirect' as component,
	'User_Profile.sql' as link
where $isadmin == 0;
--above is the login check(s)

select 'shell' as component,
	'Surplus Database' as title,
	JSON('{"title":"Pages","submenu":[
		{"link":"/index.sql", "title":"Home"},
		{"link":"/Search.sql", "title":"Search"},
		{"link":"/Edit_Items.sql", "title":"Edit Items"},
		{"link":"/Edit_Users.sql", "title":"Edit Users"},
	]}') as menu_item;

--deletes user if set to delete
delete from newusers where id = $removenewuser;
--adds the user as a user if set
insert into users (username, password_hash)
select username, password_hash from newusers
where id = $adduser;
delete from newusers where id = $adduser;
--adds the user as an editor if set
insert into users (username, password_hash, is_editor)
select username, password_hash, true from newusers
where id = $addeditor;
delete from newusers where id = $addeditor;
--adds the user as an admin if set
insert into users (username, password_hash, is_admin)
select username, password_hash, true from newusers
where id = $addadmin;
delete from newusers where id = $addadmin;

/*case when $removeuser == $isUsername then (delete from usersession where id = sqlpage.cookie('session'),
	select 'cookie' as component, 'session' as name, true as remove,
	delete from users where username = $removeuser,
	select 'redirect' as component, 'index.sql' as link)
	end;*/ --currently trying to fix a bug where an admin is unable to remove themselves.  


--deletes user if set to delete
delete from users where username = $removeuser;
--changes the user to a user if set
update users set is_admin = false, 
	is_editor = false 
	where username = $changeuser;
--changes the user to an editor if set
update users set is_admin = false,
	is_editor = true
	where username = $changeeditor;
--changes the user to an admin if set
update users set is_admin = true,
	is_editor = false
	where username = $changeadmin;

select 'title' as component,
	true as center,
	'New Customer/Staff Requests' as contents;

select 'table' as component,
	'new_users' as name,
	'New Users:' as label,
	'Remove' as markdown,
	'Add_as_Admin' as markdown,
	'Add_as_Editor' as markdown,
	'Add_as_Customer' as markdown,
	true as border,
	true as search;
select username as 'Username',
	user_type as 'User Type',
	'[🗑️](Edit_Users.sql?removenewuser=' || id || ')' as Remove,
	'[Add as a Customer](Edit_Users.sql?adduser=' || id || ')' as Add_as_Customer,
	'[Add as an Editor](Edit_Users.sql?addeditor=' || id || ')' as Add_as_Editor,
	'[Add as an Admin](Edit_Users.sql?addadmin=' || id || ')' as Add_as_Admin
from newusers;

select 'title' as component,
	true as center,
	'Edit Current Staff' as contents;

select 'table' as component,
	'current_users' as name,
	'Current Users:' as label,
	'Remove' as markdown,
	'Change_to_Admin' as markdown,
	'Change_to_Editor' as markdown,
	'Change_to_Customer' as markdown,
	true as border,
	true as search;
select username as 'Username',
	case when is_admin then 'Admin'
	when is_editor then 'Editor'
	else 'Customer'
	end as 'User Type',
	'[🗑️](Edit_Users.sql?removeuser=' || username || ')' as Remove,
	'[Change to a Customer](Edit_Users.sql?changeuser=' || username || ')' as Change_to_Customer,
	'[Change to an Editor](Edit_Users.sql?changeeditor=' || username || ')' as Change_to_Editor,
	'[Change to an Admin](Edit_Users.sql?changeadmin=' || username || ')' as Change_to_Admin
from users
where is_admin == true or is_editor == true;

select 'title' as component,
	true as center,
	'Edit Current Customers' as contents;

select 'table' as component,
	'current_customers' as name,
	'Current Customers:' as label,
	'Remove' as markdown,
	'Change_to_Admin' as markdown,
	'Change_to_Editor' as markdown,
	--'Change_to_Customer' as markdown,
	true as border,
	true as search;
select username as 'Username',
	case when is_admin then 'Admin'
	when is_editor then 'Editor'
	else 'Customer'
	end as 'User Type',
	'[🗑️](Edit_Users.sql?removeuser=' || username || ')' as Remove,
	--'[Change to a Customer](Edit_Users.sql?changeuser=' || username || ')' as Change_to_Customer,
	'[Change to an Editor](Edit_Users.sql?changeeditor=' || username || ')' as Change_to_Editor,
	'[Change to an Admin](Edit_Users.sql?changeadmin=' || username || ')' as Change_to_Admin
from users
where is_admin == false and is_editor == false;

