
SET @@foreign_key_checks = 0;
USE SAMPLE40;


alter user SAMBLE@'localhost' identified by '';

# Database size and free space size
SELECT table_schema as 'DB Name',
sum( data_length + index_length ) / 1024 / 1024 as 'DB Size in MB',
sum( data_free )/ 1024 / 1024 as 'Free Space in MB'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'SAMPLE40'
GROUP BY table_schema;

# Table sizes
SELECT table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'SAMPLE40'
ORDER BY (data_length + index_length) DESC;


# insertions
load data infile '/var/lib/mysql-files/PUBLISHER.csv' into table publisher
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

load data infile '/var/lib/mysql-files/BOOK.csv' into table book
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

load data infile '/var/lib/mysql-files/BOOK_AUTHORS.csv' into table book_authors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

load data infile '/var/lib/mysql-files/LIBRARY_BRANCH.csv' into table library_branch
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS;

load data infile '/var/lib/mysql-files/BORROWER.csv' into table borrower
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS;


load data infile '/var/lib/mysql-files/BOOK_COPIES.csv' into table book_copies
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS;

load data infile '/var/lib/mysql-files/BOOK_LOANS.csv' into table book_loans
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 ROWS;

#  establish a local network between your database host machine, and another machine that will be a database client

# Database size and free space size
SELECT table_schema as 'DB Name',
sum( data_length + index_length ) / 1024 / 1024 as 'DB Size in MB',
sum( data_free )/ 1024 / 1024 as 'Free Space in MB'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'SAMPLE40'
GROUP BY table_schema;

# Table sizes
SELECT table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'SAMPLE40'
ORDER BY (data_length + index_length) DESC;


 SELECT Name,phone 
 From publisher
 WHERE Phone LIKE '%39';
 
optimize table book, book_authors, book_copies, book_loans, borrower, library_branch, publisher; 
 
SET @@foreign_key_checks = 1;