create table if not exists testtwothings(
	thingy1 text, 
	thingy2 text
);

select 'form' as component,
	'Test Single' as title,
	'Add tests' as validate;
	
select 'test 1' as name,
	--:test1 as variable,
	'idkwhatimdoing' as label,
	true as required;
select 'test 2' as name,
	:test2 as variable,
	true as required;
	
--insert into testtwothings (thingy1)
--select :test1
--where :test1 is not null;

--insert into testtwothings (thingy2)
--select :test2
--where :test2 is not null;

insert into testtwothings (thingy1, thingy2)
select :test1,
	:test2
where :test1 is not null
	and :test2 is not null

select 'table' as component,
	true as sort,
	true as search,
	'testing' as search_placeholder;

select thingy1 as title from testtwothings
union
select thingy2 as title from testtwothings;
