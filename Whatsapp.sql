-- Create the database
CREATE DATABASE SocialMediaDB;

-- Use the database
USE SocialMediaDB;

-- Create the Users table
CREATE TABLE Users (
UserId INT PRIMARY KEY IDENTITY(1,1),
UserName NVARCHAR(50) NOT NULL,
PhoneNumber NVARCHAR(15) UNIQUE NOT NULL,
CreatedDate DATETIME NOT NULL
);


-- Populate the Users table with 5 users
INSERT INTO Users (UserName, PhoneNumber, CreatedDate)
VALUES 
('Josh', '+234 11 111 111', GETDATE()),
('Jane', '+234 22 222 222',  GETDATE()),
('Micky', '+234 33 333 333', GETDATE()),
('John', '+234 44 444 444', GETDATE()),
('Bale', '+234 55 555 555', GETDATE());


-- Create the Chats table
CREATE TABLE Chats (
ChatId INT PRIMARY KEY IDENTITY(1,1),
ChatName NVARCHAR(50) NOT NULL,
CreatedDate DATETIME NOT NULL
);

-- Populate the Chats table with 2 chats
INSERT INTO Chats (ChatName, CreatedDate)
VALUES 
('Family Group', GETDATE()),
('Friends Group', GETDATE());

-- Create the Messages table
CREATE TABLE Messages (
MessageId INT PRIMARY KEY IDENTITY(1,1),
ChatId INT NOT NULL,
SenderId INT NOT NULL,
ReceiverId INT NOT NULL,
MessageText NVARCHAR(MAX) NOT NULL,
SentDate DATETIME NOT NULL,
FOREIGN KEY (ChatId) REFERENCES Chats(ChatId),
FOREIGN KEY (SenderId) REFERENCES Users(UserId),
FOREIGN KEY (ReceiverId) REFERENCES Users(UserId)
);

-- Populate the Messages table with 5 messages
INSERT INTO Messages (ChatId, SenderId, ReceiverId, MessageText, SentDate)
VALUES 
(1, 1, 2, 'Hello Jane!', GETDATE()),
(1, 2, 3, 'Hi Micky!, My man', GETDATE()),
(1, 3, 4, 'Whats up John?', GETDATE()),
(2, 5, 1, 'Hi Josh, Are u back from Airport?', GETDATE()),
(2, 1, 5, 'Yes Bale, I am back!', GETDATE());


SELECT 
    u1.UserName AS SenderName, 
    u2.UserName AS ReceiverName, 
    m.MessageText, 
    m.SentDate, 
    u1.PhoneNumber AS SenderNumber
FROM Messages m
JOIN Users u1 ON m.SenderId = u1.UserId
JOIN Users u2 ON m.ReceiverId = u2.UserId;