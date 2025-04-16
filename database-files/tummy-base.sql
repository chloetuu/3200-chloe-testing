-- Drop and create the Tummy database
DROP DATABASE IF EXISTS Tummy;
CREATE DATABASE Tummy;
USE Tummy;

-- User Table
CREATE TABLE User (
    Username VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Region VARCHAR(50),
    Age INT,
    Bio TEXT,
    ActivityLevel VARCHAR(50),
    InclusionStatus BOOLEAN
);

-- LogEntry Table
CREATE TABLE LogEntry (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    Timestamp TIMESTAMP,
    SeverityLevel VARCHAR(50),
    Source VARCHAR(100),
    Details TEXT,
    ErrorMessage TEXT
);

-- Alert Table
CREATE TABLE Alert (
    AlertID INT PRIMARY KEY,
    Type VARCHAR(50),
    Timestamp TIMESTAMP,
    AssignedTo VARCHAR(50),
    LogID INT,
    FOREIGN KEY (AssignedTo) REFERENCES User(Username),
    FOREIGN KEY (LogID) REFERENCES LogEntry(LogID)
);

-- IssueReport Table
CREATE TABLE IssueReport (
    IssueID INT PRIMARY KEY,
    Status VARCHAR(50),
    Description TEXT,
    Timestamp TIMESTAMP,
    ReportedBy VARCHAR(50),
    LogID INT,
    FOREIGN KEY (ReportedBy) REFERENCES User(Username),
    FOREIGN KEY (LogID) REFERENCES LogEntry(LogID)
);

-- Meal Table
CREATE TABLE Meal (
    RecipeID INT PRIMARY KEY,
    Name VARCHAR(100),
    DateCreated DATE,
    PrepTime INT,
    CookTime INT,
    TotalTime INT,
    Difficulty VARCHAR(50),
    Ingredients TEXT,
    Instructions TEXT,
    ViewCount INT
);

-- Blog Table
CREATE TABLE Blog (
    BlogID INT PRIMARY KEY,
    Title VARCHAR(100),
    Content TEXT,
    PublishDate DATE,
    Username VARCHAR(50),
    RecipeID INT,
    FOREIGN KEY (Username) REFERENCES User(Username),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID)
);

-- Tag Table
CREATE TABLE Tag (
    TagID INT PRIMARY KEY,
    TagName VARCHAR(50)
);

-- Meal_Tag Bridge Table (Meal <-> Tag)
CREATE TABLE Meal_Tag (
    RecipeID INT,
    TagID INT,
    PRIMARY KEY (RecipeID, TagID),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID),
    FOREIGN KEY (TagID) REFERENCES Tag(TagID)
);

-- Saved_Meals Bridge Table (User <-> Meal)
CREATE TABLE Saved_Meals (
    Username VARCHAR(50),
    RecipeID INT,
    PRIMARY KEY (Username, RecipeID),
    FOREIGN KEY (Username) REFERENCES User(Username),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID)
);

-- Interaction Table
CREATE TABLE Interaction (
    InteractionID INT PRIMARY KEY AUTO_INCREMENT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    InteractionType VARCHAR(50),
    RecipeID INT,
    UserID VARCHAR(50),
    FOREIGN KEY (RecipeID) REFERENCES Meal(RecipeID),
    FOREIGN KEY (UserID) REFERENCES User(Username)
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
INSERT INTO Tag (TagID, TagName) VALUES
(1, 'Italian'),
(2, 'Mexican'),
(3, 'Chinese'),
(4, 'Indian'),
(5, 'Japanese'),
(6, 'American'),
(7, 'Mediterranean'),
(8, 'Gluten'),
(9, 'Dairy'),
(10, 'Nuts'),
(11, 'Shellfish'),
(12, 'Eggs'),
(13, 'Soy'),
(14, 'Breakfast'),
(15, 'Lunch'),
(16, 'Dinner'),
(17, 'Dessert'),
(18, 'Snack');

-- Insert statements for table: Meal
INSERT INTO Meal (RecipeID, Name, DateCreated, PrepTime, CookTime, TotalTime, Difficulty, Ingredients, Instructions, ViewCount) VALUES
(1, 'Spaghetti Carbonara', '2024-03-01', 15, 20, 35, 'Medium', 'Pasta, eggs, pancetta, parmesan', 'Cook pasta, mix with sauce.', 150),
(2, 'Chicken Tacos', '2024-03-02', 20, 25, 45, 'Easy', 'Chicken, tortillas, vegetables', 'Cook chicken, assemble tacos.', 200),
(3, 'Tiramisu', '2024-03-03', 30, 0, 30, 'Medium', 'Ladyfingers, coffee, mascarpone', 'Layer ingredients and chill.', 180),
(4, 'Butter Chicken', '2024-03-04', 30, 40, 70, 'Hard', 'Chicken, tomatoes, cream, spices', 'Cook chicken in sauce.', 120),
(5, 'Greek Salad', '2024-03-05', 15, 0, 15, 'Easy', 'Cucumber, tomato, feta, olives', 'Chop and mix ingredients.', 90),
(6, 'Beef Stir Fry', '2024-03-06', 20, 15, 35, 'Medium', 'Beef, vegetables, soy sauce', 'Stir-fry all ingredients.', 110),
(7, 'Margherita Pizza', '2024-03-07', 20, 15, 35, 'Medium', 'Dough, tomato sauce, mozzarella', 'Top dough and bake.', 250),
(8, 'Avocado Toast', '2024-03-08', 10, 5, 15, 'Easy', 'Bread, avocado, eggs', 'Toast bread, top with avocado.', 300),
(9, 'Chicken Curry', '2024-03-09', 25, 35, 60, 'Medium', 'Chicken, curry paste, coconut milk', 'Cook chicken in curry sauce.', 140),
(10, 'Chocolate Cake', '2024-03-10', 30, 40, 70, 'Hard', 'Flour, sugar, cocoa, eggs', 'Mix and bake ingredients.', 220),
(11, 'Pasta Primavera', '2024-03-11', 15, 15, 30, 'Easy', 'Pasta, vegetables, cream', 'Cook pasta, mix with vegetables.', 95),
(12, 'Beef Stew', '2024-03-12', 20, 120, 140, 'Hard', 'Beef, vegetables, broth', 'Simmer ingredients for hours.', 85),
(13, 'Caesar Salad', '2024-03-13', 15, 0, 15, 'Easy', 'Romaine, croutons, dressing', 'Toss ingredients together.', 110),
(14, 'Pancakes', '2024-03-14', 10, 15, 25, 'Easy', 'Flour, milk, eggs, sugar', 'Mix and cook on griddle.', 180),
(15, 'Sushi Rolls', '2024-03-15', 30, 20, 50, 'Hard', 'Rice, fish, vegetables, seaweed', 'Roll ingredients in seaweed.', 160),
(16, 'Chicken Soup', '2024-03-16', 20, 60, 80, 'Medium', 'Chicken, vegetables, broth', 'Simmer ingredients together.', 75),
(17, 'Lasagna', '2024-03-17', 30, 45, 75, 'Hard', 'Pasta, meat, cheese, sauce', 'Layer and bake ingredients.', 190),
(18, 'Fruit Smoothie', '2024-03-18', 10, 0, 10, 'Easy', 'Fruits, yogurt, milk', 'Blend all ingredients.', 200),
(19, 'Beef Burgers', '2024-03-19', 15, 15, 30, 'Easy', 'Beef, buns, toppings', 'Form patties and grill.', 240),
(20, 'Chocolate Chip Cookies', '2024-03-20', 15, 12, 27, 'Easy', 'Flour, sugar, chocolate chips', 'Mix and bake dough.', 280),
(21, 'Fish and Chips', '2024-03-21', 20, 20, 40, 'Medium', 'Fish, potatoes, batter', 'Fry fish and potatoes.', 130),
(22, 'Vegetable Stir Fry', '2024-03-22', 15, 10, 25, 'Easy', 'Vegetables, soy sauce', 'Stir-fry vegetables.', 100),
(23, 'Ratatouille', '2024-03-23', 25, 45, 70, 'Hard', 'Zucchini, eggplant, tomato, bell pepper', 'Slice and bake with herbs.', 100),
(24, 'Egg Fried Noodles', '2024-03-24', 15, 10, 25, 'Easy', 'Noodles, egg, scallions, soy sauce', 'Stir-fry all ingredients together.', 135),
(25, 'Omelette', '2024-03-25', 10, 5, 15, 'Easy', 'Eggs, cheese, vegetables', 'Whisk eggs and cook in skillet.', 125),
(26, 'Shakshuka', '2024-03-26', 20, 25, 45, 'Medium', 'Tomato sauce, eggs, bell peppers, onions', 'Simmer sauce and poach eggs in it.', 80),
(27, 'Biryani', '2024-03-27', 40, 45, 85, 'Hard', 'Rice, chicken, spices, yogurt', 'Layer and cook ingredients.', 115),
(28, 'Pho', '2024-03-28', 30, 60, 90, 'Hard', 'Beef broth, rice noodles, herbs', 'Simmer broth and assemble bowls.', 95),
(29, 'Pesto Pasta', '2024-03-29', 15, 15, 30, 'Easy', 'Pasta, basil, garlic, olive oil, pine nuts', 'Blend pesto. Mix with pasta.', 165),
(30, 'Clam Chowder', '2024-03-30', 20, 40, 60, 'Medium', 'Clams, potatoes, cream, onions, bacon', 'Simmer ingredients and serve hot.', 140);

-- Insert statements for table: Meal_Tag
INSERT INTO Meal_Tag (RecipeID, TagID) VALUES
(1, 1),
(1, 7),
(2, 16),
(2, 2),
(3, 1),
(3, 17),
(4, 1),
(4, 10),
(4, 4),
(5, 7),
(5, 3),
(6, 6),
(6, 3),
(6, 4),
(7, 1),
(7, 7),
(7, 5),
(7, 2),
(8, 15),
(8, 16),
(9, 16),
(9, 4),
(10, 17),
(10, 18),
(10, 11),
(10, 7),
(11, 1),
(11, 8),
(11, 4),
(12, 5),
(12, 8),
(13, 9),
(13, 12),
(14, 18),
(14, 3),
(15, 4),
(15, 5),
(15, 10),
(16, 13),
(16, 6),
(17, 10),
(17, 12),
(17, 2),
(18, 18),
(18, 17),
(19, 17),
(19, 18),
(19, 16),
(19, 10),
(20, 16),
(20, 10),
(20, 12);

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

-- Insert statements for table: Favorites
INSERT INTO Favorites (Username, RecipeID, Timestamp) VALUES
('user1', 38, '2024-11-18 18:52:03'),
('user16', 12, '2025-04-07 18:52:03'),
('user13', 18, '2024-12-25 18:52:03'),
('user20', 16, '2024-06-11 18:52:03'),
('user15', 40, '2024-05-02 18:52:03'),
('user2', 36, '2024-12-07 18:52:03'),
('user10', 33, '2024-07-28 18:52:03'),
('user18', 30, '2025-01-31 18:52:03'),
('user15', 47, '2024-05-19 18:52:03'),
('user12', 35, '2024-09-28 18:52:03'),
('user1', 17, '2024-11-02 18:52:03'),
('user19', 10, '2024-12-09 18:52:03'),
('user17', 2, '2024-07-26 18:52:03'),
('user9', 5, '2024-11-20 18:52:03'),
('user15', 41, '2024-09-10 18:52:03'),
('user6', 2, '2024-04-18 18:52:03'),
('user2', 6, '2025-04-16 18:52:03'),
('user18', 34, '2024-04-17 18:52:03'),
('user2', 10, '2025-03-08 18:52:03'),
('user20', 20, '2025-01-23 18:52:03'),
('user4', 45, '2025-03-06 18:52:03'),
('user4', 37, '2025-01-24 18:52:03'),
('user5', 37, '2024-08-25 18:52:03'),
('user7', 36, '2024-12-10 18:52:03'),
('user4', 6, '2025-03-11 18:52:03'),
('user5', 42, '2024-10-03 18:52:03'),
('user7', 34, '2024-08-25 18:52:03'),
('user7', 16, '2024-08-10 18:52:03'),
('user15', 49, '2024-06-16 18:52:03'),
('user6', 21, '2024-05-29 18:52:03'),
('user20', 35, '2025-02-11 18:52:03'),
('user18', 41, '2024-09-01 18:52:03'),
('user5', 23, '2025-04-16 18:52:03'),
('user11', 40, '2024-04-18 18:52:03'),
('user4', 18, '2025-04-12 18:52:03'),
('user1', 2, '2024-05-22 18:52:03'),
('user4', 5, '2024-06-20 18:52:03'),
('user19', 21, '2024-09-27 18:52:03'),
('user6', 38, '2025-01-27 18:52:03'),
('user7', 46, '2024-12-27 18:52:03'),
('user14', 29, '2024-07-26 18:52:03'),
('user11', 17, '2024-06-15 18:52:03'),
('user3', 40, '2024-06-04 18:52:03'),
('user15', 39, '2024-06-10 18:52:03'),
('user19', 2, '2024-08-11 18:52:03'),
('user10', 49, '2025-04-01 18:52:03'),
('user7', 48, '2024-04-30 18:52:03'),
('user7', 35, '2024-05-10 18:52:03'),
('user6', 1, '2024-09-02 18:52:03'),
('user14', 18, '2024-12-14 18:52:03'),
('user13', 44, '2024-08-14 18:52:03'),
('user12', 28, '2024-12-29 18:52:03'),
('user12', 37, '2024-07-20 18:52:03'),
('user10', 38, '2024-07-06 18:52:03'),
('user17', 46, '2025-01-02 18:52:03'),
('user8', 30, '2024-12-25 18:52:03'),
('user17', 11, '2024-08-05 18:52:03'),
('user18', 12, '2024-10-16 18:52:03'),
('user15', 34, '2024-06-01 18:52:03'),
('user1', 11, '2025-03-06 18:52:03'),
('user15', 2, '2025-04-01 18:52:03'),
('user20', 31, '2024-11-05 18:52:03'),
('user19', 33, '2024-10-16 18:52:03'),
('user8', 39, '2024-11-23 18:52:03'),
('user13', 37, '2025-03-21 18:52:03'),
('user7', 30, '2024-10-24 18:52:03'),
('user13', 14, '2024-08-05 18:52:03'),
('user20', 4, '2025-03-01 18:52:03'),
('user6', 22, '2024-09-17 18:52:03'),
('user12', 42, '2024-06-23 18:52:03'),
('user9', 31, '2024-12-14 18:52:03'),
('user3', 17, '2025-02-27 18:52:03'),
('user11', 12, '2025-03-09 18:52:03'),
('user3', 34, '2024-08-16 18:52:03'),
('user16', 30, '2024-07-10 18:52:03'),
('user7', 1, '2025-03-11 18:52:03'),
('user2', 21, '2024-05-07 18:52:03'),
('user6', 29, '2025-02-18 18:52:03'),
('user8', 16, '2024-08-06 18:52:03'),
('user6', 6, '2024-06-17 18:52:03'),
('user17', 28, '2024-06-08 18:52:03'),
('user7', 13, '2024-09-17 18:52:03'),
('user12', 1, '2024-05-19 18:52:03'),
('user12', 41, '2025-04-03 18:52:03'),
('user11', 29, '2024-06-19 18:52:03'),
('user7', 41, '2024-12-18 18:52:03'),
('user9', 33, '2024-10-21 18:52:03'),
('user15', 4, '2024-05-31 18:52:03'),
('user10', 35, '2025-02-06 18:52:03'),
('user5', 21, '2024-09-23 18:52:03'),
('user4', 43, '2024-04-24 18:52:03'),
('user7', 29, '2025-04-11 18:52:03'),
('user20', 19, '2024-08-31 18:52:03'),
('user1', 36, '2024-06-25 18:52:03'),
('user10', 48, '2024-09-03 18:52:03'),
('user4', 24, '2024-04-16 18:52:03'),
('user13', 47, '2025-03-15 18:52:03'),
('user1', 22, '2024-11-19 18:52:03'),
('user11', 19, '2024-11-17 18:52:03');
