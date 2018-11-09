use sakila;

#1a
SELECT 
    first_name, last_name
FROM
    actor;

#1b
SELECT 
    CONCAT(first_name, ' ', last_name) AS 'Actor Name'
FROM
    actor;
#answer was already in uppercase

#2a
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    first_name = 'Joe';

#2b
SELECT 
    *
FROM
    actor
WHERE
    last_name LIKE '%GEN%';


#2c
SELECT 
    *
FROM
    actor
WHERE
    last_name LIKE '%LI%'
ORDER BY last_name , first_name;

#2d
SELECT 
    country_id, country
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');

#3a
alter table actor 
add column description blob;

#3b
alter table actor
drop column description;

#4a
SELECT 
    last_name, COUNT(last_name) AS 'Number of Occurances'
FROM
    actor
GROUP BY last_name;

#4b
SELECT 
    last_name, COUNT(last_name) AS 'Number of Occurances'
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;


SET SQL_SAFE_UPDATES = 0;
#4c
update actor
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "WILLIAMS";

#4d
SET SQL_SAFE_UPDATES = 1;

#check for 4d
select *
from actor
where last_name like "%wil%";


#5a
show create table address;

#6a
SELECT 
    staff.first_name, staff.last_name, address.address
FROM
    staff
        JOIN
    address ON staff.address_id = address.address_id;

#6b
SELECT 
    s.first_name, s.last_name, s.staff_id, SUM(p.amount)
FROM
    staff s
        JOIN
    payment p ON s.staff_id = p.staff_id
GROUP BY staff_id;

#6c
SELECT 
    f.title,  COUNT(fa.actor_id) AS 'Number of Actors'
FROM
    film f
        INNER JOIN
    film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id;

#6d
SELECT 
    COUNT(inventory_id)
FROM
    inventory
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible');


#6e
select c.first_name, c.last_name , sum(p.amount) as "Total Amount Paid"
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by last_name ASC;

#7a 

select title
from film
where (title like  "K%" 
or title like "Q%")
in
(select language_id
from language
where name = "English");



#7b
select film_id
from film
where title = "Alone Trip";

select actor_id
from film_actor
where film_id =17;

SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id IN (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Alone Trip'));
                   

#7c

SELECT 
    cu.first_name, cu.last_name, cu.email
FROM
    customer cu
        JOIN
    address ad ON cu.address_id = ad.address_id
        JOIN
    city ci ON ad.city_id = ci.city_id
        JOIN
    country co ON ci.country_id = co.country_id
WHERE
    country = 'Canada';



#7d
SELECT 
    fc.film_id, fc.category_id, c.name, f.title
FROM
    film_category fc
        JOIN
    category c ON fc.category_id = c.category_id
        JOIN
    film f ON fc.film_id = f.film_id
WHERE
    name = 'Family';

#7e

SELECT 
    title, COUNT(f.film_id) AS 'Number of Times Rented'
FROM
    film f
        JOIN
    inventory inv ON f.film_id = inv.film_id
        JOIN
    rental ren ON inv.inventory_id = ren.inventory_id
GROUP BY title
ORDER BY COUNT(f.film_id) DESC;



#7f
SELECT 
    sta.store_id, SUM(amount)
FROM
    payment pay
        JOIN
    staff sta ON pay.staff_id = sta.staff_id
GROUP BY sta.store_id;




#7g

SELECT 
    sto.store_id, ci.city, co.country
FROM
    store sto
        JOIN
    address ad ON sto.address_id = ad.address_id
        JOIN
    city ci ON ad.city_id = ci.city_id
        JOIN
    country co ON ci.country_id = co.country_id;


#7h

SELECT 
    cat.name, SUM(pay.amount)
FROM
    category cat
        JOIN
    film_category fm ON cat.category_id = fm.category_id
        JOIN
    inventory inv ON fm.film_id = inv.film_id
        JOIN
    rental rent ON inv.inventory_id = rent.inventory_id
        JOIN
    payment pay ON rent.rental_id = pay.rental_id
GROUP BY cat.name
ORDER BY sum(pay.amount) limit 5;
    
#8a
CREATE VIEW Top_Five AS
    SELECT 
        cat.name, SUM(pay.amount)
    FROM
        category cat
            JOIN
        film_category fm ON cat.category_id = fm.category_id
            JOIN
        inventory inv ON fm.film_id = inv.film_id
            JOIN
        rental rent ON inv.inventory_id = rent.inventory_id
            JOIN
        payment pay ON rent.rental_id = pay.rental_id
    GROUP BY cat.name
    ORDER BY SUM(pay.amount)
    LIMIT 5;


 #8b   
  SELECT 
    *
FROM
    Top_Five;
    
#8c
drop view Top_Five;




