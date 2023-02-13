import pymysql
import os
import time
import datetime
print('Connect to mysql server...')
username=input('username:')
password=input('password:')

try:
    conn = pymysql.connect(host='localhost', user=username, password=password,
                          db='library', charset='utf8mb4',
                          cursorclass=pymysql.cursors.DictCursor)

except pymysql.err.OperationalError as e:
    print('Error: %d: %s' % (e.args[0], e.args[1]))
    quit()


######################### Book ########################
def toBook():
    flag=1
    bookMenu()
    while flag!='0':
        flag=input('Choose to continue:')
        if flag=='1':
            getBook()
        elif flag=='2':
            deleteBook()
        elif flag=='3':
            bookID()
        elif flag=='4':
            bookISBN()
        elif flag=='5':
            bookName()

    print("Return to main page...")
    time.sleep(1)
    os.system('cls')

def bookMenu():
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║             **Book**             ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - Book List               ║")
    print("\t\t\t\t║      2 - Delete Book             ║")
    print("\t\t\t\t║      3 - Track ID                ║")
    print("\t\t\t\t║      4 - Track ISBN              ║")
    print("\t\t\t\t║      5 - Track Name              ║")
    print("\t\t\t\t║      0 - Return                  ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")

def getBook():
    try:
        cur = conn.cursor()
        select = "select * from book"
        cur.execute(select)
        print("{:10} {:70} {:30} {:}".format("book_id","book_name","author","availability"))
        for book in cur.fetchall():
            print("{:10} {:70} {:30} {:}".format(book["book_id"],book["book_name"],book["author"],book["availability"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

# def addBook():
#     try:
#         user_name=input('User name:')
#         while True:
#             user_id=input('User ID:')
#             if len(user_id)!=8:
#                 print("Invalied Id, retry!")
#             else: break
#         cur = conn.cursor()
#         query="insert into users values('"+user_id+"','"+user_name+"');"
#         cur.execute(query)
#         conn.commit()
#         cur.close()
#         input('Success, press to continue...')
#         os.system('cls')
#         userMenu()
#     except pymysql.Error as e:
#         print('Error: %d: %s' % (e.args[0], e.args[1]))

def deleteBook():
    try:
        book_id=input('Book ID:')
        cur = conn.cursor()
        cur.callproc("delete_book",(book_id,-1))
        conn.commit()
        cur.execute("select @_delete_book_1")
        flag=cur.fetchall()[0]['@_delete_book_1']
        if flag==3:
            print("Book removed")
        elif flag==2:
            print("Book not returned")
        elif flag==1:
            print("Book not exists")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        bookMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def bookID():
    try:
        while True:
            book_id=input('Book ID:')
            if len(book_id)!=8:
                print("Invalied Id, retry!")
            else: break
        cur = conn.cursor()
        cur.callproc("track_book_by_id",(book_id,))
        result=cur.fetchall()
        if len(result)!=0:
            print("{:10} {:50} {:30} {:}".format("book_id","book_name","author","availability"))
            for book in result:
                print("{:10} {:50} {:30} {:}".format(book["book_id"],book["book_name"],book["author"],book["availability"]))
        else:
            print("No result!")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        bookMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def bookISBN():
    try:
        book_isbn=input('Book ISBN:')
        cur = conn.cursor()
        cur.callproc("track_book_by_ISBN",(book_isbn,))
        result=cur.fetchall()
        if len(result)!=0:
            print("{:15} {:50} {:30} {:}".format("ISBN","book_name","author","availability"))
            for book in result:
                print("{:15} {:50} {:30} {:}".format(book["ISBN"],book["book_name"],book["author"],book["availability"]))
        else:
            print("No result!")
        cur.close()
        cur.close()
        input('Press to continue...')
        os.system('cls')
        bookMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def bookName():
    try:
        book_name=input('Search book by keyword:')
        cur = conn.cursor()
        cur.callproc("track_book_by_name",(book_name,))
        result=cur.fetchall()
        if len(result)!=0:
            print("{:10} {:50} {:42} {:}".format("book_id","book_name","author","availability"))
            for book in result:
                print("{:10} {:50} {:42} {:}".format(book["book_id"],book["book_name"],book["author"],book["availability"]))
        else:
            print("No result!")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        bookMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))



######################### User ########################
def toUser():
    flag=1
    userMenu()
    while flag!='0':
        flag=input('Choose to continue:')
        if flag=='1':
            getUser()
        elif flag=='2':
            addUser()
        elif flag=='3':
            deleteUser()
    print("Return to main page...")
    time.sleep(1)
    os.system('cls')

def userMenu():
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║             **User**             ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - User List               ║")
    print("\t\t\t\t║      2 - Add User                ║")
    print("\t\t\t\t║      3 - Delete User             ║")
    print("\t\t\t\t║      0 - Return                  ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")

def getUser():
    try:
        cur = conn.cursor()
        select = "select * from users"
        cur.execute(select)
        print("{:20} {:20} ".format("user_id","user_name"))
        for user in cur.fetchall():
            print("{:20} {:20} ".format(user["user_id"],user["user_name"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def addUser():
    try:
        user_name=input('User name:')
        while True:
            user_id=input('User ID:')
            if len(user_id)!=8:
                print("Invalied ID, retry!")
            else: break
        cur = conn.cursor()
        query="insert into users values('"+user_id+"','"+user_name+"');"
        cur.execute(query)
        conn.commit()
        cur.close()
        input('Success, press to continue...')
        os.system('cls')
        userMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def deleteUser():
    try:
        user_id=input('User ID:')
        cur = conn.cursor()
        cur.callproc("delete_user",(user_id,-1))
        conn.commit()
        cur.execute("select @_delete_user_1")
        flag=cur.fetchall()[0]['@_delete_user_1']
        if flag==3:
            print("User removed")
        elif flag==2:
            print("This user have not return book")
        elif flag==1:
            print("User not exists")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        userMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))



######################### Borrow Service ########################
def toBorrowReturn():
    flag=1
    borrowMenu()
    while flag!='0':
        flag=input('Choose to continue:')
        if flag=='1':
            getBook()
        elif flag=='2':
            getBorrowRecords()
        elif flag=='3':
            borrowBook()
        elif flag=='4':
            returnBook()
    print("Return to main page...")
    time.sleep(1)
    os.system('cls')

def borrowMenu():
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║       **Borrow and Return**      ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - Book List               ║")
    print("\t\t\t\t║      2 - Records                 ║")
    print("\t\t\t\t║      3 - Borrow Book             ║")
    print("\t\t\t\t║      4 - Return Book             ║")
    print("\t\t\t\t║      0 - Return                  ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")


def borrowBook():
    try:
        user_id=input('User ID:')
        book_id=input('Book ID:')
        start_time=input('Borrow date(yyyy-mm-dd):')
        estimated_end_time=input('Estimated return date(yyyy-mm-dd):')
        cur = conn.cursor()
        cur.callproc("Borrow_book",(user_id,book_id,start_time,estimated_end_time,-1))
        conn.commit()
        cur.execute("select @_Borrow_book_4")
        flag=cur.fetchall()[0]['@_Borrow_book_4']
        if flag==5:
            print("Success")
        elif flag==4:
            print("Book not available")
        elif flag==3:
            print("Beyond max book for this user")
        elif flag==2:
            print("Book not exists")
        elif flag==1:
            print("User not exists")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        borrowMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def returnBook():
    try:
        user_id=input('User ID:')
        book_id=input('Book ID:')
        real_end_time=input('Real return date(yyyy-mm-dd):')
        cur = conn.cursor()
        cur.callproc("Return_book",(user_id,book_id,real_end_time,-1,-1))
        conn.commit()
        cur.execute("select @_Return_book_3")
        flag_success=cur.fetchall()[0]['@_Return_book_3']
        cur.execute("select @_Return_book_4")
        flag_penality=cur.fetchall()[0]['@_Return_book_4']
        if flag_success==4:
            if flag_penality==0:
                print("Success, no penality")
            else:
                print("Success, have overdue penality")
        elif flag_success==3:
            print("Record of this book not exists")
        elif flag_success==2:
            print("Book not exists")
        elif flag_success==1:
            print("User not exists")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        borrowMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))


######################### Register Service ########################
def toRegister():
    flag=1
    registerMenu()
    while flag!='0':
        flag=input('Choose to continue:')
        if flag=='1':
            getRoom()
        elif flag=='2':
            getRoomRecords()
        elif flag=='3':
            registerRoom()
    print("Return to main page...")
    time.sleep(1)
    os.system('cls')

def registerMenu():
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║        **Room Register**         ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - Room List               ║")
    print("\t\t\t\t║      2 - Records                 ║")
    print("\t\t\t\t║      3 - Register Room           ║")
    print("\t\t\t\t║      0 - Return                  ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")

def registerRoom():
    try:
        cur = conn.cursor()
        user_id=input('User ID:')
        room_id=input('Room ID:')
        current=datetime.datetime.now()
        now=str(current).split()[0]
        while True:
            date=input('Borrow date(yyyy-mm-dd):')
            if now>date:
                print("Wrong date, retry!")
            else:   break
        select = "select start_time, end_time from user_room_record where date_current='"+ date +"';"
        cur.execute(select)
        result=cur.fetchall()
        ans,flag=[],0
        if len(result):
            for i in result:
                ans.append([i['start_time'],i['end_time']])
            print("Unavailable time slots:\n",ans)
        start=int(input("Choose start time(hour):"))
        end=int(input("Choose end time(hour):"))
        if start>=end:
            print("Wrong time slot, retry!")
            flag=1
        if len(result):
            t=[start,end]
            for i,j in ans:
                if not (i>=t[1] or j<=t[0]):
                    print("Time conflict, retry!")
                    flag=1
        if flag==0:
            cur.callproc("insert_room_record",(user_id,room_id,date,start,end,-1))
            conn.commit()
            cur.execute("select @_insert_room_record_5")
            flag1=cur.fetchall()[0]['@_insert_room_record_5']
            if flag1==2:
                print("Room not exists")
            elif flag==1:
                print("User not exists")
            else:
                print("Success!")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        registerMenu()

    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))




######################### Records ########################
def getBorrowRecords():
    try:
        cur = conn.cursor()
        select = "select * from borrow_record"
        cur.execute(select)
        print("{:<{}} {:<{}} {:<{}} {:<{}} {:<{}} {:<{}}".format("book_id",15,"user_id",15,"borrow_time",15,"estimated_end",15,"real_end",15,"penalty",15))
        for record in cur.fetchall():
            print('%-15s%-17s%-17s%-15s%-15s%s'%(record["book_id"],record["user_id"],record["borrow_time_start"], record["borrow_time_Estimated_end"],
            record["borrow_time_real_end"] if record["borrow_time_real_end"] else 'None',record["penalty"] ))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))


def getRoomRecords():
    try:
        cur = conn.cursor()
        select = "select * from user_room_record"
        cur.execute(select)
        print("{:<{}} {:<{}} {:<{}} {:<{}} {:<{}}".format("room_id",15,"user_id",15,"start_time",15,"end_time",15,"date",15))
        for record in cur.fetchall():
            print('%-15s%-18s%-15s%-15s%-15s'%(record["room_id"],record["user_id"],str(record["start_time"])+':00', str(record["end_time"])+':00', record["date_current"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))




######################### Publisher ########################
def toPublisher():
    flag=1
    publisherMenu()
    while flag!='0':
        flag=input('Choose to continue:')
        if flag=='1':
            getPublisher()
        elif flag=='2':
            addPublisher()
    print("Return to main page...")
    time.sleep(1)
    os.system('cls')

def publisherMenu():
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║           **Publisher**          ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - Publisher List          ║")
    print("\t\t\t\t║      2 - Add Publisher           ║")
    print("\t\t\t\t║      0 - Return                  ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")

def getPublisher():
    try:
        cur = conn.cursor()
        select = "select * from publisher"
        cur.execute(select)
        print("{:<{}} {:<{}} {:<{}} ".format("ID",17,"name",19,"phone",17))
        for record in cur.fetchall():
            print('%-18s%-20s%-15s'%(record["publisher_id"],record["publisher_name"],record["phone_No"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def addPublisher():
    try:
        publisher_id=input('Publisher ID:')
        publisher_name=input('Publisher Name:')
        phone=input('Phone Number:')
        cur = conn.cursor()
        cur.callproc("add_publisher",(publisher_id,publisher_name,phone,-1))
        conn.commit()
        cur.execute("select @_add_publisher_3")
        flag=cur.fetchall()[0]['@_add_publisher_3']
        if flag==1:
            print("Publisher already exists")
        else: print("Success!")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        publisherMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))



######################### Room ########################
def toRoom():
    flag=1
    roomMenu()
    while flag!='0':
        flag=input('Choose to continue:')
        if flag=='1':
            getRoom()
        elif flag=='2':
            getRoomDetail()
        elif flag=='3':
            getScreen()
        elif flag=='4':
            getTable()
        elif flag=='5':
            getSeat()
    print("Return to main page...")
    time.sleep(1)
    os.system('cls')

def roomMenu():
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║             **Room**             ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - Room List               ║")
    print("\t\t\t\t║      2 - Room Detail             ║")
    print("\t\t\t\t║      3 - Screen List             ║")
    print("\t\t\t\t║      4 - Table List              ║")
    print("\t\t\t\t║      5 - Seat List               ║")
    print("\t\t\t\t║      0 - Return                  ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")

def getRoom():
    try:
        cur = conn.cursor()
        select = "select * from study_room"
        cur.execute(select)
        print("{:20}".format("room_id"))
        for room in cur.fetchall():
            print("{:20}".format(room["room_id"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def getRoomDetail():
    try:
        room_id=input("Room ID:")
        cur = conn.cursor()
        cur.callproc("check_room",(room_id,-1))
        conn.commit()
        cur.execute("select @_check_room_1")
        flag=cur.fetchall()[0]['@_check_room_1']
        if flag==0:
            print("Room not found!")
            input('Press to continue...')
            os.system('cls')
            roomMenu()
        else:
            cur.callproc("track_seat_by_room",(room_id,))
            print("{:20}{:20}{:20}".format("seat_id","room_id","condition"))
            for set in cur.fetchall():
                print("{:20}{:20}{:20}".format(set["seat_id"],set["room_id"],set["current_condition"]))
            print('\n')
            cur.callproc("track_table_by_room",(room_id,))
            print("{:20}{:20}{:20}".format("table_id","room_id","condition"))
            for table in cur.fetchall():
                print("{:20}{:20}{:20}".format(table["table_id"],table["room_id"],table["current_condition"]))
            print('\n')
            cur.callproc("track_screen_by_room",(room_id,))
            print("{:20}{:20}{:20}{:20}".format("screen_id","room_id","manufacturer","serial_number"))
            for screen in cur.fetchall():
                print("{:20}{:20}{:20}{:20}".format(screen["Screen_id"],screen["room_id"],screen["manufacturer"],screen["serial_number"]))
            cur.close()

        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def getScreen():
    try:
        cur = conn.cursor()
        select = "select * from screen"
        cur.execute(select)
        print("{:20}{:20}{:20}{:20}".format("screen_id","room_id","manufacturer","serial_number"))
        for screen in cur.fetchall():
            print("{:20}{:20}{:20}{:20}".format(screen["Screen_id"],screen["room_id"],screen["manufacturer"],screen["serial_number"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def getTable():
    try:
        cur = conn.cursor()
        select = "select * from study_table"
        cur.execute(select)
        print("{:20}{:20}{:20}".format("table_id","room_id","condition"))
        for table in cur.fetchall():
            print("{:20}{:20}{:20}".format(table["table_id"],table["room_id"],table["current_condition"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def getSeat():
    try:
        cur = conn.cursor()
        select = "select * from seat"
        cur.execute(select)
        print("{:20}{:20}{:20}".format("seat_id","room_id","condition"))
        for set in cur.fetchall():
            print("{:20}{:20}{:20}".format(set["seat_id"],set["room_id"],set["current_condition"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))



######################### Document ########################
def toDoc():
    flag=1
    docMenu()
    while flag!='0':
        flag=input('Choose to continue:')
        if flag=='1':
            getDoc()
        elif flag=='2':
            addDoc()
        elif flag=='3':
            delDoc()
    print("Return to main page...")
    time.sleep(1)
    os.system('cls')

def docMenu():
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║          **Files**               ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - File List               ║")
    print("\t\t\t\t║      2 - Add File                ║")
    print("\t\t\t\t║      3 - Print                   ║")
    print("\t\t\t\t║      0 - Return                  ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")

def getDoc():
    try:
        cur = conn.cursor()
        select = "select * from document"
        cur.execute(select)
        print("{:20} {:20} {:20}".format("user id","file name","file id"))
        for record in cur.fetchall():
            print('%-21s%-21s%-20s'%(record["user_id"],record["Document_name"],record["Document_id"]))
        cur.close()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def addDoc():
    try:
        user_id=input('User ID:')
        doc_name=input('File Name:')
        cur = conn.cursor()
        cur.callproc("add_document",(user_id,doc_name,-1))
        conn.commit()
        cur.execute("select @_add_document_2")
        flag=cur.fetchall()[0]['@_add_document_2']
        if flag==1:
            print("User not exists")
        else: print("Success!")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        docMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))

def delDoc():
    try:
        doc_id=input('File ID:')
        cur = conn.cursor()
        cur.callproc("print_document",(doc_id,-1))
        conn.commit()
        cur.execute("select @_print_document_1")
        flag=cur.fetchall()[0]['@_print_document_1']
        if flag==1:
            print("File not exists")
        else: print("Success!")
        cur.close()
        input('Press to continue...')
        os.system('cls')
        docMenu()
    except pymysql.Error as e:
        print('Error: %d: %s' % (e.args[0], e.args[1]))



######################### Main ########################
flag=1
while flag!='0':
    os.system('cls')
    print("\t\t\t\t╔══════════════════════════════════╗")
    print("\t\t\t\t║  **Welcome To Library System**   ║")
    print("\t\t\t\t╠══════════════════════════════════╣")
    print("\t\t\t\t║      1 - Book                    ║")
    print("\t\t\t\t║      2 - User                    ║")
    print("\t\t\t\t║      3 - Borrow Service          ║")
    print("\t\t\t\t║      4 - Room Register           ║")
    print("\t\t\t\t║      5 - Room                    ║")
    print("\t\t\t\t║      6 - Publisher               ║")
    print("\t\t\t\t║      7 - Files                   ║")
    print("\t\t\t\t║      0 - Quit                    ║")
    print("\t\t\t\t╚══════════════════════════════════╝\n")
    flag=input('Choose to continue:')
    if flag=='1':
        os.system('cls')
        toBook()
    elif flag=='2':
        os.system('cls')
        toUser()
    elif flag=='3':
        os.system('cls')
        toBorrowReturn()
    elif flag=='4':
        os.system('cls')
        toRegister()
    elif flag=='5':
        os.system('cls')
        toRoom()
    elif flag=='6':
        os.system('cls')
        toPublisher()
    elif flag=='7':
        os.system('cls')
        toDoc()

conn.close()
