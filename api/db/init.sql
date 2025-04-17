-- Create UserAction table for tracking user behavior
CREATE TABLE IF NOT EXISTS UserAction (
    ActionID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50),
    ActionType ENUM('ADD', 'SAVE', 'VIEW', 'SHARE'),
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Username) REFERENCES User(Username)
);

-- Create TagRequest table for managing tag requests
CREATE TABLE IF NOT EXISTS TagRequest (
    RequestID INT AUTO_INCREMENT PRIMARY KEY,
    TagName VARCHAR(50) NOT NULL,
    RequestedBy VARCHAR(50),
    Status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    RequestDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RequestedBy) REFERENCES User(Username)
);

-- Create UserDemographics table for managing user groups
CREATE TABLE IF NOT EXISTS UserDemographics (
    DemographicID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50),
    GroupType ENUM('AGE', 'REGION', 'INTEREST', 'DIET'),
    GroupValue VARCHAR(50),
    FOREIGN KEY (Username) REFERENCES User(Username),
    UNIQUE KEY unique_user_group (Username, GroupType)
);

-- Insert sample data for testing
INSERT INTO UserAction (Username, ActionType, Timestamp)
SELECT 
    Username,
    CASE FLOOR(RAND() * 4)
        WHEN 0 THEN 'ADD'
        WHEN 1 THEN 'SAVE'
        WHEN 2 THEN 'VIEW'
        ELSE 'SHARE'
    END,
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 30) DAY)
FROM User
LIMIT 100;

INSERT INTO TagRequest (TagName, RequestedBy, Status)
VALUES 
    ('egg-free', 'james_okoro', 'PENDING'),
    ('kid-friendly', 'nina_patel', 'PENDING'),
    ('brunch', 'charlie_chen', 'PENDING');

INSERT INTO UserDemographics (Username, GroupType, GroupValue)
SELECT 
    Username,
    'AGE',
    CASE 
        WHEN Age < 25 THEN '18-24'
        WHEN Age < 35 THEN '25-34'
        ELSE '35-44'
    END
FROM User;

INSERT INTO UserDemographics (Username, GroupType, GroupValue)
SELECT 
    Username,
    'REGION',
    Region
FROM User; 