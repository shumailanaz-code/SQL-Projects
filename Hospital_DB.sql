-- Task 2: Part 1: Q1

-- Create Hospital Database

CREATE DATABASE HospitalDB;

-- Run the Database

USE HospitalDB;
GO

-- Create Addresses Table

CREATE TABLE Addresses(
			AddressID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			Address NVARCHAR(50) NOT NULL,
			PostCode NVARCHAR(10) NOT NULL,
			City NVARCHAR(50) NOT NULL,
			CONSTRAINT UC_Address UNIQUE (Address, PostCode)
			);

-- Create Patients Table

CREATE TABLE Patients(
			PatientID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			AddressID INT NOT NULL FOREIGN KEY (AddressID)
			REFERENCES Addresses(AddressID),
			PatientFullName NVARCHAR(50) NOT NULL,
			DateOfBirth DATE NOT NULL,
			Insurance NVARCHAR(50) NOT NULL,
			UserName NVARCHAR(50) NOT NULL,
			Password NVARCHAR(50) NOT NULL,
			EmailAddress NVARCHAR(50) UNIQUE NULL CHECK
			(EmailAddress LIKE '%_@_%._%'),
			TelephoneNumber NVARCHAR(20) NULL,
			DateLeft DATE NULL
			);

-- Create Departments Table

CREATE TABLE Departments(
			DepartmentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			DepartmentName NVARCHAR(50) NOT NULL,
			DepartmentEmail NVARCHAR(50) UNIQUE NULL CHECK
			(DepartmentEmail  LIKE '%_@_%._%'),
			DepartmentTelephone NVARCHAR(20) NOT NULL
			);

-- Create Doctors Table

CREATE TABLE Doctors(
			DoctorID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			DepartmentID INT NOT NULL FOREIGN KEY (DepartmentID)
			REFERENCES Departments(DepartmentID),
			DoctorFullName NVARCHAR(50) NOT NULL,
			Availability NVARCHAR(20) NOT NULL
			);

-- Create DoctorsSpecialities Table

CREATE TABLE DoctorsSpecialities(
			DoctorID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
			Speciality NVARCHAR(50) NOT NULL
			);

-- Create Appointments Table

CREATE TABLE Appointments(
			AppointmentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			PatientID INT NOT NULL,
			DoctorID INT NOT NULL,
			DepartmentID INT NOT NULL FOREIGN KEY (DepartmentID)
			REFERENCES Departments(DepartmentID),
			AppointmentDate DATE NOT NULL,
			AppointmentTime TIME NOT NULL,
			Status NVARCHAR(20) NOT NULL,
			Review NVARCHAR(300) NULL
			);

-- Create MedicalRecords Table

CREATE TABLE MedicalRecords(
			RecordID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
			PatientID INT NOT NULL,
			DoctorID INT NOT NULL,
			PrescriptionDate DATE NOT NULL,
			Diagnosis NVARCHAR(300) NULL,
			Medicines NVARCHAR(300) NULL,
			Allergies NVARCHAR(100) NULL
			);

-- Add Foreign Key Constraint in MedicalRecords Table

ALTER TABLE MedicalRecords ADD CONSTRAINT fk_PatientID1
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID);

ALTER TABLE MedicalRecords ADD CONSTRAINT fk_DoctorID1
FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID);

-- Add Foreign Key Constraint in Appointments Table

ALTER TABLE Appointments ADD CONSTRAINT fk_PatientID2
FOREIGN KEY (PatientID) REFERENCES Patients(PatientID);

ALTER TABLE Appointments ADD CONSTRAINT fk_DoctorID2
FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID);


--- Data Insertion into Tables:


-- Insert data into Addresses Table

INSERT INTO Addresses(Address, PostCode, City)
VALUES
			('18 King Street', 'M1 1AG', 'Manchester'),
			('7 Baker Street', 'E1 7HT', 'London'),
			('65 Abbey Street', 'B1 1BD', 'Birmingham'),
			('24 Mosley Street', 'M1 1AS', 'Manchester'),
			('16 Barron Road', 'B1 1BY', 'Birmingham'),
			('30 Belgrave Road', 'LE1 1AP', 'Leicester'),
			('45 Salord Quays', 'M17 1EQ', 'Salford');

-- Insert data into Patients Table

INSERT INTO Patients(AddressID, PatientFullName, DateOfBirth , Insurance, 
									UserName, Password, EmailAddress , TelephoneNumber, DateLeft)
VALUES
			(1, 'John Smith', '1985-04-15', 'Aviva', 'john24', 'A6543c2', 'j.smith@gmail.com', '0207 231 4681', NULL),
			(2, 'Aizal Noah', '2001-07-21', 'BUPA', 'aizal54', 'C8932e5', 'a.noah@gmail.com', '0121 123 5832', NULL), 
			(3, 'Ethan David', '1995-05-19', 'Saga', 'ethan74', 'F3259b1', 'e.david@gmail.com', '0161 312 7469', NULL), 
			(4, 'Paul Alex', '1979-03-24', 'AXA Health', 'paul14', 'D58934c', 'p.alex@gmail.com', '0161 321 6974', NULL), 
			(5, 'Alper Deniz', '1982-09-05', 'WPA', 'alper64', 'G29571a', 'a.deniz@gmail.com', '0116 132 9143', NULL), 
			(6, 'Mehmet Asa', '1999-11-26', 'Saga', 'mehmet44', 'G3189b7', 'm.asa@gmail.com', '0161 241 5238', NULL), 
			(7, 'Asher Cahit', '1973-08-02', 'Vitality Health', 'asher34', 'H6942e6', 'a.cahit@gmail.com', '0121 124 6982', NULL); 

-- Insert data into Departments Table

INSERT INTO Departments(DepartmentName, DepartmentEmail, DepartmentTelephone)
VALUES
			('Cardiology', 'cardiology@rafahospital.com', '0161 312 5327'),
			('Gastroenterology', 'gastroenterology@rafahospital.com', '0161 123 6628'),
			('Neurology', 'neurology@rafahospital.com', '0161 124 6947'),
			('Orthopedics', 'orthopedics@rafahospital.com', '0161 125 4638'),
			('Pediatrics', 'pediatrics@rafahospital.com', '0161 313 7912'),
			('Oncology', 'oncology@rafahospital.com', '0161 316 7369'),
			('Dermatology', 'dermatology@rafahospital.com', '0161 314 4738');

-- Insert data into Doctors Table

INSERT INTO Doctors(DepartmentID, DoctorFullName, Availability)
VALUES
			(6, 'Hassam Gilani', 'Full-time'),
			(3, 'Mathew Femmy', 'Full-time'),
			(2, 'Adam Sinha', 'Full-time'),
			(1, 'Kinza Subhani', 'Full-time'),
			(5, 'Raghdan Ali', 'Full-time'),
			(7, 'Shibra Hashmi', 'Part-time'),
			(4, 'Esa John', 'Full-time'),
			(3, 'Seema Aftab', 'Full-time');

-- Insert data into DoctorsSpecialities Table

INSERT INTO DoctorsSpecialities(Speciality)
VALUES
			('Oncologists'),
			('Autonomic Neurologist'),
			('Gastroenterologists'),
			('Cardiologists'),
			('Pediatricians'),
			('Dermatologists'),
			('Orthopedist'),
			('Sleep Neurologist');

-- Insert data into Appointments Table

INSERT INTO Appointments(PatientID, DoctorID, DepartmentID, AppointmentDate, 
											AppointmentTime, Status, Review)
VALUES
			(6, 2, 3, '2024-01-15', '13:10:00', 'Completed', 'Professional, self-assured, attentive to my questions.'), 
			(7, 1, 6, '2024-01-21', '11:20:00', 'Completed', 'Among the greatest doctors is him. He is thorough and friendly.'),
			(1, 6, 7, '2024-01-29', '15:30:00', 'Completed', 'I find her to be approachable, professional, and responsive to my concerns.'),
			(2, 3, 2, '2024-02-21', '12:10:00', 'Completed', 'He was very professional, extremely knowledgable, and amiable.'),
			(5, 4, 1, '2024-02-28', '16:30:00', 'Completed', 'She is incredibly knowledgeable, kind, and professional.'),
			(4, 1, 6, '2024-03-17', '13:00:00', 'Completed', 'Very knowledgeable, kind, and attentive when speaking with patients.'),
			(6, 3, 2, '2024-03-24', '10:10:00', 'Completed', 'He explains the available options and pays attention to my worries'),
			(3, 7, 4, '2024-03-29', '12:10:00', 'Completed', 'He is very knowledgeable and professional.'),
			(5, 6, 7, '2024-04-01', '11:30:00', 'Cancelled', NULL), 
			(1, 6, 7, GETDATE(), '12:40:00', 'Pending', NULL), 
			(7, 5, 5, GETDATE(), '14:10:00', 'Pending',  NULL); 

-- Insert data into MedicalRecords Table

INSERT INTO MedicalRecords(PatientID, DoctorID, PrescriptionDate,
													Diagnosis, Medicines, Allergies)
VALUES
			(6, 2, '2024-01-15', 'Epilepsy', 'Clobazam, Pregabalin', 'Peanuts'),
			(7, 1, '2024-01-21', 'Cancer', 'Cladribine, Floxuridine', 'Milk'),
			(1, 6, '2024-01-29', 'Alopecia Areata', 'Barcitinib', 'Eggs'),
			(2, 3, '2024-02-21', 'Gastritis', 'Antacids, Alginates', 'Peanuts'),
			(5, 4, '2024-02-28', 'Angina', 'Sublingual Nitroglycerin' , NULL),
			(4, 1, '2024-03-17', 'Cancer', 'Cladribine, Floxuridine', 'Eggs'),
			(6, 3, '2024-03-24', 'Abdominal Adhesions', 'Celecoxib, Rofecoxib', NULL),
			(3, 7, '2024-03-29', 'Rheumatoid Arthritis', 'Methotrexate, Analgesics', NULL),
			(1, 6, GETDATE(), NULL, NULL, NULL);

-- View all Tables with updated Records

SELECT * FROM Addresses
SELECT * FROM Patients
SELECT * FROM Departments
SELECT * FROM Doctors
SELECT * FROM DoctorsSpecialities
SELECT * FROM Appointments
SELECT * FROM MedicalRecords

-- Task 2: Part 2

-- Q2: Add the constraint to check that the Appointment Date is not in the past

ALTER TABLE Appointments
ADD CONSTRAINT AppointmentDate_NotInPast
CHECK (
    (Status = 'Pending' AND AppointmentDate >= CAST(GETDATE() AS DATE)) OR
    (Status = 'Cancelled' AND AppointmentDate <= CAST(GETDATE() AS DATE)) OR
    (Status = 'Completed' AND AppointmentDate <= CAST(GETDATE() AS DATE))
);

-- Q3: List of all patients who are older than 40 and have Cancer in Diagnosis

SELECT p.* , mr.Diagnosis
FROM Patients p
INNER JOIN MedicalRecords mr
ON p.PatientID = mr.PatientID
WHERE DATEDIFF(YEAR, p.DateOfBirth, GETDATE()) > 40
AND mr.Diagnosis LIKE '%Cancer%';
GO

-- Q4(a): Create User-Defined Function to find Medicine Name 
-- and sorted the result with most recent medicine PrescribtionDate first.

CREATE FUNCTION SearchMedicines
(
	@MedicineName AS NVARCHAR(300)
)
RETURNS TABLE 
AS
RETURN
(
    SELECT PrescriptionDate, Medicines
    FROM MedicalRecords
    WHERE Medicines LIKE '%' + @MedicineName + '%'
);
GO

-- Execute User-Defined Function

SELECT * FROM SearchMedicines('Cladribine')
ORDER BY PrescriptionDate DESC
GO

-- Q4(b): Create User-Defined Function to retreive Full list of Diagnosis and Allergies
-- for a specific patient who has an appointment today

CREATE FUNCTION GetDiagnosisAndAllergies
(
    @PatientID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT mr.Diagnosis, mr.Allergies
    FROM MedicalRecords mr
    INNER JOIN Appointments a
	ON mr.PatientID= a.PatientID
    WHERE mr.PatientID = @PatientID
        AND CONVERT(DATE, a.AppointmentDate) = CONVERT(DATE, GETDATE())
);
GO

-- Execute User-Defined Function

SELECT * FROM dbo.GetDiagnosisAndAllergies(7);
GO

-- Q4(c): Create Stored Procedure to update the details for an existing doctor

CREATE PROCEDURE UpdateDoctorDetails
	@DoctorID INT,
	@DepartmentID INT,
	@DoctorFullName NVARCHAR(50),
	@Availability NVARCHAR(20)
AS
BEGIN
    UPDATE Doctors
    SET
			DepartmentID = @DepartmentID,
			DoctorFullName = @DoctorFullName,
			Availability = @Availability	
    WHERE DoctorID = @DoctorID;
END;
GO

-- Execute Stored Procedure

EXEC UpdateDoctorDetails
    @DoctorID = 3,
	@DepartmentID = 2,
    @DoctorFullName  = 'Adam Sinha',
    @Availability = 'Part-time';
GO

-- View updated Record

SELECT * FROM Doctors
WHERE DoctorID = 3
GO

-- Q4(d): Create Stored Procedure to delete the Appointments whose Status is already Completed

-- First: Create Archived Table to Move Deleted Records

CREATE TABLE ArchivedAppointments(
			AppointmentID INT NOT NULL PRIMARY KEY,
			PatientID INT NOT NULL,
			DoctorID INT NOT NULL,
			DepartmentID INT NOT NULL,
			AppointmentDate DATE NOT NULL,
			AppointmentTime TIME NOT NULL,
			Status NVARCHAR(20) NOT NULL,
			Review NVARCHAR(300) NULL
			);
GO

-- Second: Create Stored Procedure to Delete and Move Records

CREATE PROCEDURE DeleteCompletedAppointmentsAndArchive
AS
BEGIN

	-- Move Completed Appointments to Archived Table
    INSERT INTO ArchivedAppointments (AppointmentID, PatientID, DoctorID, DepartmentID, 
																AppointmentDate, AppointmentTime, Status, Review)
    SELECT AppointmentID, PatientID, DoctorID, DepartmentID, AppointmentDate,
					AppointmentTime, Status, Review
    FROM Appointments
    WHERE Status = 'Completed';

	-- Delete Completed Appointments from Appointments Table
    DELETE FROM Appointments
    WHERE Status = 'Completed';
END;
GO

-- Execute Stored Procedure

EXEC DeleteCompletedAppointmentsAndArchive;
GO

-- View the Results

SELECT * FROM ArchivedAppointments
SELECT * FROM Appointments
GO

-- Q5: Create a View to see all appointments for all doctors including 
-- appointment date, time, department, doctor’s specialty and review
 
CREATE VIEW AppointmentDetails 
AS
WITH cte AS(
SELECT * FROM Appointments
UNION ALL 
SELECT * FROM ArchivedAppointments
)
SELECT 
	ct.AppointmentDate,
    ct.AppointmentTime,
    d.DoctorFullName,
    ds.Speciality,
    dt.DepartmentName,
	ct.Status,
    ct.Review
FROM cte  ct
INNER JOIN Doctors d
ON ct.DoctorID = d.DoctorID
INNER JOIN Departments dt
ON d.DepartmentID = dt.DepartmentID
INNER JOIN DoctorsSpecialities ds
ON d.DoctorID = ds.DoctorID
WHERE Status IN ('Completed', 'Pending');
GO

-- Execute View

SELECT * FROM AppointmentDetails
ORDER BY AppointmentDate DESC;
GO

-- Q6: Create a Trigger to change Appointment Status as Available when it is Cancelled

CREATE TRIGGER ChangeStatus
ON Appointments
AFTER UPDATE
AS
BEGIN
	UPDATE Appointments
    SET Status = 'Available'
    WHERE Status = 'Cancelled';
END;
GO

-- Q7: Number of Completed Appointments with the specialty of doctors as ‘Gastroenterologists’

SELECT COUNT(*) AS NumCompletedAppointments
FROM ArchivedAppointments a
INNER JOIN Doctors d 
ON a.DoctorID = d.DoctorID
INNER JOIN DoctorsSpecialities ds
ON d.DoctorID = ds.DoctorID
WHERE a.Status = 'Completed'
AND ds.Speciality = 'Gastroenterologists';
GO


-- Additional Database Objects

--Additional 1:  Create Stored Procedure to Register New Patient 

CREATE PROCEDURE RegisterNewPatient
								@PatientFullName	NVARCHAR(50),
								@DateOfBirth			DATE,
								@Insurance				NVARCHAR(50),
								@UserName				NVARCHAR(50),
								@Password				NVARCHAR(50),
								@EmailAddress		NVARCHAR(50)		= NULL,
								@TelephoneNumber NVARCHAR(20)		= NULL,
								@DateLeft				DATE						= NULL,
								@Address					NVARCHAR(50),
								@PostCode				NVARCHAR(10),
								@City						NVARCHAR(50)
AS
BEGIN
		DECLARE @AddressID INT;

		-- Insert the Address into the Addresses table
		INSERT INTO Addresses (Address, PostCode, City)
		VALUES (@Address, @PostCode, @City);

		-- Get the AddressID 
		SET @AddressID = SCOPE_IDENTITY();

		-- Hash the password
		DECLARE @HashedPassword VARBINARY(256);
		SET @HashedPassword = HASHBYTES('SHA2_256', @Password);

		-- Insert the New Patient Values into the Patients Table
		INSERT INTO Patients(
								PatientFullName, DateOfBirth, Insurance, UserName, Password, 
								EmailAddress, TelephoneNumber, DateLeft, AddressID)
		VALUES (@PatientFullName, @DateOfBirth, @Insurance, @UserName, @Password, 
								@EmailAddress, @TelephoneNumber, @DateLeft, @AddressID)
END;

-- Execute the Stored Proedure

EXEC RegisterNewPatient
								@PatientFullName		= 'Hina Sohail',	
								@DateOfBirth				= '1981-07-23',
								@Insurance					= 'Saga',	
								@UserName					= 'hina26',
								@Password					= 'C9649e2',
								@EmailAddress			= 'h.altaf@gmail.com',
								@TelephoneNumber		= '0121 125 9828',
								@DateLeft					= NULL,
								@Address						= '27 Salford Quays',				
								@PostCode					= 'M17 3EQ',
								@City							=	'Salford'

GO

-- View the New Patient Record

SELECT* FROM Patients
WHERE PatientFullName	= 'Hina Sohail'
GO

--Additional 2:  Create Stored Procedure to Update Existing Patient 

CREATE PROCEDURE UpdatePatientRecord
								@PatientID				INT,
								@PatientFullName	NVARCHAR(50),
								@DateOfBirth			DATE,
								@Insurance				NVARCHAR(50),
								@UserName				NVARCHAR(50),
								@Password				NVARCHAR(50),
								@EmailAddress		NVARCHAR(50)		= NULL,
								@TelephoneNumber NVARCHAR(20)		= NULL,
								@DateLeft				DATE						= NULL,
								@Msg						NVARCHAR(MAX)	= NULL OUTPUT
AS
BEGIN TRY
			SET NOCOUNT ON
				UPDATE Patients
				SET
					PatientFullName			= @PatientFullName,
					DateOfBirth					= @DateOfBirth,
					Insurance						= @Insurance,
					UserName						= @UserName,
					Password						= @Password,
					EmailAddress				= @EmailAddress,
					TelephoneNumber			= @TelephoneNumber,
					DateLeft						= @DateLeft

				WHERE PatientID = @PatientID
				SET @Msg = 'Member Details Updated Successfully!';
END TRY

BEGIN CATCH
		SET @Msg = ERROR_MESSAGE();
END CATCH
GO

-- Execute the Stored Proedure

EXEC UpdatePatientRecord
								@PatientFullName		= 'Hina Sohail',	
								@DateOfBirth				= '1985-07-23',
								@Insurance					= 'Vitality Health',	
								@UserName					= 'hina26',
								@Password					= 'C9649e2',
								@EmailAddress			= 'a.altaf@gmail.com',
								@TelephoneNumber		= '0121 124 9728',
								@DateLeft					= NULL,
								@PatientID					= 12

GO

-- View the New Patient Record

SELECT* FROM Patients
WHERE PatientID	= 12
GO

-- Additional 3: Create Stored Procedure to update New Diagnosis and Medicines by Doctor

CREATE PROCEDURE UpdateDiagnosisAndMedicines
    @RecordID INT,
    @NewDiagnosis NVARCHAR(300),
    @NewMedicines NVARCHAR(300)
AS
BEGIN
    UPDATE MedicalRecords
    SET 
		Diagnosis = @NewDiagnosis,
        Medicines = @NewMedicines
    WHERE RecordID = @RecordID;
END;
GO

-- Execute Stored Procedure

EXEC UpdateDiagnosisAndMedicines
    @RecordID = 9,
    @NewDiagnosis = 'Acne',
    @NewMedicines = 'Azelaic Acid, Benzoyl Peroxide';
GO

-- View updated Diagnosis and Medicines

SELECT RecordID, Diagnosis, Medicines FROM MedicalRecords
WHERE RecordID = 9
GO

-- Additional 4: Create View to see Medical Records of a Patient including Past Appointments, 
-- Diagnosis, Medicines and Allergies

CREATE VIEW PatientMedicalRecords 
AS
WITH cte AS(
SELECT * FROM Appointments
UNION ALL 
SELECT * FROM ArchivedAppointments
)
SELECT mr.RecordID, mr.PatientID, p.PatientFullName,
			mr.PrescriptionDate, mr.Diagnosis, mr.Medicines,
			mr.Allergies, ct.AppointmentDate,
			ct.AppointmentTime, ct.Status
FROM cte ct
INNER JOIN MedicalRecords mr
ON mr.PatientID = ct.PatientID AND mr.DoctorID = ct.DoctorID
INNER JOIN Patients p
ON p.PatientID = mr.PatientID
WHERE ct.Status = 'Completed';
GO

-- Execute View

SELECT * FROM PatientMedicalRecords
WHERE PatientID = 6;
GO

-- Additional 5: Create Stored Procedure to update Appintment
--Status to Completed after seeing the Doctor

CREATE PROCEDURE UpdateAppointmentStatus
    @AppointmentID INT
AS
BEGIN
    UPDATE Appointments
    SET Status = 'Completed'
    WHERE AppointmentID = @AppointmentID;
END;
GO

-- Execute Stored Procedure

EXEC UpdateAppointmentStatus @AppointmentID = 10;
GO

-- View Updated Records

SELECT * FROM Appointments
WHERE AppointmentID = 10
GO

-- Additional 6: Create Stored Procedure to update Patient's Record when he leaves the Hospital System

CREATE PROCEDURE UpdatePatientRecordWhenLeaving
    @PatientID INT
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

	 BEGIN TRANSACTION;

	UPDATE Patients
	SET DateLeft = GETDATE()
	WHERE PatientID = @PatientID

	COMMIT TRANSACTION;
END;
GO

-- Execute Stored Procedure

EXEC UpdatePatientRecordWhenLeaving @PatientID = 1;
GO

-- View Updated Record

SELECT * FROM Patients
WHERE PatientID = 1
GO

-- Additional 7: Create User-Defined Function to Login a Patient

CREATE FUNCTION PatientLogin
(
	@UserName NVARCHAR(50),
	@Password NVARCHAR(50)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Result NVARCHAR(50)
	IF EXISTS(
						SELECT * FROM Patients
						WHERE UserName = @UserName AND Password = @Password)
		SET @Result = 'User Login Successfully!';
	ELSE
		SET @Result = 'Incorrect Username od Password!';
    RETURN @Result
END;
GO

-- Execute Function

SELECT dbo.PatientLogin('ethan74', 'F3259b1');
GO
