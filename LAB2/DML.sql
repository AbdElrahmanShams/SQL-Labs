USE LIBRARY;

insert into publisher values ('jane doe','cairo street first floor',88-888-888);
insert into publisher values ('john smith','florida second floor','25-559-112');
insert into publisher values('john doe','maiami street third floor','77-777-777');
insert into publisher values('Stephen King','alexandria fourth floor','12-223-548');

insert into library_branch values(5,'Sharpstown');
insert into library_branch values(3,'Central');

INSERT INTO BOOK VALUES (1,'The secret','john smith');
insert INTO BOOK VALUES(2,'The Lost Tribe','john doe');
insert into book values(3,'The blue elephant','Stephen King');

insert into book_authors values (1,'leonel messi');
insert into book_authors values (2,'cr7');
insert into book_authors values (3,'Stephen King');

insert into book_copies values (1,5,17);
insert into book_copies values (2,3,19);
delete from book_copies where bookid = 2 and branchid = 3;
delete from book_copies where bookid = 1 and branchid = 5;
insert into book_copies values (1,3,17);
insert into book_copies values (2,5,19);
insert into book_copies values (3,3,10);

insert into borrower values(95,'ahmed','64 street','12345526');
insert into borrower values(75,'mohamed','6 street','12346156');
insert into borrower values(65,'ali','wall street','9999666');

insert into book_loans values (95,1,3,'2019-03-05','2019-03-09');
insert into book_loans values (75,2,5,'2019-03-15','2019-03-19');




