DROP DATABASE IF EXISTS Tummy;
CREATE DATABASE Tummy;
USE Tummy;

-- Table: User
CREATE TABLE User (
    Username VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Region VARCHAR(50),
    ActivityLevel VARCHAR(50),
    Age INT,
    InclusionStatus BOOLEAN,
    Bio TEXT
);

-- Table: Follows 
CREATE TABLE Follows (
    follower_id VARCHAR(50),
    followee_id VARCHAR(50),
    follow_date DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES User(Username),
    FOREIGN KEY (followee_id) REFERENCES User(Username)
);

-- Table: Tag
CREATE TABLE Tag (
    TagID INT PRIMARY KEY,
    Cuisine VARCHAR(50),
    Allergy VARCHAR(50),
    MealType VARCHAR(50)
);

-- Table: Meal
CREATE TABLE Meal (
    RecipeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DateCreated DATE DEFAULT (CURRENT_DATE),
    PrepTime INT,
    CookTime INT,
    TotalTime INT GENERATED ALWAYS AS (PrepTime + CookTime) STORED,
    Difficulty ENUM('Easy', 'Medium', 'Hard') NOT NULL,
    Ingredients TEXT NOT NULL,
    Instructions TEXT NOT NULL,
    FavoriteStatus BOOLEAN DEFAULT FALSE
);

-- Table: Meal_Tag (Many-to-Many)
CREATE TABLE Meal_Tag (
    RecipeID INT,
    TagID INT,
    PRIMARY KEY (RecipeID, TagID),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID),
    FOREIGN KEY (TagID) REFERENCES Tag(TagID)
);

-- Table: Blog
CREATE TABLE Blog (
    BlogID INT PRIMARY KEY,
    PublishDate DATETIME,
    Content MEDIUMTEXT,
    Title VARCHAR(100),
    Username VARCHAR(50),
    RecipeID INT,
    FOREIGN KEY (Username) REFERENCES User(Username),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID)
);

-- Table: Blog_Meal (Many-to-Many)
CREATE TABLE Blog_Meal (
    BlogID INT,
    RecipeID INT,
    PRIMARY KEY (BlogID, RecipeID),
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID)
);

-- Table: Saved_Meals (Many-to-Many)
CREATE TABLE Saved_Meals (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID)
);

-- Table: Added_Meals (Many-to-Many)
CREATE TABLE Added_Meals (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID)
);

-- Table: DemographicGroupData
CREATE TABLE DemographicGroupData (
    GroupID INT PRIMARY KEY,
    GroupType VARCHAR(50),
    GroupValue VARCHAR(50)
);

-- Table: UserDemographic (Many-to-Many)
CREATE TABLE UserDemographic (
    UserID VARCHAR(50),
    GroupID INT,
    PRIMARY KEY (UserID, GroupID),
    FOREIGN KEY (UserID) REFERENCES User(Username),
    FOREIGN KEY (GroupID) REFERENCES DemographicGroupData(GroupID)
);

-- Table: CategoryData
CREATE TABLE CategoryData (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Table: RecipeData
CREATE TABLE RecipeData (
    RecipeID INT PRIMARY KEY,
    Name VARCHAR(100),
    SavedStatus BOOLEAN,
    CategoryID INT,
    ViewCount INT,
    FOREIGN KEY (CategoryID) REFERENCES CategoryData(CategoryID)
);

-- Table: Interaction
CREATE TABLE Interaction (
    InteractionID INT PRIMARY KEY,
    UserID VARCHAR(50),
    RecipeID INT,
    InteractionType VARCHAR(50),
    Timestamp DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(Username),
    FOREIGN KEY (RecipeID) REFERENCES RecipeData(RecipeID)
);

-- Table: LogEntry
CREATE TABLE LogEntry (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp DATETIME NOT NULL,
    ErrorMessage VARCHAR(255),
    SeverityLevel VARCHAR(50),
    Source VARCHAR(100),
    Details TEXT
);

-- Table: IssueReport
CREATE TABLE IssueReport (
    IssueID INT AUTO_INCREMENT PRIMARY KEY,
    Reports TEXT,
    ReportedBy VARCHAR(100),
    Description TEXT,
    Status VARCHAR(50),
    Timestamp DATETIME
);

-- Join Table: LogEntry_IssueReport (Many-to-Many)
CREATE TABLE LogEntry_IssueReport (
    LogID INT,
    IssueID INT,
    PRIMARY KEY (LogID, IssueID),
    FOREIGN KEY (LogID) REFERENCES LogEntry(LogID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (IssueID) REFERENCES IssueReport(IssueID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table: Alert
CREATE TABLE Alert (
    AlertID INT AUTO_INCREMENT PRIMARY KEY,
    LogID INT,
    AssignedTo VARCHAR(100),
    Timestamp DATETIME,
    Type VARCHAR(50),
    Status VARCHAR(50),
    FOREIGN KEY (LogID) REFERENCES LogEntry(LogID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (AssignedTo) REFERENCES User(Username)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

