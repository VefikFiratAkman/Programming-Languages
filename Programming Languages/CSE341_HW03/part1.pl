%part1
%Kurs düzenleyici 
% knowledge base


%assert yapılabilmesi icin dynamic keyler

:- dynamic (room/4).
:- dynamic (occupancy/3).
:- dynamic (course/5.
:- dynamic (student/3).
:- dynamic (instructor/3).


%room variableları
room(z06,10,hcapped,projector).
room(z11,10,hcapped,smartboard).


%occupancy variableları
occupancy(z06,8,cse341).
occupancy(z06,13,cse331).
occupancy(z06,9,cse341).
occupancy(z06,10,cse341).
occupancy(z06,11,cse341).
occupancy(z06,14,cse331).
occupancy(z06,15,cse331).
occupancy(z11,8,cse343).
occupancy(z11,9,cse343).
occupancy(z11,10,cse343).
occupancy(z11,11,cse343).
occupancy(z11,14,cse321).
occupancy(z11,15,cse321).
occupancy(z11,16,cse321).

%data disinda conflicts fonksiyonunu test icin bu ikisini koydum.
occupancy(z12,11,cse111).
occupancy(z12,11,cse222).

%course variableları
course(cse341,genc,10,1,z06).
course(cse343,turker,6,1,z11).
course(cse331,bayrakci,5,1,z06).
course(cse321,gozupek,10,1,z11).

%student variableları
student(1,[cse341,cse343,cse331],no).
student(2,[cse341,cse343],no).
student(3,[cse341,cse331],no).
student(4,[cse341],no).
student(5,[cse341,cse331],no).
student(6,[cse341,cse343,cse331],yes).
student(7,[cse341,cse343],no).
student(8,[cse341,cse331],yes).
student(9,[cse341],no).
student(10,[cse341,cse321],no).
student(11,[cse341,cse321],no).
student(12,[cse343,cse321],no).
student(13,[cse343,cse321],no).
student(14,[cse343,cse321],no).
student(15,[cse343,cse321],yes).

%instructor variableları
instructor(genc,cse341,projector).
instructor(turker,cse343,smartboard).
instructor(bayrakci,cse331,_).
instructor(gozupek,cse321,smartboard).

%conflicts fonksiyonu
%verilen iki kursun ayni sinifta ayni saatte olup olmadigini kontrol ediyor
%dogru calisiyor
conflicts(CourseID1,CourseID2) :- occupancy(X,Y,CourseID1),occupancy(A,B,CourseID2), X = A, Y = B.



%IDsi verilen studentin IDsi verilen kursa kayit olup olamadiğini kontrol ediyor.
%dogru calisiyor
enroll(StudentID,CourseID) :- course(CourseID,_,CAP,_,ROOMID), student(StudentID,_,BOOLEAN), room(ROOMID,ROOMCAP,HCAP,_),
CAP < ROOMCAP, ((BOOLEAN = yes, HCAP = hcapped ) ; (BOOLEAN = no)).


%istenilen sinifa istenilen kursun konup konulamayacagini kontrol ediyor.
%Cok detayli check etmiyor.
assign(RoomID,CourseID) :-

instructor(_,CourseID,NEED),room(RoomID,_,EQUIPMENT1,EQUIPMENT2), ((NEED = EQUIPMENT1) ; (NEED = EQUIPMENT2)).


