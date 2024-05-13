
create database Emp_travel_booking_system



use Emp_travel_booking_system

-- employees table to store information about employees
create table employees (
    employeeid int primary key identity (100,1),
    emp_name varchar(50),
	email varchar(50),
	emp_password varchar(50),
    department varchar(50),
	position varchar(50),
	hiredate date,
    phonenumber varchar(20),
    address varchar(255),
	managerid int,
	foreign key (managerid) references managers(managerid) -- Reference to the managers table
)

-- managers table to store information about managers
create table managers (
    managerid int primary key identity (100,1),
    name varchar(50),
    department varchar(50),
    email varchar(50),
	mgr_password varchar(50),
)


-- admins table to store information about administrators
create table admins (
    adminid int primary key,
    name varchar(100),
    email varchar(100),
	admin_password varchar(50),
)


-- travel agents table to store information about travel agents
create table travelagents (
    agentid int primary key,
    name varchar(100),
    email varchar(100),
	travel_agent_password varchar(50)
)

-- travelrequests table to store travel requests submitted by employees
create table travelrequest (
    requestid int primary key IDENTITY(700,1),
    employeename varchar(100),
    employeeemail varchar(100),
    employeeid int,
    reasonfortravel varchar(255),
    flightneeded varchar(10),
    hotelneeded varchar(10),
    departurecity varchar(100),
    arrivalcity varchar(100),
    departuredate date,
    departuretime time,
    additionalinformation text,
	bookingstatus varchar(50) DEFAULT 'Pending' check (bookingstatus IN ('Confirmed', 'Not available', 'Pending')), -- Restriction on status
	approvalstatus VARCHAR(50) DEFAULT 'Pending' CHECK (approvalstatus IN ('Approved', 'Rejected','Pending', 'Cancelled')),
	foreign key (employeeid) references employees(employeeid)
)


-- Insert dummy data into the travelrequest2 table
INSERT INTO travelrequest (employeename, employeeemail, employeeid, reasonfortravel, flightneeded, hotelneeded, departurecity, arrivalcity, departuredate, departuretime, additionalinformation)
VALUES
    ('John Doe', 'john@example.com', 101, 'Vacation', 'Yes', 'No', 'City A', 'City B', '2024-05-10', '10:00:00', 'Some additional info');

UPDATE travelRequest
SET bookingstatus = 'Pending'
WHERE employeeid = 100;





select * from admins
select * from travelagents
select * from travelrequest
select * from managers
select * from bookingstatus

select * from travelrequest
select * from employees

INSERT INTO travelagents (agentid, name, email, travel_agent_password)
VALUES
    (334,'Sidhu' ,'sidh@123' ,334-1);

-- Insert dummy data into the managers table
INSERT INTO managers (name, department, email, mgr_password)
VALUES 
    ('Manager 1', 'Engineering', 'manager1@example.com', 'password1'),
    ('Manager 2', 'Marketing', 'manager2@example.com', 'password2');

-- Insert dummy data into the employees table
INSERT INTO employees (emp_name, email, emp_password, department, position, hiredate, phonenumber, address, managerid)
VALUES
    ('John Doe', 'john@example.com', 'password', 'Engineering', 'Software Engineer', '2024-01-01', '123-456-7890', '123 Main St', 100), -- Assuming managerid 101 exists
    ('Jane Smith', 'jane@example.com', 'password', 'Marketing', 'Marketing Manager', '2023-12-15', '987-654-3210', '456 Elm St', 101); -- Assuming managerid 102 exists
