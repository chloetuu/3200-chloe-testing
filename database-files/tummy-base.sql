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

INSERT INTO User(Username, FirstName, LastName, Region, ActivityLevel, Age, InclusionStatus, Bio)
VAUES('soccermom123', 'Nina', 'Patel', 'Northeast', 100, 35, 'Active', 'I am a stay at home mom who has 3 children who have different dietary restrictions! Follow me to follow my journey :)')

function generateUsers(count = 50) {
  const firstNames = ['John', 'Emma', 'Michael', 'Sophia', 'William', 'Olivia', 'James', 'Ava', 'Benjamin', 'Isabella',
                      'Lucas', 'Mia', 'Henry', 'Charlotte', 'Alexander', 'Amelia', 'Daniel', 'Harper', 'Matthew', 'Evelyn',
                      'Samuel', 'Abigail', 'David', 'Emily', 'Joseph', 'Elizabeth', 'Carter', 'Sofia', 'Owen', 'Madison',
                      'Wyatt', 'Scarlett', 'Jack', 'Victoria', 'Luke', 'Aria', 'Jayden', 'Grace', 'Dylan', 'Chloe',
                      'Ethan', 'Camila', 'Levi', 'Penelope', 'Isaac', 'Riley', 'Gabriel', 'Layla', 'Julian', 'Zoey'];
 
  const lastNames = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez',
                     'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin',
                     'Lee', 'Perez', 'Thompson', 'White', 'Harris', 'Sanchez', 'Clark', 'Ramirez', 'Lewis', 'Robinson',
                     'Walker', 'Young', 'Allen', 'King', 'Wright', 'Scott', 'Torres', 'Nguyen', 'Hill', 'Flores',
                     'Green', 'Adams', 'Nelson', 'Baker', 'Hall', 'Rivera', 'Campbell', 'Mitchell', 'Carter', 'Roberts'];
 
  const regions = ['North America', 'Europe', 'Asia', 'South America', 'Africa', 'Australia', 'Middle East'];
  const activityLevels = ['Sedentary', 'Light', 'Moderate', 'Active', 'Very Active'];
  const bioPhrases = [
    'Passionate about healthy eating',
    'Food enthusiast and home chef',
    'Looking for quick and nutritious recipes',
    'Exploring international cuisines',
    'On a journey to better eating habits',
    'Meal prep enthusiast',
    'Loves discovering new flavors',
    'Foodie with a knack for improvisation',
    'Nutrition-focused cooking advocate',
    'Experimenting with sustainable food choices'
  ];
 
  let users = [];
  const usedUsernames = new Set();
 
  for (let i = 0; i < count; i++) {
    const firstName = randomElement(firstNames);
    const lastName = randomElement(lastNames);
    let username = (firstName.toLowerCase() + lastName.toLowerCase() + randomInt(1, 999)).substring(0, 50);
   
    // Ensure unique usernames
    while (usedUsernames.has(username)) {
      username = (firstName.toLowerCase() + lastName.toLowerCase() + randomInt(1, 9999)).substring(0, 50);
    }
    usedUsernames.add(username);
   
    users.push({
      Username: username,
      FirstName: firstName,
      LastName: lastName,
      Region: randomElement(regions),
      ActivityLevel: randomElement(activityLevels),
      Age: randomInt(18, 80),
      InclusionStatus: randomBoolean(),
      Bio: randomElement(bioPhrases) + '. ' + randomElement(bioPhrases)
    });
  }
 
  return users;
}

// Generate Tag data (30 tags)
function generateTags(count = 30) {
  const cuisines = ['Italian', 'Chinese', 'Mexican', 'Indian', 'French', 'Japanese', 'Thai', 'Greek', 'Spanish', 'American',
                    'Lebanese', 'Korean', 'Turkish', 'Vietnamese', 'Brazilian', 'Moroccan', 'Ethiopian', 'German', 'British', 'Caribbean'];
 
  const allergies = ['Gluten-Free', 'Dairy-Free', 'Nut-Free', 'Egg-Free', 'Soy-Free', 'Shellfish-Free', 'Fish-Free', 'Wheat-Free', 'Sesame-Free', 'None'];
 
  const mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack', 'Dessert', 'Appetizer', 'Soup', 'Salad', 'Main Course', 'Side Dish'];
 
  let tags = [];
 
  for (let i = 1; i <= count; i++) {
    tags.push({
      TagID: i,
      Cuisine: i <= 20 ? cuisines[i-1] : null,
      Allergy: i > 20 && i <= 30 ? allergies[i-21] : null,
      MealType: i > 30 && i <= 40 ? mealTypes[i-31] : null
    });
  }
 
  return tags;
}

// Generate Meal data (45 meals)
function generateMeals(count = 45) {
  const mealNames = [
    'Spaghetti Carbonara', 'Chicken Tikka Masala', 'Beef Tacos', 'Vegetable Stir Fry', 'French Onion Soup',
    'Sushi Rolls', 'Pad Thai', 'Greek Salad', 'Paella', 'Cheeseburger', 'Falafel Wrap', 'Bibimbap',
    'Turkish Kebab', 'Pho Soup', 'Feijoada', 'Moroccan Tagine', 'Doro Wat', 'Schnitzel', 'Fish and Chips',
    'Jerk Chicken', 'Lasagna', 'Kung Pao Chicken', 'Enchiladas', 'Butter Chicken', 'Coq au Vin',
    'Tempura', 'Green Curry', 'Moussaka', 'Gazpacho', 'Mac and Cheese', 'Tabbouleh', 'Bulgogi',
    'Baklava', 'Fresh Spring Rolls', 'Moqueca', 'Couscous', 'Injera with Wat', 'Sauerbraten',
    'Shepherd's Pie', 'Coconut Rice and Beans', 'Risotto', 'Sweet and Sour Pork', 'Chilaquiles',
    'Samosas', 'Ratatouille'
  ];
 
  const difficulties = ['Easy', 'Medium', 'Hard'];
 
  let meals = [];
  const startDate = new Date(2023, 0, 1);
  const endDate = new Date();
 
  for (let i = 1; i <= count; i++) {
    const prepTime = randomInt(5, 60);
    const cookTime = randomInt(10, 120);
   
    meals.push({
      RecipeID: i,
      Name: mealNames[i-1] || `Recipe ${i}`,
      DateCreated: formatDate(randomDate(startDate, endDate)),
      PrepTime: prepTime,
      CookTime: cookTime,
      Difficulty: randomElement(difficulties),
      Ingredients: `Ingredient 1, Ingredient 2, Ingredient 3, Ingredient 4, Ingredient 5 for recipe ${i}`,
      Instructions: `Step 1: Do this\nStep 2: Do that\nStep 3: Finish cooking for recipe ${i}`,
      FavoriteStatus: randomBoolean()
    });
  }
 
  return meals;
}

// Generate Meal_Tag associations (75 associations)
function generateMealTags(meals, tags, count = 75) {
  let mealTags = [];
  const usedPairs = new Set();
 
  for (let i = 0; i < count; i++) {
    const recipeID = randomInt(1, meals.length);
    const tagID = randomInt(1, tags.length);
    const pair = `${recipeID}-${tagID}`;
   
    if (!usedPairs.has(pair)) {
      usedPairs.add(pair);
      mealTags.push({
        RecipeID: recipeID,
        TagID: tagID
      });
    } else {
      i--; // Try again
    }
  }
 
  return mealTags;
}

// Generate Blog data (30 blogs)
function generateBlogs(users, meals, count = 30) {
  const blogTitles = [
    'My Favorite Summer Recipe', 'How to Master Italian Cooking', 'Quick Weeknight Dinners',
    'Baking Tips for Beginners', 'Healthy Meal Prep Ideas', 'Cooking with Seasonal Ingredients',
    'International Cuisine at Home', 'Budget-Friendly Recipes', 'Vegan Alternatives for Everyone',
    'Cooking with Kids', 'Advanced Techniques for Home Chefs', 'My Food Journey',
    'Restaurant-Style Recipes', 'Holiday Meal Planning', 'Breakfast Ideas for Busy Mornings',
    'Comfort Food Classics', 'Desserts to Impress', 'Grilling Tips and Tricks',
    'Sustainable Cooking Practices', 'One-Pot Meal Wonders', 'Spices and Herbs Guide',
    'Traditional Family Recipes', 'Cooking Without Waste', 'Dinner Party Menu Ideas',
    'Food Photography Tips', 'Kitchen Equipment Essentials', 'Cooking for Special Diets',
    'Fusion Cuisine Experiments', 'Meal Planning for the Week', 'My Culinary Disasters and Triumphs'
  ];
 
  let blogs = [];
  const startDate = new Date(2023, 0, 1);
  const endDate = new Date();
 
  for (let i = 1; i <= count; i++) {
    blogs.push({
      BlogID: i,
      PublishDate: formatDateTime(randomDate(startDate, endDate)),
      Content: `This is the content for blog post ${i}. It contains information about cooking, recipes, and food experiences.`,
      Title: blogTitles[i-1] || `Blog Post ${i}`,
      Username: users[randomInt(0, users.length - 1)].Username,
      RecipeID: randomInt(1, meals.length)
    });
  }
 
  return blogs;
}

// Generate Blog_Meal associations (40 associations)
function generateBlogMeals(blogs, meals, count = 40) {
  let blogMeals = [];
  const usedPairs = new Set();
 
  for (let i =.0; i < count; i++) {
    const blogID = randomInt(1, blogs.length);
    const recipeID = randomInt(1, meals.length);
    const pair = `${blogID}-${recipeID}`;
   
    if (!usedPairs.has(pair)) {
      usedPairs.add(pair);
      blogMeals.push({
        BlogID: blogID,
        RecipeID: recipeID
      });
    } else {
      i--; // Try again
    }
  }
 
  return blogMeals;
}

// Generate Saved_Meals associations (60 associations)
function generateSavedMeals(users, meals, count = 60) {
  let savedMeals = [];
  const usedPairs = new Set();
 
  for (let i = 0; i < count; i++) {
    const username = users[randomInt(0, users.length - 1)].Username;
    const recipeID = randomInt(1, meals.length);
    const pair = `${username}-${recipeID}`;
   
    if (!usedPairs.has(pair)) {
      usedPairs.add(pair);
      savedMeals.push({
        Username: username,
        RecipeID: recipeID
      });
    } else {
      i--; // Try again
    }
  }
 
  return savedMeals;
}

// Generate Added_Meals associations (60 associations)
function generateAddedMeals(users, meals, count = 60) {
  let addedMeals = [];
  const usedPairs = new Set();
 
  for (let i = 0; i < count; i++) {
    const username = users[randomInt(0, users.length - 1)].Username;
    const recipeID = randomInt(1, meals.length);
    const pair = `${username}-${recipeID}`;
   
    if (!usedPairs.has(pair)) {
      usedPairs.add(pair);
      addedMeals.push({
        Username: username,
        RecipeID: recipeID
      });
    } else {
      i--; // Try again
    }
  }
 
  return addedMeals;
}

// Generate DemographicGroupData (15 groups)
function generateDemographicGroups(count = 15) {
  const groupTypes = ['Age', 'Gender', 'Income', 'Education', 'Occupation'];
  const groupValues = {
    'Age': ['18-24', '25-34', '35-44', '45-54', '55-64', '65+'],
    'Gender': ['Male', 'Female', 'Non-binary', 'Other'],
    'Income': ['Low', 'Medium', 'High', 'Very High'],
    'Education': ['High School', 'Associates', 'Bachelors', 'Masters', 'Doctorate'],
    'Occupation': ['Student', 'Professional', 'Service', 'Management', 'Retired', 'Other']
  };
 
  let demographicGroups = [];
 
  for (let i = 1; i <= count; i++) {
    const groupType = groupTypes[Math.floor((i-1) / 3)];
    const possibleValues = groupValues[groupType];
    const valueIndex = (i-1) % possibleValues.length;
   
    demographicGroups.push({
      GroupID: i,
      GroupType: groupType,
      GroupValue: possibleValues[valueIndex]
    });
  }
 
  return demographicGroups;
}

// Generate UserDemographic associations (75 associations)
function generateUserDemographics(users, demographicGroups, count = 75) {
  let userDemographics = [];
  const usedPairs = new Set();
 
  for (let i = 0; i < count; i++) {
    const userID = users[randomInt(0, users.length - 1)].Username;
    const groupID = randomInt(1, demographicGroups.length);
    const pair = `${userID}-${groupID}`;
   
    if (!usedPairs.has(pair)) {
      usedPairs.add(pair);
      userDemographics.push({
        UserID: userID,
        GroupID: groupID
      });
    } else {
      i--; // Try again
    }
  }
 
  return userDemographics;
}

// Generate CategoryData (10 categories)
function generateCategories(count = 10) {
  const categoryNames = ['Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Snack', 'Appetizer', 'Main Course', 'Side Dish', 'Drink', 'Bakery'];
 
  let categories = [];
 
  for (let i = 1; i <= count; i++) {
    categories.push({
      CategoryID: i,
      Name: categoryNames[i-1] || `Category ${i}`
    });
  }
 
  return categories;
}

// Generate RecipeData (40 recipes)
function generateRecipeData(categories, count = 40) {
  const recipeNames = [
    'Classic Pancakes', 'Avocado Toast', 'Chicken Soup', 'Chocolate Cake', 'Trail Mix',
    'Bruschetta', 'Grilled Salmon', 'Roasted Vegetables', 'Smoothie', 'Banana Bread',
    'Eggs Benedict', 'Caesar Salad', 'Beef Stew', 'Tiramisu', 'Protein Balls',
    'Caprese Skewers', 'Lasagna', 'Garlic Mashed Potatoes', 'Iced Coffee', 'Cinnamon Rolls',
    'Breakfast Burrito', 'Poke Bowl', 'Chicken Parmesan', 'Apple Pie', 'Hummus and Veggies',
    'Stuffed Mushrooms', 'Butter Chicken', 'Sweet Potato Fries', 'Lemonade', 'Sourdough Bread',
    'French Toast', 'Greek Salad', 'Chili Con Carne', 'Cheesecake', 'Popcorn',
    'Shrimp Cocktail', 'Beef Wellington', 'Coleslaw', 'Matcha Latte', 'Croissants'
  ];
 
  let recipes = [];
 
  for (let i = 1; i <= count; i++) {
    recipes.push({
      RecipeID: i,
      Name: recipeNames[i-1] || `Recipe Data ${i}`,
      SavedStatus: randomBoolean(),
      CategoryID: randomInt(1, categories.length),
      ViewCount: randomInt(0, 10000)
    });
  }
 
  return recipes;
}

// Generate Interaction data (80 interactions)
function generateInteractions(users, recipeData, count = 80) {
  const interactionTypes = ['View', 'Save', 'Rate', 'Comment', 'Share'];
 
  let interactions = [];
  const startDate = new Date(2023, 0, 1);
  const endDate = new Date();
 
  for (let i = 1; i <= count; i++) {
    interactions.push({
      InteractionID: i,
      UserID: users[randomInt(0, users.length - 1)].Username,
      RecipeID: randomInt(1, recipeData.length),
      InteractionType: randomElement(interactionTypes),
      Timestamp: formatDateTime(randomDate(startDate, endDate))
    });
  }
 
  return interactions;
}

// Generate LogEntry data (25 logs)
function generateLogEntries(count = 25) {
  const errorMessages = [
    'Database connection failed', 'Query timeout', 'Invalid input detected',
    'Authentication error', 'Permission denied', 'Resource not found',
    'Data validation failed', 'API rate limit exceeded', 'Service unavailable',
    'Memory allocation error'
  ];
 
  const severityLevels = ['Info', 'Warning', 'Error', 'Critical'];
  const sources = ['Web Server', 'Database', 'API Gateway', 'Authentication Service', 'Recipe Service'];
 
  let logEntries = [];
  const startDate = new Date(2023, 0, 1);
  const endDate = new Date();
 
  for (let i = 1; i <= count; i++) {
    logEntries.push({
      LogID: i,
      Timestamp: formatDateTime(randomDate(startDate, endDate)),
      ErrorMessage: randomElement(errorMessages),
      SeverityLevel: randomElement(severityLevels),
      Source: randomElement(sources),
      Details: `Detailed information about log entry ${i}`
    });
  }
 
  return logEntries;
}

// Generate IssueReport data (15 issues)
function generateIssueReports(count = 15) {
  const reporters = ['System', 'UserFeedback', 'Admin', 'DevTeam', 'QA'];
  const statuses = ['Open', 'In Progress', 'Resolved', 'Closed', 'Reopened'];
 
  let issueReports = [];
  const startDate = new Date(2023, 0, 1);
  const endDate = new Date();
 
  for (let i = 1; i <= count; i++) {
    issueReports.push({
      IssueID: i,
      Reports: `Report details for issue ${i}`,
      ReportedBy: randomElement(reporters),
      Description: `Description of issue ${i}`,
      Status: randomElement(statuses),
      Timestamp: formatDateTime(randomDate(startDate, endDate))
    });
  }
 
  return issueReports;
}

// Generate LogEntry_IssueReport associations (20 associations)
function generateLogIssueReports(logEntries, issueReports, count = 20) {
  let logIssueReports = [];
  const usedPairs = new Set();
 
  for (let i = 0; i < count; i++) {
    const logID = randomInt(1, logEntries.length);
    const issueID = randomInt(1, issueReports.length);
    const pair = `${logID}-${issueID}`;
   
    if (!usedPairs.has(pair)) {
      usedPairs.add(pair);
      logIssueReports.push({
        LogID: logID,
        IssueID: issueID
      });
    } else {
      i--; // Try again
    }
  }
 
  return logIssueReports;
}

// Generate Alert data (20 alerts)
function generateAlerts(logEntries, users, count = 20) {
  const alertTypes = ['System', 'Security', 'Performance', 'Error', 'Warning'];
  const statuses = ['New', 'Acknowledged', 'In Progress', 'Resolved', 'Closed'];
 
  let alerts = [];
  const startDate = new Date(2023, 0, 1);
  const endDate = new Date();
 
  for (let i = 1; i <= count; i++) {
    alerts.push({
      AlertID: i,
      LogID: randomInt(1, logEntries.length),
      AssignedTo: users[randomInt(0, users.length - 1)].Username,
      Timestamp: formatDateTime(randomDate(startDate, endDate)),
      Type: randomElement(alertTypes),
      Status: randomElement(statuses)
    });
  }
 
  return alerts;
}

// Convert object array to CSV string
function objectArrayToCSV(data) {
  if (data.length === 0) return '';
 
  const headers = Object.keys(data[0]);
  const csvRows = [];
 
  // Add header row
  csvRows.push(headers.join(','));
 
  // Add data rows
  for (const row of data) {
    const values = headers.map(header => {
      const value = row[header];
      // Handle null values, strings with commas, and other special cases
      if (value === null || value === undefined) return '';
      if (typeof value === 'string' && (value.includes(',') || value.includes('"') || value.includes('\n'))) {
        return `"${value.replace(/"/g, '""')}"`;
      }
      return value;
    });
    csvRows.push(values.join(','));
  }
 
  return csvRows.join('\n');
}

// Generate all data and convert to CSV
function generateAllData() {
  // Generate the base data
  const users = generateUsers(50);
  const tags = generateTags(30);
  const meals = generateMeals(45);
  const demographicGroups = generateDemographicGroups(15);
  const categories = generateCategories(10);
  const recipeData = generateRecipeData(categories, 40);
  const logEntries = generateLogEntries(25);
  const issueReports = generateIssueReports(15);
 
  // Generate the relationship data
  const mealTags = generateMealTags(meals, tags, 75);
  const blogs = generateBlogs(users, meals, 30);
  const blogMeals = generateBlogMeals(blogs, meals, 40);
  const savedMeals = generateSavedMeals(users, meals, 60);
  const addedMeals = generateAddedMeals(users, meals, 60);
  const userDemographics = generateUserDemographics(users, demographicGroups, 75);
  const interactions = generateInteractions(users, recipeData, 80);
  const logIssueReports = generateLogIssueReports(logEntries, issueReports, 20);
  const alerts = generateAlerts(logEntries, users, 20);
 
  // Return all data as CSV strings
  return {
    User: objectArrayToCSV(users),
    Tag: objectArrayToCSV(tags),
    Meal: objectArrayToCSV(meals),
    Meal_Tag: objectArrayToCSV(mealTags),
    Blog: objectArrayToCSV(blogs),
    Blog_Meal: objectArrayToCSV(blogMeals),
    Saved_Meals: objectArrayToCSV(savedMeals),
    Added_Meals: objectArrayToCSV(addedMeals),
    DemographicGroupData: objectArrayToCSV(demographicGroups),
    UserDemographic: objectArrayToCSV(userDemographics),
    CategoryData: objectArrayToCSV(categories),
    RecipeData: objectArrayToCSV(recipeData),
    Interaction: objectArrayToCSV(interactions),
    LogEntry: objectArrayToCSV(logEntries),
    IssueReport: objectArrayToCSV(issueReports),
    LogEntry_IssueReport: objectArrayToCSV(logIssueReports),
    Alert: objectArrayToCSV(alerts)
  };
}

// Execute the data generation
const allCSVData = generateAllData();

// Print sample of each table
for (const [tableName, csvData] of Object.entries(allCSVData)) {
  const lines = csvData.split('\n');
  console.log(`\n=== ${tableName} (${lines.length - 1} rows) ===`);
  console.log(lines[0]); // Header
  console.log(lines.length > 1 ? lines[1] : 'No data'); // First data row if exists
  // Count total
}

// Total number of rows across all tables
const totalRows = Object.values(allCSVData)
  .reduce((sum, csv) => sum + csv.split('\n').length - 1, 0);

console.log(`\nTotal rows across all tables: ${totalRows}`);

// Export a combined CSV for demonstration
const combinedSample = `
# Tummy Database Mock Data
# Generated: ${new Date().toISOString()}
# Total Tables: ${Object.keys(allCSVData).length}
# Total Rows: ${totalRows}

USER TABLE SAMPLE:
${allCSVData.User.split('\n').slice(0, 6).join('\n')}

MEAL TABLE SAMPLE:
${allCSVData.Meal.split('\n').slice(0, 6).join('\n')}

TAG TABLE SAMPLE:
${allCSVData.Tag.split('\n').slice(0, 6).join('\n')}

BLOG TABLE SAMPLE:
${allCSVData.Blog.split('\n').slice(0, 6).join('\n')}

INTERACTION TABLE SAMPLE:
${allCSVData.Interaction.split('\n').slice(0, 6).join('\n')}
`;

console.log("\nGenerated mock data for Tummy database successfully!");
