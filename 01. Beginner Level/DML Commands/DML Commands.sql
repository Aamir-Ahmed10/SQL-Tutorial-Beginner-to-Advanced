

-- Inserting rows in the customers table
INSERT INTO customers (id, first_name,country,score)
VALUES (6,'Anna','USA',NULL),(7,'Sam',NULL,100)


--Insert(Copy) data from Source table "Customers" to Target table "persons"

INSERT INTO persons (id,person_name,birth_date,phone)
SELECT id,first_name,NULL,'unknown'
FROM customers


/* Using UPDATE Change the score to 0 for Customer with id 7
   and update the country to UK */

UPDATE customers
SET score = 0,
    country = 'UK'
WHERE id = 7


/*  DELETE  all Customers with id greater than 5 */

DELETE FROM customers
WHERE id > 5

SELECT * FROM customers


/* DELETE all the data from table persons
    'TRUNCATE' runs much faster although its a DDL command */

TRUNCATE TABLE persons

SELECT * FROM persons