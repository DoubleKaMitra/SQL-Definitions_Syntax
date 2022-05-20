-- SQL Order of Execution --

	1. FROM		(From where the DATA is retrieved)
	2. ON		(Join feature, clause)
	3. JOINs	(Inner, Left, Right, Full)
	4. WHERE	(Alisas not valid within a where clause. Returns true values)
	5. GROUP BY	(Aggregate funcations)
	6. HAVING	(Filters DATA after grouping, i.e. WHERE CLAUSE)
	7. SELECT 
	8. DISTINCT
	9. ORDER BY	(Can use aliases, last to be executed in query)

-- SQL ACID --
/* 
	- Atomicity: The atomicity acid property in SQL. It means either all the operations (insert, update, delete) inside a transaction take place or none. Or you can say, all the statements (insert, update, delete) inside a transaction are either completed or rolled back.
	- Consistency: This SQL ACID property ensures database consistency. It means, whatever happens in the middle of the transaction, this acid property will never leave your database in a half-completed state. 
		* If the transaction completed successfully, then it will apply all the changes to the database.
		* If there is an error in a transaction, then all the changes that already made will be rolled back automatically. It means the database will restore to its state that it had before the transaction started.
		* If there is a system failure in the middle of the transaction, then also, all the changes made already will automatically rollback. 
	- Isolation: Every transaction is individual, and One transaction can’t access the result of other transactions until the transaction completed. Or, you can’t perform the same operation using multiple transactions at the same time. We will explain this SQL acid property in a separate article.
	- Durability: Once the transaction completed, then the changes it has made to the database will be permanent. Even if there is a system failure, or any abnormal changes also, this property will safeguard the committed data.
*/

-- Most Commonly Used SQL Statements

-- Create Database --
	CREATE DATABASE databasename
/*
	2 Files are generated when a database is created
		1. (.MDF) - Data file => Master Data
		2. (
*/

-- SQL JOINS --
/* A JOIN clause is used to combine rows from two or more tables, based on a related column between them.
   Types of Joins in SQL:
		(INNER) JOIN:		Returns records that have matching values in both tables
		LEFT (OUTER) JOIN:  Returns all records from the left table, and the matched records from the right table
		RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
		FULL (OUTER) JOIN:  Returns all records when there is a match in either left or right table 
		SELF JOIN:			A self join is a regular join, but the table is joined with itself.
*/
	-- Inner Join: Returns records that have matching values in both tables
		SELECT column_name(s)
		FROM table1
		INNER JOIN table2
		ON table1.column_name = table2.column_name;

	-- Left Join: Returns all records from the left table, and the matched records from the right table
		SELECT column_name(s)
		FROM table1
		LEFT JOIN table2
		ON table1.column_name = table2.column_name;

	-- Right Join: Returns all records from the right table, and the matched records from the left table
		SELECT column_name(s)
		FROM table1
		RIGHT JOIN table2
		ON table1.column_name = table2.column_name;

	-- Full Join: Returns all records when there is a match in either left or right table 
		SELECT column_name(s)
		FROM table1
		FULL OUTER JOIN table2
		ON table1.column_name = table2.column_name
		WHERE condition;

	-- Self Join: A self join is a regular join, but the table is joined with itself.
		SELECT column_name(s)
		FROM table1 T1, table1 T2
		WHERE condition;

-- Create View Statement --
	CREATE VIEW [OR ALTER] schema_name.view_name [(column_list)]
	AS
		SELECT STATEMENT

-- Create Stored Procedure --
/* A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again. 
	Setting up multiple parameters is very easy. 
	Just list each parameter and the data type separated by a comma as shown below.
*/

	CREATE PROCEDURE spProcedureName @Variable1 datatype, @Variable2 datatype -- Begin with sp Normal naming convention
	AS
	BEGIN
		SELECT STATEMENT
	END;

-- EXECUTE sp_name  -- Used to execute stored procedure
-- ALTER PROCEDURE  -- Used to alter the stored procedure
-- DROP PROCEDURE   -- Used to delete the stored procedure 


--TRIGGERS--
-- CREATE TRIGGER DATABASE LEVEL --
	CREATE TRIGGER DB_Trigger
	ON DATABASE
	AFTER CREATE_TABLE
	AS
	BEGIN
	PRINT 'Creation of New Tables NOT ALLOWED'
	ROLLBACK TRANSACTION 
	END 
	GO
--CREATE TRIGGER TABLE LEVEL --
	CREATE TRIGGER Supplier_Trigger
	ON [dbo].[Supplier]
	AFTER INSERT
	AS
	BEGIN
	PRINT 'Insert not allowed, need approval'
	ROLLBACK TRANSACTION
	END
	GO

-- User Defined Functions --
/* 
	- User-defined scalar functions – cover the user-defined scalar functions that allow you to encapsulate complex formula or business logic and reuse them in every query.
	- Table variables – learn how to use table variables as a return value of user-defined functions.
	- Table-valued functions – introduce you to inline table-valued function and multi-statement table-valued function to develop user-defined functions that return data of table types.
	- Removing user-defined functions – learn how to drop one or more existing user-defined functions from the database.

*/
-- CREATE USER DEFINED FUNCTION --
	CREATE FUNCTION [database_name.]function_name (parameters)
	RETURNS data_type AS
	BEGIN
		SQL statements
		RETURN value
	END;

-- ALTER USER DEFINED FUNCTION --
	ALTER FUNCTION [database_name.]function_name (parameters)
	RETURNS data_type AS
	BEGIN
		SQL statements
		RETURN value
	END;

-- DROP USER DEFINED FUNCTION --
	DROP FUNCTION [database_name.]function_name;

-- Indexes --
/* Indexes are special data structures associated with tables or views that help speed up the query. 
   SQL Server provides two types of indexes: clustered index and non-clustered index.

   -- Clustered Index --
	   A clustered index stores data rows in a sorted structure based on its key values.
	   Each table has only one clustered index because data rows can be only sorted in one order. 
	   A table that has a clustered index is called a clustered table.
	   A clustered index organizes data using a special structured so-called B-tree (or balanced tree) which enables searches, inserts, updates and deletes in logarithmic amortized time.
*/
	CREATE CLUSTERED INDEX index_name
	ON schema_name.table_name (column_list);  

/*
	-- Non Clustered Index --
	A nonclustered index is a data structure that improves the speed of data retrieval from tables. 
	Unlike a clustered index, a nonclustered index sorts and stores data separately from the data rows in the table.
	It is a copy of selected columns of data from a table with the links to the associated table.
*/
	CREATE [NONCLUSTERED] INDEX index_name
	ON table_name(column_list);


-- Rank Functions --

 --SYNTAX--
		 SELECT columnnames,
		 * ROW_NUMBER() OVER (ORDER BY column) AS alias,
		 * RANK() OVER (ORDER BY column) AS alias,
		 * DENSE_RANK() OVER (ORDER BY column) AS alias,
		 * NTILE(N) OVER (ORDER BY column) AS alias,
		 FROM tablename
 /* 
	ROW_NUMBER() - We use ROW_Number() SQL RANK function to get a unique sequential number for each row in the specified data. It gives the rank one for the first row and then increments the value by one for each row. 
	RANK() - We use RANK() SQL Rank function to specify rank for each row in the result set
	DENSE_RANK() - We use DENSE_RANK() function to specify a unique rank number within the partition as per the specified column value. It is similar to the Rank function with a small difference.
	               In the SQL RANK function DENSE_RANK(), if we have duplicate values, SQL assigns different ranks to those rows as well. Ideally, we should get the same rank for duplicate or similar values.
	NTILE() - We use the NTILE(N) function to distribute the number of rows in the specified (N) number of groups. Each row group gets its rank as per the specified condition. We need to specify the value for the desired number of groups.

 */
