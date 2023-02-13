/*
This file is initiality created in 21st APR 2022. Northeastern University CS5200 Database Management Systems Final Project
Authors: Xiangyu Zeng, Xinyu Wan, Lianrui Yang
Time: Apr 28th 2022

Description: The whole project contains tables(this file), procedires and python user interface.
			 In this file, a library database and its entities are created.
			 You can directly create the database by executing this file.
			 Data are automatically inserted.  

*/
drop database if exists Library;

create database if not exists Library;

use Library;

drop table if exists publisher;
drop table if exists Users;
drop table if exists Book;
drop table if exists Document;
drop table if exists Study_room;
drop table if exists Screen;
drop table if exists Study_Table;
drop table if exists Seat;
drop table if exists Borrow_record;
drop table if exists user_room_record;



create table if not exists publisher(
publisher_id varchar(30) primary key,
publisher_name varchar(30),
phone_No varchar(30)
);

insert into publisher(publisher_id,publisher_name,phone_No) values('1000001','Pearson','123-235-3456');
insert into publisher(publisher_id,publisher_name,phone_No) values('1000002','Macmillan','576-567-8578');
insert into publisher(publisher_id,publisher_name,phone_No) values('1000003','Oxford','830-826-0987');
insert into publisher(publisher_id,publisher_name,phone_No) values('1000004','HarperCollins','153-387-2054');
insert into publisher(publisher_id,publisher_name,phone_No) values('1000005','Cambridge','739-392-5820');

create table if not exists Users(
user_id varchar(30) primary key,
user_name varchar(30)
);
-- Library id and 3 users
insert into users(user_id,user_name) values('00000001','Library');
insert into users(user_id,user_name) values('20220101','Lianrui Yang');
insert into users(user_id,user_name) values('20220102','Xinyu Wan');
insert into users(user_id,user_name) values('20220103','Xiangyu Zeng');



create table if not exists Book(
book_id varchar(30) primary key,
book_name varchar(200),
ISBN varchar(30),
publisher_id varchar(30),
author varchar(100),
availability varchar(30),
foreign key (publisher_id) references publisher (publisher_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);

-- ALTER TABLE book ADD INDEX indext_ISBN(ISBN); -- Identifying fields for secondary indexes.


-- 10 books, one user can borrow up to 5 books 
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000001','Data and Computer Communications','9780137561704','1000001','William Stallings','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000002','Starting out with Python, 5th edition','9780136912330','1000001','Tony Gaddis','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000003','Computer Networks, 5th edition','9780137523214','1000001','Andrew S. Tanenbaum,  David J. Wetheral','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000004','The Atlas Six','9781250854513','1000002','Olivie Blake','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000005','The Sentimental Life of International Law','9780192849793','1000003','Gerry Simpson','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000006','The Fight for Climate after COVID-19','9780197549704','1000003','Alice C. Hill','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000007','The Giver','9780544336261','1000004','Lois Lowry','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000008','Beren and Luthien','9780008214197','1000004','TOLKIEN J. R. R.','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000009','The Complete History of Middle-earth','0008259844','1000004','Christopher Tolkien','Available');
insert into Book(book_id,book_name,ISBN,publisher_id,author,availability) 
values('10000010','Nursing: A Concept-Based Approach to Learning, Volume II 3rd Edition','0134616812','1000001','Pearson Education','Available');


create table if not exists Borrow_record(
id int primary key not null auto_increment, -- will increase anyway even if you delete the previous record
book_id varchar(30),
user_id varchar(30),
borrow_time_start date,
borrow_time_Estimated_end date,
borrow_time_real_end date, 
penalty bool,
foreign key (book_id) references Book(book_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
foreign key (user_id) references Users(user_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);



create table if not exists Document(
user_id varchar(30),
Document_id int primary key not null auto_increment,
Document_name varchar(30),
foreign key (user_id) references Users(user_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);



create table if not exists Study_room(
room_id varchar(30) primary key
);
insert into Study_room(room_id) values('1111111101');
insert into Study_room(room_id) values('1111111102');
insert into Study_room(room_id) values('1111111103');
insert into Study_room(room_id) values('1111111104');
insert into Study_room(room_id) values('1111111105');

create table if not exists user_room_record(
id int primary key not null auto_increment, -- will increase anyway even if you delete the previous record
user_id varchar(30),
room_id varchar(30),
start_time int, 
end_time int,
date_current date,
foreign key (user_id) references Users(user_id)
		ON UPDATE CASCADE ON DELETE CASCADE,
foreign key (room_id) references Study_room(room_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);




create table if not exists Screen(
Screen_id varchar(30) primary key,
room_id varchar(30),
manufacturer varchar(30),
serial_number varchar(30),
foreign key (room_id) references Study_room(room_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);
insert into Screen(Screen_id,room_id,manufacturer,serial_number)values('Screen-001','1111111101','Sony','SK019HNL9302');
insert into Screen(Screen_id,room_id,manufacturer,serial_number)values('Screen-002','1111111103','Sony','HB982NKBLS35');
insert into Screen(Screen_id,room_id,manufacturer,serial_number)values('Screen-003','1111111104','Sony','UIEB82738BI9');
insert into Screen(Screen_id,room_id,manufacturer,serial_number)values('Screen-004','1111111104','LG',  'KJHN778JHHJ0');



create table if not exists Study_Table(
table_id varchar(30) primary key,
room_id varchar(30),
current_condition varchar(30),
foreign key (room_id) references Study_room(room_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);
insert into Study_Table(table_id,room_id,current_condition)values('Table-001','1111111101','Perfect');
insert into Study_Table(table_id,room_id,current_condition)values('Table-002','1111111101','Perfect');
insert into Study_Table(table_id,room_id,current_condition)values('Table-003','1111111101','Perfect');
insert into Study_Table(table_id,room_id,current_condition)values('Table-004','1111111102','Perfect');
insert into Study_Table(table_id,room_id,current_condition)values('Table-005','1111111102','Perfect');
insert into Study_Table(table_id,room_id,current_condition)values('Table-006','1111111103','Perfect');
insert into Study_Table(table_id,room_id,current_condition)values('Table-007','1111111104','Perfect');
insert into Study_Table(table_id,room_id,current_condition)values('Table-008','1111111105','Good');







create table if not exists Seat(
seat_id varchar(30) primary key,
room_id varchar(30),
current_condition varchar(30),
foreign key (room_id) references Study_room(room_id)
		ON UPDATE CASCADE ON DELETE CASCADE
);
insert into Seat(seat_id,room_id,current_condition)values('Seat-0001','1111111101','Perfect');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0002','1111111101','Perfect');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0003','1111111101','Perfect');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0004','1111111101','Good');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0005','1111111102','Good');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0006','1111111102','Perfect');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0007','1111111102','Good');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0008','1111111103','Good');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0009','1111111103','Perfect');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0010','1111111104','Good');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0011','1111111104','Perfect');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0012','1111111104','Perfect');
insert into Seat(seat_id,room_id,current_condition)values('Seat-0013','1111111105','Good');









