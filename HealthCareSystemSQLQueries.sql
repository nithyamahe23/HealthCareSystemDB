CREATE DATABASE HealthcareSystemDB1;
USE HealthcareSystemDB1;

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(150) NOT NULL UNIQUE,
    City VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(150) NOT NULL,
    PhoneNumber VARCHAR(20),
    Email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    Status ENUM('Scheduled', 'Completed', 'Canceled') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    MedicineName VARCHAR(150) NOT NULL,
    Dosage VARCHAR(50) NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Diagnosis TEXT,
    Treatment TEXT,
    RecordDate DATETIME NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(150) NOT NULL UNIQUE,
    HeadDoctorID INT,
    FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    AppointmentID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    PaidAmount DECIMAL(10, 2) NOT NULL,
    BalanceAmount DECIMAL(10, 2) NOT NULL,
    PaymentStatus ENUM('Paid', 'Unpaid', 'Partial') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert Expanded Sample Data
INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, City, Country) VALUES
('John', 'Doe', '1980-01-15', 'Male', '123-456-7890', 'john.doe@example.com', 'New York', 'USA'),
('Jane', 'Smith', '1985-05-20', 'Female', '123-555-7890', 'jane.smith@example.com', 'Los Angeles', 'USA'),
('Alice', 'Johnson', '1990-03-25', 'Female', '555-123-7890', 'alice.j@example.com', 'Chicago', 'USA'),
('Tim', 'Smith', '2017-12-10', 'Male', '555-456-7893', 'tim.t@example.com', 'Denver', 'USA'),
('Bob', 'Brown', '1975-11-30', 'Male', '555-987-6543', 'bob.b@example.com', 'Miami', 'USA'),
('Eve', 'Davis', '1988-07-15', 'Female', '555-654-3210', 'eve.d@example.com', 'Houston', 'USA'),
('Charlie', 'Miller', '1992-09-05', 'Male', '555-321-6548', 'charlie.m@example.com', 'Seattle', 'USA'),
('David', 'Wilson', '1982-04-20', 'Male', '555-789-4561', 'david.w@example.com', 'San Francisco', 'USA'),
('Fiona', 'Taylor', '1987-12-10', 'Female', '555-456-7893', 'fiona.t@example.com', 'Denver', 'USA'),
('Grace', 'Martinez', '1995-02-17', 'Female', '555-123-9876', 'grace.m@example.com', 'Austin', 'USA'),
('Ben', 'Lee', '1945-02-17', 'Male', '555-123-9876', 'ben.l@example.com', 'Dallas', 'USA');

INSERT INTO Doctors (FirstName, LastName, Specialization, PhoneNumber, Email) VALUES
('Gregory', 'House', 'Diagnostic Medicine', '555-678-1234', 'house.g@example.com'),
('Meredith', 'Grey', 'General Surgery', '555-987-6543', 'grey.m@example.com'),
('John', 'Watson', 'Internal Medicine', '555-321-7654', 'watson.j@example.com'),
('Amelia', 'Shepherd', 'Neurosurgery', '555-987-3214', 'shepherd.a@example.com'),
('Derek', 'Shepherd', 'Cardiology', '555-654-9874', 'shepherd.d@example.com'),
('Miranda', 'Bailey', 'Pediatrics', '555-123-6548', 'bailey.m@example.com');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason, Status) VALUES
(1, 1, '2023-07-01 10:00:00', 'Routine Checkup', 'Completed'),
(2, 2, '2023-07-02 14:00:00', 'Surgery Consultation', 'Scheduled'),
(3, 3, '2023-07-03 16:00:00', 'Follow-up Visit', 'Completed'),
(4, 4, '2023-07-04 09:00:00', 'Neurosurgery Consultation', 'Scheduled'),
(5, 5, '2023-07-05 11:00:00', 'Cardiology Consultation', 'Completed'),
(6, 6, '2023-07-06 08:00:00', 'Pediatric Checkup', 'Completed'),
(7, 1, '2023-07-07 10:00:00', 'Routine Checkup', 'Scheduled'),
(8, 2, '2023-07-08 12:00:00', 'Surgery Follow-up', 'Completed'),
(9, 3, '2023-07-09 15:00:00', 'Internal Medicine Consultation', 'Canceled');

INSERT INTO Prescriptions (AppointmentID, MedicineName, Dosage, Duration) VALUES
(1, 'Ibuprofen', '200mg', '7 days'),
(3, 'Paracetamol', '500mg', '5 days'),
(5, 'Aspirin', '100mg', '10 days'),
(6, 'Amoxicillin', '250mg', '7 days'),
(8, 'Ciprofloxacin', '500mg', '5 days'),
(9, 'Metformin', '500mg', '30 days');

INSERT INTO MedicalRecords (PatientID, DoctorID, Diagnosis, Treatment, RecordDate) VALUES
(1, 1, 'Hypertension', 'Lifestyle modification', '2023-07-01 10:30:00'),
(3, 3, 'Common Cold', 'Rest and hydration', '2023-07-03 16:30:00'),
(5, 5, 'Heart Disease', 'Medication and lifestyle changes', '2023-07-05 11:30:00'),
(6, 6, 'Asthma', 'Inhaler and medication', '2023-07-06 08:30:00'),
(7, 1, 'Diabetes', 'Insulin and diet management', '2023-07-07 10:30:00'),
(9, 3, 'Thyroid Disorder', 'Medication', '2023-07-09 15:30:00');

INSERT INTO Departments (DepartmentName, HeadDoctorID) VALUES
('Cardiology', 5),
('Surgery', 2),
('Internal Medicine', 3),
('Neurosurgery', 4),
('Pediatrics', 6),
('Diagnostic Medicine', 1);

INSERT INTO Billing (PatientID, AppointmentID, TotalAmount, PaidAmount, BalanceAmount, PaymentStatus) VALUES
(1, 1, 200.00, 200.00, 0.00, 'Paid'),
(2, 2, 1500.00, 500.00, 1000.00, 'Partial'),
(3, 3, 100.00, 100.00, 0.00, 'Paid'),
(4, 4, 3000.00, 0.00, 3000.00, 'Unpaid'),
(5, 5, 500.00, 500.00, 0.00, 'Paid'),
(6, 6, 250.00, 250.00, 0.00, 'Paid'),
(7, 7, 200.00, 100.00, 100.00, 'Partial'),
(8, 8, 1500.00, 1500.00, 0.00, 'Paid'),
(9, 9, 100.00, 0.00, 100.00, 'Unpaid');

/* Ticket 2 *
/* Task 1: Count the total number of patients in the database */
select * from patients;
select count(*) from patients;

/* Task 2 : Count the number of appointments that have been completed. */
select * from appointments;
select count(*) from appointments where status = 'completed';

/* Task 3 : Count the number of medical records with a diagnosis of "Asthma" */
select * from medicalrecords;
select count(*) from medicalrecords where diagnosis = 'Asthma';

/* Ticket 3 */
/* Task 1 : Calculate the total amount billed for all appointment */
select sum(totalamount) from billing;

/*Task 2 : Find the total amount paid by all patients for their bills. */
select sum(paidamount) from billing;

/*Task 3 : Calculate the total balance amount remaining for unpaid bills */
select sum(balanceAmount) from billing where paymentstatus = 'Unpaid';

/* Ticket 4 */
/*Task 1 : Calculate the average amount billed per appointmen*/
select avg(totalamount) from billing;

#Find the average age of patients based on their DateOfBirth
select avg(datediff(current_Date, dateOfBirth)) as AverageAge
from patients;
SELECT AVG(timestampdiff(YEAR, DateOfBirth, CURDATE())) AS AverageAge FROM Patients;

# Task 3 : Calculate the average amount of paid bills
select avg(paidAmount) from billing;

#Task 4 : Determine the average dosage prescribed per prescription
select avg(dosage) from prescriptions;

/*Ticket 5 */
# Task 1 : Find the earliest and latest AppointmentDate
select min(appointmentDate) as Earliest, max(appointmentDate) as Latest
from appointments; 

#Task 2 : Identify the lowest and highest billed amounts in the Billing table
select min(totalAmount) as Lowest, max(totalAmount) as Highest
from billing;

#Task 3 : Find the minimum and maximum dosage prescribed in the Prescriptions table
select min(dosage) as MinumumDosage, max(dosage) as MaximumDosage
from prescriptions;

#Task 4 :  Determine the youngest and oldest patients in the database
select min(timestampdiff(year, dateOfBirth, current_date)) as youngest, 
max(timestampdiff(year, dateOfBirth, current_date)) as oldest
from patients;

select 
	min(year(current_date) - year(dateOfBirth)) as youngest,
    max(year(current_date) - year(dateOfBirth)) as eldest
from patients;
select min(dateOfBirth) as Elder, max(dateOfBirth) as Young from patients;

select timestampdiff(year, dateOfBirth, current_date) as youngest, patientId from patients group by patientId;

/* Ticket 6 */
/* Task 1 : Create a query that labels bills as 'High' if the TotalAmount is greater than $1000, 
'Medium' if between $500 and $1000, and 'Low' if below $500.*/

 SELECT productName, buyPrice, 
CASE
 WHEN buyPrice > 9 AND buyPrice <=  50 THEN "LOW PRICE"
 WHEN buyPrice >= 50 AND buyPrice <= 100 THEN "Medium Price"
 WHEN buyPrice > 100 AND buyPrice <= 200 THEN "high Price"
 ELSE "Out of our rang" END AS priceStatus 
FROM products ORDER BY buyPrice DESC;

select billId,totalamount,
case
	when totalAmount > 1000 then "HIGH"
    when totalAmount >=500 and totalAmount<1000 then "Medium"
    when totalAmount < 500 then "Low"
    else "Out of Range" end as billstatus
from billing;

/* Task 2 : Write a query to show patients labeled as 'Minor' if their age is less than 18, 
'Adult' if between 18 and 65, and 'Senior' if older than 65.*/
SELECT patientId,((year(current_date()))-(year(dateOfBirth))) as age,
CASE
	WHEN ((year(current_date()))-(year(dateOfBirth))) < 18 then "MINOR"
    WHEN ((year(current_date()))-(year(dateOfBirth)))>=18 AND ((year(current_date()))-(year(dateOfBirth)))<=65 THEN "ADULT"
    WHEN ((year(current_date()))-(year(dateOfBirth)))>65 THEN "SENIOR"
    ELSE "Invalid Age" END AS agegroup
FROM PATIENTS;

/* Ticket 7 - IN operator*/
#Task 1 : Find all appointments where the Status is either 'Completed' or 'Scheduled'
select * from appointments where status in ('Completed','Scheduled');

#Task2 : Retrieve all doctors who specialize in 'Internal Medicine', 'Cardiology', or 'Pediatrics'
select * from doctors where specialization in ('Internal Medicine', 'Cardiology', 'Pediatrics');

#Task3 : Find all MedicalRecords with diagnoses of 'Diabetes', 'Hypertension', or 'Asthma'
select * from medicalrecords where diagnosis in ('Diabetes', 'Hypertension', 'Asthma');

#Task4 : List all departments with names 'Surgery', 'Cardiology', or 'Pediatrics'.
select * from departments where departmentName in ('Surgery', 'Cardiology','Pediatrics');
