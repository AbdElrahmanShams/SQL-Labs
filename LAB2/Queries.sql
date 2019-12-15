use library;

select * from book_copies;

/* a */
SELECT no_of_copies
FROM (BOOK JOIN BOOK_COPIES on book.bookID = book_copies.bookId) JOIN LIBRARY_BRANCH on book_copies.branchid = library_branch.branchid 
WHERE (BranchName = 'Sharpstown' AND Title = 'The Lost Tribe');

/* b */
SELECT BOOK.BookId,No_Of_Copies
FROM  book_copies natural join book
WHERE Title = 'The Lost Tribe';

/* c */
SELECT BORROWER.Name 
FROM BORROWER
WHERE (CardNo NOT IN (SELECT CardNo FROM book_loans));
        
/*d*/

select title ,borrower.name ,borrower.address
from book_loans join library_branch using (branchid)
	 join book using (bookid)
     join borrower using (cardno)
where duedate = current_date() and branchname = 'Sharpstown';

/*e*/

select count(bookid),branchname 
from book_loans join library_branch on book_loans.branchid = library_branch.branchid
group by  library_branch.branchId; 

/*f*/

select name,address,count(bookid)
from book_loans join borrower on book_loans.cardno = borrower.cardno
group by book_loans.cardno
having count(bookid) > 5; 

/*g*/

select title,no_of_copies

from book_copies join book using (bookid)
	 join library_branch using (branchid)
     join book_authors using (bookid)
     
where authorname = 'Stephen King' and branchname = 'Central';     