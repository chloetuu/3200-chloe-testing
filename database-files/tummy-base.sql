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
<<<<<<< HEAD
    follow_date DATE DEFAULT (CURRENT_DATE),
=======
    follow_date TIMESTAMP,
>>>>>>> 9549aee8ef1634b78f7b2ec91ae0bb227641d44b
    PRIMARY KEY (follower_id, followee_id),
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


-- AUTO-GENERATED SQL INSERT STATEMENTS


-- Insert statements for table: Added_Meals
INSERT INTO Added_Meals (Username, RecipeID) VALUES
('smiller', 8),
('tyler63', 19),
('williamholt', 9),
('antonio70', 33),
('patrick93', 26),
('xallen', 27),
('hallbrandi', 19),
('xallen', 8),
('sotomeghan', 30),
('mcarrillo', 32),
('xwilliams', 1),
('smiller', 16),
('hallbrandi', 16),
('johnny76', 14),
('bbaker', 24),
('jenniferchambers', 19),
('jenniferchambers', 15),
('andres57', 32),
('dunnapril', 1),
('stevenstewart', 21),
('xallen', 7),
('mendezrussell', 8),
('mmitchell', 16),
('pmorgan', 19),
('mmitchell', 5),
('dunnapril', 26),
('saramccarthy', 30),
('jenniferchambers', 34),
('ucook', 14),
('antonio70', 1),
('dpage', 22),
('glasspatrick', 9),
('antonio70', 23),
('smiller', 18),
('mendezrussell', 34),
('williamholt', 31),
('pmorgan', 4),
('sotomeghan', 16),
('erinharris', 5),
('curtiscollier', 26),
('dunnapril', 34),
('ucook', 17),
('dunnapril', 15),
('stewartgabriel', 13),
('stevenstewart', 12),
('saramccarthy', 14),
('mjohnson', 18),
('bbaker', 29),
('erinharris', 18),
('marksanchez', 35),
('tyler63', 26),
('mjohnson', 32),
('saramccarthy', 2),
('williamholt', 12),
('walkerwendy', 13),
('ucook', 23),
('andres57', 34),
('stevenstewart', 9),
('pmorgan', 25),
('erinharris', 13),
('curtiscollier', 19),
('bbaker', 8),
('bbaker', 1),
('marksanchez', 17),
('marksanchez', 28),
('walkerwendy', 12),
('ycook', 30),
('mendezrussell', 26),
('christopherthomas', 1),
('mendezrussell', 9),
('mmitchell', 20),
('marksanchez', 6),
('boydjudy', 5),
('dunnapril', 4),
('xwilliams', 20),
('hallbrandi', 15),
('ycook', 24),
('johnny76', 12),
('christopherthomas', 25),
('smiller', 25),
('ucook', 9),
('hallbrandi', 12),
('sotomeghan', 6),
('andres57', 20),
('mcarrillo', 31),
('williamholt', 19),
('dpage', 26),
('tyler63', 16),
('erinharris', 26),
('robert44', 28),
('christopherthomas', 30),
('dpage', 33),
('marksanchez', 26),
('antonio70', 28),
('andres57', 27),
('dunnapril', 22),
('mjohnson', 27),
('saramccarthy', 9),
('xallen', 16),
('boydjudy', 23),
('curtiscollier', 22),
('smiller', 34),
('christopherthomas', 22),
('heathershannon', 12),
('johnny76', 2),
('dpage', 31),
('jenniferchambers', 17),
('andres57', 24),
('smiller', 29),
('saramccarthy', 24),
('hallbrandi', 27),
('jenniferchambers', 24),
('pmorgan', 20),
('xallen', 22),
('marksanchez', 20),
('glasspatrick', 33),
('walkerwendy', 29),
('mendezrussell', 21),
('curtiscollier', 11),
('xwilliams', 9),
('mendezrussell', 4),
('curtiscollier', 17),
('antonio70', 12),
('smiller', 20),
('williamholt', 29),
('andres57', 9),
('stewartgabriel', 19),
('pmorgan', 21),
('jenniferchambers', 9),
('marksanchez', 12),
('mmitchell', 23),
('walkerwendy', 6),
('tyler63', 28),
('mjohnson', 35),
('dunnapril', 35),
('hallbrandi', 20),
('mcarrillo', 10),
('pmorgan', 35);

-- Insert statements for table: Alert
INSERT INTO Alert (AlertID, LogID, AssignedTo, Timestamp, Type, Status) VALUES
(1, 35, 'walkerwendy', '2024-09-18 02:43:24', 'User', 'New'),
(2, 8, 'xwilliams', '2024-09-24 20:53:03', 'Performance', 'Dismissed'),
(3, 20, 'pmorgan', '2020-11-06 02:19:16', 'User', 'Acknowledged'),
(4, 5, 'mendezrussell', '2020-04-01 19:03:59', 'System', 'Dismissed'),
(5, 7, 'boydjudy', '2024-09-05 00:58:00', 'Performance', 'Acknowledged'),
(6, 14, 'sotomeghan', '2022-08-25 19:36:14', 'Performance', 'Acknowledged'),
(7, 4, 'antonio70', '2020-09-12 04:15:35', 'Performance', 'Dismissed'),
(8, 8, 'curtiscollier', '2021-07-10 10:19:35', 'Performance', 'Dismissed'),
(9, 28, 'stewartgabriel', '2024-09-26 09:14:00', 'Performance', 'Dismissed'),
(10, 34, 'robert44', '2023-09-29 05:13:56', 'System', 'Acknowledged'),
(11, 31, 'saramccarthy', '2021-01-21 12:04:01', 'Security', 'Resolved'),
(12, 14, 'mjohnson', '2022-02-14 11:12:26', 'Security', 'New'),
(13, 3, 'mjohnson', '2020-05-23 03:03:20', 'System', 'Resolved'),
(14, 24, 'xwilliams', '2023-05-19 18:46:53', 'Performance', 'Resolved'),
(15, 16, 'williamholt', '2023-08-09 00:32:04', 'User', 'New'),
(16, 22, 'pmorgan', '2024-09-19 09:39:40', 'Security', 'Resolved'),
(17, 34, 'mmitchell', '2022-03-14 15:44:29', 'System', 'Acknowledged'),
(18, 18, 'williamholt', '2022-08-30 15:41:01', 'Performance', 'Dismissed'),
(19, 19, 'marksanchez', '2024-01-02 11:16:21', 'Security', 'Resolved'),
(20, 28, 'erinharris', '2020-05-27 03:02:00', 'Performance', 'Acknowledged'),
(21, 34, 'robert44', '2023-05-28 04:46:25', 'Security', 'Acknowledged'),
(22, 34, 'walkerwendy', '2020-04-22 19:42:48', 'Performance', 'New'),
(23, 11, 'stewartgabriel', '2020-12-23 17:06:48', 'System', 'Dismissed'),
(24, 20, 'mmitchell', '2023-09-17 18:41:45', 'System', 'Acknowledged'),
(25, 32, 'johnny76', '2020-09-12 07:21:53', 'Performance', 'Resolved'),
(26, 25, 'boydjudy', '2024-12-06 03:20:43', 'Security', 'Resolved'),
(27, 3, 'hallbrandi', '2023-10-20 16:09:54', 'Performance', 'New'),
(28, 17, 'dunnapril', '2021-01-08 13:05:30', 'Security', 'Resolved'),
(29, 17, 'heathershannon', '2022-08-21 14:38:23', 'User', 'Resolved'),
(30, 20, 'allenluke', '2023-02-15 03:12:34', 'Security', 'Dismissed'),
(31, 34, 'tyler63', '2020-04-14 06:07:00', 'Security', 'Acknowledged'),
(32, 1, 'ucook', '2020-04-03 17:18:32', 'Security', 'Dismissed'),
(33, 5, 'mendezrussell', '2024-12-16 21:58:47', 'User', 'New'),
(34, 1, 'andres57', '2023-10-13 06:53:53', 'System', 'Dismissed'),
(35, 26, 'boydjudy', '2023-02-08 00:19:52', 'User', 'Resolved');

-- Insert statements for table: Blog
INSERT INTO Blog (BlogID, PublishDate, Content, Title, Username, RecipeID) VALUES
(1, '2025-04-06 15:48:40', 'Pay order analysis gun. Paper phone federal kind local majority also. Threat green animal position.
Unit morning music moment per personal marriage full. Situation throughout quickly loss be.
It spring game admit environmental environment. Performance hear debate song modern.
Spend read action coach local. Mr risk him have serve.
Service PM behind point. Parent work rule until sell represent character.
Letter citizen people.', 'Citizen believe stage run generation expect.', 'stevenstewart', 29),
(2, '2021-03-30 07:38:37', 'Point commercial subject indeed get long. Third service public whole goal sometimes.
Church either action mention. Example throughout carry defense interest. Also total seek stuff relate spend win Mrs.
Everyone court success group space home.
There travel state near. Visit best send community usually no use. Relate little note maybe billion.
Food treatment administration well end technology shake. Hold floor sense several time nearly. Research ready responsibility rock prevent second deep.', 'Face thus ten light.', 'tyler63', 11),
(3, '2020-08-27 15:58:45', 'Help friend team. Early item scientist. Only behavior table certain option.
House fast evidence skill send seat already.
Lose way against often property relationship. Machine court technology including. Customer behind we.
Long do green several everyone follow kitchen market. Customer value window he station.
Sport when single decade carry. Month letter fly on hair day computer. Day traditional ground particular international as difficult could.', 'Whom government street one.', 'smiller', 6),
(4, '2021-10-22 02:32:19', 'Ready source another general.
Develop low room receive day charge company suffer. Try simply various Republican sister human direction.
American however garden state card action physical. Perhaps approach red research sure future animal.
Place manager with require girl size instead race. Style answer whose floor east.
This world put capital.
Become clearly campaign yourself perform body head financial. Century watch main able sense debate.', 'Surface alone talk certainly stop medical recognize.', 'boydjudy', 14),
(5, '2022-03-06 12:41:24', 'Build health name phone. Serve painting foreign weight minute note change.
Century day effect party material establish. Space arrive improve direction rule message skin.
Produce about instead program such sound. Almost because suffer from surface leg.
Sport sometimes agency teach thus wind. Either media series into whom peace expect blue. Bank act establish situation.
Industry national pay. Second energy sport card key. Boy example night from production tell describe character.', 'Bring cultural news dark tend available nice.', 'tyler63', 23),
(6, '2021-03-14 09:47:41', 'Chance purpose debate which truth. Foot officer present develop six however.
Good tend make fine. Action station list head system structure. Whatever hear father enjoy attorney large hospital.
Likely bar statement part national. Record either arrive more Democrat number.
Party they fear weight save. Address shake little shoulder floor although four hot. Yourself experience pay adult difference beyond fund.', 'A around himself very truth trial serious.', 'mendezrussell', 27),
(7, '2020-11-23 19:38:26', 'Investment whose power minute account explain able. Respond series environmental international receive meet situation. Firm describe feel analysis another leg hotel personal.
Among particular office front their individual phone decision. Response thing weight word term.
Far bit second chair. Morning American camera.
Budget up seat sometimes. Serious maintain response letter war why example.
Charge me attack throw social get nearly. Administration five best here Mrs up.', 'Carry probably establish writer.', 'erinharris', 26),
(8, '2024-08-22 17:46:49', 'Break since however cup financial.
Young scene cut moment movie. Them situation and. Put old soon evidence customer fill improve. Chair condition leader door green.
Among raise executive. Recent every above camera interesting wife.
Ahead window week around author high. Sell factor reason day wish teacher buy. Board drop little that dog evening.
Business short involve not interview service.
Deep me trade step learn control small. His subject develop sometimes main learn.', 'May purpose event shake tell vote.', 'mjohnson', 16),
(9, '2024-02-11 06:13:11', 'Exactly agency wrong movement various its. Common I truth least debate.
Long fact cell never land treat crime. Indicate pull rock call research church little. Media generation wide.
Smile significant require especially water may life in. Pass manage medical herself cultural south democratic. Floor business time note.
Successful these meet ready animal. Me wait brother public blue build book before. Occur why indeed hot box still will.', 'Beautiful many individual reason race we natural.', 'boydjudy', 4),
(10, '2024-12-04 04:20:53', 'For have side interesting.
Son avoid reveal style may development. Against born well prepare point.
East house leg information work could many. Traditional your serve boy. One month talk watch phone.
Door cultural lose spend wish. Itself detail actually single candidate the continue. No power top until step American night.
Coach candidate foot one nearly until. Final across clearly really western.', 'Then really prevent need.', 'andres57', 6),
(11, '2020-07-17 10:42:55', 'Western respond ten civil. House item if year present matter.
Senior receive fact keep security tough. Walk return security become base serious report. Plant everyone second what wear allow.
Consider no such player condition. Feel heart woman apply little catch. Line plan interesting group main game development. Skill manager factor ready and.
Leader subject hotel power exactly. Light action door court teach generation soon.', 'Performance suddenly place local.', 'erinharris', 21),
(12, '2024-12-18 02:01:53', 'Arm method attention strategy performance. Professor force help spend smile two may.
Behavior board instead choice not shake full him. When visit discover bar production. Back drug political lawyer debate economy field. Thank blood best quite.
Always it recently available.
Imagine appear energy another. Affect up soldier talk girl.
Cover his simply security wide above and. Response least rich too cup. Beautiful sign either the you become.', 'Community ability want significant especially occur simple.', 'patrick93', 16),
(13, '2020-12-28 19:45:53', 'Ever girl lead personal skin. Plant film physical establish rather visit recently. Letter question service always it artist. Evening firm beautiful interesting.
Benefit form anything condition need training. College thank moment reality role stuff.
Hospital new if benefit foot what. Feeling lead indicate answer TV.
In might example people population just social right. Talk common catch data green stock.', 'Everybody weight industry professional.', 'mendezrussell', 27),
(14, '2020-02-10 16:28:30', 'Day strategy agency eat.
Around quite often reveal second. Evidence hospital improve alone. Contain discover season training.
Seem cup watch might mouth movie. Leave around six game step. Option magazine tough too.
Charge exactly traditional race man leg drive. Someone let technology six especially inside two. Truth ago point trouble job scientist.
Store however office follow second stop. Subject Mr able election notice side. Relationship detail west option recent court least.', 'Nation nature item fly nature.', 'xallen', 35),
(15, '2022-07-08 18:27:28', 'Example fact buy table Mrs happy. Writer appear degree exist mission.
Congress important son suddenly. Appear time character foreign himself where.
Grow ahead area require treatment. Tell crime material toward. Prepare daughter until figure anything tonight.
Various hear increase southern. Study computer foot building front rate tend.
Thought follow response fund. Care likely worry.
Design book party four people rock by. Us land office medical push hold. Available because even thing avoid.', 'Young mother son I statement seek space.', 'heathershannon', 9),
(16, '2020-08-31 01:10:27', 'Option able cause score establish third. But ago catch mind. Network religious nor ten.
Sport lot unit soldier hair. New size prove behind event behavior system. Box whole tough tough.
Body source believe born lose police air. Coach hard imagine change. Space fall fact war talk thousand type.
Low seem gas stay organization drive picture. Likely nor environmental pick Republican. Eye parent whose product large.', 'Administration whole top.', 'allenluke', 22),
(17, '2021-01-16 04:51:41', 'Cultural whole six if start. Modern western movement article husband also.
Dark lead person say choice relationship. Mouth thank piece up play husband.
Fish type by scientist debate thought mouth. Population deal place whom after.
Relationship leg necessary star. Theory risk measure early research drop conference. Husband should weight sport decision. Also security dinner while evidence something.
Quality once develop leg beat thing available partner. Her whole course decade.', 'Design no affect discover because.', 'sotomeghan', 2),
(18, '2020-03-03 15:02:21', 'Phone either card mission. Admit century upon. Learn feel contain particularly. Often hour big really.
House part clear mind eat win short. Candidate officer when pick. Partner big above top truth claim president too.
Offer heart benefit movement economy. Sing citizen first talk also. Measure gas up them force computer win exist.
Hospital expect probably personal. Game course above everybody. Control little live.', 'Itself sing apply team myself success bed.', 'glasspatrick', 14),
(19, '2021-12-24 16:19:12', 'Ahead enjoy character. Body hour reason wide. News add address certainly.
Shake successful poor food. Parent down interesting any risk whom.
Strategy here six determine. Respond million simple animal.
Herself though per white natural. Yet rule book a out result.
Soon official technology imagine while investment. Man woman want listen financial. Evidence several fine field.', 'Start effect property body.', 'tyler63', 5),
(20, '2023-10-20 00:42:37', 'Factor stay network power sign. Life by professor look television knowledge.
More free resource sea. Stand or agency one good friend little. War old name wife hit.
Through month music available until rate success. Southern lay green. Some recognize sport camera deal hear standard here.
Particularly week suffer practice. Information raise despite chair science. Wrong one to space worry rather throw.', 'Return wall quickly begin.', 'jenniferchambers', 4),
(21, '2020-08-20 19:05:50', 'Reflect become material successful. Reduce huge themselves decade significant.
Forward skill education laugh value alone hair. Move my necessary sure provide. Page newspaper professional fall she. During feel shake foot.
Local prevent adult street show but. Walk popular summer find water board economic. Office short because these weight build. Pay nothing chance hot determine place blue.
Out wear close north ball choice item land. Summer even whether surface view. Usually machine first prepare.', 'Strong eat reach by house south green.', 'smiller', 18),
(22, '2020-04-08 03:56:04', 'Politics most floor democratic art. Now eight six no money bill significant. Gun occur draw local off. Final yet this notice season.
Put catch protect purpose. East both by bit certain policy themselves federal. Sit perhaps Republican east major boy.
Window world coach only nation level. Gas thus measure instead let sort sound.
Age anything degree send imagine my kid. There activity lot. While voice many.
Game practice gun expect cold. Generation large work instead listen world face.', 'Economy decade hear must traditional really.', 'robert44', 9),
(23, '2020-12-22 02:48:28', 'Go ball get dream. Building statement provide ahead seat trouble.
Feeling whose truth former. Church particularly western remain learn arrive dog describe. Imagine black value final can house country.
Nation activity shake television answer. Entire owner cultural game federal writer nation dark.
Everything name society contain myself situation sing. Specific value others participant maintain term far.
Choose time million same prove. Plant everything treat inside report.', 'Generation into likely agent sense face turn.', 'tyler63', 29),
(24, '2024-06-05 07:09:33', 'Such only similar will act majority. Individual other probably reveal bit. Culture positive on word leader team.
Player wrong star tonight fact style sport hard. Laugh still production thousand charge drive. Against might rule continue discuss. Goal reduce Mrs get in without vote.
Down decision role material someone each national. Recently would forget central local list.', 'Live yourself reduce lot professor share.', 'stewartgabriel', 10),
(25, '2021-07-23 17:49:59', 'Administration our form. Plan none appear paper face agreement.
Two cup challenge run vote ready. Wrong fear left beautiful.
Reason nearly above letter news. Special good follow cell book carry. Hold available crime agent and. With bar view rather school.
Alone guy with protect impact arrive. Yard protect enter morning experience quite lawyer. Dinner one issue development. Role lead and him.', 'Charge record five drive radio main data.', 'johnny76', 33),
(26, '2020-09-03 15:07:57', 'Friend wait their very clear. Full it just drug table quickly. Professor marriage apply sometimes live. Pressure few under after.
Where real because company century result century. Time almost win many. Myself responsibility unit road expert show remain.
Statement shake let federal phone blood maintain outside. Growth thousand eight require suffer half.
Election blue new prove part. Trade style approach rule. Political character tonight seven artist something stop.', 'Drug student out.', 'hallbrandi', 5),
(27, '2021-11-16 15:06:11', 'Peace serve night may fill response. Cold police clear entire number home employee table. Mission save senior conference away deep.
Already leave mind glass. Determine example magazine shoulder effect again. Great recently language ok. And wall in.
Lawyer price down. Plant care another read wish true. Spend police law feeling.
Item mean third. Politics visit enjoy arm including. Easy wife alone pick skin.
Group clearly beautiful employee.
Much look despite energy develop consider reality work.', 'End huge hospital often authority.', 'mendezrussell', 33),
(28, '2024-03-15 06:23:41', 'Ten each together animal recently author. Record past human second sit set boy.
Themselves everybody sit push class. Garden member ready news poor thank great mother. Your now military rise military.
Process its decision nation. Hold on factor responsibility reason. Local up nor week couple stay anyone professor.
Whom will build field sure.
Physical before finish begin. Determine fund fish herself. Stand specific strategy push could test.', 'Country keep physical.', 'mmitchell', 18),
(29, '2021-01-02 11:04:18', 'Go case color issue officer. Upon produce pattern collection certain respond. Way least fire anyone less several.
School high fund even either. Although spring agent design cause.
Physical them such customer thank respond. Administration peace ahead watch sign only mean. Big image money compare away low anything.
Explain evidence partner reveal throw. War too state. The respond could direction word record fire.
Line guy speak fall power message need. Understand color dinner tough.', 'Right structure back number.', 'stevenstewart', 32),
(30, '2020-07-10 06:58:02', 'Money per small prove task summer pressure. Company where can one we.
Power professor high often much do. Land without item second though government task wish.
Arrive message expert surface large hospital. Order public student miss watch fight. Education reflect art paper minute child respond. Seem military stage idea film him.
Stage administration floor letter. Wish build than purpose bit try record.', 'Leg Mr season grow.', 'walkerwendy', 29),
(31, '2020-05-20 04:29:12', 'Main stock ready expert knowledge government. Example you behavior mission just water. Everybody great fill per stand.
Among candidate sure city analysis church. Fear good nice assume career stuff paper. Fish daughter visit better voice paper college.
Of group morning edge discussion. Man opportunity summer bank tell firm growth. Next art if.
Example investment thought expect trial lead. Side half score become course rock image. Position power collection machine unit book amount those.', 'Cut or might decision require democratic apply only.', 'jenniferchambers', 17),
(32, '2024-10-10 01:49:08', 'Tough affect expert campaign. Group surface show city a activity staff. Culture nation sure create Mr American pull.
Member police light. None within institution choose today type north. Person kind approach someone.
Send may human watch discussion. High bring use garden.
Central challenge myself heart. Arm central area a firm eight. Score strong behind nor consumer enter.
How might sea. Blue actually live suffer two move. Crime soon great key beautiful.', 'Street arm what rather fact probably five.', 'walkerwendy', 14),
(33, '2024-03-13 19:32:22', 'Account quite meeting other whom. Staff determine lawyer trial major structure. Blood thing during.
Improve past mind parent. Position call coach environmental economic station.
Building half beat ask.
Eat scene decision side quickly resource building.
Risk others health responsibility author network. Garden moment act meeting goal.
Set national occur here Mrs. Next statement second interest. Wear management guess front bring glass state edge.
Writer too option plan claim any space first.', 'Which executive decision whose knowledge seem attack fund.', 'stewartgabriel', 21),
(34, '2022-01-09 10:17:52', 'Truth another serious father actually. Hospital expect forget some. People receive believe relate ask effort life.
Do senior know kid history try begin. Not politics have cause. Forget statement plan bring poor person.
Travel way side discover vote. Staff amount system system my. Manage notice family moment like require.
Fire cell whatever single Republican couple entire. Out now social standard. Past wish moment spend.', 'Scientist edge realize story artist system.', 'sotomeghan', 14),
(35, '2020-08-02 10:08:57', 'Goal education product difficult around you range. Control possible picture soon question forget.
Family design image. Point son trouble still way carry brother.
Allow get decide join get future. Environmental much scene like present American yet.
Human sit recently art consumer some talk ahead. Worker with technology that seek boy. Analysis kind somebody deal safe night second.
Moment miss area yet court campaign. Participant edge interest note art everything most.', 'Interesting election cover suffer drive.', 'sotomeghan', 21);

-- Insert statements for table: Blog_Meal
INSERT INTO Blog_Meal (BlogID, RecipeID) VALUES
(17, 6),
(13, 27),
(8, 8),
(11, 23),
(20, 16),
(3, 20),
(29, 7),
(2, 18),
(1, 6),
(3, 3),
(23, 23),
(12, 28),
(1, 18),
(28, 1),
(13, 8),
(3, 7),
(19, 5),
(6, 18),
(28, 12),
(12, 23),
(33, 35),
(3, 27),
(26, 14),
(3, 25),
(19, 10),
(25, 28),
(25, 16),
(19, 2),
(11, 22),
(4, 4),
(15, 30),
(16, 25),
(1, 22),
(12, 27),
(18, 1),
(29, 26),
(21, 11),
(9, 19),
(10, 26),
(26, 18),
(17, 13),
(17, 8),
(34, 11),
(17, 2),
(15, 9),
(6, 17),
(1, 27),
(27, 29),
(7, 6),
(28, 3),
(2, 10),
(16, 18),
(7, 35),
(8, 34),
(21, 17),
(13, 14),
(1, 31),
(1, 9),
(10, 6),
(26, 10),
(34, 14),
(2, 14),
(15, 16),
(21, 3),
(25, 11),
(16, 27),
(9, 11),
(32, 11),
(32, 13),
(26, 25),
(4, 9),
(21, 20),
(20, 35),
(30, 16),
(25, 9),
(16, 7),
(10, 23),
(26, 28),
(25, 3),
(23, 26),
(5, 25),
(28, 6),
(19, 12),
(34, 17),
(21, 7),
(32, 18),
(10, 12),
(27, 34),
(6, 8),
(4, 5),
(35, 13),
(2, 5),
(12, 10),
(16, 15),
(24, 4),
(8, 35),
(28, 31),
(18, 12),
(31, 9),
(33, 7),
(4, 2),
(24, 29),
(21, 15),
(22, 2),
(19, 8),
(16, 9),
(4, 34),
(7, 27),
(11, 21),
(23, 30),
(31, 35),
(9, 33),
(31, 1),
(25, 30),
(7, 1),
(30, 30),
(29, 18),
(15, 10),
(6, 7),
(18, 19),
(16, 16),
(12, 2),
(4, 27),
(6, 1),
(25, 25),
(20, 28),
(15, 27),
(19, 18),
(35, 21),
(3, 33),
(17, 33),
(30, 5),
(34, 26),
(26, 21),
(11, 14),
(25, 14),
(17, 17),
(17, 26),
(34, 23),
(6, 21),
(29, 27);

-- Insert statements for table: CategoryData
INSERT INTO CategoryData (CategoryID, Name) VALUES
(1, 'Nice'),
(2, 'Everybody'),
(3, 'Push'),
(4, 'Score'),
(5, 'Skin'),
(6, 'Little'),
(7, 'Ask'),
(8, 'Mother'),
(9, 'International'),
(10, 'Strong'),
(11, 'Role'),
(12, 'Thing'),
(13, 'Bed'),
(14, 'Serious'),
(15, 'Save'),
(16, 'Authority'),
(17, 'Second'),
(18, 'Relate'),
(19, 'Choose'),
(20, 'Idea'),
(21, 'Near'),
(22, 'Price'),
(23, 'Skill'),
(24, 'Someone'),
(25, 'Oil'),
(26, 'Style'),
(27, 'Magazine'),
(28, 'Simply'),
(29, 'Beyond'),
(30, 'Drug'),
(31, 'Per'),
(32, 'Always'),
(33, 'Environment'),
(34, 'Open'),
(35, 'Up');

-- Insert statements for table: DemographicGroupData
INSERT INTO DemographicGroupData (GroupID, GroupType, GroupValue) VALUES
(1, 'Income', 'Establish'),
(2, 'Ethnicity', 'Economic'),
(3, 'Income', 'Read'),
(4, 'Gender', 'Box'),
(5, 'Ethnicity', 'Those'),
(6, 'Gender', 'Last'),
(7, 'Ethnicity', 'Meeting'),
(8, 'Ethnicity', 'Although'),
(9, 'Ethnicity', 'Actually'),
(10, 'Gender', 'Glass'),
(11, 'Income', 'North'),
(12, 'Education', 'Focus'),
(13, 'Ethnicity', 'Break'),
(14, 'Income', 'With'),
(15, 'Income', 'Reveal'),
(16, 'Income', 'Dream'),
(17, 'Ethnicity', 'Best'),
(18, 'Gender', 'Oil'),
(19, 'Ethnicity', 'High'),
(20, 'Gender', 'Heart'),
(21, 'Education', 'Quickly'),
(22, 'Income', 'Protect'),
(23, 'Education', 'Sea'),
(24, 'Ethnicity', 'On'),
(25, 'Gender', 'Article'),
(26, 'Gender', 'Song'),
(27, 'Income', 'Right'),
(28, 'Education', 'White'),
(29, 'Gender', 'Relate'),
(30, 'Education', 'Front'),
(31, 'Ethnicity', 'Citizen'),
(32, 'Education', 'Couple'),
(33, 'Ethnicity', 'Education'),
(34, 'Gender', 'Last'),
(35, 'Gender', 'Future');

-- Insert statements for table: Follows
INSERT INTO Follows (follower_id, followee_id, follow_date) VALUES
('gatesjames', 'zcarpenter', '2022-11-23'),
('qsanchez', 'gherrera', '2023-07-29'),
('michael99', 'carpenterteresa', '2024-06-14'),
('phuerta', 'michael99', '2021-05-04'),
('qsanchez', 'olee', '2022-02-17'),
('mjohnson', 'michelle25', '2022-12-25'),
('mjohnson', 'jefferydavis', '2024-03-25'),
('wilkinsjose', 'mwheeler', '2024-03-07'),
('zcarpenter', 'rebecca94', '2024-10-25'),
('jeffreymorris', 'shelby08', '2022-03-23'),
('leslie91', 'annehendrix', '2024-07-09'),
('wilkinsjose', 'rebecca94', '2023-01-09'),
('olee', 'shelby08', '2022-08-30'),
('zcarpenter', 'mjohnson', '2024-01-22'),
('amy03', 'qsanchez', '2021-04-21'),
('olee', 'michelle25', '2021-11-14'),
('brittanypowell', 'tiffany71', '2024-09-20'),
('joseph81', 'renee18', '2021-08-06'),
('annehendrix', 'gatesjames', '2020-01-16'),
('orobinson', 'sandraparker', '2022-12-18'),
('phuerta', 'leslie91', '2023-09-24'),
('nicholasdavis', 'mwheeler', '2024-10-14'),
('qsanchez', 'jeanbautista', '2020-12-23'),
('annehendrix', 'phuerta', '2024-07-22'),
('mwheeler', 'michael99', '2021-07-18'),
('annehendrix', 'qsanchez', '2021-10-03'),
('mjohnson', 'amy03', '2021-06-25'),
('mjohnson', 'zcarpenter', '2021-09-10'),
('jeffreyfrazier', 'orobinson', '2025-04-09'),
('wilkinsjose', 'montgomerynathaniel', '2024-11-09'),
('jeanbautista', 'sandraparker', '2023-11-02'),
('gbuckley', 'brittanypowell', '2024-01-27'),
('michelle25', 'leslie91', '2021-09-30'),
('michelle25', 'joseph81', '2020-09-07'),
('ryan08', 'gherrera', '2022-06-25'),
('brian24', 'gherrera', '2023-08-09'),
('olee', 'gatesjames', '2021-10-23'),
('shelby08', 'renee18', '2021-09-25'),
('qsanchez', 'orobinson', '2022-04-13'),
('zcarpenter', 'jeffreymorris', '2022-08-08'),
('jeffreymorris', 'tiffany71', '2022-04-26'),
('montgomerynathaniel', 'wilkinsjose', '2023-07-10'),
('sandraparker', 'jeffreymorris', '2022-07-03'),
('phuerta', 'orobinson', '2021-02-20'),
('amy03', 'carpenterteresa', '2025-02-25'),
('olee', 'nmeyer', '2025-03-05'),
('brian24', 'rebecca94', '2020-12-10'),
('mjohnson', 'brittanypowell', '2020-03-06'),
('leslie91', 'anthonyjackson', '2024-07-23'),
('phuerta', 'nicholasdavis', '2022-05-27'),
('phuerta', 'joseph81', '2023-09-26'),
('ryan08', 'annehendrix', '2023-10-04'),
('carpenterteresa', 'sandraparker', '2021-06-22'),
('shelby08', 'qsanchez', '2020-04-18'),
('ryan08', 'amy03', '2023-04-21'),
('annehendrix', 'rebecca94', '2024-01-07'),
('mwheeler', 'jeffreymorris', '2023-04-23'),
('jeanbautista', 'michelle25', '2024-10-24'),
('tiffany71', 'jeanbautista', '2021-03-27'),
('annehendrix', 'nmeyer', '2025-02-02'),
('gatesjames', 'jeffreymorris', '2023-07-25'),
('nmeyer', 'qsanchez', '2023-06-12'),
('mwheeler', 'nicholasdavis', '2020-03-23'),
('qsanchez', 'michael99', '2022-03-29'),
('michael99', 'brittanypowell', '2023-08-06'),
('jeffreymorris', 'gherrera', '2023-04-18'),
('renee18', 'jefferydavis', '2022-07-29'),
('amy03', 'tiffany71', '2020-01-19'),
('gbuckley', 'michelle25', '2024-01-16'),
('qsanchez', 'brittanypowell', '2022-05-05'),
('olee', 'ryan08', '2020-04-17'),
('sandraparker', 'gherrera', '2022-11-23'),
('brittanypowell', 'rebecca94', '2022-05-15'),
('amy03', 'gatesjames', '2023-08-19'),
('mwheeler', 'leslie91', '2020-09-08'),
('michael99', 'renee18', '2021-03-03'),
('shelby08', 'joseph81', '2025-03-02'),
('mwheeler', 'brittanypowell', '2020-07-18'),
('orobinson', 'mwheeler', '2021-11-16'),
('leslie91', 'brittanypowell', '2023-04-20'),
('michelle25', 'carpenterteresa', '2022-02-05'),
('joseph81', 'jeffreyfrazier', '2022-07-18'),
('carpenterteresa', 'brittanypowell', '2022-06-04'),
('jeffreymorris', 'brian24', '2024-01-06'),
('annehendrix', 'jeffreyfrazier', '2022-04-09'),
('gatesjames', 'amy03', '2023-03-07'),
('michael99', 'montgomerynathaniel', '2020-08-27'),
('brittanypowell', 'qsanchez', '2023-06-01'),
('oherring', 'montgomerynathaniel', '2024-11-24'),
('mwheeler', 'gbuckley', '2022-09-21'),
('nicholasdavis', 'renee18', '2023-08-10'),
('brittanypowell', 'olee', '2021-05-14'),
('oherring', 'anthonyjackson', '2022-05-11'),
('gbuckley', 'montgomerynathaniel', '2020-12-30'),
('shelby08', 'jeanbautista', '2024-12-13'),
('jefferydavis', 'ryan08', '2023-05-06'),
('anthonyjackson', 'montgomerynathaniel', '2024-09-14'),
('anthonyjackson', 'jeffreyfrazier', '2022-05-31'),
('nmeyer', 'mwheeler', '2025-02-03'),
('olee', 'tiffany71', '2022-10-24'),
('nicholasdavis', 'jeffreymorris', '2020-08-14'),
('tiffany71', 'carpenterteresa', '2022-02-08'),
('gatesjames', 'ryan08', '2020-09-19'),
('qsanchez', 'ryan08', '2021-03-01'),
('brittanypowell', 'joseph81', '2023-09-26'),
('jeffreymorris', 'michael99', '2021-01-21'),
('carpenterteresa', 'annehendrix', '2020-01-10'),
('orobinson', 'ryan08', '2024-01-05'),
('gherrera', 'jeffreyfrazier', '2020-10-07'),
('jeffreymorris', 'rebecca94', '2022-07-26'),
('gherrera', 'anthonyjackson', '2024-10-08'),
('shelby08', 'sandraparker', '2022-10-12'),
('nmeyer', 'annehendrix', '2022-06-28'),
('montgomerynathaniel', 'renee18', '2020-01-27'),
('rebecca94', 'qsanchez', '2024-09-04'),
('nmeyer', 'gatesjames', '2022-01-21');

-- Insert statements for table: Interaction
INSERT INTO Interaction (InteractionID, UserID, RecipeID, InteractionType, Timestamp) VALUES
(1, 'bbaker', 6, 'Like', '2020-09-23 08:20:11'),
(2, 'johnny76', 9, 'Share', '2024-05-19 17:11:12'),
(3, 'pmorgan', 23, 'Like', '2025-01-03 16:03:23'),
(4, 'dunnapril', 11, 'Comment', '2021-03-10 01:42:53'),
(5, 'tyler63', 34, 'View', '2023-07-13 19:49:54'),
(6, 'mjohnson', 5, 'Like', '2022-12-29 12:56:15'),
(7, 'saramccarthy', 9, 'Like', '2023-12-12 15:58:50'),
(8, 'patrick93', 26, 'View', '2021-02-12 07:35:25'),
(9, 'curtiscollier', 16, 'Like', '2024-06-22 03:56:29'),
(10, 'jenniferchambers', 29, 'Share', '2021-01-22 17:25:32'),
(11, 'mmitchell', 14, 'Comment', '2020-12-06 17:45:13'),
(12, 'mendezrussell', 29, 'View', '2024-10-29 13:11:30'),
(13, 'walkerwendy', 13, 'Comment', '2023-07-14 19:44:10'),
(14, 'jenniferchambers', 8, 'Like', '2022-03-16 04:34:19'),
(15, 'saramccarthy', 5, 'Like', '2023-05-05 14:28:57'),
(16, 'pmorgan', 16, 'View', '2021-05-26 12:43:46'),
(17, 'williamholt', 5, 'View', '2023-08-11 20:16:29'),
(18, 'bbaker', 35, 'View', '2023-02-24 11:42:24'),
(19, 'heathershannon', 29, 'Share', '2022-01-08 17:53:44'),
(20, 'mendezrussell', 34, 'Share', '2022-11-11 04:26:53'),
(21, 'walkerwendy', 28, 'Comment', '2024-05-02 22:03:08'),
(22, 'dpage', 34, 'Like', '2021-01-05 11:34:52'),
(23, 'marksanchez', 10, 'Comment', '2022-12-25 16:49:08'),
(24, 'allenluke', 12, 'Like', '2025-01-12 00:20:43'),
(25, 'curtiscollier', 33, 'View', '2022-04-21 00:06:16'),
(26, 'glasspatrick', 19, 'Share', '2023-09-07 23:55:15'),
(27, 'erinharris', 26, 'Like', '2022-09-12 10:18:32'),
(28, 'allenluke', 4, 'View', '2020-02-09 05:31:39'),
(29, 'allenluke', 32, 'Like', '2022-01-14 21:41:37'),
(30, 'dpage', 35, 'Share', '2022-11-18 21:26:49'),
(31, 'glasspatrick', 22, 'Share', '2022-02-20 06:33:38'),
(32, 'saramccarthy', 22, 'View', '2025-04-09 13:30:42'),
(33, 'williamholt', 4, 'Like', '2022-08-15 04:30:21'),
(34, 'ycook', 13, 'View', '2023-02-18 02:08:39'),
(35, 'bbaker', 11, 'Share', '2024-05-20 20:57:41');

-- Insert statements for table: IssueReport
INSERT INTO IssueReport (IssueID, Reports, ReportedBy, Description, Status, Timestamp) VALUES
(1, 'Method question loss thing. Yet because picture camera blood threat sure. Budget back raise drop meeting true prepare what.', 'xsmith', 'Foreign religious media green piece leave. Middle man left under commercial old. Above drive really company knowledge.
Leg leave course skin apply sing attorney population.
Community develop choose body though. Government defense political else nothing in hospital.', 'Closed', '2020-08-10 00:58:42'),
(2, 'Mention difference bar test sure. Manage newspaper option suddenly. Change region despite gun sort.', 'martinezzachary', 'Worry great high treatment also artist friend quickly. Enter future operation thing player traditional foreign agency. Reason begin admit example miss dream rest. Involve officer create important act party take.
Team method add. International five deep stock. Hit enter especially recognize every.', 'Closed', '2020-05-24 14:05:50'),
(3, 'Possible begin western term throughout. Window system see current compare.
Glass yourself actually. Explain phone left capital audience. Wait note machine forward eye listen on.', 'rstewart', 'Ask wind difference. Save choose learn. Artist growth own food.
Natural decision mission listen response. Half head fall such land always.
Whether try interview two place. Door opportunity time wait. Magazine job under win job her always. Knowledge step decide myself them.', 'Resolved', '2021-01-18 08:18:59'),
(4, 'Seek state task. Way practice garden stop meet ability least.
Million play dream recent Democrat attorney. Money such newspaper yard music.', 'hberger', 'Guy change economic. Couple so from you area.
Direction attack degree hand determine school. Simple outside bit source phone society.
High reduce machine especially determine. Herself professor music career key mean music. Financial near performance see.', 'Open', '2024-05-24 09:33:30'),
(5, 'Watch piece require market rule recognize wall. Explain whom customer.
Team production while yeah those word score chair. Talk upon add smile. Short garden should carry.', 'rothjose', 'East itself market. Table thus defense.
Amount black after most chair writer court. Hand half truth amount west material low. Develop model have.
Any value against record seven key. Sometimes into within customer movie learn cell.', 'In Progress', '2020-01-27 16:01:42'),
(6, 'Song boy international indicate. Apply together catch guess. Must weight article apply some truth. Continue all system arm these top pay.', 'yodermichael', 'Development bag kitchen exactly southern mind care treatment.
Chance break security over what trip smile. Bill main cell. Mouth store provide animal. Six pick worry member according.', 'Closed', '2022-01-09 03:07:23'),
(7, 'Outside always account cost wear care in. Table catch thus white method start. Reality author PM almost make.
Through easy one tough. Item cold team individual clearly wonder career so.', 'david07', 'Bag item Mrs state time rather woman low. Discover cause program bag close business.
New glass city agency position good. From effort night town. Two bit green investment size majority order. Nearly order follow million little stage.', 'Closed', '2021-07-04 08:02:15'),
(8, 'Something moment material investment ok.
Outside save reduce six. Deep interest before matter sister.', 'sanderson', 'Share less tree environment check someone break.
Open special around parent full pull goal. Minute boy major.
Piece control information down statement travel talk. Discuss reason bad sound statement. Suffer left certainly.
Although can large middle require official. Sit strong nothing treat.', 'Open', '2023-01-20 22:42:55'),
(9, 'Ago that hot consider affect. Knowledge throw from all.
Agent cold also each might. Shoulder bring focus dog see money activity. Serious catch future service safe able.', 'bjensen', 'Peace us fight huge enter financial. Allow full wish term would.
Reflect test exactly miss fall value later us. Almost dinner cold especially find cup no. Letter hundred south organization probably.', 'Closed', '2024-10-09 10:54:21'),
(10, 'Probably know dark a early sure southern opportunity. Later cost recognize area conference. Series effort likely part television receive.
Weight region someone themselves analysis maybe pick current.', 'tuckerkevin', 'Save information treat until strategy start specific maybe. Order wait teach only write. Day help all friend hair very relate.
Year around you whole send trial citizen face. Never citizen bill.
College will car of often treat.', 'Resolved', '2024-12-02 10:38:33'),
(11, 'International stuff president American majority product improve. A need move use kid size suddenly. Line senior leader since truth.', 'eharmon', 'Fight media thank near agreement. Medical them best foot all once. Suggest population receive however good word attorney.
Look quickly consider people. Where attention force century life far woman. Spend include radio model trip.', 'In Progress', '2021-11-10 06:55:14'),
(12, 'Sort two behavior young. Impact ground police we carry poor cause most. Book poor none use.', 'alexis68', 'Beautiful worker building international. Evening lose event. Start answer board alone factor kind painting.
Discuss top human foot least seven. Their drug analysis foot.
Best interesting body time. Energy option per much argue foreign policy although.', 'Closed', '2021-08-08 01:46:20'),
(13, 'Hotel sound world wonder movement. Plant development society class.
Hot again conference year put party.
Recognize effort car picture design serve ago few. Body although institution I.', 'kathrynknight', 'Difference page few appear against. Bad somebody process bank difference.
Boy sea couple cost provide. Support realize push result. Mrs case reason nature.', 'Closed', '2021-02-16 08:29:47'),
(14, 'Future time thousand enter. Area bill want who. Meeting who especially find suddenly end drive. Recent task indicate.', 'hollymiller', 'Do feeling project benefit. Identify attorney still well camera.
Performance thousand him meeting. Answer once bed occur pick reflect rest inside. Fly rich institution interest outside understand purpose.
Woman term hair such home project face real. Score plant item growth item.', 'Open', '2020-12-09 02:14:49'),
(15, 'Congress buy spend himself. Agree security quality glass once I.
Three little store for prevent key guy. Issue interest focus control note organization. Mind wide audience son able work which.', 'johnsontrevor', 'Add effect meeting through. Contain police citizen could.
Rich us vote science hair knowledge. Rule over economy charge add management. Allow address market share form none. Exist serve well later.
Fall try toward sing commercial one anything. Sometimes building Mrs exist couple look dog.', 'Resolved', '2020-12-03 03:38:21'),
(16, 'There Congress trip performance property police.
Off maintain mission worker ago. Yeah yard mention seven edge. Huge often red pass behavior investment.', 'robertsonbrian', 'But her media plant. Item think expert fill would.
Eye energy join threat. Yet five detail image activity. At oil executive process tell today.', 'Open', '2022-09-23 19:05:59'),
(17, 'Color west marriage effect throw early. Some property new only war hit. Clearly office oil because. Practice news try when.', 'douglaslutz', 'Yard certainly tell growth pay future training. Politics art girl situation.
Hope area contain. Avoid adult really hope. Speech Congress expert sister rise firm book.
Toward trip election year outside open. Almost soldier nation believe tend teacher.', 'Open', '2024-07-12 13:48:46'),
(18, 'More continue enough.
Else small church dinner table. Surface then analysis side smile strategy. Conference quality understand finally entire.', 'fzuniga', 'Say explain dog sell public direction interview. What another level section page many stay.
Open speak support special floor news. Sure professor together project. Make society too girl ask away.
And contain eye hundred sort glass last skill. Senior subject either.', 'Resolved', '2024-07-24 17:21:25'),
(19, 'Relationship mention Republican both color force. Spring vote case court. Office would task PM difference wall through.', 'amberaustin', 'Produce season but make language anyone feel. Might institution institution I health agent open. Others garden better.
Away within hold real safe. Pick table involve set around.
Million loss local decision rate indicate. Question over open keep drop. Plan involve power.', 'Closed', '2023-03-24 09:12:48'),
(20, 'City radio speak feel agreement drive physical. Population huge affect.
Record certainly natural different still population. Industry may bed cause seem.', 'ymclaughlin', 'Chair leg Mr heavy. Sister walk amount front themselves. Huge few group road.
Painting short only generation news bed. Direction suggest day.
Compare later part. History myself door nature. Hospital be water between purpose entire table. Lead produce medical value.', 'Resolved', '2023-10-07 22:58:19'),
(21, 'Season point most push daughter nothing.
Administration participant else chance. Culture situation system foreign. Become site effort find though act.', 'jessica01', 'Great not similar green. Raise western keep billion behavior. Step dog not measure.
Evidence police pull attention. Drug teacher bill reason analysis physical lose. Seem rather north talk before.
Share author away policy lead human. Actually give public outside soon. Set worry join name.', 'In Progress', '2025-01-21 08:58:57'),
(22, 'Woman however step hold appear. Smile laugh car against.
Open newspaper least why. Whatever rest future late above. Ready dark each support act.', 'deannafrost', 'Member site grow because war. Now organization lay role appear only cup. Feel glass born boy soon finally recently.
Lawyer win top game travel to. Break kid quality prepare reason. Send whether firm others.', 'In Progress', '2023-04-29 18:56:44'),
(23, 'To none outside return term type lay. Itself song dream turn environment physical its modern.
Sound reach argue always program matter administration. Summer hear information several series.', 'pittmanbailey', 'Growth high among anything against professional. Two thing yet design particular indicate. Interesting maybe blood yeah way human.
After participant lot color perform allow study.
Company expert policy. Ability hotel morning choice other until then. Support course enough require degree maintain.', 'In Progress', '2020-11-05 18:49:57'),
(24, 'Place much who community show.
Up as option majority hotel red their. International marriage assume purpose try late fall.', 'robert49', 'Visit leader skill there yard. Relate recently big fill you hot. Try set around what star wind church he. Option poor figure including against glass.
Ahead per foot house push choice.
Speak several feel listen travel professional. National relate bar. Energy capital upon control.', 'Closed', '2021-01-05 15:27:21'),
(25, 'Drop smile century ask player more. Go next indeed make international before. Beat example let hot.', 'coryroth', 'Suddenly although simple key history west bed. Pressure according surface recent different foot glass.
Purpose east sister age total practice practice. Assume seem fine stage.
How before member admit become under. Discussion result agree entire.', 'In Progress', '2022-06-02 03:05:26'),
(26, 'Production money decision guess significant. Later ok process wife process. Dark high shake special common hospital paper.
Truth spend out white discuss.', 'wayne47', 'Company no just. Natural drive over theory benefit experience.
Expect until minute ever. Store care feel beautiful professor no.
Task east their couple. Identify senior team industry law.
Would too cultural collection accept cold. Edge no bank organization PM blood.', 'In Progress', '2024-10-24 17:04:49'),
(27, 'System hot when near finally. Suddenly gun experience third fund everyone.
Race its provide window he. Certainly born if push significant.', 'mary29', 'Agent interest beat consumer food trouble more arm. About benefit maintain none.
Let later oil consider west. Man defense even return become people.
Change probably move report. Pretty step explain oil. Laugh guy quite itself store.', 'Open', '2025-02-12 15:22:02'),
(28, 'Red also test trial week add.
Ask compare same like right theory. Perhaps his prepare appear above how. Finish loss also thank industry. Change sister personal study suddenly summer.', 'troy26', 'Low finally military watch fast age bit reduce. Thousand process role behind lawyer you professional newspaper. Its activity attorney listen police work reach. Hundred head lawyer.
House site name value anyone. Attorney continue nearly Mrs. Hand should ten station.', 'Closed', '2021-07-22 17:06:11'),
(29, 'Weight four system place still offer. Official option check response member my enough.', 'ecalderon', 'Allow civil tree your situation. Character son miss store trouble. Say policy feeling other whole. Begin occur field now hour.
All site strategy usually role prove. Ground born girl consumer claim.', 'Open', '2024-05-22 23:55:56'),
(30, 'Senior page religious word bed.
While ball defense bag from upon among.
Per rate morning keep investment. Item ok I. Drive per security maintain positive.', 'garciapaul', 'Might too newspaper leave accept school water never. Without key range agent reality nice food. Official join same standard international popular.
Despite represent management look. Economy church hospital certain cell type represent. Management right sign until party break.', 'In Progress', '2022-11-03 23:53:39'),
(31, 'Music until bag bit crime baby stop need. Close standard find Mr assume first some.
Modern study radio sell however. Think crime nature seek may state.', 'michael65', 'Catch contain under. Effort that successful future read image weight just. Heavy listen upon just market step beat.
Before occur customer their. Particularly beautiful ask card condition. Manage feeling manage company.
Everybody stay make American trip. Help wall over fall day think.', 'Open', '2024-02-12 23:07:52'),
(32, 'Join data general nice front appear. Concern serious draw page kid class.', 'wcarr', 'American language place hand method old next. Quickly least represent whom reach look part. Hope them yard wind fire.
Level window its analysis.
Brother rock growth we certain.
Six finish seven really. Modern lead great close often dinner thought. Agent house test try result.', 'In Progress', '2022-01-29 06:33:32'),
(33, 'Special her technology particularly scientist. Pay past suddenly more effect. Sound same away listen alone.
Born west value. Wait investment interest cause public body sing.', 'sarmstrong', 'Coach well individual mean. Attack lose maybe successful. Them lead market herself good course against.
Sell listen allow side investment threat year. Music almost air word. Event west would wall sort them.
Career return administration staff spring place interest. Together coach let.', 'Closed', '2024-07-26 23:27:42'),
(34, 'State general nature street. Author work speak support. Technology summer born stop test how after.
Pull leg herself listen individual goal person. Miss nothing former look pattern up.', 'rgoodman', 'College model agency Mr activity environment. Act dream surface me.
Another least candidate per offer. Present then somebody artist.
Focus away their card public range role. Forward themselves identify next example. Public card show difference.', 'Open', '2024-09-27 23:18:14'),
(35, 'Finally cause day my chair. Citizen evidence become nothing Democrat shoulder market.
Station watch old stage message right month. Light evening to.
Still before growth story.', 'aguirrericky', 'West international into store situation quickly pass. Collection either put shoulder.
Sound near ever carry. Together full woman future vote speak chance.
Option however sure knowledge. Often foot measure especially. Government wear turn back drive agreement.', 'Resolved', '2021-10-22 13:06:57');

-- Insert statements for table: LogEntry
INSERT INTO LogEntry (LogID, Timestamp, ErrorMessage, SeverityLevel, Source, Details) VALUES
(1, '2020-02-26 17:55:49', 'Set herself involve well sister theory.', 'Low', 'bates-day.biz', 'Raise send animal two fine. Hope out concern pattern act.
Soldier real toward meet study today style prevent.
Child through risk manage nice specific involve. Discussion green agree him.
Situation goal specific fear. Yard score care kid your whatever. Win green push democratic yourself.'),
(2, '2023-02-27 10:10:23', 'Bank positive challenge discover account talk cost.', 'Medium', 'rhodes.net', 'At inside exist whether bed weight. Paper style with.
Former down spend key look force.
Baby product near fact. Realize four firm treatment do offer. Spring my choose firm.
Forget ten many whom send suffer foreign top. Government party on. Move effort although TV walk believe.'),
(3, '2023-07-22 18:18:09', 'College support possible society.', 'Critical', 'brown.com', 'Drug positive meeting. Moment soon front produce.
Including new shake serious. To east service amount if whom prove election.
Total cell decade town. Their career military. Best left defense we cost kid win.
Hair measure manage exactly. Its available matter have to culture.'),
(4, '2023-11-25 02:27:27', 'Age free occur position tree child.', 'Critical', 'powers.com', 'Perform skill spend dog condition teacher rather. Herself bag attack. Raise so child.
Program store knowledge kid.
Just improve rise research international film capital. Price sort play participant fact himself. History enough guy increase bank owner. Artist true stock great.'),
(5, '2020-08-08 15:10:31', 'Pick ago peace life red herself purpose.', 'Medium', 'roberts-mclaughlin.info', 'Forget collection fish that tough firm find. People tree reduce when state focus. Voice able occur shake time.
Strategy they dream person. Wind upon represent talk fight week affect. Letter everything future.'),
(6, '2020-09-18 01:54:19', 'Live teacher way team rate green nor.', 'Critical', 'porter.com', 'Democrat explain large war right true page.
Book record fast arm group dog. Coach view student apply notice notice. Hundred head stand provide offer national general.
Number bit edge order ball room. Than guy shoulder discuss amount. Physical group case half also.'),
(7, '2022-07-16 21:20:51', 'Couple minute case audience girl return.', 'Medium', 'hanson-branch.com', 'Occur huge night myself big practice management sure. Job attorney board good rule well yeah.
Indeed summer think list foreign. Vote race land cause. And ever care to shake red many.
Thing clear bag. Himself son our full across how a. Increase part born street apply.'),
(8, '2024-10-09 21:23:23', 'Clear change plan most own discover type.', 'Medium', 'thomas-castro.com', 'First west paper impact sister billion. Operation film land decide. Job act school her.
Place white race national benefit. Check figure weight actually everything. Edge decide tend really thing anything. Other eat quality picture parent test state.'),
(9, '2024-05-02 22:55:44', 'Care keep coach real professional.', 'Low', 'collins.org', 'Suddenly school might since fly. Trade point bank those.
Which sell ahead east indicate which what. Power seat sound treat daughter. Fund smile law task scene senior catch writer.
Without along most cause. Garden site guess energy parent want plant.'),
(10, '2020-08-07 06:20:39', 'Technology how charge clear drive.', 'High', 'wright.biz', 'True myself east walk success organization indeed. Range appear yard prepare.
Great might others Mr education agent. During quality another bit education game reduce. Within special foreign nothing his whether money. Help box site camera front bit.
Instead safe even.'),
(11, '2021-05-27 15:09:47', 'Scientist state air resource forward speak.', 'Critical', 'stewart.info', 'Sense truth gun everyone part even. Sing least article develop behind form. Character be key hand situation against.
Your future laugh least. Three so view need field. Write care shoulder. Country wait improve defense he.
Accept pull effect. Officer like buy sound.'),
(12, '2022-03-02 07:43:17', 'Eye society sport color.', 'Low', 'johnson.com', 'Series around performance same financial we point. Ago inside value fear painting me.
Deep wrong its baby majority far technology. Process if guy explain receive lot idea. Thus perform fact song.'),
(13, '2023-07-27 14:00:58', 'My sense Republican scientist.', 'Critical', 'lynch.com', 'Maybe often produce decide fast week. Activity thousand pick part single purpose.
Nation identify number weight food. Free old consider however issue month career make.
Ability room chair. Establish soldier power imagine.
Cut month keep. Race several of. Listen writer drive her hand.'),
(14, '2023-07-02 00:39:28', 'Culture single continue call memory become better instead.', 'Critical', 'dennis.com', 'Although they particular leader field method none.
Response tough issue lawyer draw plan return.
Because discuss with. Dream hand day class new some college.
Certainly every may. Eye gas already above.
Cost away event condition owner. College decide interest environment price everyone appear.'),
(15, '2021-08-31 04:35:49', 'Local kind live indeed sea floor Congress wrong.', 'Medium', 'black-neal.info', 'Majority nature system grow. Probably woman science sing. Fact same ten small.
Behavior whole more cut media hospital camera. Admit player write simply only fine around.
Career reality throughout hard such three culture. Kitchen benefit several relate assume off. Point clearly throw.'),
(16, '2020-05-26 12:46:27', 'Matter old out market information strong officer simple.', 'High', 'ross.org', 'Hot television American within street. Race wish threat commercial.
Direction late person else. Author hot call music buy door still.
Also ready budget want tax property may. Hospital computer score drop source detail.
Today despite car. Per may affect couple miss difficult political.'),
(17, '2021-01-03 08:03:59', 'Money between national chance relationship individual from morning.', 'Critical', 'williams-cortez.com', 'Top moment positive girl commercial. Head put nearly finish future happy.
Big protect deep nice.
About life give paper size. Fly letter boy cover certain take. Ground million become bar stock.
Card certain star get rest. War deal tend final herself. Whether in finish although his.'),
(18, '2020-03-17 18:11:20', 'Certainly sign event low quality personal.', 'Medium', 'bauer.com', 'Next trade part daughter begin more. Think run item admit image network. Give sit focus cover side adult.
Window fall weight quality man. Get respond him most.
Enough focus get age personal PM. East cost design baby.
Development fly approach almost still store.'),
(19, '2022-12-12 05:06:21', 'Success bar example happy fight.', 'Medium', 'flores.info', 'A among purpose.
Young kind little nation animal. Dog region because commercial view.
Defense wait hospital raise modern ahead claim area. Foreign line red voice surface. Care may admit professional early direction language.'),
(20, '2021-03-06 23:47:02', 'Necessary dinner commercial physical executive.', 'Critical', 'dawson-joseph.com', 'Become mother not ability system Democrat. Successful course four rock rate.
Team professor force feeling president also. As cell fill wear.
Test should minute dream music. Generation trip miss reveal.'),
(21, '2021-10-07 11:39:39', 'Benefit various game stock something decision.', 'Critical', 'wilson.com', 'Agree evidence center throw as or call. Pattern still east year develop medical thank. Western response air too stop.
My travel door season deal. Argue agreement listen. Drive popular hold ready listen speak door offer.
Still arrive think possible protect project.'),
(22, '2024-09-26 22:40:19', 'Natural just light hotel.', 'Critical', 'fuller.com', 'Fish do little. Reach exactly form first apply. Nothing until behind traditional defense. Author year cultural of wish section difficult.
Part dog identify real moment already. Per record policy attention she. Very most possible company card.'),
(23, '2024-05-22 04:23:25', 'Meeting music space yard oil also admit.', 'Low', 'parker.biz', 'Operation us rate less method. Kid often middle close bar. Meeting contain structure capital from system send.
Grow party skill mean response similar man. Goal friend board analysis option.
Team a ball decade. Great weight word message today together similar.'),
(24, '2021-06-29 22:47:24', 'Real list life collection sister focus traditional low.', 'High', 'fernandez.com', 'Article early top coach remain idea cover defense. Understand actually five executive near. Great sister foreign direction thing idea new senior. Make finish identify.
Phone side exactly see church. Firm herself campaign base change.'),
(25, '2022-08-15 02:21:38', 'Ask usually member officer.', 'High', 'bowen.biz', 'Large truth one issue late husband. Out should treatment rule piece hear over black.
Special plant many total head manage white. Enough big wait far son dream yeah.
Let trial news modern meeting just. Smile bit control call far data. Include again standard.'),
(26, '2025-04-06 04:05:27', 'Adult water case.', 'Low', 'fields.com', 'Across song team create to. Central feel how.
Crime of successful member.
Ok final around performance author find. Threat material benefit.
Thank technology contain here chair forget leader. Allow reality event health send. Truth matter fish say.'),
(27, '2021-02-07 08:10:37', 'Great wife seek.', 'Medium', 'barry.net', 'Sense partner speech you yourself but include peace. Very very these.
Upon another ever nothing sister. Want election present like central community.
Manager bring operation. First teach population street voice. Out grow best thank soon hotel million.'),
(28, '2021-05-08 00:07:38', 'Window once age board total modern unit.', 'Medium', 'johnson-mcintosh.com', 'Herself sort course hotel check involve weight. Politics husband because husband.
Western gun score range stay month I. Knowledge suffer along charge travel level wall. Before drop degree part box thousand age.
Total make audience about. Yeah cell morning hotel.'),
(29, '2021-09-28 08:30:49', 'Force behavior newspaper leg teach.', 'Critical', 'hoffman-cunningham.info', 'Operation here too.
And shoulder down customer six once plant. Sell relationship listen.
Rich ago list blood southern. Natural election ahead will name candidate whom.
Next bar letter see teacher. Official town recognize total cup everything off.'),
(30, '2021-08-23 16:33:14', 'Clearly whose this cell performance cut.', 'Critical', 'tapia.com', 'Ok eat summer want current wrong. Chair career my should region area majority. Son baby treatment relate.
Rather officer record require difference. House energy sort play be.
Drive question nor manage president. Information up of paper doctor man.'),
(31, '2021-03-28 18:51:25', 'Heart travel teacher admit police approach.', 'Low', 'johnson.net', 'Hospital more but safe investment. Employee community social away. Democratic dark seat we response each.
Region cultural cover whether accept according west ago. Heart present traditional play ahead across.
Fly team stage last most raise position sing.'),
(32, '2023-05-27 18:53:42', 'Tough affect this cell after serious southern.', 'Critical', 'cochran-smith.biz', 'Thought media evidence green never dream. Simply huge class her box whole main. Discover young down six president.
Similar within threat manage. Every easy investment tree away pressure task. Data mean laugh.'),
(33, '2020-04-28 10:21:28', 'Name product why create cultural material.', 'Medium', 'patterson.com', 'Color rest water despite result where do side. Under sing box into. Difficult little section order new right ready.
Artist among dinner player leg. Serve change unit.
Center chair skin manage. Too on rise avoid assume.
Even some radio. We property impact.'),
(34, '2020-11-12 02:25:01', 'Develop believe writer white nation.', 'Medium', 'hale.org', 'North chair recognize.
Water expect either officer article. Difficult beyond able probably hour tree serious. Turn establish sound could should important.
Over sing sure traditional whom fire. Itself respond relationship whether partner less.'),
(35, '2022-08-10 23:27:14', 'Stuff commercial trouble evening consumer spend season.', 'Low', 'hughes.biz', 'Guess PM issue near source stand painting. Attack beyond occur cut miss discussion. Represent explain whatever majority door walk anything stock. Public computer vote answer film catch.
Matter public cup staff possible. Father between sort weight way meet.');

-- Insert statements for table: LogEntry_IssueReport
INSERT INTO LogEntry_IssueReport (LogID, IssueID) VALUES
(23, 8),
(35, 8),
(3, 20),
(3, 17),
(34, 3),
(11, 28),
(23, 20),
(2, 2),
(16, 29),
(2, 23),
(20, 9),
(15, 12),
(5, 25),
(9, 14),
(14, 7),
(7, 19),
(6, 31),
(14, 28),
(16, 2),
(13, 35),
(2, 19),
(27, 15),
(4, 2),
(12, 4),
(3, 25),
(8, 9),
(29, 16),
(22, 32),
(13, 8),
(15, 1),
(17, 6),
(13, 2),
(16, 19),
(12, 22),
(29, 22),
(11, 5),
(28, 3),
(6, 4),
(8, 10),
(18, 14),
(26, 5),
(11, 26),
(19, 34),
(20, 34),
(16, 32),
(6, 21),
(4, 5),
(16, 3),
(17, 20),
(10, 24),
(4, 28),
(28, 6),
(17, 11),
(1, 15),
(6, 32),
(23, 28),
(33, 18),
(7, 17),
(24, 9),
(21, 5),
(2, 27),
(3, 35),
(9, 32),
(7, 16),
(4, 19),
(18, 19),
(33, 20),
(25, 30),
(30, 6),
(33, 9),
(12, 30),
(24, 30),
(1, 29),
(24, 4),
(16, 4),
(23, 29),
(31, 27),
(9, 13),
(4, 26),
(4, 4),
(14, 10),
(28, 35),
(17, 14),
(28, 21),
(14, 14),
(19, 32),
(29, 28),
(34, 6),
(9, 8),
(21, 3),
(26, 12),
(10, 12),
(26, 34),
(16, 20),
(31, 23),
(13, 9),
(15, 29),
(5, 4),
(3, 31),
(1, 10),
(13, 24),
(2, 31),
(17, 33),
(1, 28),
(14, 5),
(15, 28),
(25, 3),
(30, 34),
(26, 21),
(11, 13),
(17, 25),
(5, 35),
(4, 33),
(26, 18),
(28, 1),
(27, 1),
(14, 31),
(12, 33),
(33, 15),
(30, 14),
(16, 9),
(3, 6),
(12, 23),
(32, 7),
(35, 23),
(18, 4),
(34, 13),
(16, 23),
(22, 1),
(17, 34),
(32, 29),
(12, 15),
(2, 9),
(14, 1),
(24, 1),
(30, 21),
(15, 32),
(25, 29),
(7, 27),
(28, 20),
(16, 6),
(9, 7),
(22, 9),
(23, 26);

-- Insert statements for table: Meal
INSERT INTO Meal (RecipeID, Name, DateCreated, PrepTime, CookTime, Difficulty, Ingredients, Instructions, FavoriteStatus) VALUES
(1, 'Investment Meal', '2023-04-12', 17, 23, 'Easy', 'Must total water may Congress building wonder. Provide crime key occur main door. Buy door person front image industry prevent.
Move social establish capital into. Wear focus off probably.', 'Industry exist civil actually. Sea short month reveal.
Pm only which stop who not. Drive ball today keep.
First wish middle standard. Along offer woman tough tonight. Loss her sense real organization.
Go law born process sense space drop.', TRUE),
(2, 'Language Meal', '2021-08-04', 25, 41, 'Easy', 'Million analysis remain return model between. Form conference across part concern. Few floor full medical thing place reflect.
Outside eye ever break administration also.', 'Throw billion each from nature. May camera good successful behavior trial. Answer experience last off behavior character center.
Law all seem learn than consider might. Direction game simple reveal better.
Hot spring time professor available matter. Exist music class traditional.', FALSE),
(3, 'Identify Meal', '2022-04-18', 21, 31, 'Medium', 'Value power poor general source never class. Successful wonder actually strong how social let. We military college.', 'Receive truth million. Alone reduce which single political.
Quickly someone fine forget trip. Huge among police. Save against pattern another rather hundred. Ten wall manage down enough room.
Rise ago economy new Republican east relationship. Window second new.', TRUE),
(4, 'Senior Meal', '2022-09-06', 18, 54, 'Hard', 'Call then source operation country sense. Challenge social work bar article.', 'Brother compare trip share sport determine politics network. Detail week provide expert.
Some face eat some mother. Popular magazine learn everyone former husband ever.
Be address hit significant hand in both. Fish turn have black.
Concern collection decide. Fear just kind president citizen enter.', TRUE),
(5, 'Own Meal', '2020-07-11', 19, 55, 'Hard', 'Always beautiful election commercial beat them term blue. One old model especially section sea picture.
Budget write news community method writer sign. Technology cause over necessary Republican.', 'Somebody top chance will audience movement financial whole. Three wife behavior enter.
Music much production positive town knowledge fish laugh.
Program other you. Choose west meet. Development western city watch.', TRUE),
(6, 'Energy Meal', '2024-11-15', 20, 59, 'Hard', 'Goal social season fly kitchen. Population security best fear tell while.
Environmental sister system set natural customer. Water physical work that.', 'Thousand as may maybe trial. Two want parent sit state. Successful budget different sea.
But feeling manager go president window always up. Begin stop deal lawyer while television. Control listen score serious never.
Through deep tough question. Begin space approach cause.', FALSE),
(7, 'Yard Meal', '2022-06-04', 22, 28, 'Easy', 'Type owner only that officer. Check throw ready yard. Response since ground small show tax. To consider reach try political life.', 'Key understand baby heart write rate. Night believe language wrong. Box protect computer its hard strong.
Between final modern water camera. Window benefit minute town father business look.
Become benefit moment window. Experience option image seat. Million natural already officer level end.', TRUE),
(8, 'Everybody Meal', '2021-05-15', 25, 27, 'Hard', 'Business identify fine yes capital. Food bad together concern small treatment doctor use. Music throw because age mention memory newspaper.', 'Present moment process amount stuff imagine. Peace specific thank cause minute. Young whatever voice shoulder she industry.
Consider group experience you tough laugh. More think month. Let like dog old recognize across property.', TRUE),
(9, 'Your Meal', '2025-03-02', 23, 23, 'Easy', 'Size best hear my beyond city. Share administration woman analysis college. Pattern lawyer surface hospital decide source.', 'But change clearly fall surface. Rock yes seek positive challenge article. Head as memory garden country choose serious.
Man far cover right ground right buy. Into amount soon step mouth. Hotel possible civil.', TRUE),
(10, 'Provide Meal', '2021-05-08', 11, 31, 'Easy', 'Staff do figure never source travel treatment. Raise section system protect great. You member reach million a available newspaper.
Act thank guess score. Response use financial her offer there.', 'Lead stand certain into structure. Full require send along central next. Lot would job individual increase east rest. Its beat general deep yourself standard.
Man join debate wonder. Certain skill statement though common program.', TRUE),
(11, 'Keep Meal', '2025-01-05', 11, 38, 'Medium', 'Increase that big remember walk but whether. Market serve difference serve resource couple claim. Test product job manager win hand popular. Interesting not newspaper home around care.', 'Deal floor president say best. New bed might result than push. Expect under job bar.
Issue something manager. Party current offer. American small pick everything soldier myself sort. Since our group term early really decade.
Finally expect man. Visit fine laugh relate perform risk doctor even.', FALSE),
(12, 'Though Meal', '2023-06-03', 13, 51, 'Hard', 'Head level leader little. Benefit interest group skill.', 'Think air right kind level office. Each political American quality cover sure bit good.
Animal price green night hot. Like degree thank green.
Determine color morning local system under table. Bank teacher occur pass.', TRUE),
(13, 'Stock Meal', '2023-04-23', 27, 23, 'Hard', 'Become war stock. More my TV that general without market.
Never agreement their capital everybody record. Nothing writer father majority military specific not.', 'Current room than good nice already fight yeah. Southern state item society support.
Unit give house about should. Effort play cultural truth.
Again training list population heart fight. Free receive pull see behavior. Mr go house teach.', FALSE),
(14, 'Color Meal', '2022-01-28', 8, 52, 'Easy', 'Reflect fast research staff wide general war. Describe real property Congress rest head reason. Can part those water certain administration red.', 'Business use bed natural blue. Performance line person safe through away. Total practice agreement somebody foot.
Beautiful away picture age service. Find act recent space.
Sure state central book range. Investment factor around east speech.', TRUE),
(15, 'Mouth Meal', '2022-12-10', 28, 43, 'Easy', 'Party require hour edge picture. Democrat she fear smile if. Feeling own model figure fine most TV.
Able that tax fill entire building. Visit husband him claim light.
Before know change.', 'State charge rich about soldier cultural. Example plant again shake specific course. Order rich prove wind.
Six senior actually treatment every method. Without either floor image become goal fire.
Building can physical few. Entire throw suggest improve.', TRUE),
(16, 'Man Meal', '2024-02-20', 26, 39, 'Hard', 'End seat site probably. Stop heart design performance feeling ground opportunity. Possible century happy appear we eat occur approach.', 'Camera analysis also experience. Month price sea recognize person own drive whole.
Now watch property piece. Time give eye want cultural season build.
Report defense improve despite old city. Worker rule act prevent them. Artist good son.', TRUE),
(17, 'Explain Meal', '2020-10-19', 23, 31, 'Medium', 'General growth score subject surface fear. Board cell throughout save hotel scene tax.
Actually fly camera. Usually war yes already they.
Policy message make inside money. Write majority set reveal.', 'Husband school type meet give almost collection. Painting position federal nation trade drop only. Discuss affect wear one seek. Water list church nation per behavior arm.
Buy hot ago listen. Wife decision early program.', FALSE),
(18, 'Field Meal', '2021-09-10', 22, 40, 'Easy', 'Fill while view me state. Behind a happen or also fund indeed.
Treatment treatment sister and lose. Daughter movement education compare.', 'Let alone mean among remember. Central walk special allow evening.
Whom degree present mouth toward south. Without consider nice daughter story. Hold woman respond over.
Other modern take small short should. Unit president remember news subject. Prove build film investment most across.', FALSE),
(19, 'Use Meal', '2021-06-23', 15, 18, 'Medium', 'Machine analysis soon fire. Any visit cell owner even any anything. Development such standard determine fast.', 'Fight budget military race trip live be everything. Bed including our believe Mrs general individual guess. Follow task maintain. Remain growth board group.
Any until of hand win continue. Easy power hold age.
Administration environment majority. Claim just seat talk forward drug form.', TRUE),
(20, 'Quality Meal', '2021-03-07', 11, 26, 'Hard', 'Care full owner seven two which others. Statement require product group religious war. Heart long special these herself.
Option think of piece space trial.', 'Charge foot support attention group arrive. Inside whole future time anyone law.
Single natural surface thought produce determine western. Kind middle I outside summer money draw. Environment history court make south week. Evening agency business.
In wife nation class laugh decide.', TRUE),
(21, 'Staff Meal', '2022-12-11', 16, 50, 'Easy', 'Concern reveal remember people study. Debate friend machine. Various professional fact get box region.', 'Guess hope along good machine. Movement suggest responsibility machine something guess recent.
Soon administration probably country. Land order one control.
Drop throw clearly order second rock. Himself than whole police. Hope see table expert class.', FALSE),
(22, 'None Meal', '2023-05-06', 8, 28, 'Medium', 'Five little finally effect authority language past. Machine thus upon hour.
Available sister nation character reach. List against process across production next. Lose wind civil similar sport attack.', 'Interesting third special bed evening. Movement word sometimes fly cup. Now special theory notice capital throw certain.
Boy lose ever himself everything attention. Appear toward avoid. Old which attack its story.', TRUE),
(23, 'College Meal', '2022-01-11', 19, 55, 'Easy', 'Give table green before hear those. Time tree threat serve. Name during figure yard represent.', 'However single person area question help practice professor. Cell across mission million tree.
Tend hour success necessary politics could include. Among tell certainly home lay resource.', TRUE),
(24, 'Protect Meal', '2024-07-20', 26, 15, 'Hard', 'Tough base if conference. Skill you think step religious. Near trade hit.', 'Yard say fear whom identify occur. Less prepare join professional father machine.
Central majority difficult thus moment. Out authority concern along. Her society school church.', FALSE),
(25, 'Rule Meal', '2021-06-09', 24, 18, 'Easy', 'Next build house political type according. Good will realize arm government race amount. Two floor animal.', 'Expert leader once stuff.
Back million natural door than through. Rule study change rather through voice level.
Recent last foot very particular how data. Throughout science month rest oil because simply. Cost base news leg. Wall civil suggest fight a gas.', FALSE),
(26, 'Soldier Meal', '2024-07-16', 26, 11, 'Easy', 'Someone about all throw wife degree. Think under by his.
Road far beautiful board foreign myself produce partner. Player sense no stage act notice. Body event power.', 'Over own what only.
Thousand memory blue church. Student evening agency.
Onto enjoy fall through economic challenge series order. Behavior series why well need. Mean Republican conference brother degree smile note. Exist loss impact fire religious leader sea.', TRUE),
(27, 'Decision Meal', '2024-03-08', 24, 46, 'Medium', 'Wonder feel individual share fear. Place bring age answer. Recent pass and over structure.
Shoulder future dinner just road win. Give Mr claim see win. Line less book suffer system throw your speech.', 'Idea forget loss expect one so occur trip. Half past tonight will ahead safe up outside.
They kind now road star physical discuss. Cause water improve later network. Whose forward quality task. So dog hair probably imagine across technology defense.', FALSE),
(28, 'Tend Meal', '2024-05-21', 30, 54, 'Hard', 'Test rest heart entire can.
Until modern notice over type while. Company hear candidate wide idea.', 'According medical fill. Probably management wish home design exist expect.
Method check heart like throw those become almost.
Explain her quality particular fly easy year. Really meeting I turn.
Arm activity need eye story yet senior. Remember enough impact religious door.', FALSE),
(29, 'Nation Meal', '2021-08-26', 9, 10, 'Easy', 'Sit thank something few. Nor success economic affect contain other new edge. Five similar social hospital.
Call interesting idea look. Out whether father industry necessary sport.', 'Paper character she report feel.
Decide possible close. Party staff look side. Race brother science operation.
Benefit lose give paper. Provide safe whose service I century. Watch all here same interview others south administration.', FALSE),
(30, 'Everybody Meal', '2023-09-21', 27, 50, 'Easy', 'Since while forward agency policy thing. Then face cup son assume team structure.', 'Information government still full none often. Bad plant police realize. Need imagine appear center.
Race American add leader data sometimes listen. Not next likely care.
Short dream maybe bad news join. Turn blue stop forget team network. Believe room positive poor some which movement road.', TRUE),
(31, 'Idea Meal', '2024-06-03', 14, 40, 'Easy', 'Investment fish federal will. Part professional eat enter tell whole special once. Stop outside discussion realize determine only bad peace. Cell up difficult business question daughter office.', 'Believe discussion quite out. Happy entire wind give foreign get trouble good.
Account note seem religious war today bad.
Treatment explain position girl century radio recently. Physical wonder computer health mouth chair recognize. Look star president while those politics.', FALSE),
(32, 'American Meal', '2023-06-26', 15, 25, 'Hard', 'Society guess glass smile against. Nearly carry some type. Church level consider remain think two.', 'Night cell north south my simply social. How treat before degree. North since and start model.
A moment likely return against point. Case politics north impact. Mind like network parent.
Standard leave quality choice fast choice no throw. Budget mouth buy raise race.', FALSE),
(33, 'Toward Meal', '2024-02-08', 29, 15, 'Hard', 'Idea travel beat pattern side. Carry despite class. Event upon deal air course charge past. And since along.', 'Cup direction majority product artist water prepare. Yes any occur force several huge some beautiful.
Detail teach guy sign hot newspaper. Billion week reality eye stay home. Perform have rule kitchen money letter group.', FALSE),
(34, 'Look Meal', '2025-01-06', 21, 55, 'Easy', 'Training authority manage discover important. Establish law page much population and cultural. Color three nor public.', 'Clear structure power challenge while data head. Change manager training treat opportunity study. Couple evidence minute way floor nice sea.
Say bit both page scientist boy hit. Learn lawyer unit interview. Mean place police dinner pull. Window ground spend street sign instead serious.', FALSE),
(35, 'Personal Meal', '2020-12-18', 7, 10, 'Hard', 'Road reflect return according middle outside. Edge from set wonder appear certain act.
Draw food ready bring security check fine. Agency notice kitchen answer middle perhaps line type.', 'Girl certain culture. Base source sister student tonight general. Say somebody close tell carry. Shoulder explain condition put.
Artist agreement appear. Particular necessary up good.
Dog lead forward sing step future. My choose beautiful so indicate.', FALSE);

-- Insert statements for table: Meal_Tag
INSERT INTO Meal_Tag (RecipeID, TagID) VALUES
(19, 16),
(1, 24),
(8, 7),
(12, 21),
(34, 9),
(19, 6),
(19, 23),
(2, 24),
(25, 6),
(19, 20),
(27, 26),
(10, 17),
(10, 32),
(35, 23),
(32, 30),
(33, 21),
(20, 21),
(11, 31),
(19, 4),
(11, 18),
(3, 8),
(13, 34),
(9, 25),
(22, 31),
(33, 8),
(31, 17),
(19, 2),
(20, 32),
(11, 3),
(35, 31),
(11, 35),
(13, 13),
(12, 10),
(32, 6),
(27, 20),
(25, 34),
(3, 12),
(18, 27),
(19, 32),
(12, 12),
(16, 9),
(7, 19),
(3, 25),
(15, 32),
(25, 22),
(33, 34),
(19, 10),
(35, 1),
(23, 27),
(32, 2),
(7, 3),
(13, 20),
(8, 12),
(30, 18),
(35, 22),
(26, 23),
(29, 5),
(27, 14),
(9, 10),
(5, 32),
(7, 23),
(8, 10),
(15, 27),
(33, 27),
(4, 26),
(33, 28),
(10, 19),
(20, 19),
(20, 4),
(33, 12),
(7, 14),
(31, 15),
(14, 8),
(9, 4),
(32, 18),
(2, 32),
(13, 18),
(24, 20),
(2, 7),
(18, 6),
(21, 10),
(18, 7),
(22, 6),
(24, 34),
(13, 16),
(29, 4),
(25, 12),
(23, 24),
(27, 1),
(24, 7),
(25, 33),
(28, 11),
(1, 13),
(14, 20),
(27, 35),
(21, 23),
(18, 12),
(14, 17),
(16, 18),
(12, 13),
(21, 8),
(9, 13),
(1, 34),
(31, 24),
(29, 18),
(1, 25),
(24, 9),
(31, 6),
(25, 27),
(4, 27),
(34, 11),
(20, 34),
(30, 25),
(22, 21),
(15, 25),
(25, 26),
(2, 26),
(31, 13),
(31, 34),
(26, 29),
(23, 9),
(7, 24),
(24, 4),
(35, 18),
(5, 2),
(20, 17),
(8, 25),
(4, 33),
(27, 23),
(23, 30),
(15, 21),
(23, 7),
(35, 25),
(22, 25),
(32, 34),
(30, 30),
(7, 11),
(1, 8),
(32, 3),
(9, 2),
(29, 13);

-- Insert statements for table: RecipeData
INSERT INTO RecipeData (RecipeID, Name, SavedStatus, CategoryID, ViewCount) VALUES
(1, 'Pressure Dish', TRUE, 6, 584),
(2, 'Pressure Dish', TRUE, 3, 3871),
(3, 'Continue Dish', TRUE, 4, 4198),
(4, 'Close Dish', FALSE, 6, 4105),
(5, 'Member Dish', FALSE, 5, 2543),
(6, 'Source Dish', TRUE, 20, 4566),
(7, 'Interview Dish', TRUE, 22, 1505),
(8, 'Who Dish', FALSE, 4, 1087),
(9, 'Course Dish', FALSE, 28, 2212),
(10, 'News Dish', TRUE, 27, 4206),
(11, 'Keep Dish', TRUE, 4, 2239),
(12, 'Film Dish', FALSE, 24, 3293),
(13, 'Production Dish', FALSE, 17, 4065),
(14, 'Seek Dish', TRUE, 34, 4918),
(15, 'Per Dish', FALSE, 22, 332),
(16, 'Marriage Dish', FALSE, 11, 1011),
(17, 'Claim Dish', TRUE, 33, 153),
(18, 'Bit Dish', TRUE, 24, 4557),
(19, 'Both Dish', FALSE, 18, 3948),
(20, 'Close Dish', TRUE, 29, 2344),
(21, 'Middle Dish', FALSE, 26, 3658),
(22, 'Sit Dish', TRUE, 35, 3081),
(23, 'Report Dish', TRUE, 23, 3225),
(24, 'Art Dish', TRUE, 31, 1438),
(25, 'Us Dish', FALSE, 15, 492),
(26, 'Oil Dish', TRUE, 27, 118),
(27, 'Second Dish', TRUE, 15, 1068),
(28, 'Rock Dish', TRUE, 22, 4177),
(29, 'Firm Dish', TRUE, 17, 3914),
(30, 'Expert Dish', TRUE, 28, 1114),
(31, 'Approach Dish', FALSE, 16, 3818),
(32, 'Among Dish', FALSE, 8, 3780),
(33, 'My Dish', TRUE, 19, 1844),
(34, 'Consumer Dish', FALSE, 29, 1553),
(35, 'Blood Dish', TRUE, 7, 107);

-- Insert statements for table: Saved_Meals
INSERT INTO Saved_Meals (Username, RecipeID) VALUES
('mmitchell', 18),
('mjohnson', 9),
('patrick93', 17),
('smiller', 22),
('jenniferchambers', 34),
('dunnapril', 25),
('xwilliams', 32),
('boydjudy', 8),
('dpage', 32),
('glasspatrick', 25),
('walkerwendy', 13),
('heathershannon', 15),
('dunnapril', 12),
('hallbrandi', 7),
('hallbrandi', 33),
('williamholt', 19),
('dunnapril', 27),
('antonio70', 34),
('saramccarthy', 2),
('robert44', 33),
('mjohnson', 19),
('smiller', 9),
('williamholt', 3),
('erinharris', 13),
('allenluke', 6),
('pmorgan', 2),
('marksanchez', 21),
('dpage', 31),
('sotomeghan', 24),
('williamholt', 24),
('stevenstewart', 25),
('xwilliams', 20),
('hallbrandi', 2),
('sotomeghan', 15),
('sotomeghan', 5),
('mmitchell', 27),
('mendezrussell', 14),
('mmitchell', 23),
('williamholt', 22),
('xwilliams', 33),
('ycook', 1),
('williamholt', 1),
('erinharris', 22),
('mcarrillo', 12),
('stewartgabriel', 35),
('robert44', 22),
('mendezrussell', 33),
('johnny76', 14),
('walkerwendy', 27),
('allenluke', 27),
('smiller', 1),
('smiller', 11),
('marksanchez', 17),
('antonio70', 13),
('stewartgabriel', 20),
('christopherthomas', 25),
('tyler63', 1),
('xwilliams', 12),
('christopherthomas', 31),
('smiller', 4),
('glasspatrick', 19),
('allenluke', 1),
('erinharris', 23),
('ycook', 32),
('sotomeghan', 3),
('ucook', 3),
('hallbrandi', 12),
('johnny76', 1),
('williamholt', 12),
('christopherthomas', 23),
('tyler63', 27),
('antonio70', 6),
('mmitchell', 30),
('marksanchez', 31),
('ycook', 7),
('mcarrillo', 18),
('antonio70', 8),
('glasspatrick', 34),
('sotomeghan', 32),
('pmorgan', 4),
('boydjudy', 24),
('bbaker', 18),
('christopherthomas', 2),
('ucook', 21),
('mcarrillo', 4),
('tyler63', 19),
('boydjudy', 10),
('allenluke', 17),
('hallbrandi', 8),
('patrick93', 26),
('smiller', 15),
('andres57', 11),
('antonio70', 3),
('patrick93', 15),
('smiller', 6),
('bbaker', 19),
('mmitchell', 10),
('curtiscollier', 5),
('sotomeghan', 34),
('christopherthomas', 14),
('xwilliams', 23),
('saramccarthy', 15),
('erinharris', 20),
('antonio70', 17),
('mcarrillo', 11),
('erinharris', 12),
('erinharris', 31),
('williamholt', 13),
('dunnapril', 29),
('stewartgabriel', 12),
('xallen', 15),
('williamholt', 11),
('stewartgabriel', 31),
('mjohnson', 30),
('erinharris', 1),
('allenluke', 25),
('boydjudy', 6),
('patrick93', 7),
('antonio70', 26),
('mjohnson', 34),
('andres57', 7),
('christopherthomas', 11),
('pmorgan', 6),
('bbaker', 9),
('stevenstewart', 26),
('tyler63', 34),
('jenniferchambers', 30),
('christopherthomas', 1),
('stevenstewart', 15),
('mendezrussell', 24),
('mmitchell', 33),
('mendezrussell', 10),
('patrick93', 10),
('andres57', 31),
('dunnapril', 35),
('tyler63', 9),
('mjohnson', 12),
('jenniferchambers', 25),
('xallen', 3),
('stewartgabriel', 28),
('dpage', 34),
('jenniferchambers', 32);

-- Insert statements for table: Tag
INSERT INTO Tag (TagID, Cuisine, Allergy, MealType) VALUES
(1, 'Mexican', 'Peanuts', 'Snack'),
(2, 'Italian', 'None', 'Snack'),
(3, 'Japanese', 'Dairy', 'Snack'),
(4, 'Italian', 'Gluten', 'Snack'),
(5, 'Chinese', 'Shellfish', 'Lunch'),
(6, 'Indian', 'None', 'Snack'),
(7, 'Thai', 'None', 'Lunch'),
(8, 'Thai', 'Dairy', 'Lunch'),
(9, 'Italian', 'Peanuts', 'Lunch'),
(10, 'Chinese', 'Dairy', 'Snack'),
(11, 'Mexican', 'None', 'Dessert'),
(12, 'Indian', 'None', 'Lunch'),
(13, 'Chinese', 'Peanuts', 'Lunch'),
(14, 'Italian', 'Dairy', 'Lunch'),
(15, 'Chinese', 'Soy', 'Dinner'),
(16, 'Chinese', 'Shellfish', 'Breakfast'),
(17, 'Italian', 'Dairy', 'Breakfast'),
(18, 'Japanese', 'Shellfish', 'Breakfast'),
(19, 'Thai', 'Gluten', 'Breakfast'),
(20, 'French', 'Shellfish', 'Breakfast'),
(21, 'French', 'Peanuts', 'Snack'),
(22, 'Mexican', 'Peanuts', 'Dessert'),
(23, 'Mexican', 'Shellfish', 'Dessert'),
(24, 'Mexican', 'None', 'Snack'),
(25, 'Mexican', 'None', 'Snack'),
(26, 'Italian', 'Shellfish', 'Snack'),
(27, 'French', 'Shellfish', 'Snack'),
(28, 'Mexican', 'Gluten', 'Snack'),
(29, 'Thai', 'Soy', 'Dessert'),
(30, 'French', 'Peanuts', 'Dessert'),
(31, 'French', 'Peanuts', 'Lunch'),
(32, 'Italian', 'Soy', 'Dessert'),
(33, 'Japanese', 'Shellfish', 'Dinner'),
(34, 'Mexican', 'Shellfish', 'Snack'),
(35, 'Chinese', 'Shellfish', 'Lunch');

-- Insert statements for table: User
INSERT INTO User (Username, FirstName, LastName, Region, ActivityLevel, Age, InclusionStatus, Bio) VALUES
('jeanbautista', 'Dawn', 'Johnson', 'Alaska', 'Medium', 26, FALSE, 'Kind this light second couple. Show grow behavior you develop.'),
('annehendrix', 'Peter', 'Harding', 'Oklahoma', 'Low', 43, TRUE, 'Themselves tax bit chance instead. Important change bill head baby safe husband a.'),
('shelby08', 'Edward', 'Mccoy', 'West Virginia', 'Low', 29, FALSE, 'Religious father easy. Foreign study keep fly begin we.
Per especially tree TV mean.'),
('brian24', 'Jessica', 'Camacho', 'Wyoming', 'Low', 55, FALSE, 'Trouble conference say. Send question hard billion well.'),
('carpenterteresa', 'Monique', 'Gonzalez', 'Minnesota', 'Low', 26, FALSE, 'Music today better human although reduce eat. Hair strategy there maybe drug way.'),
('zcarpenter', 'Thomas', 'Thomas', 'North Carolina', 'Low', 53, FALSE, 'Always view forward piece thing attention trouble. Describe sister walk create cost.'),
('leslie91', 'Joan', 'Roberts', 'Maryland', 'Low', 49, TRUE, 'Pull power special wear. Huge own stuff material.'),
('mwheeler', 'Sara', 'Miller', 'Iowa', 'High', 50, FALSE, 'Generation Mrs country meet. Hard onto strategy agent really open.'),
('qsanchez', 'Cindy', 'Williams', 'Alaska', 'Low', 37, FALSE, 'Against by seek former upon economic. Ready party industry within might security political.'),
('phuerta', 'Aaron', 'Harris', 'Nebraska', 'Low', 35, TRUE, 'Sister keep really generation put guy. Close modern national.'),
('michael99', 'Michael', 'Compton', 'Minnesota', 'Medium', 26, FALSE, 'Whole evidence sport high. Bar find address serve.'),
('wilkinsjose', 'Phyllis', 'Collins', 'Oklahoma', 'Medium', 46, TRUE, 'Name same particularly about during former. Chance career factor.'),
('anthonyjackson', 'Cindy', 'Bautista', 'Hawaii', 'High', 37, TRUE, 'By themselves budget girl. Month central star television me word finish. Off senior culture.'),
('olee', 'Alexander', 'Melton', 'Mississippi', 'Low', 70, FALSE, 'Order stay executive important see environment policy. When current different north.'),
('michelle25', 'Kelsey', 'Taylor', 'Delaware', 'High', 28, TRUE, 'Young value behavior line PM. Inside woman television it. Rise clearly watch nor idea.'),
('amy03', 'Matthew', 'Bass', 'Alabama', 'Medium', 62, FALSE, 'Account live future wonder by fear guess. Develop thought attention nice minute notice.'),
('sandraparker', 'John', 'Bishop', 'Virginia', 'Medium', 29, FALSE, 'Their through third take road social health. Middle record water account woman successful.'),
('rebecca94', 'Jennifer', 'Thornton', 'Montana', 'Low', 65, FALSE, 'One major environmental per west occur number.'),
('mjohnson', 'Jeff', 'Riley', 'New York', 'Medium', 35, TRUE, 'Establish whatever south officer peace Democrat against. Alone matter for. Near risk gun the not.'),
('montgomerynathaniel', 'Christopher', 'Frazier', 'Georgia', 'Medium', 37, FALSE, 'Although ahead hold avoid area by. Low tax issue staff. Miss candidate page report.'),
('renee18', 'Amanda', 'Lewis', 'Maryland', 'High', 28, TRUE, 'Score life himself television hotel conference. Officer skill price experience.'),
('nicholasdavis', 'Daniel', 'Taylor', 'North Carolina', 'Low', 49, TRUE, 'Adult manager ability democratic. Word this total skill himself.'),
('joseph81', 'Charles', 'Sanders', 'New Jersey', 'Medium', 57, FALSE, 'Pull one should finally agent simple contain.'),
('tiffany71', 'Natalie', 'Ritter', 'Nebraska', 'High', 60, TRUE, 'Place win southern class top tough. Other ball catch. Full organization move past.'),
('ryan08', 'Sandra', 'Davis', 'Montana', 'Low', 27, TRUE, 'Realize seven important while line poor. Serious situation memory hour.'),
('oherring', 'Kenneth', 'Murray', 'Colorado', 'Medium', 68, FALSE, 'Coach pay drug personal turn enjoy try.
Newspaper maintain night yard show. Bit officer enjoy.'),
('jeffreyfrazier', 'Laura', 'Dickerson', 'Wisconsin', 'Low', 69, TRUE, 'Like idea huge glass word five. Group word firm yard. Laugh scientist upon southern man know.'),
('gbuckley', 'Michael', 'Johnson', 'California', 'High', 36, TRUE, 'Your series born area participant pass. Point him will but computer.'),
('nmeyer', 'Sandra', 'Lane', 'Mississippi', 'Low', 59, TRUE, 'Discussion arrive for onto those value bill others. Full where grow.'),
('brittanypowell', 'John', 'Williams', 'Ohio', 'Low', 49, TRUE, 'Town top two TV break least time. Model lawyer man hard.'),
('jefferydavis', 'Ricky', 'Gray', 'Utah', 'Medium', 40, TRUE, 'Put possible skill statement catch. Light certain trouble himself determine too sport.'),
('orobinson', 'Denise', 'Reed', 'Alabama', 'High', 36, TRUE, 'How teach ever another already choice far.'),
('gatesjames', 'John', 'Gonzalez', 'Arkansas', 'High', 49, TRUE, 'Be ready kitchen even young carry. Try any building.'),
('jeffreymorris', 'Kimberly', 'Hawkins', 'Vermont', 'High', 18, TRUE, 'Account street day child firm.
Research direction six easy doctor exist. Teach camera a always.'),
('gherrera', 'Vickie', 'Clark', 'New Hampshire', 'Low', 66, FALSE, 'Parent country side involve green none. Quite court seven page according gas table.');

-- Insert statements for table: UserDemographic
INSERT INTO UserDemographic (UserID, GroupID) VALUES
('saramccarthy', 16),
('hallbrandi', 28),
('mendezrussell', 28),
('tyler63', 25),
('sotomeghan', 13),
('dpage', 30),
('tyler63', 30),
('saramccarthy', 14),
('tyler63', 24),
('stevenstewart', 20),
('dunnapril', 17),
('mjohnson', 35),
('allenluke', 13),
('walkerwendy', 9),
('saramccarthy', 3),
('xwilliams', 35),
('allenluke', 16),
('stewartgabriel', 2),
('curtiscollier', 26),
('antonio70', 5),
('erinharris', 28),
('marksanchez', 25),
('walkerwendy', 31),
('hallbrandi', 21),
('glasspatrick', 7),
('saramccarthy', 30),
('allenluke', 30),
('ucook', 7),
('walkerwendy', 32),
('antonio70', 8),
('xwilliams', 10),
('dpage', 4),
('xwilliams', 16),
('stewartgabriel', 15),
('dunnapril', 27),
('andres57', 28),
('andres57', 6),
('stewartgabriel', 10),
('heathershannon', 14),
('dpage', 28),
('andres57', 33),
('saramccarthy', 35),
('johnny76', 25),
('stewartgabriel', 8),
('allenluke', 7),
('johnny76', 16),
('robert44', 34),
('pmorgan', 5),
('xallen', 20),
('walkerwendy', 27),
('sotomeghan', 14),
('patrick93', 5),
('saramccarthy', 15),
('mmitchell', 30),
('erinharris', 4),
('boydjudy', 25),
('glasspatrick', 8),
('boydjudy', 6),
('mendezrussell', 27),
('mcarrillo', 17),
('allenluke', 3),
('pmorgan', 31),
('tyler63', 23),
('ycook', 33),
('smiller', 4),
('mendezrussell', 23),
('walkerwendy', 12),
('pmorgan', 30),
('andres57', 10),
('mjohnson', 16),
('stewartgabriel', 23),
('andres57', 2),
('ucook', 1),
('saramccarthy', 32),
('boydjudy', 4),
('erinharris', 13),
('allenluke', 6),
('mendezrussell', 29),
('robert44', 1),
('christopherthomas', 7),
('glasspatrick', 13),
('ycook', 13),
('williamholt', 24),
('xallen', 15),
('heathershannon', 20),
('ycook', 1),
('xallen', 9),
('stevenstewart', 34),
('boydjudy', 22),
('tyler63', 3),
('walkerwendy', 2),
('christopherthomas', 22),
('stewartgabriel', 22),
('mmitchell', 18),
('patrick93', 4),
('curtiscollier', 12),
('marksanchez', 7),
('curtiscollier', 29),
('mendezrussell', 19),
('heathershannon', 26),
('andres57', 26),
('erinharris', 5),
('stevenstewart', 13),
('boydjudy', 12),
('bbaker', 19),
('hallbrandi', 7),
('johnny76', 30),
('jenniferchambers', 23),
('smiller', 35),
('andres57', 7),
('ucook', 29),
('mjohnson', 30),
('robert44', 27),
('williamholt', 3),
('xallen', 35),
('andres57', 15),
('marksanchez', 29),
('hallbrandi', 15),
('erinharris', 33),
('hallbrandi', 30),
('erinharris', 10),
('allenluke', 27),
('robert44', 28),
('williamholt', 17),
('mendezrussell', 22),
('stewartgabriel', 20),
('marksanchez', 33),
('pmorgan', 35),
('ycook', 5),
('mendezrussell', 8),
('jenniferchambers', 4),
('dpage', 22),
('mjohnson', 11),
('xallen', 23),
('bbaker', 31),
('curtiscollier', 5),
('christopherthomas', 2),
('hallbrandi', 5),
('mmitchell', 12),
('marksanchez', 4),
('stewartgabriel', 33),
('stewartgabriel', 19),
('stewartgabriel', 12),
('antonio70', 11);
