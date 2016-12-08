# relational-database-implementation

The target of this small project is to have a better understand of relational database systerm. This project is based on Oracle 12c, and the client is Oracle SQL developer. 

In the first stage of this project, I and my teamate designed the ER-diagram and Relational diagram, wrote some basic sql statements to build tables and relations, plus sample data.

In the second stage of this project, we add more features such as stored procedure, trigger, complex query (including subquery), more operation(aggregated functions) as well as access control. 

The senario of this project is:
...

The supporting document of the first stage is following:
Supporting descriptions for our database design
We have chosen to model the airport database scenario as outlined in the proposed assignment. Detailed below are supporting descriptions for our ER diagram, RM diagram, and database DDL.

ER Diagram
Participation and key constraints
•	Every aircraft is owned by exactly one airline.
•	Every aircraft is equipped with exactly one type of power plant.
•	Every aircraft is described by exactly one aircraft model.  
Participation constraint
•	Every aircraft model is either an airliner of cargo freighter (ISA disjoint). 
•	Every test event must have at least one associated technician.
Cardinality constraint
•	Every technician is an expert in one to three aircraft models.
Weak entity
•	The test event is described by a weak entity, whereby CASA number (i.e., CASAnum) is the discriminator. 
Additional entity
•	Each “power plant” associated to an aircraft is given a unique engine number. The attribute “enginenum” is introduced as the primary key of “power plant”.

RM Schema
The respective descriptions for our three major entities, namely, “Aircraft”, “Aircraft model”, and “Technician”, are detailed as follows.
Aircraft entity
Starting from the “aircraft” entity, each aircraft is described by a unique international registration number (IRN). Hence “IRN” is declared the primary key of “aircraft”.
Each aircraft is owned by exactly one airline, whereby each airline has a unique “name”. Thus, “name” appears as a foreign key in the “aircraft” entity. 
Each aircraft is also exactly one type of aircraft model, whereby each aircraft model is described by a unique “Model_name”. Thus, “Model_name” appears as a foreign key in the “aircraft” entity. 
Each aircraft may also be equipped with exactly one type of suitable power plant. Thus we introduce “Engine_num” to uniquely identify each power plant, and “Engine_num” appears as a foreign key within the “aircraft” entity. 
Aircraft model entity
As detailed, each aircraft model has a unique “Model_name”. Furthermore, each aircraft model may be divided into either airliners or cargo freighters. Thus, lower-level entities of “airliner” and “Cargo_freighters” have been introduced, with “Model_name” as the foreign key in each of these lower-level entities. 
Technician entity
Each technician can be uniquely identified with an employee ID (Emp_ID). Thus, “Emp_ID” is introduced as the primary key for the “technician” entity. 
Each aircraft may be examined by a technician though a CASA specified test. In order to capture this information, a relation of “examine” and a weak entity of “Test” was created, that connected the “technician” and “aircraft” entities. Within the testing event, “CASA_num” and “Emp_num” are identified as foreign keys. These are derived from the relation “examine”, where “Emp_num”, “CASA_num” and “IRN” are declared its corresponding foreign keys. 
Furthermore, each technician may be an expert in one to three aircraft models. Thus, an “expert” relation was created, connecting the “technician” and “Aircraft_model” entities. Within the “expert” relation, the “Emp_ID” and “Model_name” were determined as foreign keys, as derived from the “technician” and “Aircraft_model” entities, respectively. 

Database DDL
In order to provide necessary constraints to the tables, three separate triggers have been introduced. 
Firstly, the trigger “Cat_noise” is utilized to ensure that noise categories of aircraft models classified under “Prop” and “TurboProp” remain declared as “Class 0”.
Secondly, the trigger “Expert_Max_Known_Model” is introduced to ensure that each technician can be an expert in one to three aircraft models. 
Lastly, the trigger “Max_score” is introduced to ensure that each CASA test does not exceed its associated maximum possible score. 


