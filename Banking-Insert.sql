USE NeferpituBanking

-----TRANSACTION STATE
INSERT INTO TransactionState(Value_TransactionState)VALUES('Success');
INSERT INTO TransactionState(Value_TransactionState)VALUES('Aborted');
INSERT INTO TransactionState(Value_TransactionState)VALUES('Failed');

-----CARD STATE
INSERT INTO CardState(Value_CardState)VALUES('Working');
INSERT INTO CardState(Value_CardState)VALUES('Banned');
INSERT INTO CardState(Value_CardState)VALUES('Blocked');
INSERT INTO CardState(Value_CardState)VALUES('Stopped');
INSERT INTO CardState(Value_CardState)VALUES('Pending confirmation');


-----Account TYPE
INSERT INTO AccountType(Type_AccountType)VALUES('Platinum');
INSERT INTO AccountType(Type_AccountType)VALUES('Gold');
INSERT INTO AccountType(Type_AccountType)VALUES('Silver');
INSERT INTO AccountType(Type_AccountType)VALUES('Basic');

-----card TYPE
INSERT INTO CardType(Value_CardType)VALUES('Platinum');
INSERT INTO CardType(Value_CardType)VALUES('Gold');
INSERT INTO CardType(Value_CardType)VALUES('Silver');
INSERT INTO CardType(Value_CardType)VALUES('Basic');



-----Account Status
INSERT INTO AccountStatus(Value_AccountStatus)VALUES('Blocked');
INSERT INTO AccountStatus(Value_AccountStatus)VALUES('Pending confirmation');
INSERT INTO AccountStatus(Value_AccountStatus)VALUES('Banned');
INSERT INTO AccountStatus(Value_AccountStatus)VALUES('Working');



------PAYMENT COMPANY
INSERT INTO PaymentCompany(Name_PaymentCompany)VALUES('VISA');
INSERT INTO PaymentCompany(Name_PaymentCompany)VALUES('Master Card');


-----Commercial Account Info
INSERT INTO CommercialAccountInfo(Education_CommercialAccountInfo,OfficialSalary_CommercialAccountInfo,UnofficialSalary__CommercialAccountInfo,Position_CommercialAccountInfo)
VALUES('School ¹13',300,500,'Manager');
INSERT INTO CommercialAccountInfo(Education_CommercialAccountInfo,OfficialSalary_CommercialAccountInfo,UnofficialSalary__CommercialAccountInfo,Position_CommercialAccountInfo)
VALUES('School ¹53',200,500,'Watcher');


-- Account Private
INSERT INTO AccountPrivate(BDate_AccountPrivate,City_AccountPrivate,Street_AccountPrivate,Phone_AccountPrivate,Email_AccountPrivate,PassportINN_AccountPrive,CommercialAccountInfo_Id)
VALUES(GETDATE(),'Dnipro','Minina','3809574150','volgea@mail.com','113131311',1);
INSERT INTO AccountPrivate(BDate_AccountPrivate,City_AccountPrivate,Street_AccountPrivate,Phone_AccountPrivate,Email_AccountPrivate,PassportINN_AccountPrive,CommercialAccountInfo_Id)
VALUES(GETDATE(),'Charkiv','Roster','380957250','sass@mail.com','33333311',2);

-- Login
INSERT INTO Login(Value_Login,LastSetDate_Login)VALUES('admin',GETDATE());
INSERT INTO Login(Value_Login,LastSetDate_Login)VALUES('user',GETDATE());


-- password
INSERT INTO Password(LastSetDate_Password,LastTry_Password,Value_Password,Tries_Password)
VALUES(GETDATE(),GETDATE(),'admin',3);
INSERT INTO Password(LastSetDate_Password,LastTry_Password,Value_Password,Tries_Password)
VALUES(GETDATE(),GETDATE(),'user',3);





-- SEX
INSERT INTO Sex(Value_Sex)VALUES('Male');
INSERT INTO Sex(Value_Sex)VALUES('Female');


---PIN
INSERT INTO Pin(Tries_Pin,SetDate_Pin,Value_Pin) 
VALUES(3,GETDATE(),'1234')
INSERT INTO Pin(Tries_Pin,SetDate_Pin,Value_Pin) 
VALUES(3,GETDATE(),'1524')


--Account 
INSERT INTO [Account](Name_Account,Surname_Account,Sex_Account_Id,IsActive_Account,AccountStatus_Id,AccountType_Id,Login_Id,Password_Id,Pin_Id,AccountPrivate_Id)
VALUES ('Vova','Kyrylyuck',1,0,4,4,1,1,1,1)
INSERT INTO [Account](Name_Account,Surname_Account,Sex_Account_Id,IsActive_Account,AccountStatus_Id,AccountType_Id,Login_Id,Password_Id,Pin_Id,AccountPrivate_Id)
VALUES ('Kostya','Kuksa',2,0,4,4,2,2,2,2)

--Card BALANCE
INSERT INTO CardBalance(CurrentBalance_CardBalance,AvailableBalance_CardBalance,Deposits_CardBalance) VALUES(0,0,0);
INSERT INTO CardBalance(CurrentBalance_CardBalance,AvailableBalance_CardBalance,Deposits_CardBalance) VALUES(200,200,200);
INSERT INTO CardBalance(CurrentBalance_CardBalance,AvailableBalance_CardBalance,Deposits_CardBalance) VALUES(300,300,300);

--CARD LIMITS
INSERT INTO CardLimits(InternetPaymentLim_CardLimits,LoanPaymentLim_CardLimits) VALUES (0,0)
INSERT INTO CardLimits(InternetPaymentLim_CardLimits,LoanPaymentLim_CardLimits) VALUES (10,10)
INSERT INTO CardLimits(InternetPaymentLim_CardLimits,LoanPaymentLim_CardLimits) VALUES (20,20)

--Card 
INSERT INTO Card(Code_Card,CardBalance_Id,CardLimits_Id,CardState_Id,CardType_Id,Account_Id,PaymentCompany_Id,BankName_Card) VALUES ('537541411009444',1,1,1,1,1,1,'Neferpitubank');
INSERT INTO Card(Code_Card,CardBalance_Id,CardLimits_Id,CardState_Id,CardType_Id,Account_Id,PaymentCompany_Id,BankName_Card) VALUES ('537541411002330',2,2,2,2,1,1,'Neferpitubank');
INSERT INTO Card(Code_Card,CardBalance_Id,CardLimits_Id,CardState_Id,CardType_Id,Account_Id,PaymentCompany_Id,BankName_Card) VALUES ('537541411030021',3,3,1,1,2,1,'Neferpitubank');


--Card Private
INSERT INTO CardPrivate(CVV_CardPrivate,ExpireDate_CardPrivate,CardPrivate_Card_id)VALUES('333','12/24',1);
INSERT INTO CardPrivate(CVV_CardPrivate,ExpireDate_CardPrivate,CardPrivate_Card_id)VALUES('356','12/23',2);
INSERT INTO CardPrivate(CVV_CardPrivate,ExpireDate_CardPrivate,CardPrivate_Card_id)VALUES('356','12/24',3);

--Card Transactions
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)VALUES(150,1,1,'537541411030021')
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)VALUES(100,1,1,'537541411030021')
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)VALUES(55,1,1,'537541411002330')
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)VALUES(1230,1,1,'537541411002330')
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)VALUES(111120,1,1,'537541411002330')
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)VALUES(12100,1,1,'537541411002330')
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)VALUES(200,1,2,'537541411002330')


-----ALert TYPE
INSERT INTO AlertType(Value_AlertType)VALUES('Warning');
INSERT INTO AlertType(Value_AlertType)VALUES('Critical Error');
INSERT INTO AlertType(Value_AlertType)VALUES('Error');
INSERT INTO AlertType(Value_AlertType)VALUES('Notification');


----Alert 
INSERT INTO Alert(Value_Alert,AlertType_Id,Caption_Alert,Account_Id)VALUES('This is test notificaiton That is your first start thia app! vThat is your first start thia app! That is your first start thia app!',1,'First notification',1);
INSERT INTO Alert(Value_Alert,AlertType_Id,Caption_Alert,Account_Id)VALUES('This is test notificaiton ¹2 That is your first start thia app! That is your first start thia app! That is your first start thia app!',2,'Second notification',1);
INSERT INTO Alert(Value_Alert,AlertType_Id,Caption_Alert,Account_Id)VALUES('This is test notificaiton That is your first start thia app! That is your first start thia app! That is your first start thia app! That is Third notification!',3,'test',2);
INSERT INTO Alert(Value_Alert,AlertType_Id,Caption_Alert,Account_Id)VALUES('That is your first start thia app! That is your first start thia app! That is your first start thia app!That is your first start thia app! That is your first start thia app!',4,'Fourth notification',1);
INSERT INTO Alert(Value_Alert,AlertType_Id,Caption_Alert,Account_Id)VALUES('You first time run our app, we hope that u will enjoy it too much That is your first start thia app! That is your first start thia app!That is your first start thia app!That is your p!',4,'That is your first start thia app!',1);



----Employee Position
INSERT INTO EmployeePosition(Value_Position)VALUES('Support');
INSERT INTO EmployeePosition(Value_Position)VALUES('Manager');
INSERT INTO EmployeePosition(Value_Position)VALUES('Administrator');


----Employee Private
INSERT INTO EmployeePrivate(BDate_EmployeePrivate,
                            City_EmployeePrivate,
							Street_EmployeePrivate,
							Phone_EmployeePrivate,
							Email_EmployeePrivate,
							Education_EmployeePrivate,
							PasportINN_EmployeePrivate)
                     VALUES('2017-07-28',
					        'Dnipro',
							'Minina',
							'38014121211',
							'vofsaea@fksdfsa.com',
							'Higher Education of KPU',
							'4811112821121');

------BRANCH
INSERT INTO Branch(Adress_Branch)
            VALUES('Karla Marksa 23');


------ScheldueShift
INSERT INTO ScheldueShift(DaysCount_ScheldueShift,
                          FromDay_ScheldueShift,
						  StartHour_ScheldueShift,
						  BreakDuration_ScheldueShift,
						  BreakStart_ScheldueShift)
				   VALUES(4,
				          '2017-07-28',
						  8,
						  25,
						  12);


-------Report type
INSERT INTO ReportType(BadRate_ReportType,
                       Value_ReportType)
				VALUES(1,
				       'Racism');
INSERT INTO ReportType(BadRate_ReportType,
                       Value_ReportType)
				VALUES(3,
				       'Not polite');
INSERT INTO ReportType(BadRate_ReportType,
                       Value_ReportType)
				VALUES(4,
				       'Other');
-------Employee
INSERT INTO Employee(Name_Employee,
                     Surname_Employee,
					 Salary_Employee,
					 Branch_Id,
					 ScheldueShift_Id,
					 EmployeePosition_Id,
					 EmployeePrivate_Id)
			  VALUES('Babek',
			         'Babekovich',
					 200,
					 1,
					 1,
					 1,
					 1);
--------WorkSkip
INSERT INTO WorkSkip(Date_WorkSkip,
                     PenaltyWork_WorkSkip,
					 Employee_Id)
			  VALUES('2017-07-28',
			         200,
					 1);
-------Registration
INSERT INTO RegistraionInfo(Date_RegistrationInfo,
                            Account_Id,
							Employee_Id)
					VALUES(GETDATE(),
					       1,
						   1);

-------SupportReport
INSERT INTO SupportReport(Date_SupportReport,
                          ReportType_Id,
						  Employee_Id)
				   VALUES(GETDATE(),
				          1,
						  1);

------SupportCustomerChat
INSERT INTO SupportCustomerChat(CustomerAccount_id)
						 VALUES(1)

------SupportRespone
INSERT INTO SupportResponse(Answer_SupportResponse,
                            Employee_id,
							SupportCustomerChat_SupportResponse_id)
					 VALUES('Hi, you can always ask any questions, or get help :)',
					         1,
							 1);
		
INSERT INTO SupportResponse(Answer_SupportResponse,
                            Employee_id,
							SupportCustomerChat_SupportResponse_id)
					 VALUES('Test response!',
					         1,
							 1
							 );
------CustomerRequest
INSERT INTO CustomerRequest(Caption_CustomerRequest,
                            Desciption_CustomerRequest,
							SupportCustomerChat_CustomerRequest_id)
					    VALUES('Caption to show!',
						       'Description to show!',
							   1)
INSERT INTO CustomerRequest(Caption_CustomerRequest,
                            Desciption_CustomerRequest,
							SupportCustomerChat_CustomerRequest_id)
					    VALUES('Caption Second!',
						       'This is second test of my request system, just check how it works!',
							   1);


								
							

				          





       