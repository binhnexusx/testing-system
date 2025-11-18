DROP DATABASE IF EXISTS Testing_System;
CREATE DATABASE Testing_System;
USE Testing_System;

CREATE TABLE Department (
    DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE `Position` (
    PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL
);

CREATE TABLE `Account` (
    AccountID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Username VARCHAR(50) NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
);

CREATE TABLE `Group` (
    GroupID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    GroupName VARCHAR(50) NOT NULL,
    CreatorID INT UNSIGNED, 
    CreateDate DATETIME DEFAULT NOW(),

    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE GroupAccount (
    GroupID INT UNSIGNED, 
    AccountID INT UNSIGNED,
    JoinDate DATETIME DEFAULT NOW(),

    PRIMARY KEY (GroupID, AccountID),
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

CREATE TABLE TypeQuestion (
    TypeID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    TypeName ENUM('Essay', 'Multiple-Choice')
);

CREATE TABLE CategoryQuestion (
    CategoryID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Question (
    QuestionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    Content VARCHAR(255) NOT NULL,
    CategoryID INT UNSIGNED,
    TypeID INT UNSIGNED, 
    CreatorID INT UNSIGNED,
    CreateDate DATETIME DEFAULT NOW(),

    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE Answer (
    AnswerID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content VARCHAR(255) NOT NULL,
    QuestionID INT UNSIGNED, 
    isCorrect BOOLEAN,

    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

CREATE TABLE Exam ( 
    ExamID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    `Code` VARCHAR(10) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    CategoryID INT UNSIGNED, 
    Duration SMALLINT UNSIGNED NOT NULL, 
    CreatorID INT UNSIGNED, 
    CreateDate DATETIME DEFAULT NOW(),

    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

CREATE TABLE ExamQuestion (
    ExamID INT UNSIGNED,
    QuestionID INT UNSIGNED,

    PRIMARY KEY (ExamID, QuestionID),

    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO Department (DepartmentName)
VALUES 
                        ('Product Development'),
                        ('Engineering'),
                        ('Design'),
                        ('Marketing'),
                        ('Sales'),
                        ('Customer Support'),
                        ('HR'),
                        ('Finance'),
                        ('Legal'),
                        ('Project');

INSERT INTO `Position` (PositionName) 
VALUES 
                        ('Dev'),
                        ('Test'),
                        ('Scrum Master'),
                        ('PM');

INSERT INTO `Account`(Email, Username, FullName, DepartmentID, PositionID) 
VALUES 
                    ('binhhoang@gmail.com','binhdev', 'Hoàng Thanh Bình', 1, 1), 
                    ('thienbao@gmail.com', 'baotester', 'Hoàng Thiên Bảo', 1, 2),
                    ('qp@gmail.com', 'qp', 'Nguyễn Quỳnh Phương', 10, 3), 
                    ('tb@gmail.com', 'tb',  'Hoàng Thiên Bình', 4, 3); 

INSERT INTO `Group` (GroupName, CreatorID)
VALUES 
                    ('Luvie project', 1), 
                    ('EnumSkin project', 3), 
                    ('Lavie project', 2), 
                    ('Unie project', 4);

INSERT INTO TypeQuestion (TypeName)
VALUES 
                        ('Essay'),
                        ('Multiple-Choice');

INSERT INTO CategoryQuestion (CategoryName)
VALUES 
                            ('Lập trình'),
                            ('Cơ sở dữ liệu'),
                            ('Mạng máy tính');

INSERT INTO Question (Content, CategoryID, TypeID, CreatorID)
VALUES 
                    ('Giải thích sự khác nhau giữa SQL và NoSQL.', 2, 1, 1),
                    ('Giao thức nào được sử dụng cho truyền thông bảo mật trên Internet?', 3, 2, 2),
                    ('Viết hàm đảo ngược chuỗi trong Java.', 1, 1, 3),
                    ('Câu lệnh SQL nào dùng để truy vấn dữ liệu?', 2, 2, 4);

INSERT INTO Answer (Content, QuestionID, isCorrect)
VALUES 
                    ('HTTPS', 2, TRUE),
                    ('HTTP', 2, FALSE),
                    ('FTP', 2, FALSE),
                    ('SELECT', 4, TRUE),
                    ('INSERT', 4, FALSE),
                    ('UPDATE', 4, FALSE);

INSERT INTO Exam (Code, Title, CategoryID, Duration, CreatorID)
VALUES 
                ('EX001', 'Cơ sở dữ liệu cơ bản', 2, 60, 1),
                ('EX002', 'Mạng máy tính cơ bản', 3, 45, 2),
                ('EX003', 'Lập trình Java', 1, 90, 3);

INSERT INTO ExamQuestion (ExamID, QuestionID)
VALUES 
                        (1, 4),
                        (2, 2),
                        (3, 3);

INSERT INTO GroupAccount (GroupID, AccountID)
VALUES 
                        (1, 1),
                        (1, 2),
                        (2, 3),
                        (2, 4),
                        (3, 1),
                        (4, 4);
