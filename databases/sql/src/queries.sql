select * from brand;

select * from model;

-- returns models with reference to brands
select b.name, m.name, m.description
from model m
         join brand b on m.brand_id = b.id;

-- returns every model, places null into b.name column if there is no reference
select b.name, m.name, m.description
from model m
         left join brand b on b.id = m.brand_id;

-- returns every brand, places nulls into model's columns if a brand has no models
select b.name, m.name, m.description
from model m
         right join brand b on b.id = m.brand_id;

-- the same as a plain join
select b.name, m.name, m.description
from model m
         inner join brand b on b.id = m.brand_id;

-- returns all models and brand, places null in columns for records without references
select b.name, m.name, m.description
from model m
         full outer join brand b on m.brand_id = b.id;

-- the same as left join
select b.name, m.name, m.description
from model m
         left outer join brand b on m.brand_id = b.id;

-- the same as right join
select b.name, m.name, m.description
from model m
         right outer join brand b on m.brand_id = b.id;

-- returns all intersections between all records in both tables
select b.name, m.name, m.description
from model m
         cross join brand b;

select * from engine;

-- an example of joining 2 tables without a direct reference
select m.name as "camelCaseName", e.family, e.model
from (select name, row_number() over () as rn from model) as m
         join (select family, model, row_number() over () as rn from engine) as e on m.rn = e.rn;