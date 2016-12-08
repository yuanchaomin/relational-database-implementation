
--INDEX
--first part
SELECT Technician.Emp_ID
FROM Technician
WHERE Salary  BETWEEN 20000 AND 50000;


--second part 
EXPLAIN PLAN FOR
SELECT Technician.Emp_ID
FROM Technician
WHERE SAlary  BETWEEN 20000 AND 50000;
SELECT * FROM TABLE(dbms_xplan.display);

--index  part
CREATE　Index Technician_Sal_In 
ON Techician(Emp_ID, Salary)

--Explain: In first part, there is a sql sentence that we want to optimize. Since data in the Techinican table may increase much frequently, we need to improve the search efficiency.
--Now we decide to use a B+ tree index on this table, expecially, On the attribute : salary. Because salary has a high cardinality, so a defual B+ tree index on this 
--attribute and Emp_ID attribute seem appropriate. The second part will give us the actual running process of this sql sentence. 1.pdf illustrated the process before we apply this index, where
--oracle will run a Full table Scan, with 3 unit of cost. However, After creating an index, oracle actually do a index range scan guided by the index TECHNICIAN_SALA_IN, which 
--mean that the index does work!



--TRIGGER
--CREATE TRIGGER FOR CATEGORIES AND NOISE CONSTRAINT
--It is a row level trigger, and will be fired before inserting or updating data on aircraft_model table. 
--we use this trigger to implement the constraint,  more specifically, there is a rule when 'Jet' corresponds to 1-5 and 'Prop' and 'TurboProp' corresponds to 0.

CREATE OR REPLACE TRIGGER Cat_noise
BEFORE INSERT OR UPDATE ON aircraft_model FOR EACH ROW

BEGIN
  IF :New.type ='Jet' AND :New.noise_class ='0'  -- if the value of an insert or update row under attribute "type" is 'Jet', 
                                                  --and the value of an insert or update row under attribute "noise_class" is '0',
												  -- Then let the value under "noise_class" become NULL.
												  --The reason why we do this is that, the "noise_class" is a not null attribute. By doing this, once if the  invalid											  
												  --condition  is satisfied, the invalid value will not be allowed  to insert into that table. (because it turns into a null value)
    THEN
    :New.noise_class:= NULL;
  END IF;
  IF :New.type = 'Prop' AND :New.noise_class != '0'  -- This if sentence is similar to the former one, but in there, when the if-code ( invalid condition) is ran, this code 
													-- will correct the wrong number to a valid value then finish insertion.
    THEN
   :New.noise_class := '0';
  END IF;
  IF :New.type = 'TurboProp' AND :New.noise_class != '0' -- This is the same as the second if sentence.
    THEN
   :New.noise_class := '0';
  END IF;

END;




--VIEW
	CREATE VIEW Test_info AS
				SELECT Test.Emp_num, CASA_Test.CASA_num, CASA_Test.CASA_TEST_NAME, Count(aircraft.IRN) AS Count_airplane
				FROM Test 
				JOIN examine ON Test.Emp_num = examine.Emp_num
				JOIN CASA_Test ON CASA_Test.CASA_num = examine.CASA_num
				JOIN aircraft ON examine.IRN = aircraft.IRN
				WHERE aircraft.Model_name IN (
											SELECT aircraft.Model_name
											FROM   aircraft
											WHERE  aircraft.engine_num = '2001'
                      )
				GROUP BY CASA_Test.CASA_num, CASA_Test.CASA_TEST_NAME, Test.Emp_num
				WITH READ ONLY;
				
	
--Here we create a view, which will show the  test information about airmodel that equips '2001' engine. This query presents the name of techinican
--who performs those tests, the type of those tests and which aircraft was examined. This view hides the information such as the score and hour of each test. So 
--a techinican will not get the informaion about other techinicans.

--STORED　PROCEDURE
CREATE OR REPLACE PROCEDURE action_technician 
   (
	action  VARCHAR,
	
	Emp_Id VARCHAR,
	F_Name VARCHAR,
	G_Name VARCHAR,
 	Phone_Numbers VARCHAR,
	Adddress VARCHAR,
	Salary INTEGER,
	Expert_model1 VARCHAR,
	Expert_model2 VARCHAR,
	Expert_model3 VARCHAR,
	result_Emp_Id OUT VARCHAR,
	result_F_name OUT VARCHAR,
	result_G_name OUT VARCHAR,
	result_Phone_number OUT VARCHAR,
	result_Adddress OUT VARCHAR,
	result_Salary OUT VARCHAR,
	result_Expert_model1 OUT VARCHAR,
	result_Expert_model2 OUT VARCHAR,
	result_Expert_model3 OUT VARCHAR
	) AS 
	
  
	BEGIN 
		IF action = 'SELECT' 
			THEN
			
			BEGIN
			SELECT Emp_Id,F_name, G_Name, Phone_Numbers, Adddress, Salary, Expert_model1, Expert_model2, Expert_model3 
			INTO result_Emp_Id,result_F_name,result_G_name, result_Phone_number, result_Adddress, result_Salary, result_Expert_model1,
				 result_Expert_model2, result_Expert_model3
			
			FROM technician 
			WHERE action_technician.Emp_Id = technician.Emp_Id;
			END;
			DBMS_OUTPUT.PUT_LINE('Employee ID:'||result_Emp_Id);
			DBMS_OUTPUT.PUT_LINE('First name:'||result_F_name);
			DBMS_OUTPUT.PUT_LINE('Last name:'||result_G_name);
			DBMS_OUTPUT.PUT_LINE('Phone Numbers:'||result_Phone_number);
			DBMS_OUTPUT.PUT_LINE('Address:'||result_Adddress);
			DBMS_OUTPUT.PUT_LINE('Salary:'||result_Salary);
			DBMS_OUTPUT.PUT_LINE('Can fix :'||result_Expert_model1);
			DBMS_OUTPUT.PUT_LINE('Can fix :'||result_Expert_model2);
			DBMS_OUTPUT.PUT_LINE('Can fix :'||result_Expert_model3);
		
		END IF;
		
		IF action = 'UPDATE'
			THEN
			
			BEGIN
			UPDATE Technician
			SET
				Technician.Emp_Id = action_technician.Emp_Id,
				Technician.F_Name = action_technician.F_Name,
				Technician.G_Name = action_technician.G_Name, 
				Technician.Phone_Numbers = action_technician.Phone_Numbers,
				Technician. Adddress = action_technician.Adddress,
				Technician.Salary = action_technician.Salary,
				Technician.Expert_model1 = action_technician.Expert_model1,
				Technician.Expert_model2 = action_technician.Expert_model2,
				Technician.Expert_model3 = action_technician.Expert_model3			
			WHERE action_technician.Emp_Id = Technician. Emp_Id;
			COMMIT;
			DBMS_OUTPUT.PUT_LINE('Update is Successful');
			END;
        END IF;
		
		IF action = 'INSERT'
			THEN
			
			BEGIN
			INSERT INTO Technician
			VALUES 
			(
			action_technician.Emp_Id,
			action_technician.F_Name, 
			action_technician.G_Name,
			action_technician.Phone_Numbers,
			action_technician.Adddress,
			action_technician.Salary,
			action_technician.Expert_model1,
			action_technician.Expert_model2,
			action_technician.Expert_model3
				
			);
			END;
			COMMIT;
			DBMS_OUTPUT.PUT_LINE('Insertion is Successful');
		END IF;
			
	END;
	
	

--Query report
SELECT technician.Emp_id,CASA_Test.CASA_num, Count(CASA_Test.CASA_num), Sum(Test.Test_hour)
FROM yyan7582.CASA_Test 
JOIN yyan7582.Examine ON CASA_Test.CASA_num = Examine.CASA_num AND CASA_Test.Max_score = examine.Max_score
JOIN yyan7582.Test ON Examine.Emp_num = Test.Emp_num AND  Examine.Exam_Date = Test.Test_Date AND Examine.Examine_Score = Test.Test_score
JOIN yyan7582.technician ON Test.Emp_num = technician.Emp_ID
JOIN YYAN7582.AIRCRAFT ON aircraft.IRN=examine.IRN
WHERE technician.Emp_Id IN
						(
						SELECT technician.Emp_Id
						FROM yyan7582.technician
						WHERE technician.Expert_model1 = 'B747ER' OR technician.Expert_model2 = 'B747ER' OR technician.Expert_model3 = 'B747ER'
						)
          AND aircraft.model_name='B747ER'
GROUP BY  technician.Emp_id,CASA_Test.CASA_num;
--
--This is the query report. In general, it joins 4 tables, combines aggregate functions such as count and sum funtion, as well. A group by clause and a subquery are also
--in that query. What's more, this sentence can consist other clause like order by, limit and so on, its select clause can get more information too.
--The main idea in this query is that: select all techinican who is an expert of airplane 'B747ER', get the information about their ID, the amount of tests they 
--operated, the total hours they spend on those test on B747ER.


--GRANT PRIVILEGES
GRANT SELECT ON yyan7582.Examine TO COMP5138_PUBLIC;
GRANT SELECT ON yyan7582.Test TO COMP5138_PUBLIC;
GRANT SELECT ON yyan7582.technician TO COMP5138_PUBLIC;
GRANT SELECT ON YYAN7582.AIRCRAFT TO COMP5138_PUBLIC;
GRANT SELECT ON yyan7582.Test_info TO COMP5138_PUBLIC;
GRANT EXECUTE ON yyan7582.action_technician TO COMP5138_PUBLIC;
GRANT UPDATE ON yyan7582.Technician TO COMP5138_PUBLIC;
GRANT INSERT ON yyan7582.Technician TO COMP5138_PUBLIC;