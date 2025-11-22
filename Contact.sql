-- this serves as a contact page for users to contact admins, (if they desire it).  can be removed from index.sql if unneeded.
select 'shell' as component,
	'Surplus Database' as title;

select 'hero' as component,
	'Contacts' as title;
select 'table' as component,
	true as striped_rows,
	true as align_center;
	
select 'Jonathan Thornton' as name,
	'Database Editor' as role,
	'supertaco343@gmail.com' as email,
	'123-456-7890' as phone;

select 'Greg Hook' as name,
	'Admin' as role,
	'hookga@mst.edu' as email,
	'123-456-7890' as phone;
