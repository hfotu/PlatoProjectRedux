/* Project Plato:
This project is focused on helping researchers being able to communicate with each other
without having to use multiple types of programs, but instead all of it would be in one
program. This allows us to better manage data and saves alot of time.
*/
CREATE DATABASE PlatoDB;
USE PlatoDB;

-- Table structure for table 'identity_types'

CREATE TABLE identity_types (
    typeID INT IDENTITY(1,1) PRIMARY KEY,
    typeFirstName VARCHAR(20) NOT NULL,
    typeLastName VARCHAR(20) NOT NULL
);

-- Table structure for table 'expenses'

CREATE TABLE expenses (
    expenseID INT IDENTITY(1,1) PRIMARY KEY,
    expenseType VARCHAR(10) NOT NULL
);

-- Table structure for table 'deadlines'

CREATE TABLE deadlines (
    deadlineID INT IDENTITY(1,1) PRIMARY KEY,
    deadlineDate DATE NOT NULL
);

-- Table structure for table 'stats'

CREATE TABLE stats (
    statsID INT IDENTITY(1,1) PRIMARY KEY,
    statsDescription VARCHAR(20) NOT NULL
);

-- Table structure for table 'projects'

CREATE TABLE projects (
    projectID INT IDENTITY(1,1) PRIMARY KEY,
    projectName VARCHAR(50) NOT NULL,
    projectDescription VARCHAR(200) NOT NULL,
    projectCriteria VARCHAR(200) NOT NULL,
    projectTimeStart DATE NOT NULL,
    projectTimeEnd DATE,
    typeID INT,
    CONSTRAINT FK_individualType FOREIGN KEY (typeID)
    REFERENCES identity_types(typeID)
);

-- Table structure for table 'travel'

CREATE TABLE travels (
    travelID INT IDENTITY(1,1) PRIMARY KEY,
    travelDate DATE NOT NULL,
    travelRegistration INT NOT NULL,
    travelTrainingDate DATE NOT NULL,
    -- travel passport picture stores either T/F 
    travelPassportPicture CHAR(1) NOT NULL,
    -- travel assumption risk stores either T/F
    travelAssumptionOfRisk CHAR(1) NOT NULL,
    -- travel star form stores either T/F
    travelStarForm CHAR(1) NOT NULL,
    -- travel insurance information stores either T/F
    travelInsuranceInformation CHAR(1) NOT NULL
);

-- Table structure for table 'grant_types'

CREATE TABLE grant_types (
    grantTypeID INT IDENTITY(1,1) PRIMARY KEY,
    grantTypeName VARCHAR(20) NOT NULL,
    grantTypeAmount DECIMAL(19,4) NOT NULL,
    grantTypeDescription VARCHAR(200) NOT NULL,
    grantTypeEndDay DATE NOT NULL,
    deadlineID INT,
    CONSTRAINT FK_deadline FOREIGN KEY (deadlineID) 
    REFERENCES deadlines(deadlineID)
);

-- Table structure for table 'individual'

CREATE TABLE individual (
    individualID INT IDENTITY(1,1) PRIMARY KEY,
    idFirstName VARCHAR(30) NOT NULL,
    idLastName VARCHAR(30) NOT NULL,
    idBirthDate VARCHAR(30) NOT NULL,
-- Chooses between M (males) and F (females)
    idGender CHAR(1) NOT NULL,
    idAddress VARCHAR(40) NOT NULL,
    idCity VARCHAR(20) NOT NULL,
    idState VARCHAR(20) NOT NULL,
    idCountry VARCHAR(20) NOT NULL,
    idZip INT NOT NULL,
    idResidentCounty VARCHAR(20) NOT NULL,
    idEmail VARCHAR(20),
    idPhone VARCHAR(22) NOT NULL,
    projectID INT,
    typeID INT,
    CONSTRAINT FK_project FOREIGN KEY (projectID)
    REFERENCES projects(projectID),
    CONSTRAINT FK_identityType FOREIGN KEY (typeID) 
    REFERENCES identity_types(typeID)
);

-- table structure for table 'budgets'

CREATE TABLE budgets (
    budgetID INT IDENTITY(1,1) PRIMARY KEY,
    budgetRequestAmount DECIMAL(19,4) NOT NULL,
    budgetAwardedAmount DECIMAL(19,4) NOT NULL,
    budgetSpentAmount DECIMAL(19,4) NOT NULL,
    projectID INT,
    expenseID INT,
    CONSTRAINT FK_project FOREIGN KEY (projectID)
    REFERENCES projects(projectID),
    CONSTRAINT FK_expense FOREIGN KEY (expenseID)
    REFERENCES expenses(expenseID)
);

-- table structure for table 'grant_applications'

CREATE TABLE grant_applications (
    applicationsID INT IDENTITY(1,1) PRIMARY KEY,
    applicationsDate DATE NOT NULL,
    applicationRequestAmount DECIMAL(19,4) NOT NULL,
    projectID INT,
    statsID INT,
    CONSTRAINT FK_project FOREIGN KEY (projectID)
    REFERENCES projects(projectID),
    CONSTRAINT FK_stats FOREIGN KEY (statsID)
    REFERENCES stats(statsID)
);