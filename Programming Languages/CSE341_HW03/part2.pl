%part2
%checks is there a direct route between two given cities
% knowledge base

flight(edirne,erzurum,5).
flight(erzurum,edirne,5).
flight(erzurum,antalya,2).
flight(antalya,erzurum,2).
flight(antalya,izmir,1).
flight(izmir,antalya,1).
flight(antalya,diyarbakir,5).
flight(diyarbakir,antalya,5).
flight(izmir,istanbul,3).
flight(istanbul,izmir,3).
flight(izmir,ankara,6).
flight(ankara,izmir,6).
flight(ankara,istanbul,2).
flight(istanbul,ankara,2).
flight(istanbul,trabzon,3).
flight(trabzon,istanbul,3).
flight(ankara,trabzon,6).
flight(trabzon,ankara,6).
flight(ankara,kars,3).
flight(kars,ankara,3).
flight(ankara,diyarbakir,8).
flight(diyarbakir,ankara,8).
flight(kars,gaziantep,3).
flight(gaziantep,kars,3).



% rules

%Bunu elle yazdim. En uzun directed route 8 durakliydi onu karsilayacagi yere kadar elle yazdim.
%dogru calisiyor.


route(X,Y,C) :- flight(X,Y,C), X\=Y;

		flight(X,D1,C1), flight(D1,Y,C2), X\=Y, C is C1+C2;

		flight(X,D1,C1), flight(D1,D2,C2), flight(D2,Y,C3),
			X\=Y,X\=D1,X\=D2,
			Y\=D1,Y\=D2,
			D1\=D2,
			C is C1+C2+C3;

		flight(X,D1,C1), flight(D1,D2,C2), flight(D2,D3,C3), flight(D3,Y,C4), 
			X\=Y,X\=D1,X\=D2,X\=D3,
			Y\=D1,Y\=D2,Y\=D3,
			D1\=D2,D1\=D3,
			D2\=D3,
			C is C1+C2+C3+C4;

		flight(X,D1,C1), flight(D1,D2,C2), flight(D2,D3,C3),flight(D3,D4,C4), flight(D4,Y,C5),
			X\=Y,X\=D1,X\=D2,X\=D3,X\=D4,
			Y\=D1,Y\=D2,Y\=D3,Y\=D4,
			D1\=D2,D1\=D3,D1\=D4,
			D2\=D3,D2\=D4,
			D3\=D4,
			C is C1+C2+C3+C4+C5;

		flight(X,D1,C1), flight(D1,D2,C2), flight(D2,D3,C3),flight(D3,D4,C4), flight(D4,D5,C5),flight(D5,Y,C6),
			X\=Y,X\=D1,X\=D2,X\=D3,X\=D4,X\=D5,
			Y\=D1,Y\=D2,Y\=D3,Y\=D4,Y\=D5,
			D1\=D2,D1\=D3,D1\=D4,D1\=D5,
			D2\=D3,D2\=D4,D2\=D5,
			D3\=D4,D3\=D5,
			D4\=D5,
			C is C1+C2+C3+C4+C5+C6;

			flight(X,D1,C1), flight(D1,D2,C2), flight(D2,D3,C3),flight(D3,D4,C4), flight(D4,D5,C5),flight(D5,D6,C6),flight(D6,Y,C7),
			X\=Y,X\=D1,X\=D2,X\=D3,X\=D4,X\=D5,X\=D6,
			Y\=D1,Y\=D2,Y\=D3,Y\=D4,Y\=D5,Y\=D6,
			D1\=D2,D1\=D3,D1\=D4,D1\=D5,D1\=D6,
			D2\=D3,D2\=D4,D2\=D5,D2\=D6,
			D3\=D4,D3\=D5,D3\=D6,
			D4\=D5,D4\=D6,
			D5\=D6,
			C is C1+C2+C3+C4+C5+C6+C7;


			flight(X,D1,C1), flight(D1,D2,C2), flight(D2,D3,C3),flight(D3,D4,C4), flight(D4,D5,C5),flight(D5,D6,C6),flight(D6,D7,C7),flight(D7,Y,C8),
			X\=Y,X\=D1,X\=D2,X\=D3,X\=D4,X\=D5,X\=D6,X\=D7,
			Y\=D1,Y\=D2,Y\=D3,Y\=D4,Y\=D5,Y\=D6,Y\=D7,
			D1\=D2,D1\=D3,D1\=D4,D1\=D5,D1\=D6,D1\=D7,
			D2\=D3,D2\=D4,D2\=D5,D2\=D6,D2\=D7,
			D3\=D4,D3\=D5,D3\=D6,D3\=D7,
			D4\=D5,D4\=D6,D4\=D7,
			D5\=D6,D5\=D7,
			D6\=D7,
			C is C1+C2+C3+C4+C5+C6+C7+C8.



