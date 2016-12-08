--INSERT VALUES INTO Aircraft_Model
INSERT INTO Aircraft_Model
VALUES
('B747ER','Boeing','747','ER',12408,70.7,64.4,19.4,'Jet',	'Cat.1','3'
);
INSERT INTO Aircraft_Model
VALUES
('B777','Boeing',	'777','',13427,73.86,60.93,18.51,'Jet',	'Cat.1','3'
);
INSERT INTO Aircraft_Model
VALUES
('A330','Airbus',	'330','',10185,63.69,60.3,16.83,'Jet',	'Cat.1','3'
);
INSERT INTO Aircraft_Model
VALUES
('A380','Airbus','380','',14800,72.75,63,24.08,'Jet','Cat.3','5'
);
INSERT INTO Aircraft_Model
VALUES
('B787','Airbus','787','',15200,56.7,60,16.9,'Jet','Cat.2','4'
);
INSERT INTO Aircraft_Model
VALUES
('AN38','Boeing','38','',3050,15.67,22.06,5.05,'Prop',	'Cat.1','0'
);

--INSERT VALUES INTO Airliner
INSERT INTO Airliner
VALUES
('B747ER', 416);
INSERT INTO Airliner
VALUES
('B777', 386);
INSERT INTO Airliner
VALUES
('A330', 335);
INSERT INTO Airliner
VALUES
('A380', 555);
INSERT INTO Airliner
VALUES
('B787', 285);


--INSERT VALUES INTO Cargo_Freighters
INSERT INTO Cargo_Freighters
VALUES
('AN38',1300
);

--INSERT VALUES INTO Power_Plant
INSERT INTO Power_plant
VALUES
('1002', 'General Electric CF650E2s');
INSERT INTO Power_plant
VALUES
('1003', 'General Electric GE90-75Bs');
INSERT INTO Power_plant
VALUES
('2001', 'RollsRoyce Trent 768');
INSERT INTO Power_plant
VALUES
('2002',	'Rolls-Royce Trent 900');
INSERT INTO Power_plant
VALUES
('1004',	'General Electric GEnx');
INSERT INTO Power_plant
VALUES
('3001',	'Pratt and Whitney JT9D7R4G2 turbofans');
INSERT INTO Power_plant
VALUES
('2003',	'RollsRoyce RB211524D4s');
INSERT INTO Power_plant
VALUES
('4001',	'Pratt and Whitney PW4074 turbofans');
INSERT INTO Power_plant
VALUES
('5001',	'Honeywell TPE331-14GR-801E');


--INSERT VALUES INTO Suit
INSERT INTO Suit
VALUES
('B747ER',	'1002', 2);
INSERT INTO Suit
VALUES
('B747ER',	'2001', 2);
INSERT INTO Suit
VALUES
('B747ER',	'1004',  2);
INSERT INTO Suit
VALUES
('A330',	'2001', 2);
INSERT INTO Suit
VALUES
('A330',	'4001',2);
INSERT INTO Suit
VALUES
('A380',	'2002',4);
INSERT INTO Suit
VALUES
('A380',	'2001',4);
INSERT INTO Suit
VALUES
('B777',	'1003',4);
INSERT INTO Suit
VALUES
('B787',	'1004',4);
INSERT INTO Suit
VALUES
('AN38',	'5001',2);


--INSERT VALUES INTO Airline_Fax
INSERT INTO Airline
VALUES
('All Nippon Airways',	'70751523',	'303312233',	'http://www.ana.co.jp/');
INSERT INTO Airline
VALUES
('Singapore Airline',	'70751524',	'302212234',	'http://www.singaporeair.com/');
INSERT INTO Airline
VALUES
('United Airline',	'70751525',	'301112235',	'https://www.united.com/');
INSERT INTO Airline
VALUES
('China Southern Airline',	'70751526',	'300012236',	'http://www.csair.com/');
INSERT INTO Airline
VALUES
('Quantas Airline',	'70751527',	'298912237',	'http://www.qantas.com/');


--INSERT VALUES INTO Aircraft
INSERT INTO Aircraft
VALUES
('NHB747535','B747ER','All Nippon Airways', '1002');
INSERT INTO Aircraft
VALUES
('SQB777536','B777','Singapore Airline', '1003');
INSERT INTO Aircraft
VALUES
('UAAn38550','AN38','United Airline','5001');
INSERT INTO Aircraft
VALUES
('UAA330537','A330','United Airline',,'2001');
INSERT INTO Aircraft
VALUES
('CZA380538','A380','China Southern Airline','2002');
INSERT INTO Aircraft
VALUES
('QFB787539','B787','Quantas Airline','1004');


--INSERT VALUES INTO Technician
INSERT INTO Technician
VALUES
('DEN9002',	'Denny',	'Andrew',	'51237891',	'5778 Briarwood Court Macon GA 31204',	152001
);
INSERT INTO Technician
VALUES
('JAC9003',	'Jackson',	'Montana',	'51237892',	'1395 Mulberry Court Coventry RI 02816',	152002
);
INSERT INTO Technician
VALUES
('MAD9004',	'Maddox',	'Cordell',	'51237893',	'796 Cherry Lane Tampa FL 33604',152003
);
INSERT INTO Technician
VALUES
('DEN9005',	'Denny',	'Zackary',	'51237894',	'7672 Surrey Lane Waterbury CT 06705',	152004
);
INSERT INTO Technician
VALUES
('GAR9006','Garret',	'Sal',	'51237895',	'348 Lake Avenue Menomonee Falls WI 53051',	152005
);


--INSERT VALUES INTO Test
INSERT INTO Test
VALUES
('DEN9002',	'20701',	'winds_examine',	201);
INSERT INTO Test
VALUES
('JAC9003',	'20702',	'winds_examine', 201);
INSERT INTO Test
VALUES
('MAD9004',	'20703',	'engine_examine',	301);
INSERT INTO Test
VALUES
('DEN9005',	'20704',	'engine_examine',	301);
INSERT INTO Test
VALUES
('GAR9006',	'20705',	'landing_gear_examine',	101);

--INSERT VALUES INTO Expert
INSERT INTO Expert
VALUES
('JAC9003',	'A330');
INSERT INTO Expert
VALUES
('JAC9003',	'A380');
INSERT INTO Expert
VALUES
('MAD9004',	'B777');
INSERT INTO Expert
VALUES
('DEN9005',	'A330');
INSERT INTO Expert
VALUES
('GAR9006',	'A380');
INSERT INTO Expert
VALUES
('DEN9002',	'B747ER');
INSERT INTO Expert
VALUES
('DEN9002',	'B777');
INSERT INTO Expert
VALUES
('DEN9002',	'B787');


--INSERT VALUES INTO Examine
INSERT INTO Examine
VALUES
('DEN9002',	'20701', 'NHB747535',	'27/MAR/2016',	200,	2);
INSERT INTO Examine
VALUES
('JAC9003',	'20702'	,'SQB777536',	'28/MAR/2016',	200,	2);
INSERT INTO Examine
VALUES
('MAD9004',	'20703'	,'UAAn38550',	'29/MAR/2016',	300,	3);
INSERT INTO Examine
VALUES
('DEN9005',	'20704'	,'CZA380538',	'30/MAR/2016',	300,	3);
INSERT INTO Examine
VALUES
('GAR9006',	'20705'	,'QFB787539',	'31/MAR/2016',	101,	1);



