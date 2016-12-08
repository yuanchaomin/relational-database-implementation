--CREATE TABLE Aircraft_Model
CREATE TABLE Aircraft_Model(
  Model_Name VARCHAR(12),
  Maker VARCHAR(10),
  Model_Num VARCHAR(5),
  Sub_Model_Code VARCHAR(3),
  Max_Range INTEGER,
  Length REAL,
  Span REAL,
  Height REAL,
  Type VARCHAR(20),
  Emission_Cat VARCHAR(5),
  Noise_Class VARCHAR(1),
  CONSTRAINT Aircraft_Model_PK PRIMARY KEY (Model_Name),
  CONSTRAINT Aircraft_Model_Type_TypeCheck CHECK(Type = 'Jet' or Type = 'Prop' or Type = 'TuroProp'),
  CONSTRAINT Aircraft_Emission_TypeCheck CHECK(Emission_cat = 'Cat.1' or Emission_cat = 'Cat.2' or Emission_cat ='Cat.3' or Emission_cat = 'Cat.4' or Emission_cat = 'Cat.5'),
  CONSTRAINT Aircraft_Noise_class_TypeCheck CHECK(Noise_class = '0' or Noise_class = '1' or Noise_class = '2' or Noise_class = '3' or Noise_class = '4' or Noise_class = '5')
  );
--CREATE TABLE Airliner
CREATE TABLE Airliner(
  Model_Name VARCHAR(12),
  Max_Passenger INTEGER,
  CONSTRAINT Airliner_PK PRIMARY KEY (Model_Name),
  CONSTRAINT Airliner_FK FOREIGN KEY (Model_Name) REFERENCES Aircraft_Model(Model_Name)
);

--CREATE TABLE Cargo_Freighters
CREATE TABLE Cargo_Freighters(
  Model_Name VARCHAR(12),
  Max_Cargo_Weight INTEGER,
  CONSTRAINT Cargo_Freighters_PK PRIMARY KEY (Model_Name),
  CONSTRAINT Cargo_Freighters_FK FOREIGN KEY (Model_Name) REFERENCES Aircraft_Model(Model_Name)
);

--CREATE TABLE Power_Plant
CREATE TABLE Power_Plant(
  Engine_Num VARCHAR(5),
  Engine_Name VARCHAR(50),
  CONSTRAINT Power_Plant_PK PRIMARY KEY (Engine_Num)
);

--CREATE TABLE Suit
CREATE TABLE Suit(
  Model_Name VARCHAR(12),
  Engine_num VARCHAR(5),
  Fixed_Num INTEGER,
  CONSTRAINT Suit_PK PRIMARY KEY (Model_Name, Engine_Num),
  CONSTRAINT Suit_FK1 FOREIGN KEY (Model_Name) REFERENCES Aircraft_Model(Model_Name),
  CONSTRAINT Suit_FK2 FOREIGN KEY (Engine_Num) REFERENCES Power_Plant(Engine_Num)
  CONSTRAINT Suit_Fix_num_Typecheck CHECK(1 <= Fixed_Num <= 4)
);

--CREATE TABLE Airline
CREATE TABLE Airline(
  Airline_Name VARCHAR(30),
  Airline_Fax VARCHAR(10),
  Airline_Phone VARCHAR(10),
  Website VARCHAR(30),
  CONSTRAINT Airline_PK PRIMARY KEY (Airline_Name)
)

--CREATE TABLE Aircraft
CREATE TABLE Aircraft(
  IRN VARCHAR(15),
  Model_Name VARCHAR(50),
  Airline_Name VARCHAR(30),
  Engine_Num VARCHAR(5),
  CONSTRAINT Aircraft_PK PRIMARY KEY (IRN),
  CONSTRAINT Aircraft_FK1 FOREIGN KEY (Airline_Name) REFERENCES Airline(Airline_name),
  CONSTRAINT Aircraft_FK2 FOREIGN KEY (Model_Name) REFERENCES Aircraft_Model(Model_Name),
  CONSTRAINT Aircraft_FK3 FOREIGN KEY (Engine_Num) REFERENCES Power_plant(Engine_Num)
);

--CREATE TABLE Technician
CREATE TABLE Technician(
  Emp_Id VARCHAR(10),
  F_Name VARCHAR(20),
  G_Name VARCHAR(20),
  Phone_Numbers VARCHAR(10),
  Adddress VARCHAR(50),
  Salary INTEGER,
  CONSTRAINT Technician_PK PRIMARY KEY (Emp_Id)
);


--CREATE TABLE Test
CREATE TABLE Test(
  Emp_Id VARCHAR(10),
  CASA_Num VARCHAR(10),
  Test_Name VARCHAR(25),
  Max_Score INTEGER,
  CONSTRAINT Test_PK PRIMARY KEY  (Emp_Id, CASA_Num),
  CONSTRAINT Test_FK FOREIGN KEY (Emp_Id) REFERENCES Technician(Emp_Id)
);


--CREATE TABLE Expert
CREATE TABLE Expert(
  Emp_ID VARCHAR(10),
  Model_Name VARCHAR(12) NOT NULL,
  CONSTRAINT Expert_PK PRIMARY KEY (Emp_Id, Model_Name),
  CONSTRAINT Expert_FK1 FOREIGN KEY (Emp_Id) REFERENCES Technician(Emp_Id),
  CONSTRAINT Expert_FK2 FOREIGN KEY (Model_Name) REFERENCES Aircraft_Model(Model_Name)
);

--CREATE TABLE Examine
CREATE TABLE Examine(
  Emp_Id VARCHAR(10),
  CASA_Num VARCHAR(10),
  IRN VARCHAR(15),
  Exam_Date date,
  Score INTEGER NOT NULL,
  Hours INTEGER,
  CONSTRAINT Examine_PK PRIMARY KEY (Emp_Id,CASA_Num,IRN,Exam_Date),
  CONSTRAINT Examine_FK1 FOREIGN KEY (Emp_Id, CASA_Num) REFERENCES Test(Emp_Id,CASA_Num),
  CONSTRAINT Examine_FK2 FOREIGN KEY (IRN) REFERENCES Aircraft(IRN)
  );




create or replace TRIGGER Cat_noise
BEFORE INSERT OR UPDATE ON aircraft_model FOR EACH ROW

BEGIN
  IF :New.type ='Jet' AND :New.noise_class ='0'
    THEN
    :New.noise_class:= NULL;
  END IF;
  IF (:New.type = 'Prop' OR :New.type = 'TurboProp') AND :New.noise_class != '0'
    THEN
   :New.noise_class := '0';
  END IF;

END;


CREATE OR REPLACE TRIGGER Expert_Max_Known_Model
BEFORE INSERT ON Expert
 FOR EACH ROW
 DECLARE
  Count_known_model NUMBER;

BEGIN
  SELECT COUNT (*) INTO Count_known_model FROM Expert WHERE Emp_ID = :New.Emp_ID;
  IF (Count_known_model) >= 3 THEN
    :New.Emp_ID := NULL;
    :New.Model_name := NULL;
  END IF;
END;


CREATE OR REPLACE TRIGGER Max_score
BEFORE INSERT ON examine
 FOR EACH ROW
 DECLARE
  Maxs NUMBER;

BEGIN
  SELECT Max_score INTO Maxs FROM Test WHERE CASA_Num = :New.CASA_Num;
  IF (Maxs < :New.score) THEN
    :New.score := NULL;
  END IF;
END;
