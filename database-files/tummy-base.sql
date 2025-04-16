
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
    Bio TEXT
);

-- Table: Follows
CREATE TABLE Follows (
    follower_id VARCHAR(50),
    followee_id VARCHAR(50),
    follow_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (followee_id) REFERENCES User(Username) ON DELETE CASCADE
);

-- Table: Tag
CREATE TABLE Tag (
    TagID INT AUTO_INCREMENT PRIMARY KEY,
    Cuisine VARCHAR(50),
    Allergy VARCHAR(50),
    MealType VARCHAR(50)
);

-- Table: Meal
CREATE TABLE Meal (
    RecipeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DateCreated DATE DEFAULT (CURRENT_DATE),
    PrepTime INT,
    CookTime INT,
    TotalTime INT GENERATED ALWAYS AS (PrepTime + CookTime) STORED,
    Difficulty VARCHAR(20) NOT NULL,
    Ingredients TEXT NOT NULL,
    Instructions TEXT NOT NULL
);

-- Table: Meal_Tag (Many-to-Many)
CREATE TABLE Meal_Tag (
    RecipeID INT,
    TagID INT,
    PRIMARY KEY (RecipeID, TagID),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE,
    FOREIGN KEY (TagID) REFERENCES Tag(TagID) ON DELETE CASCADE
);

-- Table: Blog
CREATE TABLE Blog (
    BlogID INT AUTO_INCREMENT PRIMARY KEY,
    PublishDate DATETIME,
    Content MEDIUMTEXT,
    Title VARCHAR(100),
    Username VARCHAR(50),
    RecipeID INT,
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE SET NULL
);

-- Table: Blog_Meal (Many-to-Many)
CREATE TABLE Blog_Meal (
    BlogID INT,
    RecipeID INT,
    PRIMARY KEY (BlogID, RecipeID),
    FOREIGN KEY (BlogID) REFERENCES Blog(BlogID) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: Saved_Meals (Many-to-Many)
CREATE TABLE Saved_Meals (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: Favorites (Many-to-Many)
CREATE TABLE Favorites (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: Added_Meals (Many-to-Many)
CREATE TABLE Added_Meals (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: DemographicGroupData
CREATE TABLE DemographicGroupData (
    GroupID INT AUTO_INCREMENT PRIMARY KEY,
    GroupType VARCHAR(50),
    GroupValue VARCHAR(50)
);

-- Table: UserDemographic (Many-to-Many)
CREATE TABLE UserDemographic (
    Username VARCHAR(50),
    GroupID INT,
    PRIMARY KEY (Username, GroupID),
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (GroupID) REFERENCES DemographicGroupData(GroupID) ON DELETE CASCADE
);

-- Table: CategoryData
CREATE TABLE CategoryData (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Table: RecipeData
CREATE TABLE RecipeData (
    RecipeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    SavedStatus INT,
    CategoryID INT,
    ViewCount INT,
    FOREIGN KEY (CategoryID) REFERENCES CategoryData(CategoryID) ON DELETE SET NULL
);

-- Table: Interaction
CREATE TABLE Interaction (
    InteractionID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50),  # Changed from UserID
    RecipeID INT,
    InteractionType VARCHAR(50),
    Timestamp DATETIME,
    FOREIGN KEY (Username) REFERENCES User(Username) ON DELETE CASCADE,
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID) ON DELETE CASCADE
);

-- Table: LogEntry
CREATE TABLE LogEntry (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp DATETIME,
    ErrorMessage TEXT,
    SeverityLevel VARCHAR(20),
    Source VARCHAR(100),
    Details TEXT
);


-- Insert statements for table: User
INSERT INTO User (Username, FirstName, LastName, Region, ActivityLevel, Age, Bio) VALUES
('richardbird', 'Martha', 'Smith', 'California', 'High', 26, 'Form attack hear make one fly. Worry policy sea too ahead. Pressure somebody movement.'),
('harrelljennifer', 'April', 'Hamilton', 'Arkansas', 'High', 20, 'Take culture production election provide. Drug campaign suddenly fish girl.'),
('johnsonsteven', 'Rachel', 'Williams', 'California', 'High', 59, 'While investment follow wear. Mean move care play evidence response.'),
('zburton', 'Frank', 'Gould', 'Arizona', 'Medium', 63, 'Woman address grow meet visit. College despite yes card. Or project example long information.'),
('zacharymitchell', 'Nancy', 'Mitchell', 'Connecticut', 'Medium', 26, 'Fire first beautiful education us wear talk. Unit them act choice physical whatever.'),
('tzhang', 'Michael', 'Jackson', 'Delaware', 'Medium', 49, 'Manager through dinner. Us bed until road operation account worry. Expect time put challenge.'),
('ravenrobinson', 'Brian', 'Price', 'Tennessee', 'High', 62, 'Rate continue head third officer chair staff. We forward parent exactly.'),
('brendamathis', 'Heather', 'Gates', 'Delaware', 'Low', 41, 'Others learn institution what alone red. Marriage another happy. Six plan check nor southern.'),
('james41', 'Caitlin', 'Dixon', 'Nevada', 'Low', 37, 'Theory that market. School camera million within address that.'),
('victoria20', 'Suzanne', 'Williams', 'Alabama', 'Low', 65, 'Country herself throughout thought group relate cause arrive.'),
('tsmith', 'Maria', 'Chang', 'Maryland', 'High', 20, 'Perhaps last father author according special model. Stage able shake me resource.'),
('wilkinsjaime', 'Judy', 'Powell', 'Mississippi', 'Low', 38, 'Character option phone when. Spend game mean nor husband door generation with.'),
('zsanchez', 'Jonathan', 'Cortez', 'Colorado', 'Low', 60, 'Threat month both defense. Cultural lot often race.'),
('moorejason', 'Amy', 'Ortiz', 'Ohio', 'Low', 56, 'Position we player as carry. Former TV leader travel thus near alone.'),
('eric86', 'Brian', 'Mahoney', 'Georgia', 'Medium', 58, 'Yard compare low parent couple by reality. Would simple firm however indicate increase represent.'),
('michaelhamilton', 'Patricia', 'Hudson', 'Tennessee', 'Low', 42, 'Behind skin notice most. Chance capital loss outside trip. Month guess measure.'),
('deborah13', 'Aaron', 'Miller', 'Maine', 'Medium', 67, 'Fine recently win vote environment. Build second happy chance arrive.'),
('rojasandrew', 'Juan', 'Brown', 'North Carolina', 'Low', 30, 'Congress present last accept answer. Like prepare particular.'),
('carmenjohnson', 'Summer', 'Solis', 'Kentucky', 'Medium', 26, 'Let religious few democratic.'),
('brianblack', 'David', 'Pena', 'Hawaii', 'High', 69, 'Card national edge east build office three. Others executive create down.'),
('barbaramorris', 'Rebecca', 'Steele', 'Wyoming', 'Medium', 29, 'Good writer message staff. Run yeah low play century occur teach collection.'),
('larry22', 'Tammy', 'Walker', 'Idaho', 'Medium', 56, 'Manage present nation box director indeed. Necessary example sit. Manage fire fill.'),
('randy74', 'Patricia', 'Ball', 'Missouri', 'High', 35, 'Between ability soldier. Note simple figure personal coach generation accept again.'),
('edwardjordan', 'Rodney', 'Clements', 'Delaware', 'High', 48, 'Professional bed his big. Institution rich for.
Wonder near play may.'),
('skelley', 'Joseph', 'Phillips', 'Nebraska', 'Medium', 22, 'Present box source data threat. Us not land teacher better police important.'),
('chenlaura', 'Steven', 'Anderson', 'Missouri', 'Low', 19, 'Window expect but write feeling. Employee research create sound. Book exist beautiful hot news.'),
('kimberlysharp', 'Lauren', 'Smith', 'Montana', 'Medium', 47, 'Traditional treatment tough bad both. Speech there these war store country.'),
('kevinbaird', 'Lisa', 'Phillips', 'Nebraska', 'High', 18, 'We hard approach ok everyone. Baby reason trade action.'),
('xchase', 'Joyce', 'Torres', 'Hawaii', 'Medium', 51, 'Different myself argue machine adult.'),
('daniel73', 'Mark', 'Larson', 'Illinois', 'High', 68, 'Agent wrong project lay. Low car risk leg. Work source although participant.'),
('eholder', 'Jorge', 'Williams', 'Tennessee', 'Low', 23, 'Bank determine green. Move if force eight any road phone base.'),
('ryandiaz', 'Dominique', 'Hart', 'California', 'Low', 49, 'While table story under check build thank. Fight face time rate wall trial page.'),
('emily08', 'Joseph', 'Nichols', 'South Dakota', 'High', 60, 'Stand school lot point. Day election few piece throughout enter also.'),
('melanievelazquez', 'Stephen', 'Jordan', 'Utah', 'Low', 47, 'Avoid result image hear later again gas try. Major that career doctor sell.'),
('anthony91', 'Mark', 'Taylor', 'Tennessee', 'High', 29, 'Go member economic whole thus. Light back financial too moment.');

-- Insert statements for table: Tag
INSERT INTO Tag (Cuisine, Allergy, MealType) VALUES
('Italian', 'Gluten', 'Breakfast'),
('Italian', 'Gluten', 'Lunch'),
('Italian', 'Gluten', 'Dinner'),
('Italian', 'Gluten', 'Dessert'),
('Italian', 'Gluten', 'Snack'),
('Italian', 'Dairy', 'Breakfast'),
('Italian', 'Dairy', 'Lunch'),
('Italian', 'Dairy', 'Dinner'),
('Italian', 'Dairy', 'Dessert'),
('Italian', 'Dairy', 'Snack'),
('Italian', 'Nuts', 'Breakfast'),
('Italian', 'Nuts', 'Lunch'),
('Italian', 'Nuts', 'Dinner'),
('Italian', 'Nuts', 'Dessert'),
('Italian', 'Nuts', 'Snack'),
('Italian', 'Shellfish', 'Breakfast'),
('Italian', 'Shellfish', 'Lunch'),
('Italian', 'Shellfish', 'Dinner'),
('Italian', 'Shellfish', 'Dessert'),
('Italian', 'Shellfish', 'Snack'),
('Italian', 'Eggs', 'Breakfast'),
('Italian', 'Eggs', 'Lunch'),
('Italian', 'Eggs', 'Dinner'),
('Italian', 'Eggs', 'Dessert'),
('Italian', 'Eggs', 'Snack'),
('Italian', 'Soy', 'Breakfast'),
('Italian', 'Soy', 'Lunch'),
('Italian', 'Soy', 'Dinner'),
('Italian', 'Soy', 'Dessert'),
('Italian', 'Soy', 'Snack'),
('Mexican', 'Gluten', 'Breakfast'),
('Mexican', 'Gluten', 'Lunch'),
('Mexican', 'Gluten', 'Dinner'),
('Mexican', 'Gluten', 'Dessert'),
('Mexican', 'Gluten', 'Snack'),
('Mexican', 'Dairy', 'Breakfast'),
('Mexican', 'Dairy', 'Lunch'),
('Mexican', 'Dairy', 'Dinner'),
('Mexican', 'Dairy', 'Dessert'),
('Mexican', 'Dairy', 'Snack'),
('Mexican', 'Nuts', 'Breakfast'),
('Mexican', 'Nuts', 'Lunch'),
('Mexican', 'Nuts', 'Dinner'),
('Mexican', 'Nuts', 'Dessert'),
('Mexican', 'Nuts', 'Snack'),
('Mexican', 'Shellfish', 'Breakfast'),
('Mexican', 'Shellfish', 'Lunch'),
('Mexican', 'Shellfish', 'Dinner'),
('Mexican', 'Shellfish', 'Dessert'),
('Mexican', 'Shellfish', 'Snack'),
('Mexican', 'Eggs', 'Breakfast'),
('Mexican', 'Eggs', 'Lunch'),
('Mexican', 'Eggs', 'Dinner'),
('Mexican', 'Eggs', 'Dessert'),
('Mexican', 'Eggs', 'Snack'),
('Mexican', 'Soy', 'Breakfast'),
('Mexican', 'Soy', 'Lunch'),
('Mexican', 'Soy', 'Dinner'),
('Mexican', 'Soy', 'Dessert'),
('Mexican', 'Soy', 'Snack'),
('Chinese', 'Gluten', 'Breakfast'),
('Chinese', 'Gluten', 'Lunch'),
('Chinese', 'Gluten', 'Dinner'),
('Chinese', 'Gluten', 'Dessert'),
('Chinese', 'Gluten', 'Snack'),
('Chinese', 'Dairy', 'Breakfast'),
('Chinese', 'Dairy', 'Lunch'),
('Chinese', 'Dairy', 'Dinner'),
('Chinese', 'Dairy', 'Dessert'),
('Chinese', 'Dairy', 'Snack'),
('Chinese', 'Nuts', 'Breakfast'),
('Chinese', 'Nuts', 'Lunch'),
('Chinese', 'Nuts', 'Dinner'),
('Chinese', 'Nuts', 'Dessert'),
('Chinese', 'Nuts', 'Snack'),
('Chinese', 'Shellfish', 'Breakfast'),
('Chinese', 'Shellfish', 'Lunch'),
('Chinese', 'Shellfish', 'Dinner'),
('Chinese', 'Shellfish', 'Dessert'),
('Chinese', 'Shellfish', 'Snack'),
('Chinese', 'Eggs', 'Breakfast'),
('Chinese', 'Eggs', 'Lunch'),
('Chinese', 'Eggs', 'Dinner'),
('Chinese', 'Eggs', 'Dessert'),
('Chinese', 'Eggs', 'Snack'),
('Chinese', 'Soy', 'Breakfast'),
('Chinese', 'Soy', 'Lunch'),
('Chinese', 'Soy', 'Dinner'),
('Chinese', 'Soy', 'Dessert'),
('Chinese', 'Soy', 'Snack'),
('Indian', 'Gluten', 'Breakfast'),
('Indian', 'Gluten', 'Lunch'),
('Indian', 'Gluten', 'Dinner'),
('Indian', 'Gluten', 'Dessert'),
('Indian', 'Gluten', 'Snack'),
('Indian', 'Dairy', 'Breakfast'),
('Indian', 'Dairy', 'Lunch'),
('Indian', 'Dairy', 'Dinner'),
('Indian', 'Dairy', 'Dessert'),
('Indian', 'Dairy', 'Snack'),
('Indian', 'Nuts', 'Breakfast'),
('Indian', 'Nuts', 'Lunch'),
('Indian', 'Nuts', 'Dinner'),
('Indian', 'Nuts', 'Dessert'),
('Indian', 'Nuts', 'Snack'),
('Indian', 'Shellfish', 'Breakfast'),
('Indian', 'Shellfish', 'Lunch'),
('Indian', 'Shellfish', 'Dinner'),
('Indian', 'Shellfish', 'Dessert'),
('Indian', 'Shellfish', 'Snack'),
('Indian', 'Eggs', 'Breakfast'),
('Indian', 'Eggs', 'Lunch'),
('Indian', 'Eggs', 'Dinner'),
('Indian', 'Eggs', 'Dessert'),
('Indian', 'Eggs', 'Snack'),
('Indian', 'Soy', 'Breakfast'),
('Indian', 'Soy', 'Lunch'),
('Indian', 'Soy', 'Dinner'),
('Indian', 'Soy', 'Dessert'),
('Indian', 'Soy', 'Snack'),
('Japanese', 'Gluten', 'Breakfast'),
('Japanese', 'Gluten', 'Lunch'),
('Japanese', 'Gluten', 'Dinner'),
('Japanese', 'Gluten', 'Dessert'),
('Japanese', 'Gluten', 'Snack'),
('Japanese', 'Dairy', 'Breakfast'),
('Japanese', 'Dairy', 'Lunch'),
('Japanese', 'Dairy', 'Dinner'),
('Japanese', 'Dairy', 'Dessert'),
('Japanese', 'Dairy', 'Snack'),
('Japanese', 'Nuts', 'Breakfast'),
('Japanese', 'Nuts', 'Lunch'),
('Japanese', 'Nuts', 'Dinner'),
('Japanese', 'Nuts', 'Dessert'),
('Japanese', 'Nuts', 'Snack'),
('Japanese', 'Shellfish', 'Breakfast'),
('Japanese', 'Shellfish', 'Lunch'),
('Japanese', 'Shellfish', 'Dinner'),
('Japanese', 'Shellfish', 'Dessert'),
('Japanese', 'Shellfish', 'Snack'),
('Japanese', 'Eggs', 'Breakfast'),
('Japanese', 'Eggs', 'Lunch'),
('Japanese', 'Eggs', 'Dinner'),
('Japanese', 'Eggs', 'Dessert'),
('Japanese', 'Eggs', 'Snack'),
('Japanese', 'Soy', 'Breakfast'),
('Japanese', 'Soy', 'Lunch'),
('Japanese', 'Soy', 'Dinner'),
('Japanese', 'Soy', 'Dessert'),
('Japanese', 'Soy', 'Snack'),
('American', 'Gluten', 'Breakfast'),
('American', 'Gluten', 'Lunch'),
('American', 'Gluten', 'Dinner'),
('American', 'Gluten', 'Dessert'),
('American', 'Gluten', 'Snack'),
('American', 'Dairy', 'Breakfast'),
('American', 'Dairy', 'Lunch'),
('American', 'Dairy', 'Dinner'),
('American', 'Dairy', 'Dessert'),
('American', 'Dairy', 'Snack'),
('American', 'Nuts', 'Breakfast'),
('American', 'Nuts', 'Lunch'),
('American', 'Nuts', 'Dinner'),
('American', 'Nuts', 'Dessert'),
('American', 'Nuts', 'Snack'),
('American', 'Shellfish', 'Breakfast'),
('American', 'Shellfish', 'Lunch'),
('American', 'Shellfish', 'Dinner'),
('American', 'Shellfish', 'Dessert'),
('American', 'Shellfish', 'Snack'),
('American', 'Eggs', 'Breakfast'),
('American', 'Eggs', 'Lunch'),
('American', 'Eggs', 'Dinner'),
('American', 'Eggs', 'Dessert'),
('American', 'Eggs', 'Snack'),
('American', 'Soy', 'Breakfast'),
('American', 'Soy', 'Lunch'),
('American', 'Soy', 'Dinner'),
('American', 'Soy', 'Dessert'),
('American', 'Soy', 'Snack'),
('Mediterranean', 'Gluten', 'Breakfast'),
('Mediterranean', 'Gluten', 'Lunch'),
('Mediterranean', 'Gluten', 'Dinner'),
('Mediterranean', 'Gluten', 'Dessert'),
('Mediterranean', 'Gluten', 'Snack'),
('Mediterranean', 'Dairy', 'Breakfast'),
('Mediterranean', 'Dairy', 'Lunch'),
('Mediterranean', 'Dairy', 'Dinner'),
('Mediterranean', 'Dairy', 'Dessert'),
('Mediterranean', 'Dairy', 'Snack'),
('Mediterranean', 'Nuts', 'Breakfast'),
('Mediterranean', 'Nuts', 'Lunch'),
('Mediterranean', 'Nuts', 'Dinner'),
('Mediterranean', 'Nuts', 'Dessert'),
('Mediterranean', 'Nuts', 'Snack'),
('Mediterranean', 'Shellfish', 'Breakfast'),
('Mediterranean', 'Shellfish', 'Lunch'),
('Mediterranean', 'Shellfish', 'Dinner'),
('Mediterranean', 'Shellfish', 'Dessert'),
('Mediterranean', 'Shellfish', 'Snack'),
('Mediterranean', 'Eggs', 'Breakfast'),
('Mediterranean', 'Eggs', 'Lunch'),
('Mediterranean', 'Eggs', 'Dinner'),
('Mediterranean', 'Eggs', 'Dessert'),
('Mediterranean', 'Eggs', 'Snack'),
('Mediterranean', 'Soy', 'Breakfast'),
('Mediterranean', 'Soy', 'Lunch'),
('Mediterranean', 'Soy', 'Dinner'),
('Mediterranean', 'Soy', 'Dessert'),
('Mediterranean', 'Soy', 'Snack');

-- Insert statements for table: Meal
INSERT INTO Meal (Name, DateCreated, PrepTime, CookTime, Difficulty, Ingredients, Instructions) VALUES
('Factor necessary.', '2023-04-01', 44, 44, 'Medium', 'Surface sell however cell idea interview pass. Bring economy floor or live up building.
Individual effect investment language social.', 'Lose example cover.
Whether activity soldier later everything.
Seven scene family evidence sometimes north might. Stay decision company owner together try write.
Become treatment region space movement event investment southern. Lot thank large cause TV system address. Center point avoid wind race.
Understand particular simple since really. During country image individual conference study. Capital table eight.'),
('Hour interest.', '2024-05-03', 49, 87, 'Hard', 'Bank eat affect space very receive remain down. Week girl national between support than teacher local.
Hope commercial technology teach idea police crime. Show change simple ten financial.', 'Hair five sometimes long clear million. Dark well no lawyer level student responsibility.
Give though use usually any. Provide entire stop decision.
Meeting material gun activity argue. Marriage daughter Congress none attention event. Their talk movement. Choice financial professor value tend claim.
Customer focus card help else. Evidence recently agreement avoid positive then.
Within through church risk perform somebody American course. Happen into himself person.'),
('Development fire most.', '2023-06-16', 52, 18, 'Easy', 'Answer its rock able book buy. American actually per own large toward.', 'Center citizen throw fall she work. Significant know various resource.
Consider claim design involve. Explain better base save property speech year. Brother suffer still stop.
Interest radio appear senior join hundred series about. Bag year raise especially north suggest. Office true do structure own cut.
Issue those war tax. The player admit cultural there action wall. Usually and summer city interest.'),
('Cold black arrive.', '2024-06-29', 40, 113, 'Hard', 'Me pattern finish room trouble thank fish certain. Level show walk collection say.', 'Education situation early hospital black future time economy. Very consider health student painting.
Can hand hotel center current toward better single. Fly company be move job property. Parent when look use capital shoulder represent.
Them politics use military. Want professional suddenly dog whether against specific effort. Television economy high while participant newspaper pass.'),
('President force campaign.', '2024-07-21', 23, 21, 'Hard', 'Because onto lose project. City recognize fund share to public detail. Recent term expect happy player property area.', 'Today art card any than sea debate. Customer help officer state reach buy.
Along travel east forget. Read candidate hundred item audience young.
Never exactly effect week to room however. Either cost newspaper especially including message foreign.
Whatever just matter arrive. Blue else picture budget travel perform. Never popular summer five expect.
Way accept ago bad. South beautiful push floor goal party since. Sense understand keep color thank seven.'),
('Blue environmental.', '2022-05-02', 28, 80, 'Medium', 'Technology them work direction push these. Interest lay director ground after several senior. With push wind from simple.', 'Strategy part would policy. Perhaps all forward government institution all.
Physical could example someone Democrat. Environmental impact walk same part option. System movement whatever fly. Network pattern never street clear tell.
Actually have four son. Community today couple clearly.
Woman process dog ago. Discover family professional. Challenge kid agent campaign well direction yourself. Sea effort trip morning good through.'),
('School nature.', '2020-09-27', 46, 16, 'Medium', 'From hit practice choice even mean. Trouble tonight box far just subject.
Prepare pull agent tell energy budget who road.', 'Others process help foreign land adult. Today impact positive wonder author idea last although.
Total message PM whom cup tell. Offer join serve would she cut performance.
Drive difficult player consumer impact among. Over put case health activity ahead government.
Car player find by city Mrs economic. Adult three bag but expect now exist.
Ever against fly. Word yourself focus trouble chance cultural lay. Pick oil population environment ground threat.'),
('Until traditional learn.', '2024-06-28', 49, 100, 'Hard', 'High think it choose. Special third public. Remember actually near or.
Glass teach hospital challenge moment beat. As theory voice risk respond human prepare. Book notice cultural of.', 'Player more future chance major. Authority over deep main article leg wrong measure.
Require someone structure kid support. Others early staff law network anything out. Hospital record those else add international hotel.
Can discussion start after college different. Star court car provide mean upon. Soldier camera including father wear view.
Name account side capital. Put fish matter even particular could.
Which trial time building some.'),
('Form main.', '2023-10-03', 51, 24, 'Medium', 'East information take country reason. Make debate true wall participant bring contain.
Poor police information Congress action. Sound change treat yes campaign sing color. Term enjoy ready control.', 'Side prove call try account force. Trip whether gas feel issue early that. Religious rule student blue lawyer stuff.
Boy international station yeah. Machine someone similar top no perform no.
Every ever rather. Wind see space lot window.
Particular wind grow seek. Writer Republican scientist. Every seat coach I.
Claim defense successful skill line. Same white protect major interest wonder.
Away treatment cup this realize area standard. Thousand natural car concern actually final administration.'),
('Including morning hot some.', '2021-12-27', 28, 47, 'Hard', 'Quite game back brother. Drug throw water point. Her scientist product local stuff behind. Rich beat find.', 'Bank conference section themselves such. Policy book eye despite center.
Style agree camera talk. Simple involve understand family when Mrs get economy. Answer chair nothing ready night.
Read resource account heavy international name weight. Continue simply defense subject avoid white.
Threat have glass attack response staff. Family mouth force many live back hundred.
Imagine next life senior few first. Natural policy or. Likely side write sea popular. Under free wind likely specific.'),
('Here national.', '2022-06-19', 38, 81, 'Medium', 'City they sound avoid finally fire nation walk. Share main example matter.
What whether study western word within see. Final bring eat nice mention prove election.', 'Smile guy your industry how. Hospital add interview administration. Behavior player wish arrive might region time alone.
Congress assume such suggest court box fear. Bill where enter data manager sell figure. Parent standard market skin politics.
Record day second among street day. Soldier anything another range manager price. Former pattern wait happen difference money car.
Half live special talk ever fear consider.'),
('Second foot develop.', '2024-03-30', 40, 80, 'Medium', 'Defense clearly local positive usually discussion could. Cold truth prove born police could shake. Fine source wait base long.', 'Surface be image trade. Information respond central however thus laugh tell.
Onto including parent work choose song.
Fly set add suggest physical. Job half public safe fact. Base pressure group how environment. City hundred tend help wonder.
Small direction yard officer social issue little interesting. Will term evidence suffer sure person role.
Move tend despite treat. Most leave song deal still.'),
('Strong no husband.', '2023-11-19', 30, 64, 'Easy', 'Prove now can perform rather. Play then maybe only participant new life.
Above age myself total necessary. Fight law individual American actually share. Before as century security concern.', 'Word perhaps sure accept gas seek add. Care try measure home.
Assume sit soon management image high even. Themselves once focus fill quickly affect really. Recent home four mention see sport information.
Risk future theory. Commercial visit serve image responsibility him. Should light hand no bill arm house.
Yard wait box statement scene analysis. Increase laugh team charge officer trip. Yard player throughout hear hope stage mean.
Husband green reflect finally us step camera build.'),
('Debate each.', '2021-01-03', 33, 65, 'Medium', 'Hour lead goal. Short over listen go run senior policy.
Bag side long road space. Family speak hit apply. Them whose information within attorney.', 'Think ago step able theory direction hand late. Fire once test foreign leave send lot. Operation second exist today try college fact.
Agency consumer on camera. Listen serious blood national relationship.
Tv human left anything. Offer half crime writer.
Friend case plan into blue identify cut. Help practice husband themselves role skill.
Let long modern white free.
Any avoid Republican five those use. Long shake see exist level generation. Opportunity on environment try.'),
('Decade police.', '2022-05-12', 29, 63, 'Hard', 'By leader institution degree sort if quickly. Record able data century quality weight each. Purpose citizen source have financial.
Lose thousand always wear. Carry way add big worker.', 'When former idea order might democratic experience. Protect likely interest remember cold mission capital.
Side young police require case defense. Arm station like. Adult marriage into smile.
Air moment me subject. Four thank four their sea. Need let available four animal picture so.
Read behavior his hand act never. Possible provide probably cold mind yes perform mother.
Put accept offer interesting usually. Foot south still garden. Others break color thank budget small prove.'),
('Catch culture.', '2024-10-31', 40, 113, 'Hard', 'Seem assume her car agreement benefit improve speech. Camera training dream shake start. Start woman field blood.
Hope use material involve. Car material enter surface would where guy.', 'Short work your window main pay. Likely heart range hold organization type important brother.
Maintain social there present attention night age if. Environmental few fast decade less seven. Edge single race.
Team even help. Shake trip shoulder coach smile decide commercial. Not street interesting.
Decision ready interesting lay have game seat. Major very official may service show.
Mr like nor card final against. Any major story together suggest. Identify head very main put.'),
('Expert and.', '2020-08-29', 39, 23, 'Medium', 'Politics baby each huge. Beautiful at particularly cost see usually investment. Until buy friend simple. Buy light my plant.
Model reason note crime. Dark top bed analysis.', 'Area structure various far time say understand. It the threat born.
Describe five could do. Gas pull number TV goal. Spring worker who.
Perform simple safe particularly. Position he position.
Especially media against well situation business. Personal whom play certain career away successful.
Kid ball oil morning argue.
Outside who room common even. Pressure rich agree reveal.'),
('Hear policy few draw.', '2023-09-16', 47, 45, 'Hard', 'Organization TV man campaign. Knowledge call community fund myself crime true. Rather door actually decade address serve move.', 'Campaign discussion decide. Film everyone than family listen interview. Camera cover understand different off check range fear.
Perhaps how when century dream street institution. True character might care others western. Down effort race usually rather place firm.
Point indeed fish magazine certain behind. Note easy special between wear leg.
Spring race four wrong manager sense. About watch production stock east total player boy. Think any alone sometimes president friend.'),
('Study alone challenge.', '2020-11-02', 44, 69, 'Hard', 'Laugh save fine thousand world two. Street boy she along world southern. Middle everybody threat learn economy.
Serve certainly space finally. Option detail specific personal marriage medical scene.', 'Evidence party want true nor various enter. Remember provide discussion rather.
Music practice seven me outside ball. Movie get evening.
Job yes city majority despite truth friend similar. Deal according fast management Republican. Prove soon mother answer effort feeling happen. Difference move be reach care.
Water account guy recognize green first same. Everybody avoid citizen nation. Onto nothing example send prepare quality.'),
('In southern.', '2022-11-03', 33, 51, 'Medium', 'Impact note factor candidate only expect. Debate degree property buy kid since boy.
Concern nation interview center reach. Measure program treatment draw.', 'Require just television finish every mouth much. Thought beautiful agree. Allow whom nothing save.
Concern discover nature. World left each. Leg interest born idea level.
Resource close explain health. Such space share.
Site she rate recently baby value.
Strong contain green win inside. It more police effect feel. Know citizen factor poor people large. Accept toward bed operation federal.'),
('Head someone.', '2021-04-18', 21, 63, 'Easy', 'Different have bill first word quickly theory. South lawyer church impact better probably newspaper.', 'Here stuff small husband various.
As eight sister box myself. Money real church form need.
Wrong discover collection learn here plan. Official health century newspaper.
Surface enjoy effect perhaps. Town front detail while.
Necessary memory amount watch pick visit. Drive some new lay western. Local experience employee more new box. Act eat effort avoid treatment.
Reflect ok year deep stop meeting. Put radio term trade.'),
('Particular lot.', '2023-03-08', 18, 80, 'Easy', 'Might international machine security carry. First religious plant task.
Likely relationship record call ask truth appear own. Page court nice. Hit behind accept name.', 'Kid reflect pattern ready down week. Today gun arrive success free mouth senior. Return offer seem financial view.
Glass already recognize tough. Card far approach.
Final fund rate that star which. Protect Congress police me different.
Seven every positive along. Car through good never whether.
Page operation myself idea. Responsibility citizen painting member white base mention. Arm human save outside role suggest wife.'),
('Front.', '2025-03-03', 40, 36, 'Medium', 'State your perform know issue next. Usually indicate task firm their blood sing now. Piece us bill cause movie environmental ok.', 'Once hard game then interview. Road once simple could set prevent management. National Congress whole discover.
Animal walk less far consumer under thank. Which by moment wide onto onto attorney. Night letter newspaper again miss.
Education a close deal week agreement. Of more begin movement degree science.
Over within positive skin. Picture quickly defense plant step. Remain decade town expect.
Whether north anyone organization candidate. Sure especially fill. Mention month scene law mother.'),
('His daughter common level.', '2020-06-19', 49, 116, 'Hard', 'Arrive majority long build. Because experience present true chair figure difference. Will carry own green each southern. Bill agent become thank poor smile art.', 'See short full agree admit. Edge my bit machine trouble action.
They billion beat learn four yourself. Actually fast structure brother nor. Behind item unit affect.
Hotel newspaper election crime. Voice alone card Mrs education future particularly. Material certainly prevent teach perform end want.
Service sing family window public great meeting ability. Add class collection ready show. Share never behavior wife position bar man.'),
('Fast let.', '2020-03-02', 42, 29, 'Medium', 'Movement father kitchen financial. Again help most machine land.
Fund end deep purpose win item. Try scientist minute recently fund part around program.', 'Usually side experience program. Artist while forward southern one star because.
Join outside ball should board away get. Candidate entire when risk expert movement.
Clearly some commercial public necessary morning wife. Sell experience message father.
Relationship street financial. Democratic race possible first part.
East week about pull break bring sure. Detail sure risk they fast. Director news late detail long model television race.
Tough model trade face certain.'),
('Front wind.', '2024-09-15', 19, 39, 'Easy', 'Rest enter wide beyond gas happy mission. Small attorney meeting. Near letter claim might despite.', 'Available usually thus administration sell. Pretty early me other pick line trouble mouth.
Effort performance give important wife. Produce home board religious number rich attention. Feeling after pretty late.
Become understand side increase yard direction. Us care relate form sense Congress. Real all forward join.
Effort us professional country lead hot. Market agreement control. Cost teach throughout across. Piece fly will find office per green.'),
('Meeting according.', '2020-04-13', 53, 46, 'Medium', 'Learn discuss full my market. Street defense design serious happen age.', 'Check increase right end. Tough two car.
Group bad another debate term officer beautiful. Still poor myself.
Another wall side hope. Would federal more hold central loss. Itself apply laugh woman break.
Alone arm actually church. Course analysis begin teacher best often. Fund day lead point line reach.
Wrong bad modern test. Full town expect morning find.
Make since fill decade mouth. Sea everyone artist news firm win purpose.
More family day. Management significant land without.'),
('Face region just.', '2022-11-15', 17, 16, 'Hard', 'Cold major news light trial. Indeed person enjoy difficult Congress.
Nothing common current really. Writer catch north no. Part article pressure into.', 'Few turn office.
Indicate traditional agree third charge. Market protect green me heavy act husband.
Report him purpose everyone process want. Relate part imagine.
Teacher more bill read himself report kid hotel. Push debate guy huge skin before.
Image suffer great when finish. Whom head alone son.
Rise practice which draw industry. Leader finally indicate firm maybe expert.'),
('Yard poor.', '2024-12-10', 44, 101, 'Hard', 'People idea Mr whether order arrive not foreign.
Shoulder enough daughter camera less. Several often spend trip unit.', 'Beyond child father thank conference. Heart research present without education. With which probably level Mr.
Pay cost single rise more rise particularly. Until throw word better.
Option similar also despite look. Son short community just public other.
Chance or position cold all. Energy seem enjoy talk. Community most performance seek condition. Hit both station happy company above standard.'),
('Throw.', '2022-11-15', 11, 105, 'Easy', 'Far here trade institution activity Mrs source. Man box fly. Design too recognize body front.
Like set huge would compare. Through wall enter that heavy. Concern how head inside home.', 'Us food weight contain cell impact. Between might term stand scientist. Affect else laugh protect.
Positive real stand economic. Family else program second no machine certain. Heart everything suffer class country.
Threat parent check reach. Must hand few light reality line. Current manage little address unit thank office.
Trip financial question security party. Than only table however give small. Keep yet raise court all keep continue.'),
('Half Mrs.', '2025-03-22', 39, 84, 'Easy', 'Past at marriage hotel nation main light. Open international upon might pull. Machine visit consumer better to.
Individual relate mother front close down control. Free create will nice front.', 'Pick use free political model. Success sell last. Deal another detail despite.
Under option such speech road. Quite authority yourself contain current moment month. Yes year well create letter opportunity.
Most number information toward. Poor accept we think service assume party pick. Plant case national sea really behavior trade.
Almost land assume major street billion. Sure white assume may.'),
('Social theory if.', '2025-03-27', 22, 103, 'Hard', 'Those improve tend. Rule article state official side per next.
Involve hold the assume instead meet investment over.', 'Benefit best process reduce. Point there huge reduce work. Food catch compare admit war plant smile wide.
Meet skill inside character experience like. He four pick model.
Challenge trial but back letter phone somebody.
Former other catch animal want language hard. Other require employee man campaign trade. Stop energy history attack candidate certainly.
Ground report avoid though give who. Support again raise. Smile low work career issue full door.
Economy learn run hot. Eye customer leg cause.'),
('Investment change later.', '2021-11-24', 31, 70, 'Medium', 'Speech wife term military hit prevent think add. Play actually main safe walk possible.
Movement standard guy. Tonight six trip sea take.', 'Specific job member fund economic manage. Everything hit act nor under role run. From employee truth sure chance all such. Early special employee.
White democratic interest away. Hundred follow two court agree month chance. Live statement safe area clear network suffer.
Girl item newspaper security put capital past.
Republican question necessary list least reality worker. Water possible expect door information. Might high industry dog reveal.'),
('Expect discover.', '2023-03-25', 54, 92, 'Medium', 'More meet trial fly rich it. Then civil together half cut college some.
Mean know position partner question. Move threat stuff him over even. Fast travel look throughout start again manager.', 'Relate own we far. Be her action bar political TV phone question. Take clearly what term road there say after.
Democrat compare teach fear tonight step nor. Land top example picture dark this people century. Spend land day group who service.
Evidence five art office right. Itself but expert thus.
Success back free off truth could meeting.
Hospital surface month reach story.
School lose new discuss another over fear both. Officer become fly piece suddenly surface.'),
('Every unit million.', '2024-11-02', 11, 35, 'Easy', 'Sea budget skill offer minute place. Arm ok fill it cup return ten.
Share child your quite mind former blue. Good red instead bring summer.', 'Hand do service pay. Thought five leader lawyer news full. Must former never notice hear.
Sport color change how. Majority protect third party design business.
Young team shake who task test activity. Program beat bit quality send person.
Glass summer half sell word energy. Vote top us task baby less million left. Single stage citizen feeling.
Hold woman foreign these decade budget. Energy future military set toward majority pass.'),
('Thing concern since.', '2023-11-15', 26, 70, 'Hard', 'Past doctor machine want church scientist. Garden guess customer technology performance difficult hand successful. Hundred thousand only toward check score.', 'Attorney pretty go stage help. Road song worry another none. Figure audience each throughout thousand program. Since trouble right try everything popular enter road.
Its about position center prevent city popular.
Listen here tend. Particular way thought animal.
Mouth day then rule. Model score structure western hand spring safe book.
The listen great goal. Past garden blood goal or tell film. Although onto after every concern house standard catch. Consumer avoid each now thing task lot here.'),
('Agree bed line.', '2020-01-25', 38, 84, 'Easy', 'Side second after policy for sister against report. Ball chair level never indicate. Weight red call.
Individual world reality himself. Education blue change consider seek audience.', 'Throughout thing serious language girl process season. That experience its future.
Alone four edge. Safe dinner attack article. Key third gun notice truth.
Remember huge foot prepare might probably art young. Wall business focus glass drop church. Really doctor issue. Action bank assume.
After central news detail force item miss moment. Glass card evening us financial sound trial. Prove seven above report section peace.'),
('Individual hope.', '2021-11-20', 59, 82, 'Easy', 'Son read evidence respond region two speech. Career life around individual course. Anything traditional include threat second size together.', 'Art floor area official occur standard. After late smile consumer home technology.
Strong become record manage value. Trade actually check wrong nearly. Current until could into think move yard his.
Throw student room ok baby. Five society machine where fact.
Southern add interest PM. Other arm might as market form. Environmental successful garden.
Board available hold simple analysis several author. Yet enough his.
Kid bad answer section it military. Work change market national father.'),
('Bank.', '2025-01-14', 56, 66, 'Hard', 'Painting carry statement summer professional. Us environment young decade commercial left. Consider form quality letter glass threat cause.', 'Few act ask hundred explain. Process be research direction air. Then they instead building field specific.
Affect research sea major as quality. Near top try.
Say prevent eye. Military sense determine.
National pay value first process. Now support stand strategy any entire collection. Participant her perhaps allow question buy.
Investment stand cover huge student may throughout to.
I control material. Dog your team participant measure clear item. Kind magazine whose popular.'),
('Process body evidence.', '2020-10-01', 57, 37, 'Medium', 'Loss notice citizen notice event detail major. Unit present family than trouble white day magazine.', 'Mouth important defense now clear. It require third television five. Form organization management environment.
Across station employee speak. Political place between guy rock I store. Another threat language. Serve better week open meeting find blue.
Exactly sure about especially seven. Investment soon institution soon born play section. Season third mention position argue.
Always mention gun tax. Voice edge hold growth like owner think. Any wait gun wrong commercial important.'),
('Human close letter.', '2023-12-27', 16, 30, 'Hard', 'Pretty read quality Democrat power. Three none yard month article experience contain.
Lay forget claim rate law north mention. Book instead deal floor. My opportunity answer return.', 'Cut kind expert note rest four explain kitchen. Yet kid cost traditional. Provide beyond marriage Democrat need. Man represent figure theory.
Story enter follow morning list specific. Let television reduce main community police.
Two television under live. High truth speak growth five.
Nation both rule real nation. Compare successful really kitchen.
Although sell fact including seat.'),
('Coach dinner.', '2021-08-07', 10, 27, 'Easy', 'Meeting quite face. People any attack we be democratic. Middle no policy apply deep music industry.', 'Challenge nation former realize lawyer especially true. Site relate apply chair.
Price American help person become smile. Defense Mr anyone almost thousand summer natural.
Each artist trial agency no woman address executive. Page middle trip. Suddenly yard kind.
Day weight at who particularly. On share create director way. Series including song sit even.
Institution far cover at authority bank director. Require father knowledge often rather since simple. Sense physical practice consider.'),
('Third own.', '2021-10-29', 50, 23, 'Medium', 'Hear million rest radio music statement street industry. And fine play scientist political. Provide that wrong cause author hear.
Wide section act.', 'Finally great population. Back edge energy eat various save. Forget TV contain catch laugh five series.
Card need serve either. Organization likely entire military. Practice follow even site focus watch.
Company worry before behind tax.
Improve left notice myself enjoy daughter stuff able. Individual those reduce seek.
Smile south share everybody wife. Education best you stock western care.
Election leg position must state day city. Talk happen last quickly program every assume.'),
('Keep owner.', '2022-04-04', 14, 52, 'Easy', 'Door million strategy military husband right seven. Service nice far item expect draw first. Entire blue style red indicate southern thing.
Middle expert sing morning. Industry thank follow stay.', 'Media production nor together. Can small truth because. Trouble clear ability.
Region speech she left could mother company fast. Because me rock on.
Help no already.
Suggest Democrat smile interest eat next agree.
Wish including bad. At simply often sing late suffer. Increase look speak color building.
Rate believe charge whom. Fast born commercial rock nor hold image behind. Director meet century recently include.
Successful certain difference tax. Hundred whom drive Mr audience address.'),
('Improve two.', '2025-03-01', 57, 62, 'Hard', 'First your development lay teach group agreement short. Study bag live into design article weight. Rise rule six rise.
Administration factor buy agree difference score set.', 'Sometimes worker environmental close. Key drop knowledge. Great there too effect plant seven else.
Top civil compare crime whom. Various treatment test a add heart. Study baby much however.
Environmental last information marriage sea.
Including factor manage garden. Three performance then.
Drop whole concern with mention. Kitchen watch western cell son low his new. Room him tend century heart.
Hope gun language less. Particular concern oil smile.'),
('Direction generation policy.', '2021-04-07', 50, 28, 'Easy', 'Year religious feel start model. Pm street might raise may conference his.
Off protect economic lot own artist. Evidence fact describe threat summer require money.', 'Start say recently but. Space someone senior add.
Trip skill treat hundred support run tell. Exactly perform woman too authority later attack.
Ever camera size agreement order half million economy. Bank likely use hit begin. Door two leg crime.
Low accept worker surface miss save nor nature. Safe wall clearly shoulder.
Enjoy arrive view long. Break claim hard choose level generation.
Much time pretty head low.'),
('Especially exactly.', '2022-06-03', 55, 21, 'Hard', 'Nice court information matter network.
From crime explain us. Ability appear everybody since cut computer memory. Choice hotel parent interesting.', 'Senior bad station investment space call young. Appear would summer only. Specific sometimes job magazine ready office cultural.
Who attack executive. Election be opportunity political whose piece. Good bar true miss thing discuss.
Question sense money see behavior analysis. Trip focus member student century. Team compare yet road let agent candidate interview.
Everything really sell institution. Trade customer point themselves purpose space paper.'),
('Any research need bring.', '2024-01-16', 38, 102, 'Easy', 'One me effort step. Of realize really chance camera reality while position.', 'Get painting development color measure indeed. Professor minute institution democratic do.
Place last section building. Traditional daughter individual myself. Than think would although.
Trade agent appear exist. Value paper report skin value. Boy knowledge item enough.
Decade key of central nearly. Easy direction positive them should all.
Follow source stage own song. Bring argue just. Note activity degree measure world development.'),
('Suggest theory animal.', '2020-10-27', 33, 120, 'Easy', 'Enter suggest affect term between watch. Entire whole growth appear better none.
Marriage fight establish few approach wrong. Buy determine wear our piece cut option. Their everything agent simple.', 'Pattern visit establish value along none. Table me care lot relate say population season. Couple friend real young father.
Whose wide southern. Friend spring including ever feel senior surface.
School rate peace price total. The machine key lot.
Conference walk reality in in pass. Wait contain look pattern. Across hear the hold enter American service.
Piece city magazine blood drop summer sport. Process number experience remember plan car thought Mr.
Coach media reach. Crime forget could never.'),
('Challenge as.', '2021-09-09', 41, 107, 'Easy', 'Serious mention message action space do never owner. Prepare so significant. Defense catch foot ahead.', 'Cell learn possible return significant majority per. Research deal art not today already. Series nature project nearly reflect decade eye.
Suffer create candidate ever career they.
Outside of around movement despite many likely. Specific whom century majority activity. Owner last down total.
Team resource believe cultural drive check role. Under material new for.
Politics wall whom serious seat. Many result however focus establish employee into. Kid chair concern page traditional about under.');

-- Insert statements for table: CategoryData
INSERT INTO CategoryData (Name) VALUES
('Appetizers'),
('Main Dishes'),
('Desserts'),
('Beverages'),
('Sides'),
('Breakfast'),
('Lunch'),
('Dinner');

-- Insert statements for table: DemographicGroupData
INSERT INTO DemographicGroupData (GroupType, GroupValue) VALUES
('Age Group', '18-25'),
('Age Group', '26-35'),
('Age Group', '36-45'),
('Age Group', '46-55'),
('Age Group', '56+'),
('Region', 'Northeast'),
('Region', 'Southeast'),
('Region', 'Midwest'),
('Region', 'Southwest'),
('Region', 'West'),
('Activity Level', 'Low'),
('Activity Level', 'Medium'),
('Activity Level', 'High'),
('Dietary Preference', 'Vegetarian'),
('Dietary Preference', 'Vegan'),
('Dietary Preference', 'Gluten-Free'),
('Dietary Preference', 'Dairy-Free'),
('Dietary Preference', 'None');

-- Insert statements for table: LogEntry
INSERT INTO LogEntry (LogID, Timestamp, ErrorMessage, SeverityLevel, Source, Details) VALUES
(1, '2024-11-28 06:48:58', 'Draw whole mission policy it.', 'Low', 'chang.biz', 'Site team risk hear tell. About environment room. Tree some they back pay radio discussion company. Hit few do admit.
Cultural risk may choice really while traditional.
Hear lawyer because loss huge. Expect do team anything.
Several cause today check ball prove those term. Kind federal mission.'),
(2, '2023-04-29 00:24:32', 'Decision financial else difficult grow.', 'Critical', 'poole.com', 'Capital buy meet sense. Measure majority sea know modern easy. Leader both seven mention cover.
Coach table nor effect. Drive wear main time lose. Phone lawyer run economy no form.
Minute a appear. Leader movie but enter save maybe something.'),
(3, '2022-06-16 16:22:41', 'Increase expect long yet thing.', 'Medium', 'morgan.com', 'Matter our participant provide stock. Church piece order woman they production. Enough prove lead training whole determine. These social establish green.
Because foot receive source. My truth around think into eye. Recognize prove stuff enjoy watch film structure.'),
(4, '2021-11-02 00:58:47', 'Nature including left out than that or.', 'High', 'walsh.info', 'Raise maybe officer myself show pretty walk.
Guess up drive goal. Pull discuss house list author soon. Western read study skill allow sure at.
Radio picture kind. Message family school candidate. Success pretty argue represent smile.'),
(5, '2020-07-26 06:19:18', 'There why claim include skin fish similar parent.', 'Critical', 'russo-burns.com', 'Hit everybody serve take political. Hard white animal world kitchen. Sure investment budget himself different.
Traditional political parent professional very fill. Above boy local. Factor culture develop budget whom central.
Unit what trade history dog production quickly.'),
(6, '2022-05-04 16:05:10', 'Institution break my garden career as step section.', 'High', 'chambers.biz', 'Painting mind free foot attack long bar.
He trial return seven let hour. Us four bit.
Agent trade green wait present buy why fire. Record voice present notice yourself relationship model.
Become meeting difficult director. Laugh not expert radio.
Picture poor method or. Unit next hour gun.'),
(7, '2022-06-21 23:42:52', 'Fly similar plant support despite professor.', 'Critical', 'morris-sanchez.org', 'Head thought military sure foot. Authority understand because help option.
Sort various indeed pick. Traditional tell follow several able weight pretty.'),
(8, '2024-06-02 17:25:57', 'When history suffer reality.', 'High', 'miller.com', 'Technology senior shoulder.
Service magazine management.
Natural situation it blood future mind.
Total measure me. Among outside whose those both ability. Today after administration able.
Let billion customer since decade. And watch trade.'),
(9, '2023-07-16 02:38:30', 'Development once movement movement choose similar check firm.', 'High', 'johnson-martin.com', 'Various network interest and. Bit field son baby leg east point student.
Tv pattern pay tell fly security. Natural recent cell.
Buy mother news black. I wife difference spend thank alone. Test identify scene phone authority police.'),
(10, '2024-05-28 10:49:01', 'Unit watch mention center write doctor because military.', 'Low', 'hurley.com', 'Student network century seat. Some important meeting hold school green month floor. Peace at data raise force draw industry.
Region significant town full describe finally base. General stuff few ready such. Soldier minute scene girl kitchen class wonder. Establish already contain pressure.'),
(11, '2022-07-23 08:55:52', 'Almost minute rock now adult.', 'Low', 'harvey-reynolds.com', 'Environmental effect attack see professional also drive. Prove color commercial arrive show. Part water fear politics mouth.
Organization purpose find. Idea enter above off major brother another nature.'),
(12, '2022-11-13 20:53:19', 'Whose clear doctor area since both join common.', 'High', 'bradley.info', 'Before near understand out method church trial.
Hour win state data west theory. Success field low must require nature.
History more brother process religious agree. Civil husband build player stuff available. Mother military tell possible north want word.'),
(13, '2021-01-25 03:03:42', 'Entire simple short artist give traditional part.', 'High', 'oconnor-rodriguez.com', 'Word institution police leader. Mouth discussion per positive real happen would.
Bed beat Congress us suddenly debate economic. Rich on brother explain building again unit.
Education big group yard father write. Resource pull religious despite thought top.'),
(14, '2021-12-11 07:02:38', 'Senior commercial meeting next nation watch event.', 'High', 'stephens.biz', 'Suddenly especially compare show. Reality support rather machine hold take born.
Loss officer near bad first key. Often little sort safe enjoy word.
Something to food begin can.
Say finally realize determine ago argue. Discuss prove term treat. Light particular take million.'),
(15, '2025-01-28 21:30:18', 'Amount perform other officer.', 'Critical', 'mosley-brown.net', 'Half since born choice. Really person remain economic chance vote throw.
Deep develop my dog risk worry citizen. Rock seek night stage.
Peace here determine music. Environmental hour coach turn discussion approach almost. Catch lot still forget.'),
(16, '2023-01-13 02:19:14', 'Culture former dark receive often within measure city.', 'Critical', 'owen-ramirez.info', 'Beautiful it focus while feel foot government.
Sign magazine school.
Six onto real foreign. Here factor employee while say home. Reduce father spring agreement future pass speak.
Term on drug tell when listen thousand. Teacher drop color detail student according.'),
(17, '2023-12-11 06:57:29', 'Information individual ever life without kid.', 'Low', 'green.info', 'Television discuss what. Cover now create economy lot.
Doctor focus near do conference significant along indicate. Join sense political. Imagine skill kind assume page more.
Six since political one. Type necessary between any magazine. Government game author view.'),
(18, '2021-03-24 07:25:15', 'Wrong allow forget article free player seven.', 'Low', 'turner.com', 'Break short may whom rule send tough. And scene somebody through item school start.
Degree fact article ready. Least eye trial whose assume evidence PM cultural. Billion yard government material sound enjoy. Sell citizen employee onto left word.'),
(19, '2024-01-12 10:03:32', 'Term success prove fall sport military could.', 'High', 'delgado.biz', 'Sister discussion either issue brother. Window walk since hotel. Why behind any until science stuff.
During fire fire project feel.
Else develop these others level share down. Total perhaps you.
Like know step fall investment. Sign purpose study. Laugh can source hair sport animal participant.'),
(20, '2025-01-12 13:34:17', 'If want foot power never until understand.', 'High', 'brown.com', 'Talk picture none tonight. Play describe lot my there Republican. Serve must baby. Around realize news thought three later.
Much positive suggest glass.
Technology every later anything. Run talk region play source thus.'),
(21, '2020-06-10 00:30:09', 'Future during eight.', 'High', 'holden.info', 'Happen low course against not. Pm system back where her forward act.
Theory suddenly fly finish challenge. Add next herself call.
Family model expect son rich character remember small. Nation personal campaign tough. Economic threat amount network.'),
(22, '2020-08-10 07:13:54', 'Star subject small probably.', 'Medium', 'thomas.com', 'Picture family method particular style. Style lose bag letter. Power four land car down when live bed.
Reality amount while school. Sell run audience very behind.
Central material popular same low four. Look still machine. War among draw space tough let them second.'),
(23, '2021-09-30 17:00:23', 'Thousand front those represent.', 'Medium', 'mcdowell.com', 'Really information something lawyer. Full raise experience stop issue teach.
Toward discuss professional total unit show item project. Above third tree person head fine effect business.
Hour collection baby money reveal likely trouble. Last raise doctor worry. Treatment as control.'),
(24, '2023-03-28 09:51:59', 'Bad see about same.', 'Critical', 'chan.net', 'North drop assume lawyer. Decide moment either project shoulder friend. Republican cultural still question it long.
Computer event away study. Call minute identify very. Free medical network perform thought others suggest American.'),
(25, '2021-10-25 15:48:44', 'Television without live method again and process traditional.', 'High', 'crawford.com', 'Serious me country say many carry that. West church establish hot draw probably three.
Environment later require north bed seek choice heavy. Water civil car make stock pattern either. Individual difference stage husband work again. Discover fly listen somebody catch card.'),
(26, '2023-04-28 22:39:21', 'Try lot no young range big.', 'High', 'caldwell.com', 'Room all attorney discover man some too. Baby item how social. Quite sing group require.
Seek leave important wife.
Box risk court catch above benefit time she. Condition kid anything pull plan cause model thousand. Charge audience get plan.'),
(27, '2021-01-18 20:25:41', 'Do political bring professor.', 'Low', 'cox.org', 'Manager owner ready fly ready wife generation pretty. Less network place. Usually bar apply court.
Sea data Mrs article fight human. Analysis million store difficult. Without series number west take probably.
Direction see state democratic. Pick base look.'),
(28, '2020-11-24 01:46:12', 'Brother until white program senior interesting result.', 'Low', 'fletcher.com', 'Generation have state win box day. Relate send authority owner investment among office human.
Affect thank professional significant part face politics really. Girl special second city matter.'),
(29, '2024-02-11 02:52:36', 'Offer population his fund stop might.', 'High', 'phillips.com', 'Question left off respond more vote drug attack. Beautiful structure may in focus join. Trial guy beautiful news city choice idea.
Remain sit fight probably left only. Evidence development follow high success.'),
(30, '2025-01-06 14:02:54', 'Hotel simple marriage up.', 'Low', 'gibson.biz', 'Public everybody reality example cup. Smile five hold day camera. Nice send guy half speech child time.
Occur effect image wish send. Speech husband method friend pull character.'),
(31, '2022-12-24 20:57:43', 'Question thousand there story.', 'Critical', 'ballard.org', 'Art exist factor ground series admit hard.
Wrong treat these decade. Produce know design room standard or true cost. Drop brother surface cover special peace house.
Color so economic summer standard among. Street account establish.
How effect bill. Experience want what point.'),
(32, '2025-04-15 05:38:48', 'Three consider say first into.', 'Low', 'sims-gibson.com', 'Well door store. Religious artist agreement safe.
Democrat too identify federal they ahead under. Able which either success wait.
Show send case theory house player tough. Total technology set response.'),
(33, '2022-02-21 06:42:35', 'Bad finish change author she.', 'Critical', 'clark-buckley.com', 'Ever always just cause night environment Congress. Him they him officer letter why story.
Certain develop available eye walk save choose. Discussion other indeed issue. Rich before statement town need happy.
Report product compare improve financial. Hard form customer free though.'),
(34, '2025-01-30 16:10:43', 'Main she could across method.', 'Critical', 'vega.com', 'Loss white region sea citizen. Do discussion age shake. Film significant still citizen finally off note director.
Special new discuss easy first cold the top.
Year international side economy suggest positive. Close site safe beyond.'),
(35, '2024-08-01 23:18:24', 'Know least case half behavior policy according plant.', 'High', 'marquez.com', 'Generation rise hospital protect gun history continue. Success them rule president staff through lead husband.
Positive position successful in leave everyone. Fire happen low movie father sure name international.');

-- Insert statements for table: Follows
INSERT INTO Follows (follower_id, followee_id, follow_date) VALUES
('brendamathis', 'kimberlysharp', '2023-01-22'),
('kimberlysharp', 'zsanchez', '2022-08-02'),
('kimberlysharp', 'zacharymitchell', '2020-12-23'),
('ryandiaz', 'eholder', '2021-12-05'),
('victoria20', 'richardbird', '2021-01-14'),
('eric86', 'michaelhamilton', '2021-12-18'),
('larry22', 'brendamathis', '2024-01-25'),
('rojasandrew', 'ravenrobinson', '2024-08-25'),
('daniel73', 'barbaramorris', '2022-02-17'),
('barbaramorris', 'edwardjordan', '2020-09-29'),
('tsmith', 'deborah13', '2024-01-10'),
('eholder', 'carmenjohnson', '2024-09-19'),
('rojasandrew', 'michaelhamilton', '2023-03-28'),
('moorejason', 'eric86', '2024-04-09'),
('brianblack', 'eric86', '2020-03-24'),
('james41', 'ryandiaz', '2023-06-19'),
('wilkinsjaime', 'richardbird', '2022-09-04'),
('wilkinsjaime', 'zburton', '2023-01-03'),
('chenlaura', 'brendamathis', '2022-10-04'),
('edwardjordan', 'johnsonsteven', '2023-01-16'),
('johnsonsteven', 'zsanchez', '2020-07-28'),
('eric86', 'kevinbaird', '2020-05-12'),
('xchase', 'zacharymitchell', '2020-11-18'),
('larry22', 'chenlaura', '2023-03-31'),
('johnsonsteven', 'randy74', '2021-12-28'),
('edwardjordan', 'randy74', '2024-05-15'),
('kevinbaird', 'wilkinsjaime', '2024-07-04'),
('johnsonsteven', 'larry22', '2023-03-17'),
('edwardjordan', 'tsmith', '2024-07-02'),
('randy74', 'skelley', '2020-06-28'),
('ravenrobinson', 'ryandiaz', '2022-07-08'),
('kimberlysharp', 'daniel73', '2020-02-13'),
('moorejason', 'brianblack', '2024-03-20'),
('richardbird', 'randy74', '2021-10-15'),
('rojasandrew', 'wilkinsjaime', '2021-08-30'),
('kimberlysharp', 'deborah13', '2023-06-26'),
('brianblack', 'larry22', '2023-01-02'),
('kevinbaird', 'carmenjohnson', '2023-06-12'),
('edwardjordan', 'carmenjohnson', '2022-04-24'),
('emily08', 'skelley', '2022-09-06'),
('zsanchez', 'michaelhamilton', '2024-12-04'),
('zburton', 'emily08', '2022-10-23'),
('anthony91', 'daniel73', '2023-04-30'),
('barbaramorris', 'emily08', '2020-09-28'),
('eric86', 'barbaramorris', '2022-03-18'),
('zburton', 'brianblack', '2020-11-10'),
('randy74', 'tsmith', '2021-05-08'),
('tsmith', 'edwardjordan', '2024-04-05'),
('chenlaura', 'victoria20', '2024-04-13'),
('larry22', 'michaelhamilton', '2022-06-06'),
('richardbird', 'daniel73', '2023-01-06'),
('tsmith', 'skelley', '2023-10-03'),
('eholder', 'anthony91', '2020-05-18'),
('zacharymitchell', 'johnsonsteven', '2024-09-24'),
('tzhang', 'chenlaura', '2024-08-27'),
('edwardjordan', 'victoria20', '2020-05-29'),
('eric86', 'moorejason', '2021-06-20'),
('daniel73', 'ravenrobinson', '2025-03-30'),
('eholder', 'xchase', '2022-09-04'),
('moorejason', 'randy74', '2023-10-31'),
('zacharymitchell', 'kevinbaird', '2022-09-13'),
('emily08', 'zsanchez', '2022-05-25'),
('carmenjohnson', 'xchase', '2020-01-01'),
('ravenrobinson', 'melanievelazquez', '2024-07-04'),
('moorejason', 'edwardjordan', '2023-11-01'),
('kevinbaird', 'moorejason', '2021-12-12'),
('skelley', 'rojasandrew', '2021-06-18'),
('eholder', 'tzhang', '2025-03-19'),
('zacharymitchell', 'moorejason', '2024-02-02'),
('larry22', 'skelley', '2024-01-02'),
('anthony91', 'richardbird', '2024-07-10'),
('tzhang', 'anthony91', '2021-01-10'),
('ravenrobinson', 'skelley', '2022-02-17'),
('moorejason', 'brendamathis', '2020-09-07'),
('xchase', 'ryandiaz', '2023-06-17'),
('melanievelazquez', 'harrelljennifer', '2022-12-03'),
('zburton', 'larry22', '2020-11-07'),
('eholder', 'randy74', '2022-07-08'),
('wilkinsjaime', 'melanievelazquez', '2023-06-17'),
('xchase', 'james41', '2023-12-12'),
('richardbird', 'ryandiaz', '2024-08-04'),
('kevinbaird', 'tsmith', '2023-02-10'),
('anthony91', 'ravenrobinson', '2023-07-23'),
('brendamathis', 'melanievelazquez', '2024-04-05'),
('victoria20', 'zsanchez', '2024-05-03'),
('chenlaura', 'tsmith', '2025-03-14'),
('zacharymitchell', 'zsanchez', '2023-01-19'),
('zburton', 'randy74', '2020-11-22'),
('eholder', 'kevinbaird', '2025-02-06'),
('randy74', 'richardbird', '2021-09-02'),
('barbaramorris', 'harrelljennifer', '2025-03-04'),
('carmenjohnson', 'tzhang', '2023-05-04'),
('james41', 'victoria20', '2020-02-19'),
('harrelljennifer', 'barbaramorris', '2020-05-01'),
('victoria20', 'rojasandrew', '2021-02-05'),
('kimberlysharp', 'skelley', '2021-08-09'),
('randy74', 'wilkinsjaime', '2022-10-24'),
('brianblack', 'kevinbaird', '2020-01-30'),
('edwardjordan', 'melanievelazquez', '2023-11-01'),
('brendamathis', 'skelley', '2022-07-29'),
('ravenrobinson', 'tzhang', '2020-11-01'),
('harrelljennifer', 'carmenjohnson', '2023-11-20'),
('daniel73', 'kevinbaird', '2022-11-29'),
('moorejason', 'deborah13', '2024-08-21'),
('kimberlysharp', 'chenlaura', '2020-06-18'),
('richardbird', 'carmenjohnson', '2020-07-12'),
('zacharymitchell', 'kimberlysharp', '2023-02-03'),
('ryandiaz', 'brendamathis', '2020-12-23'),
('xchase', 'moorejason', '2020-10-14'),
('edwardjordan', 'michaelhamilton', '2021-05-04'),
('zsanchez', 'xchase', '2020-04-17'),
('tzhang', 'ravenrobinson', '2020-09-10'),
('rojasandrew', 'larry22', '2023-12-29'),
('zacharymitchell', 'randy74', '2020-08-07'),
('barbaramorris', 'rojasandrew', '2023-12-23'),
('anthony91', 'barbaramorris', '2024-11-06');

-- Insert statements for table: Meal_Tag
INSERT INTO Meal_Tag (RecipeID, TagID) VALUES
(1, 104),
(1, 81),
(1, 123),
(1, 43),
(2, 78),
(2, 150),
(2, 161),
(3, 49),
(3, 41),
(3, 39),
(3, 23),
(4, 53),
(4, 142),
(4, 48),
(5, 109),
(6, 193),
(6, 139),
(6, 59),
(6, 101),
(7, 58),
(7, 113),
(8, 16),
(8, 170),
(8, 66),
(8, 14),
(8, 195),
(9, 130),
(9, 175),
(9, 10),
(9, 128),
(9, 71),
(10, 75),
(10, 182),
(10, 21),
(10, 147),
(10, 125),
(11, 121),
(11, 108),
(11, 40),
(11, 65),
(11, 55),
(12, 134),
(12, 106),
(12, 27),
(12, 9),
(12, 139),
(13, 148),
(13, 110),
(14, 125),
(14, 38),
(14, 74),
(14, 107),
(14, 83),
(15, 163),
(15, 93),
(15, 116),
(15, 32),
(16, 130),
(16, 55),
(16, 155),
(16, 31),
(17, 75),
(17, 88),
(17, 99),
(18, 146),
(18, 126),
(18, 110),
(18, 6),
(19, 134),
(19, 155),
(20, 92),
(20, 181),
(20, 201),
(20, 195),
(20, 20),
(21, 44),
(22, 153),
(22, 210),
(23, 207),
(23, 189),
(23, 201),
(24, 69),
(25, 2),
(25, 208),
(26, 123),
(27, 30),
(28, 27),
(28, 128),
(28, 36),
(29, 29),
(29, 85),
(30, 1),
(30, 110),
(30, 159),
(30, 174),
(30, 103),
(31, 63),
(31, 125),
(32, 140),
(32, 80),
(32, 77),
(32, 127),
(32, 21),
(33, 131),
(33, 125),
(33, 147),
(34, 195),
(35, 80),
(35, 90),
(36, 108),
(36, 56),
(36, 9),
(37, 98),
(38, 36),
(38, 195),
(38, 44),
(38, 133),
(38, 141),
(39, 49),
(40, 151),
(40, 67),
(40, 160),
(40, 179),
(41, 40),
(41, 75),
(41, 108),
(41, 67),
(42, 121),
(43, 47),
(43, 115),
(43, 146),
(43, 148),
(44, 207),
(44, 208),
(44, 98),
(45, 155),
(45, 130),
(45, 105),
(46, 15),
(46, 107),
(47, 87),
(47, 113),
(48, 180),
(48, 9),
(49, 164),
(49, 177),
(49, 72),
(49, 137),
(49, 29),
(50, 95);

-- Insert statements for table: Blog
INSERT INTO Blog (PublishDate, Content, Title, Username, RecipeID) VALUES
('2025-03-08 18:54:53', 'Simple drive hot front oil single five. Kid size work that manage station.
Any game yard environment. Crime air nearly. Often glass control collection at anyone age.
See I American tonight then common wear. Great drive may night soon see yet.
Turn prevent item these. Provide past add example north forward song.
Modern anything arrive help stop follow box. Response over risk issue main today.
Value reason red might state management. Time she him list.
Behind middle population animal morning. Rise rich fund involve generation information. Be nothing least religious attorney site body. Girl possible environment front arrive evening build.
Short religious herself remain. Society ahead here generation approach tough opportunity already. Tv hour brother special bit soon.
Create break standard card anyone.
Modern bar democratic kid skin might. Choose get true according.
School apply answer mention whether ten. But price strategy we bill bar ready. Show these knowledge describe there.', 'Feel property catch along.', 'brendamathis', 26),
('2025-02-01 16:51:52', 'Effect indeed professional painting do quite. Offer economic shake figure explain low pressure. Friend space various player share investment medical as.
May we material center between call. Special course beat next toward citizen no. Difference industry coach project as system.
Training message hot result yeah. Police face example.
Join vote simply hour ground. Could record audience about gun. Standard send star picture we.
Later green look whole cultural. Wind near visit key economic property similar.
Fund professional let next some dinner. Stuff agreement figure fly. Age piece air value.
Suddenly heavy guess hair area. Hope like meeting show fall part history. Know arm window must.
Chance international father allow finish. My son per standard. Nice population staff day forget west necessary.
Third pretty senior responsibility push operation. Standard term although since sing sport until. Level skill class far to but job.', 'Fight that might.', 'emily08', 40),
('2025-04-15 22:46:47', 'Me meeting computer significant. Former of nothing go enter perhaps stage happy. Nature part idea between him material thus.
Somebody create citizen strategy study. Best future medical including.
Force education father single moment. Five decision note.
Unit TV south statement present. Job understand call.
Carry send government father task technology.
Station subject most walk road significant. Vote occur figure investment point middle. Meet manager family gas on bill.
Information investment certain teacher cell especially summer. Group sort health think his and.
Option skill up marriage garden. Within century kid provide future to. Environment word difference up deal.
Action receive and. More future success church their heart.
Audience technology building Mrs. Worry suggest perform financial think toward continue. Somebody try job protect rule site seat.
Young class behavior list. Organization wife why produce black be.', 'Behind machine coach parent.', 'tsmith', 40),
('2025-04-03 17:04:57', 'Responsibility which especially budget hard century. Test human focus phone.
Process participant office yeah she.
School window capital continue chance. Ahead find night memory sea. Theory toward act game concern. Yes too argue.
Bit place meet remain. Among our state animal drug ten memory. Mission interesting hundred.
Specific half star. Window sort trade authority from officer most.
Would question those morning ball. Letter feel coach.
Long bring relationship wide Mrs rest. Board production up democratic. Brother share listen sometimes let various.
Wait help herself method. Understand attorney see almost. See certainly area want beat. Fall various choose born simple skin able.
Sound tree own these. Growth teach herself government station. Home indeed ability.
Myself listen all three. Night method free thank face hard accept. We challenge season although loss here.', 'White win policy may.', 'eholder', 30),
('2025-01-02 23:47:05', 'Certain collection kind particularly. Moment teacher time study cover hotel.
It one machine movement. Trouble control on situation dark involve instead.
Total some ten. Use it serious road everybody chair meet public.
Explain beyond get street. Police remember here model skill marriage minute.
Area program question different new region. Police sort suddenly fight. Likely audience per defense that few kid.
Month read security grow alone nor. Born current him bill.
Let also cost radio sea might there. Truth TV institution sing former.
Artist leader quite want. Surface body worker.
Decision although later beyond federal year. House design bad dream this return.
Green statement goal oil left. Administration gun hold nation. Billion event over wife new.
Lead whole bit option. Break respond tend he item painting technology those. Career heavy produce operation life this election.
Response itself line. Size and build how tend.', 'Imagine south those.', 'victoria20', 1),
('2025-03-02 03:12:35', 'Night field memory hundred door various. Conference car member Democrat.
Bag sort old five. World news model hit.
Hour suddenly experience education side. Individual avoid black blood.
Left lose must husband. Our former future foot.
Human everybody agency my. About beat think might listen.
Model left find stop. Charge son loss. Hair since color might southern condition professor.
Program lot party community good finish trial. Short star newspaper. Third compare science relationship cold despite population.
Billion something national customer recent if school across. Institution official suggest benefit actually. Do eye wear write walk.
Us place southern Mrs court loss. Charge here item must side huge management. Current significant small step so above.
Clearly national eye ever stop half. Point sing customer during process watch hour blood.
Unit statement local professional indicate camera. Too drive memory actually. Support though nation address.', 'Where own attorney purpose close.', 'emily08', 32),
('2025-01-07 21:54:38', 'Hand such suddenly democratic science sell. Attack exist end western stuff.
Professional create people fill central run. Forward whose seem. Friend finally benefit their machine thought TV camera.
Success home four low most. Question wind west. Sport almost suggest everybody. General research miss wide.
Office society measure blood. Take from summer mean reality movie. Board parent last perform.
Woman way citizen own. Last water discuss thank character just.
Weight little maintain expert American red agreement answer. Fish talk contain serve main get very I. But region area bank.
Raise sure local without ground be hair. Focus she more worry. Picture time word.
Soon final professor more various body here. Move cup page partner Mr practice development.
Son particular grow look painting role. Bit subject party.
Brother debate let case hundred simple. Say fight sign feeling.
Whether visit sure able. Say morning every about loss.', 'Win improve play situation.', 'zburton', 50),
('2025-04-12 21:30:21', 'Yet entire attack. Economy direction all until arrive.
Heavy Mr model music decide others. Entire staff girl morning.
Become season create pull standard.
Try get center increase.
Between me whom state animal large few. State woman become shoulder commercial stage.
Back Congress strategy rule concern environmental. Economic someone within front without anyone. Air then thus.
Here sell daughter sea. View early suffer until. Data service attention receive.
Floor edge home write however. Cultural even music thing black sign.
Skin minute everybody father agreement politics national. Rock a benefit whatever role there according approach. Though everybody Mr face region.
Authority late position few economy relationship. Ability region nothing economic best style might hundred.
Trip possible building close themselves marriage. Officer small face care appear.
Someone idea sea lay. Address good tree way.
American him gas stage product audience. Discover article off simply population form onto.', 'Star spend.', 'skelley', 26),
('2025-01-06 06:25:56', 'Involve watch identify lose share. Prepare subject response recently. War senior another how.
First total door admit against if consumer. Daughter wear side cultural employee.
Mouth business interest yes its religious alone effect. Involve her meet interview business.
Idea my occur cup still. Job relationship with water.
Kid since eat perhaps home. Oil well choose partner a consumer.
Method draw late myself get other whether. Nice campaign participant film none above. Arm just mention plan take myself read.
Ready institution college relate air reflect. Development cover magazine middle such. Method cover product cause still religious medical.
Manager decade old life court pay scene. Economic state month however left responsibility.
Market begin worker condition. Must catch few college occur son child. Always fine generation rich.
Pull company all especially sure. Fund deal whom child.
Company sit since side. Hand age rich term woman write certainly growth.
Concern most page suggest.', 'Nothing thank sense water.', 'tzhang', 43),
('2025-03-19 14:10:40', 'Will like your behavior. Across real quality animal notice staff near.
Cup adult believe describe ask.
Visit ten themselves sport. Recent exist answer dinner side. Degree right maybe claim.
Painting movement knowledge great me home media. Yes probably charge scientist.
Able finally laugh dinner range tax inside. Security knowledge affect true.
Situation majority more hot particularly reduce. Oil cup color drug on threat. Star account citizen with provide. Southern challenge late second name former school.
Decision eight late usually. Interview court career stop.
Later court before stand let huge really defense.
Pull day forward skill brother chair rich. Produce fine mission or.
Piece common Mrs history number start address.
Concern her decision from civil. Kind forget water cover nothing system argue.
Soldier share car hotel music send. Idea market director and easy. Board discuss gun industry.', 'Treatment indeed and.', 'chenlaura', 27),
('2025-02-19 07:08:06', 'Development even employee worker five speak represent small. Possible subject go. Five establish size majority maybe history.
Fund factor than citizen television personal. Threat occur account will TV.
A card office economic. Under child enough response.
Room one fast yourself nation. Plant someone camera thank plan pay film station. Control support student raise eye role left.
Public bag clearly through physical. Feel lawyer growth among hot.
Might great manager full how future never. Money suggest writer bag home. Left lead scientist. High plant summer win member rest.
Window blood approach talk skill time day. Different more attorney relate most daughter. South learn plan successful practice wrong.
Win order pass budget. Cover nothing miss carry firm.
Detail spring sound care. Bill clearly billion they wife president cold.
Impact wonder girl teacher road look.', 'Force final start executive while.', 'zacharymitchell', 49),
('2025-01-02 11:16:32', 'Game skin fine. Until activity enjoy race find.
After always think among hold respond forward. Turn research thing another next try debate. Rule travel individual shake involve.
Report one president worry study show. Summer result wide large have arrive. Account reveal ground note school.
Simple side think fund western wear. No town rich. Allow poor any pull.
How become he particular agent specific.
Against product our age. Small half story.
Once loss spend have test participant ten. Head similar federal agree movie. Risk sea agent himself candidate everybody.
Not west tonight. Strong continue weight morning sound at.
Always plant community light Mr effect. Play million both scene. Control hard security.
Certainly day feel myself chance unit. Able suggest defense kitchen reach.
Black rule collection another. Investment very together show spring spring over. Central speak structure sea study me.', 'Compare audience.', 'ravenrobinson', 22),
('2025-01-24 07:09:06', 'Trip yard enter rule. Process drop song. How exist environment send. Work strategy stock peace modern cup our.
Other station where similar since quickly. Floor truth eye spring cold. You century follow order exactly market likely certainly.
Piece whether model somebody fly notice. Purpose what art safe finish speak.
Since group tough democratic community. Program statement article figure fund feeling popular. Mind notice mouth kind rate some.
Movement think issue subject its ago available. Close participant him focus green she.
Effort company perform claim although sing reality. Shake fall recognize expert several money method number.
Management agent few glass. Sound like also.
School property add I. Reveal foreign town executive increase necessary prepare. Meeting be spend bag.
Include set fund should. Physical page with popular will.
Boy help join occur. Everything evening four course responsibility. Member than professional treatment serious until performance.', 'Play across wind dark.', 'brianblack', 8),
('2025-01-03 16:49:19', 'Unit prepare strategy head weight view door painting. Ago send media office. To next hope organization after across personal I.
Dog contain language bar baby. Five test understand impact husband book. Black TV young risk area rise.
Although reason which out. Success recognize still.
Pull interesting white behind think even professional. Very voice call.
Organization left born change. Full marriage until treatment develop service.
Day safe car herself little painting. Much short between give realize foreign.
Kid why small war. That decision beat management. Discussion determine several.
Next dog wind fine glass. Official analysis what senior game statement decade sound. It mention arm fine brother best.
Matter approach safe job not certain boy learn. Car Mrs body woman nature interesting. Voice some feel win official. Thing plan analysis series.
Page number later land. Or form identify pull manage. Report improve light official modern.', 'Official suddenly play interest.', 'carmenjohnson', 6),
('2025-02-24 10:11:05', 'Month family with church region hour still. Sell picture even recently mother.
Exactly body west decade old.
Short half move chance fast explain. Police hour determine gas reflect service traditional.
Price happen through. Return reduce month audience event role data.
Car type front oil pretty because deal without. Bank avoid officer these forget leg. Relate them she along feeling cut figure.
Local free debate model raise that. Economic affect spring bar care show.
Century within recognize enough. Watch painting return one already change.
Test they food good paper strong challenge believe. World mission his price couple nature.
Stay try quickly. Move traditional condition pattern best.
Great response address well. It home defense project.
Challenge since check.
Break song toward most issue popular. Walk safe low throughout current spring put difference.
Respond base behind teach plan enter standard.
Modern together part pass tend or red. Only right provide sit herself.', 'Organization away mind apply.', 'larry22', 48),
('2025-02-22 03:14:07', 'Unit themselves window understand. Sister hot travel society magazine since hand.
Inside defense cover reveal. Ten us president. Not over himself get.
Campaign might approach health they finally.
Turn about beat. Lawyer half mission finally remain drop listen level. Minute cell activity type line inside strategy central.
World important white person other kid particular. Keep form movement only. Generation prevent piece.
Indicate three project democratic until develop. Treatment born kid trade morning change standard. Tv poor blood kind I level.
Source media media though. Itself personal hospital poor create image key. Five most employee discussion.
Foreign suddenly military rise matter particular. Stay age main middle impact. Range organization plan page paper should significant.
Others century modern to life increase. Memory watch during article him. Her these industry goal.
Kitchen activity thousand reflect fly call. Town resource specific information box.', 'Study against.', 'melanievelazquez', 32),
('2025-03-28 03:00:22', 'Congress hundred firm because. Politics seek study accept civil cold test. Stand religious sell grow late perhaps bring. Still dream response maybe.
Soon hotel wind morning arm. Cold general financial. What boy TV from.
Usually trade impact size. Often option brother major pretty. Later standard his knowledge type.
Car court resource officer in. Tv anything early loss style enough determine.
Station few buy consider majority left within. Market culture last executive while prepare.
Dog ever hope place hair benefit catch. Image player leader training before bad camera. Official particularly brother state six shake.
Fall body among speak yeah option. After year nothing best myself really. Value upon fine though head.
Or possible central firm ball. Green today never mission. Thank man nature treatment office my.
Itself grow bank law.', 'Know administration drive building.', 'zsanchez', 29),
('2025-02-05 06:08:41', 'Song edge project. Response drive nature personal.
Movie message set news by discussion. Often budget individual into.
Nothing member structure truth figure despite glass. Skill before street onto want behind.
Easy teacher especially skill study soldier. Understand even record hard north more. Left stop message high protect.
Base your child write detail sell authority beat. Skin can season hard. Study middle down half.
Feel catch image garden ask concern still. Where card security knowledge war character assume.
Article never story or arrive. Glass first study day trade visit.
Learn fast girl trade perhaps of technology concern. Exactly among determine.
Party seem medical police reason. Identify perhaps reflect them. Nothing our visit return.
Send question number Mr two stage. Great yes event clearly ready best. Cause administration clearly kind they vote something.', 'Against significant four.', 'larry22', 32),
('2025-01-09 09:00:09', 'Company data establish development color nothing. Language edge them much especially author language.
Age policy somebody change sit. Risk speech cell home. Debate school usually note skin authority.
Bring travel treatment remain. Write Mrs whose woman site short piece. Many early history raise agency after.
Analysis source gun else trip note.
Design military laugh again lot area fire. Southern bar cause blue appear once process hit.
Activity go meeting will medical. Store forward necessary.
Thing anyone owner rock stay. Military reduce contain future. Note kind fire out.
Nor well site poor century it. Reveal board save suffer sort. Later let like themselves research. Discuss report example air bad pick discover.
Cup for west. Draw majority nor maybe or money.
Each people get easy. Culture which represent alone instead material.
Buy above member it produce open. Myself visit during choose fight certain animal prove.', 'Ago feeling stock.', 'zburton', 18),
('2025-02-26 16:37:58', 'Same young travel choice writer notice everybody enjoy. Because because herself above. Drop or risk western form agent thing.
Prove go poor toward land race main. Create expert interview policy idea race. List thus traditional business writer point.
Onto cost painting thus. Environmental identify position increase success occur.
Always protect base place sport. Reality nothing class process raise size fly I. Image purpose call experience structure heavy candidate.
Boy also continue tell structure begin total year. Threat go game that without. Moment family well ten like.
Head perhaps interest edge. General police business can benefit.
Reflect half decade find bill. Reason trial each expert.
Red full provide. Picture green bad middle quite medical. Few say even whom drive.
Life rate popular difference very could. To she your generation like others.
Per poor stand reflect kid.
Worry newspaper score show. Instead others fact.', 'Himself number doctor.', 'michaelhamilton', 22),
('2025-01-05 09:08:44', 'Suffer west age center agreement his. Performance section speak since according simple.
Join trouble partner even class minute seem. Know similar left if on low. Hundred civil success a theory.
Process discover water whether century production. Recently sing determine. Century machine industry say language west tree.
Happy sign any minute official. Age method term listen. Product one international quality store act.
Result right husband list seven action world. Teacher guess court also administration employee. Executive scientist executive game energy than. He middle society quality.
Film grow method change.
Run scene late worry hope. Such source teach voice but challenge.
Can various woman a factor more war. Set upon involve trade recent yard.
To continue free style. Person back inside both everybody determine.
Body television late food deal attention. Project fine nearly election get leg out. Side quickly something administration.', 'Indeed exist cut yard second.', 'chenlaura', 38),
('2025-02-13 12:53:06', 'Consumer suffer often subject simple first great. Note face service culture TV edge. Effect magazine item wall.
Someone radio artist skin office point. Serve whole story. West report Democrat well guy nothing American. Really rest tree.
Front why letter stage. Hospital modern from direction they live range pull.
Town name industry color cost end.
Across community require fact just time ahead language. Expect police expert media evening early certain.
Although kid second view reduce book out. Management whom impact character.
Fine choice manage high cost choose toward.
Write degree tough including center. Job right coach me. Less point person budget hope be state.
Lot court throughout market interview. Food build this stay read whom time.
Cause power each course network toward drug. Move fast capital somebody both floor lead land.
Tough foot bank. Among career coach small whether fact note.
Box describe blood rather stop read kid. World be summer.', 'Current employee enjoy create.', 'melanievelazquez', 23),
('2025-04-13 03:33:58', 'Main cell wrong bar. Before teach choose my.
Third according nor. Its provide compare police center usually. Realize whatever plant decade note fish.
World cut challenge difficult model. Wide conference little seat popular. Letter impact coach still.
Event million policy economic just world relationship. Laugh these despite anything drop learn fine physical. Beyond color since nice region them born.
Lose fly series bag list boy page. Teach response possible. Physical not yet what network statement necessary. South audience yet.
Movie him more wall raise important professional. Hard before street various. Laugh weight measure author defense look.
Glass out clear single he between place south. Operation care beautiful feel. Rise design ask yourself hold federal Mr.
Activity ahead oil contain check memory. Generation many human have impact.
Concern person example effect evening grow. To nation total.', 'Already movement.', 'brendamathis', 10),
('2025-03-18 01:06:56', 'Own surface first article report. Can artist nothing support test month learn. Focus gas society clearly election.
So drive big author.
Step one view speak bit window skill course. Bag international may or usually available statement.
Structure cover agree miss by put white question. Try become myself visit though. Fast capital hotel the yet structure. On key well professional fast.
Suffer figure produce sound real. Either end name side finish because side. Require big hope still.
Realize performance bad issue each air. Red staff them pressure reach.
Admit possible wind daughter plan newspaper. Hundred the phone visit director range speak picture. Himself no woman institution know.
Peace scientist almost approach. Sign husband wide message from option spring.
Even community building current institution. Democrat mission peace rock part organization. Music though industry study guy. Good effect health music.
Administration audience measure dark across a.', 'Guess follow close far.', 'richardbird', 49),
('2025-01-22 17:35:48', 'While story help team. Attack research inside play include crime stay. Eight security any shoulder thus carry.
Community much unit its middle. Purpose after sense structure month arm instead. Visit entire section mind carry every only. Hospital soon civil training there short sing.
Hour present deal adult discussion data serious action.
Place especially decide message bag possible understand. Present interest right.
List including simple central can. Organization face fact any their. Structure decide second heart police miss summer cell.
Environment everyone alone officer debate. Low from commercial type skin free tree. Name despite here increase tree local. Story help allow air woman different point rock.
Ok bank record lay charge.
Same early success weight movie hair spring. Social word direction democratic necessary prove drug.
Here view draw Democrat listen entire current law. Method miss state game attack control agree Mr. Order performance adult measure word respond.', 'Control protect turn respond.', 'randy74', 16),
('2025-02-27 16:50:25', 'Agreement air risk other knowledge list better. Body knowledge there agency. Way country choose hair method.
It development course cover. Heart network share not forget financial last. A movement up war response. Cause specific just short yard first.
Already network her hold need understand every institution. Mr song across value bank recent later admit.
Tv impact then detail represent. Benefit car half example goal rate. Age table agree attack rise bill.
Camera boy here remember eight office rock. Art anyone region ability word actually.
Station establish rest event book tax. Wall movement stock.
Research former price southern.
Consider explain professional leave. Source feel nothing from. Professional suddenly impact crime give hotel. Population yeah front lot read away rise.
However weight control across.
Top cup source thing. We away quickly themselves become a degree.
Girl certain early need law nature training condition. Boy study west expert ok former.', 'Effect simply purpose.', 'tzhang', 25),
('2025-04-05 12:10:44', 'Day general concern story discuss only future. Control seem daughter side. Nearly course of almost church company fine.
Product article soon system. From provide rather sometimes ten. Leader sense assume machine development medical certainly.
Spring themselves treatment market during city popular. Case and want society.
Sure industry long wrong. Environmental before decision according. Responsibility head maintain state writer than answer.
Task such wrong rise soldier successful himself. Ahead treatment follow board minute impact particularly.
Identify step future player care. Thing accept claim around. Issue drive then point unit maybe. These claim ground go so control surface.
Sit southern hit expert sit. If laugh seek nature friend morning.
Finish require soon. Question house Congress care. Professor list few spend name wait.
Floor effort candidate fall bag final. Suggest staff business let receive sign apply reason. Song attorney message myself.', 'Analysis stay consider partner.', 'zburton', 15),
('2025-02-10 18:24:21', 'Board after bag. Three their quite most day whether star. Dog middle professor adult whole hospital debate.
Professional as loss discussion room. Real among son per.
Interest serious there age one. How long take on.
Arrive method range effort management near. Just television system discover.
Our kind land decision. Easy likely probably idea painting.
Treatment person air yard analysis minute. Spring heavy call lot. Member itself benefit usually.
Throughout building morning fly cold move billion turn. Moment wall into rich certain. Century lose money middle. Sign carry situation church memory property.
Compare night machine kitchen still maintain to. Along pattern candidate dream gun provide.
Product during since add sit. Clearly available product view benefit dream race. Each law example hotel people who option.
Describe big value ahead everything. Simple certainly magazine.
Young subject order in. Behind spring reflect behind free whom. Act fall somebody just while suffer miss.', 'Ask economic establish.', 'edwardjordan', 31),
('2025-03-25 03:53:44', 'Spring great by animal seven clear. Camera bill friend oil west door among. Civil really memory time wall.
Behavior physical eight need. Process grow long coach.
Whole teach relationship stop.
Assume either answer take specific road rich series. Tough method concern. Everybody magazine pull success inside theory.
Interest down own song.
Point although save western. Agent ever change describe. Child think case wind guess choose city production.
Provide enter staff group when page wrong.
Among important pretty believe investment product. Oil gun all point admit learn democratic. Measure that officer able raise daughter though.
Make bank human local too after ready above. Provide either people fly opportunity argue boy. Past power onto attention check.
Challenge something name difference through local relationship. Travel hundred shake detail well before. Term weight likely professional avoid.', 'Write reduce never.', 'skelley', 8),
('2025-02-16 16:25:50', 'Clearly wide provide event light instead. Fire social understand know. Contain evidence discussion page green staff how.
Player investment back game fish strong. Mother wish call back start.
So people each five somebody. Relationship risk study. Part process star education away but.
Data part apply wrong. Traditional financial once someone avoid interview issue care.
It analysis against thousand notice. Program various entire hospital but card. New service increase power.
Hot ten education with fly. Beat plan item myself support. Their letter region.
Quality experience first answer. Push identify son physical far hold appear whom. By political within shoulder.
Indeed only special key must view television. Summer decision woman remain out daughter short. Two mission discover choice.
Treatment less fish have specific realize as meeting. Give seek bag want shoulder imagine report knowledge. Something continue challenge skin cover white.', 'Hospital author.', 'zsanchez', 16);

-- Insert statements for table: Blog_Meal
INSERT INTO Blog_Meal (BlogID, RecipeID) VALUES
(1, 50),
(1, 25),
(2, 12),
(2, 49),
(3, 33),
(3, 13),
(4, 50),
(4, 27),
(5, 2),
(6, 11),
(6, 6),
(6, 35),
(7, 25),
(8, 45),
(9, 26),
(9, 16),
(9, 22),
(10, 2),
(10, 42),
(11, 39),
(11, 37),
(11, 14),
(12, 13),
(12, 15),
(12, 7),
(13, 50),
(14, 14),
(14, 24),
(15, 2),
(16, 19),
(16, 23),
(17, 14),
(17, 41),
(17, 15),
(18, 40),
(19, 17),
(20, 13),
(20, 42),
(21, 13),
(22, 40),
(22, 46),
(22, 47),
(23, 25),
(23, 39),
(24, 22),
(24, 37),
(24, 34),
(25, 42),
(26, 49),
(26, 17),
(26, 11),
(27, 47),
(28, 16),
(29, 36),
(29, 41),
(30, 42),
(30, 30);

-- Insert statements for table: Saved_Meals
INSERT INTO Saved_Meals (Username, RecipeID) VALUES
('kevinbaird', 20),
('kevinbaird', 45),
('kevinbaird', 17),
('kevinbaird', 37),
('kevinbaird', 38),
('kevinbaird', 14),
('kevinbaird', 31),
('kevinbaird', 44),
('kevinbaird', 35),
('xchase', 6),
('eric86', 34),
('eric86', 36),
('eric86', 39),
('eric86', 46),
('eric86', 42),
('eric86', 12),
('eric86', 29),
('daniel73', 33),
('daniel73', 16),
('daniel73', 43),
('daniel73', 17),
('daniel73', 32),
('brianblack', 13),
('brianblack', 37),
('brianblack', 23),
('brianblack', 46),
('brianblack', 33),
('brianblack', 35),
('brianblack', 34),
('brianblack', 27),
('skelley', 1),
('skelley', 30),
('skelley', 9),
('skelley', 22),
('ryandiaz', 6),
('randy74', 48),
('randy74', 4),
('rojasandrew', 4),
('rojasandrew', 5),
('rojasandrew', 37),
('rojasandrew', 44),
('rojasandrew', 35),
('anthony91', 30),
('anthony91', 6),
('anthony91', 34),
('brendamathis', 25),
('brendamathis', 38),
('brendamathis', 50),
('brendamathis', 48),
('brendamathis', 27),
('brendamathis', 30),
('brendamathis', 16),
('brendamathis', 29),
('brendamathis', 9),
('zacharymitchell', 16),
('zacharymitchell', 50),
('zacharymitchell', 18),
('zacharymitchell', 28),
('zacharymitchell', 26),
('zacharymitchell', 47),
('zacharymitchell', 48),
('zacharymitchell', 5),
('zacharymitchell', 12),
('zacharymitchell', 3),
('james41', 26),
('carmenjohnson', 43),
('carmenjohnson', 25),
('carmenjohnson', 34),
('carmenjohnson', 22),
('carmenjohnson', 20),
('richardbird', 41),
('richardbird', 45),
('richardbird', 14),
('richardbird', 1),
('harrelljennifer', 24),
('harrelljennifer', 21),
('harrelljennifer', 8),
('harrelljennifer', 44),
('harrelljennifer', 38),
('harrelljennifer', 30),
('harrelljennifer', 22),
('harrelljennifer', 18),
('harrelljennifer', 9),
('wilkinsjaime', 25),
('wilkinsjaime', 39),
('emily08', 36),
('emily08', 18),
('emily08', 38),
('tzhang', 20),
('tzhang', 45),
('tzhang', 49),
('tzhang', 15),
('zburton', 21),
('zburton', 19),
('zburton', 43),
('zburton', 9),
('zburton', 34),
('deborah13', 29),
('deborah13', 14),
('deborah13', 1),
('deborah13', 4),
('deborah13', 46),
('deborah13', 27),
('deborah13', 12),
('deborah13', 15),
('deborah13', 32),
('deborah13', 23),
('michaelhamilton', 21),
('michaelhamilton', 3),
('michaelhamilton', 15),
('michaelhamilton', 2),
('michaelhamilton', 31),
('eholder', 35),
('eholder', 14),
('eholder', 31),
('barbaramorris', 35),
('barbaramorris', 31),
('barbaramorris', 25),
('barbaramorris', 38),
('barbaramorris', 44),
('edwardjordan', 31),
('edwardjordan', 47),
('edwardjordan', 22),
('edwardjordan', 49),
('zsanchez', 5),
('zsanchez', 21),
('zsanchez', 31),
('zsanchez', 39),
('zsanchez', 42),
('zsanchez', 49),
('zsanchez', 45),
('zsanchez', 11),
('zsanchez', 10),
('zsanchez', 30),
('kimberlysharp', 2),
('kimberlysharp', 24),
('kimberlysharp', 40),
('larry22', 23),
('larry22', 46),
('larry22', 36),
('larry22', 10),
('victoria20', 17),
('victoria20', 12),
('chenlaura', 39),
('chenlaura', 16),
('chenlaura', 29),
('chenlaura', 7),
('chenlaura', 9),
('chenlaura', 28),
('ravenrobinson', 4),
('ravenrobinson', 16),
('ravenrobinson', 21),
('ravenrobinson', 17),
('ravenrobinson', 46),
('ravenrobinson', 25),
('ravenrobinson', 35),
('ravenrobinson', 32),
('ravenrobinson', 12),
('johnsonsteven', 37),
('moorejason', 10),
('moorejason', 38),
('moorejason', 28),
('moorejason', 2),
('moorejason', 45),
('moorejason', 16),
('moorejason', 4),
('moorejason', 43),
('moorejason', 48),
('moorejason', 39),
('melanievelazquez', 7),
('melanievelazquez', 21),
('melanievelazquez', 28),
('melanievelazquez', 49),
('melanievelazquez', 32);

-- Insert statements for table: Added_Meals
INSERT INTO Added_Meals (Username, RecipeID) VALUES
('kevinbaird', 7),
('kevinbaird', 6),
('kevinbaird', 26),
('xchase', 5),
('xchase', 46),
('eric86', 36),
('daniel73', 23),
('daniel73', 19),
('brianblack', 39),
('brianblack', 40),
('brianblack', 45),
('brianblack', 32),
('skelley', 38),
('skelley', 15),
('skelley', 22),
('ryandiaz', 50),
('ryandiaz', 22),
('ryandiaz', 20),
('ryandiaz', 36),
('ryandiaz', 14),
('randy74', 18),
('randy74', 19),
('rojasandrew', 34),
('rojasandrew', 27),
('rojasandrew', 26),
('rojasandrew', 42),
('anthony91', 49),
('brendamathis', 37),
('brendamathis', 22),
('zacharymitchell', 15),
('zacharymitchell', 39),
('zacharymitchell', 19),
('zacharymitchell', 18),
('james41', 26),
('james41', 30),
('james41', 4),
('carmenjohnson', 43),
('carmenjohnson', 2),
('carmenjohnson', 48),
('carmenjohnson', 39),
('richardbird', 16),
('richardbird', 2),
('richardbird', 36),
('tsmith', 6),
('wilkinsjaime', 30),
('wilkinsjaime', 27),
('wilkinsjaime', 47),
('wilkinsjaime', 36),
('tzhang', 33),
('tzhang', 29),
('zburton', 22),
('zburton', 30),
('zburton', 48),
('deborah13', 10),
('michaelhamilton', 41),
('barbaramorris', 49),
('barbaramorris', 39),
('barbaramorris', 42),
('barbaramorris', 32),
('barbaramorris', 19),
('edwardjordan', 22),
('edwardjordan', 24),
('edwardjordan', 18),
('edwardjordan', 34),
('edwardjordan', 2),
('zsanchez', 13),
('zsanchez', 44),
('zsanchez', 10),
('zsanchez', 9),
('zsanchez', 49),
('kimberlysharp', 26),
('kimberlysharp', 23),
('larry22', 2),
('larry22', 35),
('larry22', 46),
('larry22', 44),
('chenlaura', 4),
('ravenrobinson', 6),
('ravenrobinson', 7),
('ravenrobinson', 9),
('ravenrobinson', 38),
('ravenrobinson', 22),
('johnsonsteven', 43),
('johnsonsteven', 9),
('johnsonsteven', 5),
('johnsonsteven', 3),
('johnsonsteven', 23),
('moorejason', 7),
('moorejason', 5),
('melanievelazquez', 18),
('melanievelazquez', 8),
('melanievelazquez', 13),
('melanievelazquez', 32),
('melanievelazquez', 19);

-- Insert statements for table: UserDemographic
INSERT INTO UserDemographic (Username, GroupID) VALUES
('kevinbaird', 15),
('kevinbaird', 3),
('xchase', 13),
('xchase', 11),
('xchase', 3),
('eric86', 12),
('eric86', 9),
('daniel73', 7),
('daniel73', 8),
('brianblack', 18),
('brianblack', 3),
('skelley', 5),
('skelley', 14),
('skelley', 8),
('ryandiaz', 15),
('randy74', 7),
('randy74', 17),
('randy74', 13),
('rojasandrew', 16),
('rojasandrew', 3),
('anthony91', 8),
('anthony91', 3),
('anthony91', 12),
('brendamathis', 6),
('brendamathis', 2),
('zacharymitchell', 3),
('james41', 15),
('james41', 2),
('james41', 8),
('carmenjohnson', 11),
('richardbird', 13),
('richardbird', 14),
('richardbird', 18),
('harrelljennifer', 10),
('harrelljennifer', 11),
('tsmith', 6),
('tsmith', 2),
('tsmith', 15),
('wilkinsjaime', 3),
('wilkinsjaime', 10),
('wilkinsjaime', 16),
('emily08', 14),
('tzhang', 14),
('zburton', 6),
('zburton', 13),
('zburton', 3),
('deborah13', 13),
('deborah13', 9),
('michaelhamilton', 16),
('michaelhamilton', 6),
('eholder', 5),
('barbaramorris', 2),
('barbaramorris', 4),
('edwardjordan', 16),
('edwardjordan', 9),
('zsanchez', 4),
('kimberlysharp', 15),
('larry22', 6),
('victoria20', 1),
('chenlaura', 13),
('ravenrobinson', 5),
('johnsonsteven', 6),
('johnsonsteven', 7),
('moorejason', 7),
('moorejason', 8),
('moorejason', 1),
('melanievelazquez', 3),
('melanievelazquez', 14),
('melanievelazquez', 17);

-- Insert statements for table: RecipeData
INSERT INTO RecipeData (Name, SavedStatus, CategoryID, ViewCount) VALUES
('Factor necessary.', 0, 7, 614),
('Hour interest.', 1, 7, 154),
('Development fire most.', 0, 1, 664),
('Cold black arrive.', 1, 4, 155),
('President force campaign.', 0, 1, 154),
('Blue environmental.', 1, 4, 68),
('School nature.', 1, 8, 997),
('Until traditional learn.', 1, 6, 695),
('Form main.', 1, 2, 699),
('Including morning hot some.', 1, 8, 379),
('Here national.', 0, 1, 688),
('Second foot develop.', 1, 1, 520),
('Strong no husband.', 1, 5, 284),
('Debate each.', 0, 1, 174),
('Decade police.', 0, 6, 77),
('Catch culture.', 0, 4, 838),
('Expert and.', 0, 1, 789),
('Hear policy few draw.', 1, 7, 484),
('Study alone challenge.', 0, 5, 852),
('In southern.', 0, 3, 371),
('Head someone.', 0, 3, 787),
('Particular lot.', 1, 8, 863),
('Front.', 1, 5, 512),
('His daughter common level.', 0, 7, 10),
('Fast let.', 0, 3, 724),
('Front wind.', 0, 4, 717),
('Meeting according.', 0, 8, 408),
('Face region just.', 0, 3, 804),
('Yard poor.', 1, 1, 909),
('Throw.', 1, 5, 166),
('Half Mrs.', 0, 6, 189),
('Social theory if.', 1, 8, 765),
('Investment change later.', 0, 8, 941),
('Expect discover.', 0, 5, 373),
('Every unit million.', 1, 6, 745),
('Thing concern since.', 0, 1, 189),
('Agree bed line.', 1, 5, 56),
('Individual hope.', 0, 3, 262),
('Bank.', 0, 1, 987),
('Process body evidence.', 0, 4, 779),
('Human close letter.', 1, 4, 877),
('Coach dinner.', 1, 6, 363),
('Third own.', 0, 1, 835),
('Keep owner.', 0, 2, 245),
('Improve two.', 0, 3, 17),
('Direction generation policy.', 1, 8, 838),
('Especially exactly.', 1, 6, 181),
('Any research need bring.', 1, 3, 202),
('Suggest theory animal.', 1, 5, 755),
('Challenge as.', 0, 7, 942);

-- Insert statements for table: Interaction
INSERT INTO Interaction (Username, RecipeID, InteractionType, Timestamp) VALUES
('johnsonsteven', 1, 'Comment', '2025-03-10 04:33:34'),
('ravenrobinson', 44, 'Like', '2025-03-20 00:17:47'),
('zacharymitchell', 10, 'Like', '2025-02-11 14:53:11'),
('brendamathis', 12, 'Comment', '2025-03-24 08:57:28'),
('carmenjohnson', 26, 'Comment', '2025-01-28 05:43:49'),
('eholder', 17, 'Share', '2025-03-10 00:56:15'),
('ravenrobinson', 27, 'Like', '2025-03-06 07:50:21'),
('ryandiaz', 49, 'View', '2025-02-26 00:55:56'),
('brianblack', 14, 'Share', '2025-02-15 02:01:18'),
('zacharymitchell', 31, 'View', '2025-03-01 01:50:06'),
('wilkinsjaime', 12, 'Comment', '2025-01-05 14:09:04'),
('ravenrobinson', 5, 'Like', '2025-01-17 07:27:29'),
('james41', 13, 'Share', '2025-01-23 19:49:57'),
('melanievelazquez', 48, 'View', '2025-03-02 17:10:54'),
('moorejason', 8, 'Share', '2025-02-27 07:43:19'),
('wilkinsjaime', 44, 'View', '2025-02-14 16:26:18'),
('harrelljennifer', 43, 'View', '2025-03-12 06:31:50'),
('james41', 12, 'Comment', '2025-04-15 19:21:33'),
('chenlaura', 45, 'Share', '2025-02-27 14:34:11'),
('kimberlysharp', 50, 'Share', '2025-03-15 08:30:13'),
('edwardjordan', 11, 'Like', '2025-01-31 15:19:48'),
('ravenrobinson', 1, 'Like', '2025-02-19 00:44:46'),
('edwardjordan', 24, 'Comment', '2025-02-26 07:44:11'),
('eric86', 22, 'Comment', '2025-03-11 16:16:20'),
('deborah13', 27, 'Share', '2025-02-22 13:38:01'),
('harrelljennifer', 13, 'Comment', '2025-02-19 16:35:48'),
('kevinbaird', 40, 'Comment', '2025-01-04 06:21:59'),
('richardbird', 26, 'Comment', '2025-01-18 21:44:13'),
('carmenjohnson', 34, 'Like', '2025-02-08 12:34:14'),
('michaelhamilton', 5, 'Share', '2025-02-26 04:28:41'),
('carmenjohnson', 8, 'View', '2025-03-26 10:46:44'),
('eholder', 50, 'Like', '2025-03-03 08:43:38'),
('victoria20', 27, 'Share', '2025-04-01 17:12:05'),
('ryandiaz', 7, 'Share', '2025-04-09 12:27:10'),
('brianblack', 4, 'Like', '2025-01-06 06:16:27');