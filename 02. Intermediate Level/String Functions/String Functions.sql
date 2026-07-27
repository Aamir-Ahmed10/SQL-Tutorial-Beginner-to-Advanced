
/*MANIPULATE String Function*/

--1)CONCAT Function (Combines multiple strings into One)
--Show a list of customers' first names together with their country in one columns

SELECT CONCAT(first_name,' ', country) AS name_country
FROM Customers

--2)UPPER and 3)LOWER Functions (Converts all characters to Uppercase/Lowercase)
--Transform the customers' first name to lowercase

SELECT LOWER(first_name) AS low_name
FROM Customers

--Transform the customers' first name to uppercase
SELECT UPPER(first_name) AS up_name
FROM Customers



--4)TRIM Functions (Removes Leading and Trailing spaces)
--FInd customers whose first name contains leading or trailing spaces

SELECT first_name,
       LEN(first_name) len_name,  /*checking number of characters*/
	   LEN(TRIM(first_name)) len_trim_name,  /*checking number of characters after trim*/
	   LEN(first_name) - LEN(TRIM(first_name)) flag  /*checking for flag means if result=0 then no extra space else there are extra spaces*/
FROM Customers


--5)REPLACE Functions (Replaces specific character with a new character)

--Remove dashes(-) from a phone number
SELECT '123-456-7890' AS phone,
REPLACE ('123-456-7890','-','') AS clean_phone

--Replace file extension from txt to csv
SELECT 'report.txt' AS old_filename,
REPLACE ('report.txt','.txt','.csv') AS new_filename


/*CALCULATION String Function*/


--1)LEN Function (Counts how many chaacters) /*Its CALCULATION String Function*/
--Calculate the length of each customers' first name.

SELECT first_name, LEN(first_name) AS len_name
FROM Customers


/*String Extraction Functions*/

--1)LEFT (Extracts specific number of characters from the start)
--Retrieve the 1st 2 characters of each first name
SELECT first_name, LEFT(TRIM(first_name),2) AS first_2_char
FROM Customers


--2)RIGHT (Extracts specific number of characters from the end)
--Retrieve the last 2 characters of each first name
SELECT first_name, RIGHT(TRIM(first_name),2) AS last_2_char
FROM Customers


--3)SUBSTRING (Extracts a part of string at a specified position)
--Retrieve a list of customers' first names after removing the first character.

SELECT first_name, SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS sub_name
FROM Customers


