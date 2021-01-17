CREATE DATABASE NeferpituBanking;

USE NeferpituBanking;

CREATE TABLE [CardType](
[Id_CardType] INT IDENTITY PRIMARY KEY,
[Value_CardType] NVARCHAR(25)
);

CREATE TABLE [CardState](
[Id_CardState] INT IDENTITY PRIMARY KEY,
[Value_CardState] NVARCHAR(25)
);

CREATE TABLE [TransactionState](
[Id_TransactionState] INT IDENTITY PRIMARY KEY,
[Value_TransactionState] NVARCHAR(25)
);



CREATE TABLE [AccountType](
[Id_AccountType] INT IDENTITY PRIMARY KEY,
[Type_AccountType] NVARCHAR(30)
);

CREATE TABLE [AccountStatus](
[Id_Status] INT IDENTITY PRIMARY KEY,
[Value_AccountStatus] NVARCHAR(25)
);

CREATE TABLE [AlertType](
[Id_AlertType] INT IDENTITY PRIMARY KEY,
[Value_AlertType] NVARCHAR(25)
);

CREATE TABLE [CommercialAccountInfo](
[Id_CommercialAccountInfo] INT IDENTITY PRIMARY KEY,
[Education_CommercialAccountInfo] NVARCHAR(40),
[OfficialSalary_CommercialAccountInfo] MONEY,
[UnofficialSalary__CommercialAccountInfo] MONEY,
[Position_CommercialAccountInfo] NVARCHAR(25)
);

CREATE TABLE [AccountPrivate](
[Id_AccountPrivate] INT IDENTITY PRIMARY KEY, 
[BDate_AccountPrivate] DATE,
[City_AccountPrivate] NVARCHAR(25),
[Street_AccountPrivate] NVARCHAR(30),
[Phone_AccountPrivate] NVARCHAR(25),
[Email_AccountPrivate] NVARCHAR(25),
[PassportINN_AccountPrive] NVARCHAR (20),
[CommercialAccountInfo_Id] INT FOREIGN KEY REFERENCES CommercialAccountInfo(Id_CommercialAccountInfo)
);

CREATE TABLE [PaymentCompany](
[Id_PaymentCompany]INT IDENTITY PRIMARY KEY, 
[Name_PaymentCompany] NVARCHAR (40)
);

CREATE TABLE[CardLimits](
[Id_CardLimits] INT IDENTITY PRIMARY KEY,
[InternetPaymentLim_CardLimits] MONEY,
[LoanPaymentLim_CardLimits] MONEY
);

CREATE TABLE[Login](
[Id_Login] INT IDENTITY PRIMARY KEY,
[Value_Login] NVARCHAR(45),
[LastSetDate_Login] DATE
);

CREATE TABLE[Password](
[Id_Password] INT IDENTITY PRIMARY KEY,
[Value_Password] NVARCHAR(45),
[LastSetDate_Password] DATE,
[Tries_Password] INT,
[LastTry_Password] DATETIME
);

CREATE TABLE[Sex](
[Id_Sex] INT IDENTITY PRIMARY KEY,
[Value_Sex] NVARCHAR(10)
);

CREATE TABLE[Pin](
[Id_Pin] INT IDENTITY PRIMARY KEY,
[Tries_Pin] INT,
[SetDate_Pin] DATE,
[Value_Pin] NVARCHAR(20)
);

CREATE TABLE[Account](
[Id_Account] INT IDENTITY PRIMARY KEY,
[Name_Account] NVARCHAR(30),
[Surname_Account] NVARCHAR(30),
[IsActive_Account] BIT,
[PhotoURL_Account] NVARCHAR(40),
[Pin_Id] INT FOREIGN KEY REFERENCES [Pin](Id_Pin),
[AccountStatus_Id] INT FOREIGN KEY REFERENCES [AccountStatus](Id_Status),
[Sex_Account_Id] INT FOREIGN KEY REFERENCES Sex(Id_Sex),
[AccountPrivate_Id] INT FOREIGN KEY REFERENCES AccountPrivate(Id_AccountPrivate),
[AccountType_Id] INT FOREIGN KEY REFERENCES AccountType(Id_AccountType),
[Login_Id] INT FOREIGN KEY REFERENCES [Login](Id_Login),
[Password_Id] INT FOREIGN KEY REFERENCES [Password](Id_Password),
);


CREATE TABLE [CardBalance](
[Id_CardBalance]INT IDENTITY PRIMARY KEY,
[CurrentBalance_CardBalance] MONEY, 
[AvailableBalance_CardBalance] MONEY,
[Deposits_CardBalance] MONEY

);
CREATE TABLE[Card](
[Id_Card] INT IDENTITY PRIMARY KEY,
[Code_Card] NVARCHAR (20),
[BankName_Card] NVARCHAR(30),
[CardType_Id] INT FOREIGN KEY REFERENCES CardType(Id_CardType),
[Account_Id] INT FOREIGN KEY REFERENCES Account(Id_Account),
[CardLimits_Id] INT FOREIGN KEY REFERENCES CardLimits(Id_CardLimits),
[PaymentCompany_Id] INT FOREIGN KEY REFERENCES PaymentCompany(Id_PaymentCompany),
[CardState_Id] INT FOREIGN KEY REFERENCES CardState(Id_CardState),
[CardBalance_Id] INT FOREIGN KEY REFERENCES CardBalance(Id_CardBalance)
);

CREATE TABLE[CardPrivate](
[Id_CardPrivate] INT IDENTITY PRIMARY KEY,
[CVV_CardPrivate] NVARCHAR (3),
[ExpireDate_CardPrivate] NVARCHAR(5),
[CardPrivate_Card_id] INT UNIQUE FOREIGN KEY REFERENCES  Card(Id_Card)
);




CREATE TABLE [Alert](
[Id_Alert] INT IDENTITY PRIMARY KEY,
[Caption_Alert] NVARCHAR(45),
[Value_Alert] NVARCHAR(200),
[Account_Id] INT FOREIGN KEY REFERENCES [Account](Id_Account),
[AlertType_Id] INT FOREIGN KEY REFERENCES [AlertType](Id_AlertType)
);


CREATE TABLE [LoginPasswordHistory](
[Id_LoginPasswordHistory] INT IDENTITY PRIMARY KEY,
[Caption_LoginPasswordHistory] NVARCHAR (30),
[Description_LoginPasswordHistory] NVARCHAR (70),
[Date_LoginPasswordHistory] DATETIME,
[LoginPasswordHistory_Account_Id] INT FOREIGN KEY REFERENCES Account(Id_Account)
);


CREATE TABLE [Transaction](
[Id_Transaction] INT IDENTITY PRIMARY KEY,
[Value_Transaction] MONEY,
[Date_Transaction] DATETIME DEFAULT GETDATE(),
[TransactionState_Id] INT FOREIGN KEY REFERENCES TransactionState(Id_TransactionState),
[CardOwner_Id] INT FOREIGN KEY REFERENCES Card(Id_Card),
[DestionationCard_Transaction] NVARCHAR (20)
);





----------------------------------------------------------EMPLOYEE----------------------------------------------------------------------------
CREATE TABLE EmployeePrivate(
[Id_EmployeePrivate] INT IDENTITY PRIMARY KEY,
[BDate_EmployeePrivate] DATE,
[City_EmployeePrivate] NVARCHAR(20),
[Street_EmployeePrivate] NVARCHAR(30),
[Phone_EmployeePrivate] NVARCHAR (20),
[Email_EmployeePrivate] NVARCHAR (40),
[Education_EmployeePrivate] NVARCHAR (30),
[PasportINN_EmployeePrivate] NVARCHAR(20)
);

CREATE TABLE [EmployeePosition](
[Id_EmployeePosition] INT IDENTITY PRIMARY KEY,
[Value_Position] NVARCHAR(20)
);


CREATE TABLE Branch(
[Id_Branch] INT IDENTITY PRIMARY KEY,
[Adress_Branch] NVARCHAR(25),
);

CREATE TABLE ScheldueShift(
[Id_ScheldueShift] INT IDENTITY PRIMARY KEY,
[DaysCount_ScheldueShift] INT,
[FromDay_ScheldueShift] DATE,
[StartHour_ScheldueShift] INT,
[BreakDuration_ScheldueShift] INT,
[BreakStart_ScheldueShift] INT
);


CREATE TABLE Employee(
[Id_Employee] INT IDENTITY PRIMARY KEY,
[Name_Employee] NVARCHAR(20),
[Surname_Employee] NVARCHAR(20),
[PhotoURL_Employee] NVARCHAR(30),
[Salary_Employee] MONEY,
[ScheldueShift_Id] INT FOREIGN KEY REFERENCES ScheldueShift(Id_ScheldueShift),
[Branch_Id] INT FOREIGN KEY REFERENCES Branch(Id_Branch),
[EmployeePosition_Id] INT FOREIGN KEY REFERENCES EmployeePosition(Id_EmployeePosition),
[EmployeePrivate_Id] INT FOREIGN KEY REFERENCES EmployeePrivate(Id_EmployeePrivate),
);


CREATE TABLE [Payment](
[Id_Payment] INT IDENTITY PRIMARY KEY,
[Value_Payment] MONEY,
[Date_Payment] DATETIME,
[Employee_Id] INT FOREIGN KEY REFERENCES Employee(Id_Employee)
);


CREATE TABLE [WorkSkip](
[Id_WorkSkip] INT IDENTITY PRIMARY KEY,
[Date_WorkSkip] DATE,
[PenaltyWork_WorkSkip] MONEY,
[Employee_Id] INT FOREIGN KEY REFERENCES Employee(Id_Employee)
);

CREATE TABLE RegistraionInfo(
[Id_RegistrationInfo] INT IDENTITY PRIMARY KEY,
[Date_RegistrationInfo] DATE,
[Account_Id] INT FOREIGN KEY REFERENCES Account(Id_Account),
[Employee_Id] INT FOREIGN KEY REFERENCES Employee(Id_Employee)
);


CREATE TABLE SupportCustomerChat(
[Id_SupportCustomerChat] INT IDENTITY PRIMARY KEY, 
[CustomerAccount_id] INT FOREIGN KEY REFERENCES Account(Id_Account)
);

CREATE TABLE CustomerRequest(
[Id_CustomerRequest] INT IDENTITY PRIMARY KEY,
[Desciption_CustomerRequest] NVARCHAR(300),
[Caption_CustomerRequest] NVARCHAR(20),
[Date_CustomerRequest] DATETIME DEFAULT GETDATE(),
[SupportCustomerChat_CustomerRequest_id] INT FOREIGN KEY REFERENCES SupportCustomerChat([Id_SupportCustomerChat])
);



CREATE TABLE SupportResponse(
[Id_SupportResponse] INT IDENTITY PRIMARY KEY,
[Answer_SupportResponse] NVARCHAR(300),
[Employee_id] INT FOREIGN KEY REFERENCES Employee(Id_Employee),
[Date_SupportResponse] DATETIME DEFAULT GETDATE(),
[SupportCustomerChat_SupportResponse_id] INT FOREIGN KEY REFERENCES SupportCustomerChat([Id_SupportCustomerChat])
);

CREATE TABLE SupportResponseInfo(
[Id_SupportResponseInfo] INT IDENTITY PRIMARY KEY,
[Rating_SupportResponseInfo] INT,
[SupportResponse_Id] INT FOREIGN KEY REFERENCES SupportResponse(Id_SupportResponse)
);

CREATE TABLE ReportType(
[Id_ReportType] INT IDENTITY PRIMARY KEY,
[Value_ReportType] NVARCHAR(25),
[BadRate_ReportType] INT
);

CREATE TABLE SupportReport(
[Id_SupportReport] INT IDENTITY PRIMARY KEY,
[Date_SupportReport] DATE,
[ReportType_Id] INT FOREIGN KEY REFERENCES [ReportType](Id_ReportType),
[Employee_Id] INT FOREIGN KEY REFERENCES [Employee](Id_Employee)
);

CREATE TABLE SupportResponseReport(
[Id_SupportResponseReport] INT IDENTITY PRIMARY KEY,
[Value_SupportResponseReport] NVARCHAR(200),
[Caption_SupportResponseReport] NVARCHAR (20),
[Date_SupportResponseReport] DATE,
[IsChecked_SupportResponseReport] BIT,
[Account_Id] INT FOREIGN KEY REFERENCES  Account(Id_Account),
[ReportType_Id] INT FOREIGN KEY REFERENCES ReportType(Id_ReportType),
[SupportResponse_Id] INT FOREIGN KEY REFERENCES SupportResponse (Id_SupportResponse)
);
 
-------------


