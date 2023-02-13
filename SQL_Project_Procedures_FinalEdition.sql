/*
This file is initiality created in 22nd APR 2022. Northeastern University CS5200 Database Management Systems Final Project
Authors: Xiangyu Zeng, Xinyu Wan, Lianrui Yang
Time: Apr 28th 2022

Description: The whole project contains tables, procedires(this file) and python user interface.
			 In this file, procedures that provide functions are created. After each procedure,
             an example is given so that you could understand how to use the procedure. Some 
             procedures can return state. A state is a flag that help user finding errors.

*/

-- Examples
-- set @state = 0;
-- set @state_p = 6;
-- -- Add Tuples
-- select * from publisher;
-- call add_publisher('1000006', 'Test_Publisher', '123-432-4245', @state);
-- -- Delete Tuples
-- select * from users;
-- call delete_user('20220101', @state);
-- -- Update
-- select * from Borrow_record;
-- call Borrow_book('20220103','10000006','2022-04-23','2022-04-27',@state);
-- call Return_book('20220103','10000006','2022-04-26',@state,@state_p);
-- -- Check Tuples
-- call track_book_by_name('computer');



USE library;
delimiter $$;
SET SQL_SAFE_UPDATES = 0;

drop procedure if exists track_book_by_ISBN;
drop procedure if exists track_book_by_id;
drop procedure if exists track_book_by_name;
drop procedure if exists Borrow_book;
drop procedure if exists Return_book;
drop procedure if exists track_study_room_by_table;
drop procedure if exists track_study_room_by_screen;
drop procedure if exists track_study_room_by_seat;
drop procedure if exists delete_user;
drop procedure if exists delete_book;
drop procedure if exists insert_room_record;
drop procedure if exists add_publisher;
drop procedure if exists add_document;
drop procedure if exists print_document;
drop procedure if exists check_room;
drop procedure if exists track_seat_by_room;
drop procedure if exists track_table_by_room;
drop procedure if exists track_screen_by_room;
-- TOTALLY 18 PROCEDURES



-- Borrowing Book Part

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- I. Searching Book
-- tracking book by ISBN
create procedure track_book_by_ISBN(IN ISBN_input varchar(30))
BEGIN
select * from Book where ISBN = ISBN_input;
end
$$;
-- call track_book_by_ISBN('9780137561704');  


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- tracking Book by bookid
create procedure track_book_by_id(IN bookid_input int)
BEGIN
select * from Book where book_id = bookid_input;
end
$$;
-- call track_book_by_id('10000001'); 

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- tracking Book by Name
create procedure track_book_by_name(IN book_name_input varchar(200))
BEGIN
select * from Book where book_name like concat('%',book_name_input,'%');
end
$$;
-- call track_book_by_name('computer');


-- II. Borrow a Book
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Borrow a Book
create procedure Borrow_book(IN user_id_input varchar(30), IN book_id_input varchar(30), IN borrow_start_time_input date, IN borrow_estimated_end_time_input date, OUT state int)
BEGIN
-- 1. Check whether the user exists.
-- 2. Check whether the user borrows more than 5 books
-- 3. Check if the book exists and is available
-- 4. Generate record and fill in userID Bookid, start time, expected end time
-- 5. Alter availability under Bookid to 'Not Available'
DECLARE user_count int default 0; 
DECLARE book_count int default 0;
DECLARE user_book_count int default 0;
DECLARE book_ava varchar(30);

select count(*) into user_count from users where user_id = user_id_input; -- Verify if user exists
select count(*) into book_count from book where book_id = book_id_input; -- Verify if book exists
select count(*) into user_book_count from Borrow_record where user_id=user_id_input and borrow_time_real_end is NULL; -- Verify the number of book that user has borrowed

IF user_count>0 THEN
	IF book_count>0 THEN
		IF user_book_count<5 THEN
			select availability into book_ava from book where book_id = book_id_input; -- Verify availability of this book
			IF book_ava = 'Available' THEN
				insert into Borrow_record(user_id,book_id,borrow_time_start,borrow_time_Estimated_end)
				values(user_id_input,book_id_input,borrow_start_time_input,borrow_estimated_end_time_input);
                UPDATE Book SET availability = 'Not Available' where book_id = book_id_input;
                SET state = 5; -- Success
			ELSE
				SET state = 4; 
                END IF;-- Book not available
		ELSE
			SET state = 3;
            END IF;-- Beyond max book for this user
	ELSE
		SET state = 2;
        END IF;-- Book not exists
ELSE
     SET state=1;    -- User not exists
	 END IF;  

end
$$;
-- select * from users;
-- select * from book;
-- select * from Borrow_record;
-- set @state = 0;
-- call Borrow_book('20220102','10000001','2022-04-23','2022-04-27',@state);
-- call Borrow_book('20220101','10000002','2022-04-23','2022-04-27',@state);
-- call Borrow_book('20220101','10000003','2022-04-23','2022-04-27',@state);
-- call Borrow_book('20220101','10000004','2022-04-23','2022-04-27',@state);
-- call Borrow_book('20220101','10000005','2022-04-23','2022-04-27',@state);
-- call Borrow_book('20220101','10000006','2022-04-23','2022-04-27',@state);


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Return a Book
create procedure Return_book(IN user_id_input varchar(30), IN book_id_input varchar(30), IN borrow_time_real_end_input date, OUT state int, OUT state_penality int)
BEGIN
-- 1. Check whether the user exists
-- 2. Check userID and BooKID in all records that have no borrow_time_real_end in the borrow record
-- 3. Update the real end time into the record
-- 4. Determine whether there is a penalty and update into the record
-- 5. Change Bookid Availability to 'Avaibalbe'
DECLARE user_count int default 0; 
DECLARE book_count int default 0;
DECLARE user_record_count int default 0;
DECLARE estimated_date date;
select count(*) into user_count from users where user_id = user_id_input; -- Verify if user exists
select count(*) into book_count from book where book_id = book_id_input; -- Verify if book exists
select count(*) into user_record_count from Borrow_record where user_id = user_id_input and book_id = book_id_input and borrow_time_real_end is NULL; 
-- Verify if not closed record of this user and this book exists
select borrow_time_Estimated_end into estimated_date from Borrow_record where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end is NULL;
SET state_penality = 3; -- Initialize penality state, if state_penality =3, return not success

IF user_count>0 THEN
	IF book_count>0 THEN
		IF user_record_count>0 THEN 
            UPDATE Borrow_record SET borrow_time_real_end = borrow_time_real_end_input where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end is NULL;
			-- Update real end time to the record (existed, belong to the user, not returned, related to the book)
            UPDATE Book SET availability = 'Available' where book_id = book_id_input;
            -- Verify penality
            IF borrow_time_real_end_input>estimated_date THEN
				UPDATE Borrow_record SET penalty = TRUE where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end = borrow_time_real_end_input;
                SET state_penality = 1; -- Has penality
            ELSE
				UPDATE Borrow_record SET penalty = FALSE where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end = borrow_time_real_end_input;
				SET state_penality = 0; -- Does not have penality
                END IF;
            SET state = 4; -- Success
        ELSE 
			SET state = 3; -- Record of this book not exists
			END IF;
	ELSE
		SET state = 2; -- Book not exists
        END IF;
ELSE 
	SET state = 1; -- User not exists
	END IF;


end
$$;

-- set @state = 0;
-- set @state_p = 4;
-- call Return_book('20220101','10000001','2022-04-26',@state,@state_p);
-- call Return_book('20220101','10000002','2022-05-27',@state,@state_p);
-- call Return_book('20220101','10000003','2022-05-27',@state,@state_p);
-- call Return_book('20220101','10000004','2022-05-27',@state,@state_p);
-- call Return_book('20220101','10000005','2022-05-27',@state,@state_p);
-- select * from Borrow_record;
-- select * from book;



-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
--  Check Room
-- check room if exist
create procedure check_room(IN room_input varchar(30),OUT state int)
BEGIN
DECLARE room_count int default 0; 
select count(*) into room_count from study_room where room_id = room_input;
if room_count>0 then
	set state=1; -- have room
else
	set state=0; -- room not exist
end if;
end
$$;


-- call check_room('1111111101',@state); 

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- tracking seat by room
create procedure track_seat_by_room(IN room_input varchar(30))
BEGIN
select * from seat where room_id=room_input;
end
$$;
-- call track_seat_by_room('1111111101');  


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- tracking table by room
create procedure track_table_by_room(IN room_input varchar(30))
BEGIN
select * from study_table where room_id=room_input;
end
$$;
-- call track_table_by_room('1111111101');  


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- tracking screen by room
create procedure track_screen_by_room(IN room_input varchar(30))
BEGIN
select * from screen where room_id=room_input;
end
$$;
-- call track_screen_by_room('1111111101');  



-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Track study room
-- Input expected number of screen, return room id
create procedure track_study_room_by_screen(IN num_of_screen_input int)
BEGIN

select room_id from 
(select count(screen_id) as number_of_screen, room_id from 
(select Study_room.room_id, Screen_id, manufacturer, serial_number from Study_room 
left join screen
on screen.room_id = study_room.room_id) as aaa group by room_id) as bbb where number_of_screen = num_of_screen_input;
end
$$;
-- call track_study_room_by_screen(1);
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Track room by number of seats,  return room id
create procedure track_study_room_by_seat(IN num_of_seat_input int)
BEGIN

select room_id from 
(select count(seat_id) as number_of_seat, room_id from 
(select Study_room.room_id, seat_id from Study_room 
left join seat
on seat.room_id = study_room.room_id) as aaa group by room_id) as bbb where number_of_seat = num_of_seat_input;
end
$$;
-- call track_study_room_by_seat(1);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Track room by number of tables,  return room id
create procedure track_study_room_by_table(IN num_of_table_input int)
BEGIN

select room_id from 
(select count(table_id) as number_of_table, room_id from 
(select Study_room.room_id, table_id from Study_room 
left join Study_Table
on Study_Table.room_id = study_room.room_id) as aaa group by room_id) as bbb where number_of_table = num_of_table_input;
end
$$;

-- call track_study_room_by_table(1);

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Eliminate USER

create procedure delete_user(IN user_id_input varchar(30), OUT state int)
BEGIN
DECLARE user_count int;
DECLARE book_record_count int;
select count(*) into user_count from users where user_id = user_id_input;
select count(*) into book_record_count from Borrow_record where user_id = user_id_input and borrow_time_real_end is NULL; 
-- Verify if not closed record of this user exists
IF user_count>0 THEN
	IF book_record_count <= 0 THEN
		DELETE from Borrow_record where user_id = user_id_input; -- Remove borrowing book records of this user
		DELETE from Borrow_record where user_id = user_id_input; -- Remove study room use record of this user.
        DELETE from users where user_id = user_id_input; -- Remove this user from user table
   
		set state = 3; -- successfully remove this user
        
	ELSE
		set state = 2; -- Please return borrowed book(s) before delete this user
        END IF;
ELSE
	set state = 1; -- does not have this user
	END IF;

END
$$;


-- set @state = 0;
-- set @state_p = 5;
-- select * from users; -- display users
-- call Borrow_book('20220101','10000002','2022-01-22','2022-02-22',@state) -- borrow a book for Lianrui Yang
-- select * from Borrow_record; -- Display the record
-- call return_book('20220101','10000002','2022-02-19',@state,@state_p); -- return book for Lianrui Yang
-- call delete_user('20220101', @state); -- If have a not returned book, cannot delete this user. Else, delete this user and his record.




-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Eliminate book
create procedure delete_book(IN book_id_input varchar(30), OUT state int)
BEGIN
DECLARE book_count int;
DECLARE book_record_count int;
select count(*) into book_count from Book where book_id = book_id_input;
select count(*) into book_record_count from Borrow_record where book_id = book_id_input and borrow_time_real_end is NULL; 
-- Verify if not closed record of this book exists
IF book_count>0 THEN
	IF book_record_count <= 0 THEN
		DELETE from Borrow_record where book_id = book_id_input; -- Remove borrowing book records of this book
		DELETE from book where book_id = book_id_input; -- Remove this book from book table
       
		set state = 3; -- successfully remove this user
        
	ELSE
		set state = 2; -- Please return borrowed book(s) before delete this book
        END IF;
ELSE
	set state = 1; -- does not have this book
	END IF;

END
$$;

-- select * from book;
-- set @state = 0;
-- set @state_p = 6;
-- call Borrow_book('20220103','10000002','2022-01-22','2022-02-22',@state) -- borrow this book 
-- select * from Borrow_record; -- Display the record
-- call delete_book('10000002', @state); -- If have a not returned book, cannot delete this book. Else, delete this book and his record.
-- call return_book('20220103','10000002','2022-02-19',@state,@state_p); -- return this book




-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create room record
create procedure insert_room_record(IN user_id_input varchar(30), IN room_id_input varchar(30), IN date_current_input date, IN start_time_input int, IN end_time_input int, OUT state int)
BEGIN
DECLARE user_count int;
DECLARE room_count int;
select count(*) into user_count from users where user_id = user_id_input;
select count(*) into room_count from Study_room where room_id = room_id_input;

IF user_count>0 THEN
	IF room_count>0 THEN
		IF start_time_input< end_time_input THEN
			insert into user_room_record(user_id,room_id,start_time,end_time, date_current)
						values(user_id_input,room_id_input,start_time_input,end_time_input,date_current_input);
    
		ELSE
			SET state = 3; -- Invalid time input. Start time after end time;
            END IF;
	ELSE
		SET state = 2; -- Room detect error. Does not have this room
        END IF;
ELSE
	SET state =1; -- User detect error. Does not have this user.
	END IF;

END
$$;

-- SET @state = 0;
-- select * from users;
-- select * from study_room;
-- select * from user_room_record;
-- call insert_room_record('20220102','1111111103', '2022-02-22', '9', '10',@state);



-- ------------------------------------------------------------------------------------------------------------------------------------
create procedure add_publisher(IN publisher_id_input varchar(30), IN publisher_name_input varchar(30), IN phone_No_input varchar(30), OUT state int)
BEGIN
DECLARE publisher_count int;
select count(*) into publisher_count from publisher where publisher_id = publisher_id_input;

IF publisher_count = 0 THEN
 insert into publisher(publisher_id,publisher_name,phone_No) values(publisher_id_input, publisher_name_input, phone_No_input);


ELSE
 SET state = 1; -- Already has this publisher
 END IF;


END
$$;

-- SET @state = 0;
-- call add_publisher('111111111', 'AAAAAAAA', '123-432-4245', @state);
-- select * from publisher;



-- ------------------------------------------------------------------------------------------------------------------------------------
create procedure add_document(IN user_id_input varchar(30), IN Document_name_input varchar(30), OUT state int)
begin
declare user_count int;
select count(*) into user_count from users where user_id = user_id_input;
IF user_count = 1 THEN
 insert into Document(user_id,Document_name) values (user_id_input, Document_name_input);


ELSE
 SET state = 1; -- does not have this user
    END IF;

end
$$;

-- set @state = 0;
-- call add_document('20220103','abcd',@state);
-- select * from document;


-- ------------------------------------------------------------------------------------------------------------------------------------
create procedure print_document(IN document_id_input int, OUT state int)
begin
declare doc_count int;
select count(*) into doc_count from Document where Document_id = document_id_input;

IF doc_count >0 THEN
 DELETE from Document where Document_id = document_id_input;
    
ELSE
 SET state = 1; -- Does not have this document
    END IF;

end
$$;

-- set @state = 0;
-- call print_document(5,@state);
-- select * from document;

