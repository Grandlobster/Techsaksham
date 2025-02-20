create database AI;

use AI;

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT, 
    Username VARCHAR(255) UNIQUE NOT NULL, 
    Email VARCHAR(255) UNIQUE,           
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    
);

CREATE TABLE Conversations (
    ConversationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,                  
    StartTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EndTime TIMESTAMP,                    
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Messages (
    MessageID INT PRIMARY KEY AUTO_INCREMENT, 
    ConversationID INT NOT NULL,             
    SenderID INT,                          
    MessageText TEXT NOT NULL,                 
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (ConversationID) REFERENCES Conversations(ConversationID),
    FOREIGN KEY (SenderID) REFERENCES Users(UserID) 
);

CREATE TABLE QueryPatterns (
    PatternID INT PRIMARY KEY AUTO_INCREMENT, 
    PatternText TEXT NOT NULL,                
    Frequency INT DEFAULT 0,                  
    LastAsked TIMESTAMP                    
);

CREATE TABLE ChatbotResponses (
    ResponseID INT PRIMARY KEY AUTO_INCREMENT, 
    QueryPatternID INT,                      
    ResponseText TEXT NOT NULL,             
    ModelVersion VARCHAR(50),                 
    CreationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (QueryPatternID) REFERENCES QueryPatterns(PatternID) 
);


CREATE TABLE AIModelIntegration (
    ModelID INT PRIMARY KEY AUTO_INCREMENT,     
    ModelName VARCHAR(255) UNIQUE NOT NULL,     
    Version VARCHAR(50) NOT NULL,              
    UpdateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    Description TEXT                             
);


INSERT INTO Users (Username, Email) VALUES
('Rohan', 'Rohan.doe@example.com'),
('Aadesh', 'Aadesh.smith@example.com'),
('Pratik', 'Pratik.lee@example.com'),
('Girish', 'Girish.jones@example.com'),
('saurabh', 'saurabh.jones@example.com');

INSERT INTO Conversations (UserID) VALUES
(1),  -- Rohan
(2),  -- Aadesh
(1),  -- Rohan (another conversation)
(3),  -- Pratik
(4),  -- Girish
(5);  -- saurabh

INSERT INTO Messages (ConversationID, SenderID, MessageText) VALUES
(1, 1, 'Hello, chatbot!'), 
(1, NULL, 'Hi there! How can I help you?'),
(1, 1, 'What is the weather like today?'), 
(1, NULL, 'It is sunny and warm.'), 
(2, 2, 'Good morning!'),  
(2, NULL, 'Good morning to you too!'), 
(3, 1, 'I have a question.'), 
(5, NULL, 'Ask away!'),
(4, 3, 'Hi!'), 
(4, NULL, 'Hello!'); 


SELECT * FROM Users;

SELECT c.ConversationID, u.Username, c.StartTime  
FROM Conversations c
JOIN Users u ON c.UserID = u.UserID;          

SELECT m.MessageID, u.Username AS Sender, m.MessageText, m.Timestamp  
FROM Messages m
JOIN Users u ON m.SenderID = u.UserID
WHERE m.ConversationID = 1;  

SELECT PatternText, Frequency  
FROM QueryPatterns
ORDER BY Frequency DESC;

-- ----------------------------------------------------------------------------------------

CREATE DATABASE CryptoManagement;

USE CryptoManagement;

-- Table to store different types of currencies
CREATE TABLE Currencies (
    CurrencyID INT AUTO_INCREMENT PRIMARY KEY,
    CurrencyName VARCHAR(50) NOT NULL,
    CurrencySymbol VARCHAR(10) NOT NULL,
    MarketCap DECIMAL(20, 2),
    CirculatingSupply DECIMAL(20, 2),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store users' wallets
CREATE TABLE Wallets (
    WalletID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    CurrencyID INT NOT NULL,
    Balance DECIMAL(20, 8) DEFAULT 0.0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CurrencyID) REFERENCES Currencies(CurrencyID)
);

-- Table to store transaction history
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    FromWalletID INT NOT NULL,
    ToWalletID INT NOT NULL,
    Amount DECIMAL(20, 8) NOT NULL,
    TransactionTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (FromWalletID) REFERENCES Wallets(WalletID),
    FOREIGN KEY (ToWalletID) REFERENCES Wallets(WalletID)
);

-- Table to store encrypted transaction details
CREATE TABLE EncryptedTransactions (
    EncryptedTransactionID INT AUTO_INCREMENT PRIMARY KEY,
    TransactionID INT NOT NULL,
    EncryptedData TEXT NOT NULL,
    EncryptionMethod VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);


-- Insert entries into Currencies table
INSERT INTO Currencies (CurrencyName, CurrencySymbol, MarketCap, CirculatingSupply) VALUES 
('Bitcoin', 'BTC', 800000000000, 19000000),
('Ethereum', 'ETH', 400000000000, 120000000),
('Ripple', 'XRP', 20000000000, 45000000000),
('Litecoin', 'LTC', 10000000000, 70000000),
('Cardano', 'ADA', 15000000000, 32000000000);

-- Insert entries into Wallets table
INSERT INTO Wallets (UserID, CurrencyID, Balance) VALUES 
(1, 1, 0.5),   -- Rohan's Bitcoin wallet
(2, 2, 2.0),   -- Aadesh's Ethereum wallet
(3, 3, 1000.0), -- Girish's Ripple wallet
(4, 4, 5.0),   -- Saurabh's Litecoin wallet
(5, 5, 300.0); -- Pratik's Cardano wallet

-- Insert entries into Transactions table
INSERT INTO Transactions (FromWalletID, ToWalletID, Amount) VALUES 
(1, 2, 0.1),   -- Rohan sends Bitcoin to Aadesh
(2, 3, 0.5),   -- Aadesh sends Ethereum to Girish
(3, 4, 200.0), -- Girish sends Ripple to Saurabh
(4, 5, 1.0),   -- Saurabh sends Litecoin to Pratik
(5, 1, 50.0);  -- Pratik sends Cardano to Rohan

-- Insert entries into EncryptedTransactions table
INSERT INTO EncryptedTransactions (TransactionID, EncryptedData, EncryptionMethod) VALUES 
(1, 'encrypted_data_1', 'AES-256'),
(2, 'encrypted_data_2', 'AES-256'),
(3, 'encrypted_data_3', 'AES-256'),
(4, 'encrypted_data_4', 'AES-256'),
(5, 'encrypted_data_5', 'AES-256');


-- Queries

-- Retrieve all entries from Currencies table
SELECT * FROM Currencies;

-- Retrieve all entries from Wallets table
SELECT * FROM Wallets;

-- Retrieve all entries from Transactions table
SELECT * FROM Transactions;

-- Retrieve all entries from EncryptedTransactions table
SELECT * FROM EncryptedTransactions;

-- Retrieve transactions along with wallet details
SELECT 
    T.TransactionID,
    W1.UserID AS FromUserID,
    W2.UserID AS ToUserID,
    T.Amount,
    T.TransactionTime,
    T.Status
FROM 
    Transactions T
JOIN 
    Wallets W1 ON T.FromWalletID = W1.WalletID
JOIN 
    Wallets W2 ON T.ToWalletID = W2.WalletID;

-- Retrieve wallet balances for each user along with currency details
SELECT 
    U.Name AS UserName,
    C.CurrencyName,
    W.Balance
FROM 
    Wallets W
JOIN 
    Currencies C ON W.CurrencyID = C.CurrencyID
JOIN 
    Users U ON W.UserID = U.UserID;