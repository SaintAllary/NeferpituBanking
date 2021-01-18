USE NeferpituBanking;

CREATE PROC Get__AlertType
@ID INT
AS
SELECT Value_AlertType 
FROM AlertType
WHERE AlertType.Id_AlertType = @ID


--EXEC Get__AlertType

CREATE PROC Get__CardState
@ID INT
AS
SELECT Value_CardState
FROM CardState
WHERE CardState.Id_CardState = @ID

--EXEC Get__CardState 2

CREATE PROC Get__TransactionState
@ID INT
AS
SELECT Value_TransactionState
FROM TransactionState
WHERE TransactionState.Id_TransactionState = @ID


CREATE PROC Get__CardType
@ID INT
AS
SELECT Value_CardType
FROM CardType
WHERE CardType.Id_CardType = @ID



CREATE PROC Get__AccountType
@ID INT
AS
SELECT Type_AccountType
FROM AccountType
WHERE AccountType.Id_AccountType = @ID



CREATE PROC DO__Transaction
@Value MONEY,
@CardOwner_Id INT,
@DestinationCardCode NVARCHAR(20)
AS
SET NOCOUNT OFF
IF (SELECT CardBalance.CurrentBalance_CardBalance FROM CARD,CardBalance
    WHERE Card.CardBalance_Id = CardBalance.Id_CardBalance
	AND CARD.Id_Card = @CardOwner_Id)>= @Value
BEGIN
UPDATE [CardBalance]
SET CurrentBalance_CardBalance = CurrentBalance_CardBalance-@Value
FROM [CardBalance],[Card]
WHERE [Card].Id_Card = @CardOwner_Id
AND [Card].CardBalance_Id = CardBalance.Id_CardBalance
UPDATE [CardBalance]
SET CurrentBalance_CardBalance = CurrentBalance_CardBalance+ @Value
FROM [CardBalance],[Card]
WHERE [Card].Code_Card = @DestinationCardCode
AND [Card].CardBalance_Id = CardBalance.Id_CardBalance;
INSERT INTO [Transaction](Value_Transaction,TransactionState_Id,CardOwner_Id,DestionationCard_Transaction)
VALUES(@Value,1,@CardOwner_Id,@DestinationCardCode);
DECLARE @IsExecuted BIT =1 
return @IsExecuted
END





CREATE PROC  CHECK__SignIn
@Login NVARCHAR(45),
@Password NVARCHAR(45),
@User_signed_Id INT OUTPUT
AS 
SET NOCOUNT ON
SELECT @User_signed_Id = Id_Account
FROM Account,Password,Login
WHERE 
Account.Login_Id = Login.Id_Login
AND Account.Password_Id = Password.Id_Password
AND Password.Value_Password = @Password
AND Login.Value_Login = @Login
UPDATE Account
SET IsActive_Account = 1
WHERE Account.Id_Account = @User_signed_Id
RETURN @User_signed_Id



CREATE PROC Get_InfoPermission
@Login NVARCHAR(45),
@Password NVARCHAR(45),
@output BIT OUTPUT
AS
SET NOCOUNT ON
SELECT @output =  Count(*) FROM Login,Password
WHERE Login.Value_Login = @Login 
AND Password.Value_Password = @Password



CREATE PROC GET_AllUsersCards
@UserId INT,
@Login NVARCHAR (45),
@Password NVARCHAR (45)
AS 
SET NOCOUNT ON
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
   SELECT * FROM [Card]
   WHERE Card.Account_Id = @UserId
END
ELSE
BEGIN
   return null
END



CREATE PROC GET_PrivateCardInfo
@Card_id BIGINT,
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS
SET NOCOUNT ON
SELECT [CardPrivate].CVV_CardPrivate,
[CardPrivate].ExpireDate_CardPrivate 
FROM [CardPrivate],[Account],[Login],[Password]
WHERE CardPrivate.CardPrivate_Card_id = @Card_id
AND [Account].Password_Id = Password.Id_Password
AND [Account].Login_Id = Login.Id_Login
AND [Login].Value_Login = @Login
AND [Password].Value_Password= @Password


CREATE PROC GET_PaymentCompany
@CompanyId INT
AS 
SET NOCOUNT ON
SELECT * FROM PaymentCompany
WHERE PaymentCompany.Id_PaymentCompany = @CompanyId




CREATE PROC GET_CardType
@CardTypeId INT 
AS
SET NOCOUNT ON
SELECT * FROM CardType
WHERE CardType.Id_CardType = @CardTypeId



CREATE PROC GET_CardLimits
@CardLimitsId INT,
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS
SET NOCOUNT ON
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT * FROM CardLimits
WHERE CardLimits.Id_CardLimits = @CardLimitsId
END



CREATE PROC GET_CardState
@CardStateId INT 
AS
SET NOCOUNT ON
SELECT * FROM CardState
WHERE CardState.Id_CardState = @CardStateId



CREATE PROC GET_CardBalance
@CardBalanceId INT,
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS
SET NOCOUNT ON
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT * FROM CardBalance
WHERE CardBalance.Id_CardBalance = @CardBalanceId
END


CREATE PROC GET_AllTransactions
@CardOwnerId INT,
@Login NVARCHAR(45),
@Password NVARCHAR (45)
AS
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT * FROM [Transaction]
WHERE [Transaction].CardOwner_Id = @CardOwnerId
END


CREATE PROC GET_TransactionState
@transactionStateId INT
AS 
BEGIN
SELECT * FROM TransactionState
WHERE TransactionState.Id_TransactionState = @transactionStateId
END


CREATE PROC GET_AccountInfo
@IdUser INT,
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS 
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT * FROM Account
INNER JOIN AccountPrivate ON AccountPrivate.Id_AccountPrivate= Account.AccountPrivate_Id
INNER JOIN CommercialAccountInfo ON CommercialAccountInfo.Id_CommercialAccountInfo=AccountPrivate.CommercialAccountInfo_Id
INNER JOIN AccountType ON AccountType.Id_AccountType = Account.AccountType_Id
INNER JOIN AccountStatus ON AccountStatus.Id_Status = Account.AccountStatus_Id
WHERE Account.Id_Account = @IdUser
END



CREATE PROC SET_Password
@NewPass NVARCHAR(45),
@Login NVARCHAR(45),
@Password NVARCHAR(45),
@IdPass INT
AS
SET NOCOUNT OFF
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
UPDATE Password
SET Password.Value_Password = @NewPass,
    Password.LastSetDate_Password = GETDATE()
WHERE Password.Id_Password = @IdPass
END



CREATE PROC SET_Login
@NewLogin NVARCHAR(45),
@Login NVARCHAR(45),
@Password NVARCHAR(45),
@IdLog INT
AS
SET NOCOUNT OFF
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
UPDATE Login
SET Login.Value_Login = @NewLogin
WHERE Login.Id_Login = @IdLog
UPDATE Login
SET Login.LastSetDate_Login = GETDATE()
WHERE Login.Id_Login = @IdLog
END


CREATE PROC GET_LoginPassword
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS 
SET NOCOUNT ON
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT Login.Value_Login,LastSetDate_Login,Value_Password,LastSetDate_Password FROM Account,Login,Password
WHERE Password.Id_Password = Account.Password_Id
AND LOGIN.Id_Login = Account.Login_Id
AND Login.Value_Login = @Login
And Password.Value_Password = @Password
END


CREATE PROC GET_AllAlerts
@AccountId INT,
@Login NVARCHAR(45),
@Password NVARCHAR (45)
AS
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT AlertType.Value_AlertType AS 'Type',Alert.Caption_Alert AS 'Caption',Alert.Value_Alert AS 'Value' FROM [Alert],AlertType
WHERE Alert.Account_Id = @AccountId
AND AlertType.Id_AlertType = Alert.AlertType_Id
END


CREATE PROC GET_CardCodeById
@CardId INT
AS
BEGIN
SELECT [Card].Code_Card FROM [Card]
WHERE [Card].Id_Card = @CardId
END


CREATE PROC GET_LoginPasswordHistory
@UserId INT,
@Login NVARCHAR(45),
@Password NVARCHAR (45)
AS
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN 
SELECT * FROM LoginPasswordHistory
WHERE LoginPasswordHistory.LoginPasswordHistory_Account_Id = @UserId
END




CREATE TRIGGER Password_UPDATE
ON [Password]
AFTER UPDATE
AS
IF UPDATE ([Value_Password])
BEGIN
INSERT INTO LoginPasswordHistory(Caption_LoginPasswordHistory,Description_LoginPasswordHistory,Date_LoginPasswordHistory,LoginPasswordHistory_Account_Id)
VALUES('Password was changed',
      'Did you do this? If no write on feedpack page to our support',
	   GETDATE(),
	  (SELECT Account.Id_Account FROM inserted,Account WHERE inserted.Id_Password = Account.Password_Id))
END






CREATE TRIGGER Card_UPDATED
ON [Card]
AFTER UPDATE
AS
IF UPDATE ([CardState_Id]) 
BEGIN
INSERT INTO Alert(Caption_Alert,Value_Alert,AlertType_Id,Account_Id)
VALUES('Card information was changed',
       'Your cards information was changed,are you sure that you was in charge of this?'
        ,1
		,(select Account_Id from inserted))
END



CREATE PROC GET_Feedbacks
@UserId INT,
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS
SET NOCOUNT ON
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT [SupportCustomerChat].Id_SupportCustomerChat, 
SupportResponse.Answer_SupportResponse,
SupportResponse.Date_SupportResponse
            FROM SupportCustomerChat
            LEFT JOIN SupportResponse ON  SupportResponse.SupportCustomerChat_SupportResponse_id = SupportCustomerChat.Id_SupportCustomerChat  
			WHERE SupportCustomerChat.CustomerAccount_id = @UserId
END



CREATE PROC GET_Requests
@UserId INT,
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS
SET NOCOUNT ON
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
SELECT [SupportCustomerChat].Id_SupportCustomerChat, 
CustomerRequest.Caption_CustomerRequest, 
CustomerRequest.Desciption_CustomerRequest,
CustomerRequest.Date_CustomerRequest
            FROM SupportCustomerChat
            LEFT JOIN CustomerRequest ON  CustomerRequest.SupportCustomerChat_CustomerRequest_id = SupportCustomerChat.Id_SupportCustomerChat 
			WHERE SupportCustomerChat.CustomerAccount_id = @UserId
END




CREATE PROC DO__SendFeedbackRequest
@UserId INT,
@Caption NVARCHAR(20),
@Description NVARCHAR(200),
@Login NVARCHAR(45),
@Password NVARCHAR(45)
AS
SET NOCOUNT ON
DECLARE @Permission BIT
EXEC Get_InfoPermission @Login,@Password, @Permission OUTPUT
IF @Permission =1
BEGIN
INSERT INTO CustomerRequest(Caption_CustomerRequest,
                            Desciption_CustomerRequest,
							SupportCustomerChat_CustomerRequest_id)
					 VALUES(@Caption,
					        @Description,
							(Select SupportCustomerChat.Id_SupportCustomerChat
							           FROM SupportCustomerChat
							           WHERE SupportCustomerChat.CustomerAccount_id = @UserId));
END




--EXEC DO__SendFeedbackRequest 1,'Vau','Ogo chto ohgo','admin','admin'


--SELECT * FROM  SupportCustomerChat
--SELECT * FROM  CustomerRequest
--SELECT * FROM  SupportResponse
--EXEC GET_Requests 1 ,'admin','admin'
--EXEC GET_Feedbacks 1, 'admin', 'admin'

--DROP PROC GET_Feedbacks

----EXEC GET_AllAlerts 1 ,'admin', 'admin'

----EXEC GET_AllAlerts 1 , 'admin' , 'admin'
--EXEC DO__Transaction 100,2,'537541411009444'
--EXEC DO__Transaction 100,1,'537541411030021'
--EXEC DO__Transaction 100,3,'537541411009444'
--EXEC DO__Transaction 100,3,'537541411009444'
--EXEC DO__Transaction 100,1,'537541411002330'
