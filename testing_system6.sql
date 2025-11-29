DROP DATABASE IF EXISTS Testing_System;
CREATE DATABASE Testing_System;
USE Testing_System;

CREATE TABLE Department (
    DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE `Position` (
    PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
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
-- SELECT data
-- get all list account 
SELECT * from `Account`;
-- Lấy AccountID, Email, FullName
SELECT AccountID, Email, FullName  from `Account`;  -- DISTINCT: loại bỏ những trường trùng VD: SELECT * DISTINCT(FullName) FROM `Account`

-- Lấy ra tất cả những Account  thuộc phòng ban số một
SELECT * FROM `Account` WHERE DepartmentID = 1 AND PositionID = 4 and 3 and 7 ; 									-- Các toán tử đi chung cùng where 
SELECT * FROM `Account` WHERE DepartmentID IN (1,2,4);
SELECT * FROM `Account` WHERE DepartmentID NOT IN (1,2,4);
SELECT * FROM `Account` WHERE DepartmentID NOT IN (1,2,3,4,5,6,7,8);
SELECT * FROM `Account` WHERE DepartmentID BETWEEN 1 AND 8;
SELECT * FROM `Account` WHERE CreateDate IS NULL; -- Lấy những bảng mà cái field đó rỗng
SELECT * FROM `Account` WHERE CreateDate < '2025-11-18 20:37:53';
-- Lấy tất cả bản ghi trong bảng Account bắt đầu bằng chữ N
SELECT * FROM `Account` WHERE FullName LIKE 'N%';                          -- LIKE: so sánh gàn đúng còn % nó là wildcard là dạng ký tự thay thế, ký tự gì cũng được, _ cũng là ký tự wildcard nó chỉ thay thế 1 ký tự
-- Lấy tất cả bản ghi trong bảng Account mà FullName có chữ thứ 2 là U
SELECT * FROM `Account` WHERE FullName LIKE '__G%';  					   

-- Thử đếm nhân viên phát. 
SELECT COUNT(*) FROM `Account`; -- COUNT(*) là đếm từng dòng, còn COUNT(1) nó chèn thêm 1 cột, full 1 luôn xong đếm, COUNT theo tên trường cũng được.











DROP TABLE IF EXISTS Student;
CREATE TABLE `Student`(
     Id		                    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	 Student_Name				VARCHAR(50) NOT NULL,
     Subject_Name		      	VARCHAR(50) NOT NULL,
     Point_Student				TINYINT
);

SELECT * FROM Student;

INSERT INTO Student (Student_Name, Subject_Name, Point_Student)
VALUES				('Name1',	'Sql', 		'7'),
					('Name2',	'Java', 	'8'),
                    ('Name3',	'Java', 	'9'),
                    ('Name4',	'Sql', 		'5'),
                    ('Name5',	'Java', 	'4'),
                    ('Name6',	'Spring', 	'5'),
                    ('Name7',	'Java', 	'8'),
                    ('Name8',	'Spring', 	'8'),
					('Name9',	'Sql', 	'5'),
                    ('Name10',	'Spring', 	'4'),
                    ('Name11',	'Sql', 	'5'),
                    ('Name12',	'Spring', 	'8'),
                    ('Name13',	'Sql', 	'8')
                    ;
SELECT max(Point_Student) FROM Student WHERE Subject_Name = 'Sql';
SELECT sum(Point_Student) from Student;
SELECT avg(Point_Student) from Student;



-- Q1 
SELECT 
    A.AccountID,
    A.FullName,
    D.DepartmentName
FROM `Account` A
JOIN Department D ON A.DepartmentID = D.DepartmentID;

-- Q2
SELECT *
FROM `Account`
WHERE CreateDate > '2010-12-20';

-- Q3
SELECT A.*
FROM Account A, Position P
WHERE A.PositionID = P.PositionID
  AND P.PositionName = 'Dev';

-- Q4 
SELECT DepartmentID, COUNT(*) AS SoNhanVien
FROM Account
GROUP BY DepartmentID
HAVING COUNT(*) > 3;

-- Q5
SELECT QuestionID, COUNT(*) AS Solan
FROM ExamQuestion
GROUP BY QuestionID
ORDER BY Solan DESC
LIMIT 1;

-- Q6
SELECT CategoryID, COUNT(*) AS SoCauHoi
FROM Question
GROUP BY CategoryID;

-- Question 1: Store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DELIMITER //
CREATE PROCEDURE GetAccountByDepartment(
    IN p_DepartmentName VARCHAR(50)
)
BEGIN
    SELECT A.AccountID, A.Email, A.Username, A.FullName, D.DepartmentName, P.PositionName
    FROM `Account` A
    JOIN Department D ON A.DepartmentID = D.DepartmentID
    JOIN `Position` P ON A.PositionID = P.PositionID
    WHERE D.DepartmentName = p_DepartmentName;
END //
DELIMITER ;

-- CALL GetAccountByDepartment('Engineering');


-- Question 2: Store để in ra số lượng account trong mỗi group
DELIMITER //
CREATE PROCEDURE GetAccountCountByGroup()
BEGIN
    SELECT G.GroupID, G.GroupName, COUNT(GA.AccountID) AS SoAccount
    FROM `Group` G
    LEFT JOIN GroupAccount GA ON G.GroupID = GA.GroupID
    GROUP BY G.GroupID, G.GroupName;
END //
DELIMITER ;

-- CALL GetAccountCountByGroup();


-- Question 3: Store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DELIMITER //
CREATE PROCEDURE CountQuestionByTypeInCurrentMonth()
BEGIN
    SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.QuestionID) AS SoCauHoi
    FROM TypeQuestion TQ
    LEFT JOIN Question Q ON TQ.TypeID = Q.TypeID
    WHERE MONTH(Q.CreateDate) = MONTH(CURDATE()) 
      AND YEAR(Q.CreateDate) = YEAR(CURDATE())
    GROUP BY TQ.TypeID, TQ.TypeName;
END //
DELIMITER ;

-- CALL CountQuestionByTypeInCurrentMonth();


-- Question 4: Store để trả ra id của type question có nhiều câu hỏi nhất
DELIMITER //
CREATE PROCEDURE GetTypeQuestionWithMostQuestions()
BEGIN
    SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.QuestionID) AS SoCauHoi
    FROM TypeQuestion TQ
    LEFT JOIN Question Q ON TQ.TypeID = Q.TypeID
    GROUP BY TQ.TypeID, TQ.TypeName
    ORDER BY SoCauHoi DESC
    LIMIT 1;
END //
DELIMITER ;

-- CALL GetTypeQuestionWithMostQuestions();


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DELIMITER //
CREATE PROCEDURE GetTypeQuestionNameWithMostQuestions()
BEGIN
    SELECT TQ.TypeName
    FROM TypeQuestion TQ
    LEFT JOIN Question Q ON TQ.TypeID = Q.TypeID
    GROUP BY TQ.TypeID, TQ.TypeName
    ORDER BY COUNT(Q.QuestionID) DESC
    LIMIT 1;
END //
DELIMITER ;

-- CALL GetTypeQuestionNameWithMostQuestions();


-- Question 6: Store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi hoặc user có username chứa chuỗi
DELIMITER //
CREATE PROCEDURE SearchGroupOrAccount(
    IN p_SearchString VARCHAR(50)
)
BEGIN
    SELECT 'Group' AS Type, GroupName AS Name, NULL AS Username, NULL AS Email
    FROM `Group`
    WHERE GroupName LIKE CONCAT('%', p_SearchString, '%')
    
    UNION ALL
    
    SELECT 'Account' AS Type, FullName AS Name, Username, Email
    FROM `Account`
    WHERE Username LIKE CONCAT('%', p_SearchString, '%');
END //
DELIMITER ;

-- CALL SearchGroupOrAccount('project');


-- Question 7: Store cho phép người dùng nhập vào fullName, email và tự động gán username, positionID, departmentID
DELIMITER //
CREATE PROCEDURE CreateNewAccount(
    IN p_FullName VARCHAR(100),
    IN p_Email VARCHAR(50)
)
BEGIN
    DECLARE v_Username VARCHAR(50);
    DECLARE v_PositionID TINYINT UNSIGNED;
    DECLARE v_DepartmentID TINYINT UNSIGNED;
    
    -- Tách email để tạo username (bỏ phần @mail)
    SET v_Username = SUBSTRING_INDEX(p_Email, '@', 1);
    
    -- Set default PositionID là Dev (ID = 1)
    SET v_PositionID = 1;
    
    -- Set default DepartmentID là phòng chờ (Project - ID = 10)
    SET v_DepartmentID = 10;
    
    -- Insert account mới
    INSERT INTO `Account` (Email, Username, FullName, DepartmentID, PositionID)
    VALUES (p_Email, v_Username, p_FullName, v_DepartmentID, v_PositionID);
    
    -- In ra kết quả
    SELECT 'Tạo tài khoản thành công!' AS Message,
           AccountID,
           Email,
           Username,
           FullName,
           (SELECT DepartmentName FROM Department WHERE DepartmentID = v_DepartmentID) AS DepartmentName,
           (SELECT PositionName FROM `Position` WHERE PositionID = v_PositionID) AS PositionName
    FROM `Account`
    WHERE Email = p_Email
    ORDER BY AccountID DESC
    LIMIT 1;
END //
DELIMITER ;

-- CALL CreateNewAccount('Nguyễn Văn A', 'nguyenvana@gmail.com');


-- Question 8: Store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi loại đó có content dài nhất
DELIMITER //
CREATE PROCEDURE GetLongestQuestionByType(
    IN p_TypeName VARCHAR(50)
)
BEGIN
    SELECT Q.QuestionID, Q.Content, TQ.TypeName, LENGTH(Q.Content) AS ContentLength
    FROM Question Q
    JOIN TypeQuestion TQ ON Q.TypeID = TQ.TypeID
    WHERE TQ.TypeName = p_TypeName
    ORDER BY LENGTH(Q.Content) DESC
    LIMIT 1;
END //
DELIMITER ;

-- CALL GetLongestQuestionByType('Essay');


-- Question 9: Store cho phép người dùng xóa exam dựa vào ID
DELIMITER //
CREATE PROCEDURE DeleteExamByID(
    IN p_ExamID INT UNSIGNED
)
BEGIN
    DECLARE v_ExamExists INT;
    
    -- Kiểm tra exam có tồn tại không
    SELECT COUNT(*) INTO v_ExamExists
    FROM Exam
    WHERE ExamID = p_ExamID;
    
    IF v_ExamExists = 0 THEN
        SELECT 'Exam không tồn tại!' AS Message;
    ELSE
        -- Xóa các câu hỏi trong exam trước
        DELETE FROM ExamQuestion
        WHERE ExamID = p_ExamID;
        
        -- Xóa exam
        DELETE FROM Exam
        WHERE ExamID = p_ExamID;
        
        SELECT 'Xóa exam thành công!' AS Message;
    END IF;
END //
DELIMITER ;

-- CALL DeleteExamByID(1);