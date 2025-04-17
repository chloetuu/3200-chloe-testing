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
    AlertID INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(50),
    Timestamp TIMESTAMP,
    AssignedTo VARCHAR(50),
    LogID INT,
    Status VARCHAR(50) DEFAULT 'OPEN',
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
INSERT INTO User (Username, FirstName, LastName, Region, Age, Bio, ActivityLevel, InclusionStatus) VALUES
('mccoywilliam', 'Hayden', 'Smith', 'Hawaii', 32, 'Show product responsibility economic. Do though since reduce region provide my.', 'High', 1),
('jacqueline17', 'Gregory', 'Escobar', 'Maine', 22, 'Every home economy decision red machine off. Social water recent cause weight bill.', 'High', 1),
('markrush', 'Jerome', 'Barry', 'Wisconsin', 32, 'Consider dinner someone gun meeting black. Operation race discover year feel area race.', 'Medium', 0),
('bryangarcia', 'Jennifer', 'Gonzalez', 'New Mexico', 63, 'Group partner without up Mrs else financial. Fight when from computer.', 'High', 0),
('imcdonald', 'Kevin', 'Herrera', 'New York', 38, 'Forget dream someone sound early. Professor green sure big. Analysis reach finish lead could young.', 'Medium', 1),
('jbarnett', 'Tiffany', 'Bell', 'Washington', 27, 'Capital art majority individual. Service today town left choice none.', 'High', 1),
('bvasquez', 'Danielle', 'Barnes', 'South Dakota', 37, 'Draw mouth itself measure small region. Ok cost wish property role.', 'Medium', 0),
('renee38', 'Krista', 'Black', 'Arizona', 69, 'Price high take by through. Run whom fast agency leave and start.', 'Medium', 1),
('joshuablair', 'Matthew', 'Warren', 'Idaho', 36, 'Hand apply young physical true meeting art. Religious notice example character.', 'High', 0),
('nicholas77', 'Diane', 'Freeman', 'Texas', 22, 'Artist discussion day throw bring federal.', 'Low', 0),
('emma63', 'Theresa', 'Turner', 'New Mexico', 67, 'Bad world down. Top though radio relate late any water. Specific return little church long scene.', 'Low', 1),
('dunnjoshua', 'Renee', 'Robertson', 'North Carolina', 22, 'Over food with management health work. Girl look at system. Brother almost president win sometimes.', 'Low', 0),
('grantdaniel', 'Phyllis', 'Dennis', 'Hawaii', 48, 'Stop lawyer central others. Wind you morning degree.', 'Medium', 0),
('seanreed', 'Paul', 'Meza', 'Kansas', 64, 'Remain before accept wide read take receive. Create article end dark approach.', 'High', 1),
('sotoscott', 'Richard', 'Lee', 'Virginia', 56, 'Grow specific risk product. Special team page him treatment space set.', 'Low', 1),
('whiteheather', 'James', 'Fletcher', 'Oregon', 67, 'Pick keep provide industry dog week. Common agree role.', 'High', 1),
('philip04', 'Lori', 'Flores', 'Pennsylvania', 54, 'Letter carry major power key baby. Serve tend family often to cell form. Open half area.', 'Medium', 0),
('kelsey94', 'Rebecca', 'Mcintyre', 'Indiana', 66, 'Impact government culture. Stage speech or not different fill dinner.
Three short along record.', 'High', 1),
('aprilwilkerson', 'Donald', 'Robertson', 'New Jersey', 38, 'While citizen large world why right. Day trouble degree tree full person resource newspaper.', 'Medium', 0),
('terrywarren', 'Jonathan', 'Obrien', 'Nebraska', 18, 'Security worry fly few may. Wish top each right strategy picture.', 'High', 1),
('xtaylor', 'James', 'Vaughan', 'New Jersey', 35, 'Many behavior through cover. Actually reason sport him move. Remain each beat forget.', 'High', 1),
('pmoore', 'Travis', 'Mcguire', 'North Dakota', 51, 'Gun enjoy with west. Store man suddenly strong baby remain.', 'High', 1),
('probinson', 'Chris', 'Wright', 'Virginia', 25, 'Plant approach note determine nation stop professor.
Visit job around large.', 'High', 0),
('dianaaguilar', 'Philip', 'Mills', 'Missouri', 39, 'Economic nice care big. Religious wide writer writer compare.', 'Medium', 1),
('odonnellmonica', 'Kelly', 'Peck', 'New York', 38, 'Benefit however stop police recent. Sense call finish always include TV window.', 'High', 0),
('tammyjarvis', 'Jacob', 'Turner', 'Alabama', 48, 'Behavior condition color appear organization.', 'High', 0),
('stephaniehowe', 'Jesse', 'Tyler', 'Oklahoma', 46, 'Night event rich. Beat production brother law. Center hospital we the beautiful development.', 'Medium', 0),
('ncastaneda', 'Collin', 'Weaver', 'Mississippi', 63, 'Up it movie management staff training identify shake. Score us action spring option language.', 'High', 1),
('gentrymelissa', 'Laura', 'Smith', 'Rhode Island', 64, 'Space your impact amount who. College part machine as newspaper president magazine.', 'High', 0),
('manuel99', 'Nicholas', 'Morgan', 'South Dakota', 37, 'Health under adult. Economy involve time pay speech beat culture.', 'High', 0),
('lauramclaughlin', 'Keith', 'Owens', 'Louisiana', 48, 'Good capital success professor. Yet later education beyond fund religious.', 'Low', 1),
('shepardamanda', 'Paul', 'Swanson', 'Nevada', 49, 'Themselves approach skin learn job. Create pay wife spring president nearly recent.', 'High', 0),
('cschultz', 'Lisa', 'Richards', 'California', 33, 'Prevent cover political manage information. Night serious more here well. We general sort loss.', 'Low', 0),
('derekburns', 'Carmen', 'Benson', 'Florida', 39, 'Give happen partner leader. Structure speech newspaper investment still area. Partner world peace.', 'High', 0),
('michaelphillips', 'Jack', 'Mendoza', 'Alabama', 60, 'Necessary full not off late. Pick management determine check computer hair other.', 'High', 0);

-- Insert statements for table: LogEntry
INSERT INTO LogEntry (LogID, Timestamp, SeverityLevel, Source, Details, ErrorMessage) VALUES
(1, '2021-09-29 00:42:44', 'INFO', 'martin.info', 'Rise father the government. Manager it great maybe.
Whole like population challenge might defense whole. Beyond worry nation others particular by rule officer.', 'Cell TV star manage art learn miss.'),
(2, '2021-06-16 09:45:07', 'INFO', 'phillips.com', 'West pick girl significant purpose year light. Pay million what perhaps hour world.
Follow building author off. Thing firm capital save both.', 'Light summer better action.'),
(3, '2023-09-08 12:42:09', 'ERROR', 'heath-odonnell.org', 'Tough alone dinner gas. Laugh perhaps cold.', 'Job success such very.'),
(4, '2022-04-09 09:34:23', 'INFO', 'warren.com', 'Public husband toward three market. Standard performance seat quickly movement create smile. Community you sell officer one exactly range.', 'Dream medical before discussion already claim ten stop.'),
(5, '2022-02-25 00:01:33', 'WARNING', 'adkins.com', 'Stay process budget while employee sister. Public treatment organization six threat man. Step maybe free world music but.', 'Issue long community shoulder.'),
(6, '2021-04-30 06:05:10', 'CRITICAL', 'snyder.net', 'Beautiful community product response. Organization face dream country sure this debate. Executive structure laugh kid.', 'Early increase method still.'),
(7, '2024-10-14 08:59:52', 'WARNING', 'white.com', 'Simply despite majority defense main. Miss ready pull light. Opportunity reduce bar thus rock.', 'Father still hard ability that life film.'),
(8, '2020-06-16 04:17:26', 'CRITICAL', 'powell.info', 'Whose hit why size remember. Morning first kind writer notice certain chance.
North hand law sea. Response these least politics. A serve people lose simply whether ability. Go also blue.', 'Measure nothing soldier community good itself first.'),
(9, '2024-12-26 17:23:35', 'WARNING', 'long.com', 'Work half just fire available. Former leg little reflect evidence agency few most. Protect unit sure finish doctor network.', 'Song today specific remember respond good sign.'),
(10, '2022-02-17 08:58:23', 'CRITICAL', 'wong-stokes.info', 'Number report many still though in. Bill four serious minute kind.
Company how see rise parent over camera factor. Mind performance successful their.
Much listen soldier street.', 'Store condition feeling peace view stock manage.'),
(11, '2023-09-09 13:04:13', 'CRITICAL', 'murphy-cannon.net', 'Official so great pay. Manage defense reason those price. Try serious employee summer top note.', 'Concern control professional sometimes.'),
(12, '2024-10-27 04:12:22', 'WARNING', 'miller-mercado.org', 'Grow people particularly operation budget degree. Growth pretty article customer.', 'Ever that husband yourself step.'),
(13, '2024-04-17 14:51:11', 'WARNING', 'lee-jones.com', 'Popular detail interest fact agreement evidence season. South true start television spring star industry.', 'Know community yeah.'),
(14, '2021-10-03 17:57:38', 'ERROR', 'morrison.org', 'Argue wear under me buy near town. Modern interest until later national training game. Great stay above no project head.', 'You record this smile risk.'),
(15, '2025-02-11 01:38:48', 'WARNING', 'salinas.info', 'Simply movement growth arm. Paper care day add. Sometimes several dog yard check travel.', 'Time study onto.'),
(16, '2023-08-27 13:25:03', 'ERROR', 'cox.com', 'War heavy relationship set score. Ball ask walk ability certainly candidate wear. Budget term process.', 'Magazine pick far capital opportunity ground.'),
(17, '2020-12-16 18:57:35', 'WARNING', 'ramirez.org', 'Win appear type forget side. World into each. Capital size direction seek. Life do recently grow decide.
It person former how around position find. Simply but standard yourself debate.', 'Institution believe age wait under newspaper.'),
(18, '2021-06-21 21:28:02', 'INFO', 'best.com', 'Defense hope north finally nothing property. Full crime ground cold main. Economic catch white hospital century never.', 'Series vote black play people statement my.'),
(19, '2023-06-12 02:21:23', 'INFO', 'russell-thomas.com', 'Laugh seek sense them minute deep. Power down someone pick why effect make. Similar lawyer compare choose long culture. Your structure education car toward.', 'Doctor tough recently oil site finish office practice.'),
(20, '2022-10-23 04:09:36', 'WARNING', 'holloway.com', 'Organization board line large wear weight difference. Fly magazine wide manager finally group.
Newspaper seven senior with. Parent close we program word. Inside radio able role.', 'Federal important amount happy event training.'),
(21, '2020-01-31 07:00:41', 'CRITICAL', 'davis-jones.org', 'Cell treat production. Plan during one fish number that.
Ok property see her help. Bank where late body.
Exist our decade. Want financial account director. Bank recent product build why.', 'Receive such quite contain along consumer free.'),
(22, '2024-05-30 07:42:24', 'ERROR', 'russell.com', 'Edge nearly perform note around increase several. War form goal medical middle south.
Source game realize keep lead employee. Low night inside look.', 'Must return baby suddenly maybe music.'),
(23, '2024-10-20 13:45:53', 'ERROR', 'downs-mendoza.com', 'Speech pressure car street card. Thing kid foot mean find stage.
Knowledge according source win soldier sit take.
Upon style song.', 'Treatment discover need mention.'),
(24, '2020-11-25 20:55:51', 'CRITICAL', 'harris.net', 'Evening energy player feel force single kid trip. Unit lead step best. Itself likely boy reduce never card.
Tonight discuss teacher spring personal. Live against commercial face hospital hotel cause.', 'Share pick agreement eye.'),
(25, '2020-05-29 01:09:20', 'ERROR', 'henry-nguyen.biz', 'Every me arrive bag federal trade material. Suggest in drop class tree since. Effort thus beautiful view.
Then shoulder personal firm. Training student old meet body final.', 'Although current cause kitchen.'),
(26, '2021-04-23 23:30:04', 'CRITICAL', 'wilson-lowe.net', 'Pick remain cup TV. Go listen create ground area never fear. Oil street read have for describe.
Radio table recent and according building. Gas majority us he.', 'Involve thank exactly nice can.'),
(27, '2021-10-20 02:22:44', 'CRITICAL', 'larsen-holder.com', 'Develop mind commercial call single way. Now offer notice near positive fish finally. Small phone election parent.', 'Pattern since energy minute part.'),
(28, '2022-05-20 03:42:05', 'ERROR', 'leonard-curry.com', 'Yard staff per war. Action tell significant soon. Wind middle often standard she road. Out citizen spring strong.
Option parent woman resource visit. Change receive parent admit article article.', 'Fly way western Democrat address human.'),
(29, '2021-11-13 15:01:28', 'ERROR', 'pineda-myers.com', 'If same toward husband. Cultural black live able.
Provide bit name stand especially. Democratic new participant institution recent.', 'Degree ok I most that wife century.'),
(30, '2023-11-12 12:46:40', 'WARNING', 'yoder.com', 'Company serious campaign also.
Hit song fish movie participant step. Always while word determine describe into your.', 'May executive structure.'),
(31, '2021-03-26 12:46:44', 'ERROR', 'gibson-mcclain.com', 'Even operation fight area point author. Water buy thus else small.
Some federal exist particular beyond. Worker either represent job close everyone. Hotel theory arrive country worry.', 'Tree note need daughter.'),
(32, '2022-01-21 17:29:01', 'WARNING', 'hill-ramos.com', 'Receive serious education under. Her believe generation technology fact.
Pull guess speak difficult herself student economic. Forward more near others fund. Rich put letter black world like though.', 'Choice toward join yeah onto anything fast husband.'),
(33, '2023-07-06 02:23:35', 'CRITICAL', 'myers.com', 'Free customer series outside. Democratic how night according western growth. Fire and recent day force.', 'Evidence wind list method hundred change nature.'),
(34, '2021-09-04 13:02:26', 'CRITICAL', 'lee.biz', 'Challenge allow attorney defense according between allow. In material spend indeed.', 'Magazine deep idea commercial.'),
(35, '2021-03-08 10:40:57', 'WARNING', 'thomas.com', 'Concern factor stock possible every like. Far many Congress ahead job.', 'His wife low probably.');

-- Insert statements for table: Tag
INSERT INTO Tag (TagID, TagName) VALUES
(1, 'Vegetarian'),
(2, 'Vegan'),
(3, 'Gluten-Free'),
(4, 'Dairy-Free'),
(5, 'Quick'),
(6, 'Healthy'),
(7, 'Low-Carb'),
(8, 'High-Protein'),
(9, 'Budget-Friendly'),
(10, 'Family-Friendly');

-- Insert statements for table: Meal
INSERT INTO Meal (RecipeID, Name, DateCreated, PrepTime, CookTime, TotalTime, Difficulty, Ingredients, Instructions, ViewCount) VALUES
(1, 'Tree Research', '2023-10-18', 9, 23, 32, 'Hard', 'Industry be take house top as without. Simple child easy property wrong why. Because trouble among these among list.', 'Think outside senior style hit wall model. Third positive address however know.
Worry dog look choice attorney tend democratic past. Parent window decade issue.
Late take language. Understand fill require. Look else side seven chance.
Wrong food next very. Would stage consumer.
Career foot large your office base movement. Most material cut cell better deep respond.
Purpose me bank half risk pay question. Stand tax yeah production chair loss laugh.', 324),
(2, 'Always Quickly', '2023-07-24', 16, 18, 34, 'Hard', 'Skin simply will compare people. Table respond program remain century science sign. Data store theory wonder career particularly.
Get buy direction. Human pay among five discover security.', 'Art really child doctor. Agency likely rich decade. Sea of see.
Employee lay decision charge standard. Detail difficult level provide response interview.
Million table major left kind visit. Central official summer right. Prevent chair describe person month open down.
Personal such respond capital they manage. Tax be federal. Hold step challenge view north.
Manage college prevent charge. Bad fine fly language at deep.
Authority those everybody represent effect.', 405),
(3, 'Adult Respond', '2024-04-05', 14, 31, 45, 'Medium', 'Street exactly leg.
Strategy although sign democratic job week war leave. According American manager buy so camera.', 'Service too let compare room.
Plant around top whatever continue. Weight explain better situation.
Camera guess travel people real region campaign. Boy idea wait impact church. Democratic dark game officer situation be.
Production onto book window not agency life card. Base maintain simply professor. Join show least blood hotel mind.
Sport enjoy face without thousand reason movie meet. Report positive house. Cup where well about knowledge design.', 696),
(4, 'As Central', '2024-06-07', 24, 55, 79, 'Hard', 'Media only cell writer hotel public on. Himself morning nor study camera. Baby season radio education church place democratic.', 'Character fact reason. Fear woman doctor.
Civil someone beyond. Hundred service I fall. Budget office major financial sure pretty. Race business kitchen into nor trial among.
Situation evidence many none agreement marriage. Food try picture year special toward culture. Base while important ground.
Usually next have that at. Medical action task parent necessary success.', 17),
(5, 'President Management', '2024-07-04', 10, 42, 52, 'Hard', 'Term yeah rich once billion. Nor either but perhaps bar capital.
Drive even admit. Base evidence foreign play power. Address force report way product.', 'Power sign poor new southern. Dog this here spring tax charge. Step sort time ball each provide thus.
Rock indicate push night. Test mouth add agent you field. Hair one now.
Learn keep friend. Senior across will already dog theory.
Explain operation which true draw. Best sea suddenly father blue least.
Remain around remember ever home west. Finally apply company two us employee money.', 863),
(6, 'Example Role', '2021-01-13', 30, 33, 63, 'Easy', 'Stage result control deal. Themselves customer throw item attention international. Professional story recently soldier.', 'Summer detail since major them heart.
First knowledge look evidence certainly development staff. Cost large material without say. Group person stay baby that. Build difficult only.
Instead space which design. Ever experience ability try including. Local president wonder become however collection.
Movement couple bill. East teach learn.
Who whose get recent he PM. Necessary technology left station.
Leave certainly plant. Today mind couple piece actually culture. Say finish fact score.', 393),
(7, 'As Feel', '2022-01-02', 12, 28, 40, 'Easy', 'Travel finally life language area goal.', 'Paper middle mention later cold. Receive himself likely store want add. Reach southern occur.
Capital on government general organization. Thing else sit represent fund detail investment. May full likely the former even.
Simply exactly actually. Prove most behind nearly television.
Avoid couple nature degree level up.
Father even hope name act attack. At ever always government. Wall subject reach strategy buy company wife happen.
Many discover or job realize yourself.', 108),
(8, 'Current International', '2021-10-02', 11, 33, 44, 'Medium', 'Coach instead say develop country truth. Soldier recently billion before such. Million professional big participant could choose hair. Away beautiful inside outside.', 'Education according view care offer stay prevent.
Past finish try seat something fight want my. Travel simple likely which late turn research. Debate none environment quickly bar foreign cup.
This human trouble we agent. Subject entire bit.
Home step available. Page country drop industry. Able sister instead threat safe my these rule. Cup agency result partner.
Author deep we clear. Measure leave ago improve.
Statement change start type end key raise. Our law benefit realize forget front.', 880),
(9, 'Difference Consider', '2023-08-18', 24, 16, 40, 'Medium', 'Election determine address eat trial. East dog put including international mention threat kind.', 'Simple director level.
Attention would specific management ball friend simply. Over article behavior staff. Coach or likely discover upon relate.
Friend by outside despite. Take religious treatment end cover.
Treatment table beat another carry born term matter. Join compare stop stay. Particular paper leader include station within bill.
Quite movement couple machine network practice by. Picture public control community. Thank quickly nice trade.', 377),
(10, 'Also Information', '2021-10-17', 25, 31, 56, 'Hard', 'Expert customer our ok property process. Sign put message because half yet hour.
Admit reduce who another like visit then. Idea dream say go. Big bar possible study compare bit tax because.', 'Moment citizen open others reach. Full soldier lose. Actually industry room Democrat tree.
Federal leader grow game cold water. Imagine plan soon win.
On deep according low. Others reflect one second.
Evening across again human television. Do at visit guess.
Build tell deep that. Ten season care condition middle occur former guess.
Join general experience recent. Military relate discuss final local.
Current know manager certainly. Letter pretty TV lose medical. On think station pay.', 933),
(11, 'Candidate Determine', '2023-08-14', 10, 45, 55, 'Medium', 'More seek throughout condition.
Such upon career. Lead ahead road have story traditional. Discussion hour spring national up artist.', 'For save investment board continue report. Authority picture manager suffer father field science. Month laugh crime particularly.
Weight enjoy talk region hundred. Raise almost account cold fact strong. Laugh radio face ready after able by.
Poor daughter government car professor true season.
Fly senior glass water.
Help traditional staff investment he building. American box live now where. Nothing focus important.', 364),
(12, 'Same Item', '2022-02-17', 30, 10, 40, 'Hard', 'Indeed firm itself he join now.
Air media threat speak population write social. Term care adult build.
Station camera send law. Area machine answer.', 'Type pass only trip couple ability. Fund option administration recent born common mean.
Congress sort thing today old including. Company tell control least of wife that.
Religious plan official kitchen country design. Whether image least lay and.
Cost his democratic term.
Can degree age chair billion learn. Past no across. Political even leave skill positive truth professional.
Something pass network medical. Simply audience whole story matter.', 659),
(13, 'Able Item', '2022-09-27', 7, 44, 51, 'Hard', 'Best her situation state image. Eat instead consider be interesting.
Possible plant it star someone. Assume fly animal group tend heart type lawyer.', 'Yes cell everything house film because within beat. If true officer learn late. Under him present clear.
Nice eat organization environmental. Successful thing once.
Hotel send prevent possible. Kid you be education central ask true.
Natural environment fund class chair organization office. Onto within cut foreign set reason push.
Difference long now door. It art politics. Generation institution cell mother structure class agent.', 62),
(14, 'Occur Catch', '2020-03-07', 22, 20, 42, 'Easy', 'Consider Democrat write author. Song major car do none. Test loss each seek history degree.
White travel behind wife none together service. Whole reduce special argue.', 'Size onto popular day themselves bank size. Around take possible finish agency theory everybody. Factor remain boy capital huge.
Whether news fight contain value establish.
Space may whom memory bad. Magazine figure clearly either forget indeed. Enough yes southern could begin especially.
People other design another rich movie service. Others station buy senior.
Gun southern produce test fast policy. Some street production improve.', 311),
(15, 'Herself Special', '2022-12-18', 13, 13, 26, 'Medium', 'Company two everything sell open sometimes mention. Choice wind actually little. Case how boy police himself pressure. Brother machine can realize from person arrive.', 'Certainly rock eight research stock think together behind. Task others door make. Break read benefit baby with Congress.
Particularly different policy. Individual nation Republican idea attention impact pull. Pay team bed about lead economic.
Try operation back respond tell weight. Store stuff light second pick for heavy section.
Thing story seek ten whose itself fish small. Discussion city act large best condition.', 938),
(16, 'Him It', '2020-08-03', 15, 31, 46, 'Medium', 'Up still bag help something beyond necessary. Range keep be decade still unit long establish. Your increase art system.', 'Arrive its land thing claim wife feel. Certainly picture voice you meet goal off. Wear who many building training.
Heavy grow so increase deal him. Course should provide western modern appear discover.
Fine him perform civil prepare cultural growth. Particularly herself feeling any into. Moment discuss purpose increase senior list state within.', 303),
(17, 'Story Bar', '2021-07-03', 22, 12, 34, 'Medium', 'Bad wife light box factor professor deep. International wide picture become new never. Hear beyond friend under available knowledge baby.', 'Investment speak spring detail effort.
Son do child American charge. Whose century at so.
Machine church community pass our success leader. Wear my suddenly international trade instead state.
Painting marriage choose well discussion must nation. Difference Republican anything. Pull want marriage participant according usually how.
Simply successful lot. Growth over know teach everybody. Property hundred society approach why.', 549),
(18, 'Upon Hot', '2020-04-26', 7, 37, 44, 'Easy', 'Cause image billion continue. And maintain four many support consider final. Face thank actually position.
Star across hold debate. Quickly than response city food buy region.', 'Somebody so themselves memory admit quality expert.
Phone serious test dark wait message lead media. Sport young first serious civil will general. Also station look always.
Defense life identify own. International threat goal church prevent too movement common. Choice half down able trouble.
Design environmental reach response. People specific attorney idea painting scene. Build themselves part final development.
Move occur section teach machine poor style. Peace to production.', 411),
(19, 'He As', '2022-12-27', 17, 36, 53, 'Easy', 'Political hear information weight pattern. Into pretty bad. Late seven agency sense.
Per the message. Know land suffer usually south. Argue cost find small.', 'Long clear effort brother easy some name. Would clearly floor Republican officer us similar. Hand your help rock.
Successful case relationship push research listen international. Seven what show interview goal system job. Rich job themselves movie.
Artist worry writer sometimes area drop. Whole why responsibility.
While idea various idea still event. After soon country than care call mention marriage.
Forward else practice step minute leave six officer. Huge Mr us few fire.', 816),
(20, 'Recognize Different', '2022-02-10', 28, 58, 86, 'Hard', 'Hot Mr physical strong. Surface hundred move group thing behind though. Attorney forward its cold yard meeting.', 'Over hear baby across medical. Easy car agent later.
Red hand fund available establish attack. When form democratic member source.
Begin outside feeling news here choose guy. Wide term full almost. Among center effect.
Myself arm away notice. Both best interesting analysis as example that standard.
Move so child. Truth actually talk start.
Media evidence million. Plant center present morning. Century agency treat.', 204),
(21, 'Democrat Success', '2022-03-21', 11, 21, 32, 'Hard', 'Lot unit spend management memory. Too baby course still side responsibility Mrs. Wife relationship purpose these even even.', 'Doctor power threat couple. Decade cost team capital piece those. Democratic decision walk condition everybody success.
Spring approach money upon some professional somebody. Their suggest join challenge positive play.
President blue well out local ten. Ready range author line maintain performance total.
Professor hundred behavior pretty season region. Especially while bar blue suggest watch.
Husband agency word watch choose result doctor. Friend leader development measure town order.', 797),
(22, 'Often Section', '2022-06-11', 15, 32, 47, 'Easy', 'A nature different Republican continue toward respond. Case but operation heart to expect.', 'Perform behavior maintain wonder scientist. Stage hope sort. Almost plan produce opportunity wind country into either.
Remember term stop he. Successful add account which fear.
Everything security son material performance really total. Join court without draw similar.
Control what return worker.
Simple food page. Report police build method garden.
Hope government find than. Read moment form plan design people. Both nice like Democrat.', 185),
(23, 'Region Find', '2020-10-24', 8, 39, 47, 'Medium', 'Sort best probably coach give. Ten ball or Mrs ago senior. Industry usually happen world.
Strategy amount civil pass continue establish so. Whom board soon. Traditional bed last catch soon.', 'Reach find box should start. Improve scene learn believe.
Ever security lay growth. Health similar establish.
Yourself push music owner huge figure doctor. Approach cause analysis soldier home. Edge management look social pressure person.
Marriage grow discover third fly great. Often all throughout although you. See somebody quickly.
Spend property fight yard reduce.
Region money home. Why lose his start green but group. Hour policy table foreign worry several environment tonight.', 225),
(24, 'Serve Compare', '2020-07-04', 7, 19, 26, 'Hard', 'Write up describe dinner risk. Civil decide talk another none among culture.
Particular civil scientist represent protect employee usually win.', 'Leg first risk. Stop industry blood long.
Home respond management wide tax. Lot need somebody firm. Enter authority defense physical bit lead race. Environmental skin daughter growth.
Person laugh agency call. Fire front avoid.
Their left avoid certainly door pull measure though.
Great concern technology expert politics. Natural reason authority key surface short PM town. Black message cold seat. Heart end evening.
Score never level work. Education special question red more.', 329),
(25, 'Article Father', '2020-04-29', 20, 45, 65, 'Medium', 'Participant treatment bag rule such church debate. Still begin drug relationship study other painting.
Beautiful marriage economic cut you able. Fact son fund others doctor environmental.', 'Hospital including baby list feeling culture laugh. Provide while remember offer over American that job. Affect toward not water across single seek.
Speak meet add give program. Way I generation find.
Traditional yourself should government. Drop finally church front population.
Fund officer pretty police bed bill. Six scene policy threat to foreign light. Hospital do of score.
Government power something risk population ten apply wear. Kid individual writer base.', 284),
(26, 'Herself Great', '2023-07-27', 21, 42, 63, 'Hard', 'Main card thing coach. Guy space look yet indicate.
Standard case production short five painting defense. Feel quite cost theory senior media. Clear the man billion look firm big claim.', 'Film fly evening. Research market miss prepare.
Group point social letter news money speak avoid. Red bill perhaps scene wonder certain eat parent.
Plan page pay public. Defense face player director coach.
Site resource line office. Process month everyone pull across.
Happy involve technology star. Dog fast sing serve blue right. Various condition such often project second.
Memory serve join. Difficult away party parent senior street able. Prepare purpose firm his actually believe after.', 858),
(27, 'Movement Ask', '2023-02-28', 9, 25, 34, 'Hard', 'Capital unit show identify standard become. Hear degree crime prevent.
Head support special personal house quickly. Science voice letter big avoid.', 'Particular understand fall American maintain face mind. Must have candidate her beautiful begin worry.
Work plant director white century. Agent nature stay.
Mr road pass knowledge. Central value man throughout set real decade fear.
It professional across crime court level.
Republican loss production without national imagine edge. Relationship professional threat by fight fall.', 361),
(28, 'American Baby', '2021-04-18', 19, 16, 35, 'Hard', 'Show hold common model. Next thank act Democrat. Important mission interview agreement. Space executive important word any top positive.', 'Can Congress everything happy. Career nor already it marriage.
Hot trade wonder scene. Who black produce series officer.
But house collection half call. Later themselves democratic foreign.
Area over take difficult.
Business whose consumer surface PM protect relate. Best them especially various travel avoid. Over team box major yard determine.
Back surface conference couple continue artist very.
No behind sing test.', 172),
(29, 'Probably Early', '2021-04-21', 12, 32, 44, 'Easy', 'Determine whose task front well summer including.
Congress my according. Attorney man they at. Break left left support staff edge.', 'Law then serious game half community field.
Father add leader forget down small live clearly. Apply fine discuss country father question. Style heart expect debate stage current drug.
Issue or fall chance say phone. Bed sister break tax indeed.
Child similar image employee people. Father series later especially next them order. Law task environment you.
Local project whatever event decision politics popular. Group glass remember throughout.', 92),
(30, 'Apply Sign', '2024-08-03', 19, 37, 56, 'Easy', 'Marriage activity family election week eat. Write food perform grow mouth win perhaps.
Choice industry me lay area nation. Ten method reach brother party.', 'Contain doctor federal Mr if watch whatever. Design hard check. Various although leave significant American shake base national.
Commercial enjoy house allow law. Work simply military sister all. Popular employee strategy at effect deal.
Art statement rich people half church at. After between investment food long charge before near.
Fall build explain Democrat. Win field artist bad. Remember week thus industry business.', 917),
(31, 'Near Town', '2024-01-22', 11, 42, 53, 'Hard', 'Off tell couple give. Magazine future school finally morning. Set old go yard.
Live they kind nice save. Citizen theory during value drive build.', 'Note time although economy. Participant ready decade bill much require system. Police expect list factor anything price land four.
Recognize tough follow class public. Test civil wide admit major.
Star hold give cost top catch sister. You fine instead present.
Billion sell instead former should more. Whose think ability animal operation hair foreign. Choice cover rule movement current.
Respond out plant model hope design lose. Information bar unit. Note family nice increase hot color rich.', 983),
(32, 'Old Movement', '2023-12-13', 21, 54, 75, 'Medium', 'North quite participant return myself fly end.
I bad these face go whole. Although trade join edge evidence.', 'Unit front must him good nice board accept. Their nor first child collection decision professor. Recently into way write.
Operation deal even factor society. Focus teach crime themselves sit foreign read. Help at thing onto who ten often.
Knowledge attorney big speak. Hope director pass identify by. Nice media series start TV her social goal.
Already one interview action maybe. Exist professor tax take parent young computer. Strategy fine him fall.', 829),
(33, 'Energy Assume', '2025-01-01', 9, 55, 64, 'Hard', 'Painting activity ago cultural. Produce soon poor. You issue music choose work media.', 'Century mission capital guy. Alone gun public spring during adult poor. Would strong degree run deal.
Sit speech how sure open camera. Law physical stay oil dark key. Spring allow add.
Sea poor action. So billion hour size scientist.
Four result name parent home describe country race.
Reveal determine teach. Democrat generation large language single.
Store few upon security issue ago. Increase whom force stop list occur able. Bag sell wrong glass.', 265),
(34, 'He Very', '2024-06-30', 27, 49, 76, 'Easy', 'Really tend near task people. Part long image ball at simply feeling. History behavior indeed name drug item only.
Choose and pretty tree else dark spring. Political federal or alone class building.', 'Car line once drop conference create let. Later half direction from new.
Activity last car hot see. Admit travel interesting other set.
Director body why agreement. Ago town also letter quickly worry. Security take charge message religious term.
Specific not single TV realize leader will. Many cell serious century such available.
Father sing look begin within war. Defense record look might party.
Imagine southern anything myself radio.
Purpose turn against accept artist.', 677),
(35, 'Rule Career', '2022-12-15', 13, 33, 46, 'Easy', 'Raise occur whether necessary conference difficult loss open. Have themselves employee assume growth accept.', 'Movement business movie season just blue a table. Sit one ground kitchen condition positive.
Beautiful class teacher school. Listen kind agree wide bed make American.
Former study exactly political sell hope. Expert simple compare role. Memory sure commercial author medical.
Trip color accept public team rich such serve. Matter he herself article civil enjoy political.
Plan public offer significant develop actually. Conference voice when nation.
Feel government carry deep employee determine.', 963);

-- Insert statements for table: Alert
INSERT INTO Alert (AlertID, Type, Timestamp, AssignedTo, LogID, Status) VALUES
(1, 'User', '2021-10-24 07:10:39', 'terrywarren', 16, 'OPEN'),
(2, 'User', '2023-07-24 18:17:38', 'dianaaguilar', 33, 'OPEN'),
(3, 'Performance', '2020-11-20 16:15:24', 'dunnjoshua', 28, 'OPEN'),
(4, 'User', '2022-01-18 10:18:48', 'odonnellmonica', 19, 'OPEN'),
(5, 'User', '2024-08-26 19:51:49', 'emma63', 25, 'OPEN'),
(6, 'System', '2022-03-06 03:21:38', 'bryangarcia', 31, 'OPEN'),
(7, 'User', '2024-02-11 21:38:52', 'emma63', 3, 'OPEN'),
(8, 'Performance', '2020-06-15 05:50:52', 'odonnellmonica', 17, 'OPEN'),
(9, 'Security', '2025-01-31 15:14:12', 'derekburns', 6, 'OPEN'),
(10, 'Performance', '2024-07-16 22:05:18', 'grantdaniel', 10, 'OPEN'),
(11, 'Security', '2022-05-03 05:34:00', 'pmoore', 5, 'OPEN'),
(12, 'Performance', '2023-08-30 21:12:06', 'tammyjarvis', 14, 'OPEN'),
(13, 'Security', '2023-07-02 20:23:42', 'derekburns', 1, 'OPEN'),
(14, 'Performance', '2024-03-09 01:10:35', 'michaelphillips', 12, 'OPEN'),
(15, 'User', '2022-03-23 20:05:17', 'lauramclaughlin', 21, 'OPEN'),
(16, 'Performance', '2022-07-11 19:14:49', 'sotoscott', 4, 'OPEN'),
(17, 'System', '2021-07-30 11:03:20', 'jbarnett', 5, 'OPEN'),
(18, 'Performance', '2024-01-13 16:47:09', 'philip04', 32, 'OPEN'),
(19, 'Security', '2022-12-06 00:31:05', 'cschultz', 27, 'OPEN'),
(20, 'Performance', '2021-09-21 04:17:54', 'whiteheather', 18, 'OPEN'),
(21, 'User', '2022-08-07 07:23:48', 'emma63', 18, 'OPEN'),
(22, 'Performance', '2022-10-07 08:03:58', 'renee38', 33, 'OPEN'),
(23, 'Security', '2023-07-02 11:09:29', 'xtaylor', 2, 'OPEN'),
(24, 'Performance', '2023-01-24 14:06:30', 'cschultz', 24, 'OPEN'),
(25, 'Security', '2021-07-23 03:13:38', 'mccoywilliam', 4, 'OPEN'),
(26, 'System', '2020-11-28 14:27:08', 'seanreed', 28, 'OPEN'),
(27, 'Performance', '2022-07-02 13:08:02', 'ncastaneda', 5, 'OPEN'),
(28, 'Performance', '2024-02-13 08:10:12', 'gentrymelissa', 35, 'OPEN'),
(29, 'System', '2022-03-03 03:48:26', 'grantdaniel', 5, 'OPEN'),
(30, 'User', '2024-10-03 19:58:02', 'sotoscott', 33, 'OPEN'),
(31, 'System', '2020-07-15 20:46:36', 'michaelphillips', 24, 'OPEN'),
(32, 'Security', '2021-04-07 22:42:10', 'grantdaniel', 34, 'OPEN'),
(33, 'Security', '2023-12-01 07:03:49', 'terrywarren', 24, 'OPEN'),
(34, 'Security', '2024-03-17 08:19:26', 'gentrymelissa', 13, 'OPEN'),
(35, 'User', '2023-08-03 05:54:37', 'seanreed', 20, 'OPEN');

-- Insert statements for table: Blog
INSERT INTO Blog (BlogID, Title, Content, PublishDate, Username, RecipeID) VALUES
(1, 'Subject bill pretty.', 'Become population plant fill attorney. Spring sign already weight inside study.
Way he sign thought moment.
Economic respond TV data attack discuss. Bill it small well deep. Seem represent physical tell.
Yet its after purpose property tend. Success writer guess.
Beyond treat happy American. At positive it on. Weight game our night force.
Street nearly involve full physical. Follow national popular rich fund letter. Become number focus medical per.
Statement song right prevent.
These trouble clear compare. Care should eight feel itself serve where discover. Upon task professor what position ten least one.
Wear common yet once necessary wish hope. Executive population question personal against event. New officer quickly might stage and.
According if build you old.
Various everyone impact cut around catch defense while. Skill agreement thousand cover vote foot notice memory. Population nature land there.
Low sea physical week meet. Wish indeed key effort person where.', '2025-03-10', 'shepardamanda', 28),
(2, 'Sell happy without.', 'Nor rock section resource least. This such instead mean other old off. Member kind marriage matter from. Far leader newspaper strong century miss really meeting.
Year medical far drop decade. Perhaps speech general level soldier.
Middle miss standard cut two nature service use. Today rest truth data it back. Candidate away what.
Outside owner positive generation sister role. Term major more evening pay later. But career again man factor job. Board rich treat.
Design Republican produce also. Though me put talk ready throughout.
Like participant power run yet. Thus themselves smile quickly you form live stage.
Tend easy wait animal city maintain. Concern score whose grow south image difficult thousand. Black between under.
Thing him citizen admit only. Possible without night event along. While foreign recently street about smile.
On government bad customer. Image early test theory drive. Improve consumer range vote read seem million.
Town few bad address forward.', '2020-08-22', 'philip04', 17),
(3, 'Purpose according reason important.', 'Compare final skill difficult half green town. Modern between save tell. Any energy blue room trouble.
Recent although fish far television citizen.
Good officer certain high. Window necessary more black. Trouble large together whatever civil third.
Decision likely recognize spring. Benefit group security official writer same. Move product challenge myself treat.
Above bad anyone organization election different institution. Particular course believe democratic great.
Future financial movie be. Mr idea economic step line wall. Ago song actually top time billion business party.
Give somebody budget prove.
Material break son write major adult argue. Image week game admit media choose. Art admit cover same third usually.
Serve mission animal purpose though. Father central recognize rest. Read worry believe decide. Until once score dog.
Number decision letter send sport subject your. Mrs guy big condition church. Region design during note building then.', '2022-05-29', 'sotoscott', 5),
(4, 'Authority drive.', 'View top cover move page set. Town center pass office score environmental threat anyone. Vote without ask meet.
Media including set star floor season teacher.
Product network issue yet important five debate. Myself report answer live surface ground.
Kind girl with kitchen. Field population western serious how once director. Likely factor approach professor standard.
Sister cause sometimes outside need begin ahead trip.
Modern keep man foreign. Sister add against part safe type identify. Build strong another question up threat. Mean despite program culture thing.
Military machine instead analysis crime whole. Both bill relate serious treatment.
Listen on city fall paper.
Economic serious industry hope get interview. Writer explain choice center.
Hotel sure again. Bar speech situation possible. Involve local amount second boy happy.
Job open others movement different. Identify think outside large opportunity. High identify house it ahead fall.', '2024-12-19', 'xtaylor', 6),
(5, 'International reality evidence try foot.', 'Poor after could. Owner do bar require. Without mind base event.
Lead authority generation night there simple. Number center although production factor popular. Everything less eight computer.
Address adult important data while politics. Structure everybody discuss Mrs food wall until.
Final debate line always whether ago once. Affect few student spring actually artist security tree.
Year big economy series firm. Skin already move offer huge.
Worry question choose husband. Service deal personal laugh majority. Charge determine article above those.
Assume kind instead past. Threat society so prepare line. Ability account be sound bit else back. Benefit statement call else.
Action tonight affect hundred. List animal compare suffer like interesting.
If present really work feel avoid finish. Even administration amount plan community activity sense. Choose growth large modern recently player successful.
Decade long begin success. Garden again son resource always seven.', '2021-09-13', 'bvasquez', 18),
(6, 'Real opportunity suggest.', 'Guess scene turn smile. Bill race lot. Ask college memory go side effort capital.
Message information easy. So well role hair. Sort from study get indeed.
Water civil some lot item. Public reflect nice hundred. Drive most song world price want well she.
Often whose various whether reach senior. Itself opportunity paper wonder. Anyone process real build board fill.
Chance mention former remain before authority item.
Billion political though region economy option play. Leader partner affect market later in.
Official stock father ok. Let and gun bad material key point fall.
Black letter fall field lead follow have doctor. Past number from find walk today career.
Late option too likely. Recognize view charge foreign range which. Law management little man.
Because fine generation force operation picture no. Memory actually collection although.
North eye himself despite.
Debate majority authority. Player clear lose several question cost. That good have federal someone investment home.', '2024-07-29', 'ncastaneda', 29),
(7, 'Report project whose.', 'Hard peace support trip. Outside foot nor morning others sit.
Safe speech individual cut there attack. Early picture year factor floor rate. Early family rich.
Stuff of source discussion generation else. Know break upon think though. Season war onto stage apply nothing.
Manage professional huge industry support movie. Head process create throughout.
Knowledge tend trial tend movie. Particularly wall when cell management skill large. Need company speak thousand.
Policy chance point subject. Involve finally sit also bar.
Unit strategy TV perform hot success light. Section crime environmental ability health. Worker mouth door bed southern investment.
Kind police particularly media condition physical red. Produce course day somebody myself eye. Conference eye strong nature race listen.
Development learn available face able. Study surface standard fall continue fact music board. Just suffer sort for tell.', '2022-01-11', 'shepardamanda', 28),
(8, 'Recently customer.', 'Strong anyone need officer eye exist. Forget various southern.
Clear marriage measure step member commercial ago. Teacher fast south hospital.
Range watch of interview back reduce.
Fight hundred player some know all culture. Performance material team radio. Ready require career free young. Action just fine production leader health.
Save allow toward sport south type project. Protect together it management whatever design make. Oil need yeah clearly face.
Modern shoulder writer. Apply card fire which home only and.
Article might watch concern hospital past hot. Manage behind would gas before religious every. Able simply for. Economy serve happy free should.
Soon investment down maintain reach budget. Just establish adult anyone many statement.
Price together more character. Spring time she always. Affect book crime.
Test build future research. Service out crime growth image let fine event. Indicate employee political including occur.', '2024-09-15', 'mccoywilliam', 29),
(9, 'Easy suddenly good however.', 'Trial others service table despite civil arrive. Scene respond language cause social choice by start.
Hard enjoy up produce continue action herself. Whether show consider because trip fight catch.
Couple Mrs without budget. Consider wide difficult friend investment century. Democratic hundred front skill east skin sister.
Less how alone yeah. Thus manage recently figure agency open.
Affect situation Republican professional. Night doctor will today threat.
Writer maybe drive consider face mother happen. Throughout eight power federal the. Brother spend traditional trade perhaps large.
Industry product radio course. Eight team clear language way. Statement provide consumer campaign compare.
Together should training name history blue from force. Add actually full soon. Official concern writer but go it.
Large think cup before teach give report. Few discover hotel official measure. Blue white city rise trade thought continue population.', '2022-09-02', 'jacqueline17', 19),
(10, 'Practice none general return.', 'Over answer cell run yourself room yes. Put four possible economic various despite whom. Fill increase factor sort.
Opportunity expect all certain pull. Including religious travel become less cost language. Include will price exist.
Partner join away loss he language continue. Artist citizen turn none market truth certainly.
Arm beautiful toward. View rise plant population foreign evening.
Consumer my list conference college foot natural order. Result who management student myself either. Debate place recently address during big.
Strategy activity major important country generation support. Look long form effect today. Record resource outside become eight. Worry watch her us yet stuff course.
Husband current wish it food newspaper get.
Garden save cost note recent. Color people catch daughter Republican within situation beyond. Respond item range eight instead generation assume. Test hard my practice news PM.', '2023-11-13', 'odonnellmonica', 17),
(11, 'Peace rate.', 'Account discover own under feeling determine relationship. Natural meeting now sit.
Ball guy compare oil four. Manage rise eye last wait. Guy able choice soon thank bit.
Only keep eat college old pay it large. Say most challenge bring spring face region.
Day remember fast enjoy product. Leader challenge myself three five material buy.
Sit senior author within good mouth.
President large onto some civil. Surface movie partner degree special forward. Something she phone term my ahead. In thought want play kitchen.
Threat newspaper add decision listen. Eat pull agreement. Arrive score quite into.
House else fast child cost no sell. Worker another special Republican instead. Smile memory hand follow recognize after.
Young argue strong reveal society fund this. Often own manage several.
Which seat director modern. Around point stuff break.
Maintain cost girl always next again. Lose health why ten else sense risk. Ground field happen carry best edge what.', '2023-06-27', 'michaelphillips', 3),
(12, 'Serve letter its truth.', 'Body answer study interest agent program heart. Entire start order expect scientist.
Degree chance really not improve. East too have poor.
Smile way language economic subject marriage. Left style area each kitchen father. Child white third.
Whether order close over standard audience.
Fund well film child heart fear participant left. Possible discussion particularly walk onto radio understand impact.
World policy crime compare small. Environmental run way agree could minute director. Everything lose four American street story tough.
Bar cup age enter. After future store much others economic.
Success economic summer four age mention night. Sense fly campaign whom lawyer where particularly.
Cell father wear assume those carry food. Short easy cost cost. Building check program foreign head.
Yeah management rule single situation. Seven item white any cold they.
Number nor participant opportunity data. Around where music have.', '2022-06-07', 'derekburns', 18),
(13, 'Interest film gas campaign.', 'Simple just become half central age figure. Nation tough rock happy form land certain. Good together beyond challenge.
Either edge provide town water item. Build scientist prove condition this fine hope. Last above bit how president feeling.
Law theory fast become data book.
Article man pick matter model nor voice. Example factor live one career group election.
Those wonder own minute woman environment deep against. Story air hot minute process explain month.
Enough both board collection. Treatment military impact difference movement prove no.
Understand difficult believe each modern whatever. Note mind at shake.
Result effort stand sense. Keep us into as would interesting prevent. Your provide necessary other agree. Under product claim action.
Political together use during tonight. Its economy certainly camera standard field. Event possible discuss boy under agreement.
Magazine cup girl laugh. Standard remember cost blood organization throw. Increase rule voice job list.', '2024-08-01', 'pmoore', 27),
(14, 'Few career member.', 'Minute card center themselves direction. Must feeling decade ready reveal management.
Important recent apply others.
West city everybody east job hear necessary. Industry try us world we middle.
Player night mind artist rather song visit. Manager image natural major line study performance country. Guess from by may.
Account expect high resource likely well tonight show. Work floor follow under major. Add cell wait.
Position other yet room message out market.
Order play feel include system oil. Business great foreign smile near certainly. Brother right get four.
Manager including back accept style guy region. Instead air successful total must science. Increase month alone the discussion third nearly.
Position nothing special want become unit. Specific sport quickly.
Reach discuss strong. Community into impact far he indeed court again. Room president scientist hope least.
Record ok medical.', '2020-09-28', 'dianaaguilar', 31),
(15, 'Service training system available.', 'Player price stage impact. Trade might admit. Beyond sit hotel those contain wide class.
Trade part lawyer final force it should. Voice religious suggest newspaper risk choice investment unit.
Exist television dream skin remember. Sport work I newspaper rich beyond big. Though claim car growth garden.
Must allow by front.
Report score no live feel story hour leg. Hit often guy laugh trouble great about.
Store or public four consider figure.
Watch three policy politics imagine. System want available now event save. Cold plan could suggest physical.
Protect appear pass first who former woman. Ground require prepare adult. Last material federal share.
Pm institution statement friend peace course. Benefit these stay probably fact.
Edge add particular result these.
Good commercial town.
None four base save whatever thousand decide. Other result energy even. Increase art continue attack anyone west push.', '2020-12-05', 'lauramclaughlin', 4),
(16, 'Effort social leave voice.', 'All wide mention night position. Rate officer project international toward. Star most number though must audience another. Source whom dark might late.
Arm senior task role several create. Could group imagine allow tend drug.
Concern improve adult tree modern sure town. Hair fill campaign question road. Moment power chair piece trade under member. Sit may position reach.
Though far energy happen cover call. Grow adult thank hope lot continue. Among white main range newspaper. His move sister his have international.
Focus a cover yeah run. Develop since difference.
Table total guy continue clearly. Organization peace future believe until medical. Him rule Mrs mind.
Suggest project kid involve his white. Note consumer body beautiful why.
Very role individual light.
Hundred inside side local. Relationship close machine from.
Hard sister member base local stuff former language. Economic quickly nature enjoy. Feel some effort decade why experience around. Vote become kind course suddenly.', '2021-05-31', 'grantdaniel', 13),
(17, 'Usually weight population security tell.', 'Minute here thing very institution including hear. Guy lead specific theory project respond reflect.
Test make worry eight rock. Figure need can fire near.
Night peace town father enough hit. Rise technology rock people several.
How opportunity picture. On always chair rate human.
Campaign main option. It phone skin.
Its century property wonder professional.
Each hold modern tough property. Age wish really of. Sell so thing expert idea word keep.
Usually experience true every.
Cause order fear head effect staff writer. Window their near.
Participant teacher chair opportunity ready. Education old attorney authority total score choose. Most material grow discussion answer.
Congress need crime strong this turn apply. Together finish use detail nice. Month oil director establish talk.
For while very culture. Oil later others rock store also. Item soon beat attack south.
Cup give hour entire fill. Business life similar. Peace eat order campaign.', '2023-10-24', 'jacqueline17', 8),
(18, 'Drug hot rather.', 'Look listen bad research. No hotel training agent art charge.
Cut water most end gas. Approach draw glass second wait decade.
Live medical could hospital line. Night anything myself. Check base for enjoy dog research cut.
Executive project whether edge. Herself both should religious argue pay anyone.
Image both dog news collection but all ok. Take size like total business station. Author make modern.
Itself lot together. Material bad dog store often husband. Huge my simply white matter leg get.
Someone body project night kitchen become. Without effort else treat despite standard.
Determine skin rise card. Goal point note treatment job.
In morning condition four campaign. Indicate single which expert fire gun. Fast bed hundred none believe rule.
Price project cup whatever dream. Attorney memory language phone. Use design key director price commercial.
Statement day dream later they. Day north successful job tree. Recognize also card race. Author carry budget we.', '2022-03-02', 'joshuablair', 5),
(19, 'Team message design market wonder.', 'Time live suffer have stay rate. Usually newspaper close goal hear. Cell or rule president.
Government personal nature Mr many where east. Soon appear child idea.
Maintain want fish. Cut bring do believe particularly figure before. Strong say focus character agreement price. Night response safe event.
Green generation should girl open. Form imagine radio.
Degree page party for mind former relate. Assume responsibility carry since have.
Information authority tree early paper. Adult before poor then seek miss.
Better always race democratic study quality claim whether. Success not fight professional we. Affect over serious. Then should or build drive.
Big of idea camera fire measure great. Evening perform choose mean. Describe view education song after such.
Their bag respond clearly. Whom into half alone. Before final catch loss by section pull factor.
Suggest firm appear painting today. Writer help citizen personal imagine. More thus value.', '2024-11-25', 'derekburns', 16),
(20, 'Spring the executive.', 'Hear back impact customer set.
He us treat should off because. Reason budget travel might oil more. Work institution five society. Nice without appear national system environmental.
Laugh side result full doctor project. Former idea various your however. Argue firm test some hair on run.
Sing ten can report table floor owner ok. Marriage despite walk medical ground less. Nor act his fish catch live us.
Available bill always various speech. Organization actually along film instead. Allow scientist color social wide language environment.
Politics news girl member responsibility mean.
Song natural tough new. Education voice tonight.
Stand really imagine east. Check success federal report. Mean American oil indicate figure magazine discuss network.
Little education break box speak culture. Anything watch natural marriage personal follow community.
Place road would determine president soldier at. Election nature pass improve positive similar.', '2021-04-30', 'joshuablair', 33),
(21, 'Early life at.', 'Month tax view election see. Respond most north show.
Sign south among worker large house trade. Lawyer picture many wear maintain. Total no end also morning.
Than both year case race. Child have image growth special establish.
Amount find those defense operation. Remember by billion design reach wear. Support industry also bit.
Move anything simple finally conference American score. Else the particularly director seek admit.
Hope she expect listen prove clear own card. Popular radio do despite himself sister in.
East price after suffer. Interview social management Congress these officer. Treatment decide wide professor medical marriage laugh.
Also either ball artist mouth ever. Deal interview pressure. Compare seem live whatever key exist.
Bring stuff your easy. Newspaper beyond cover word camera. Offer send analysis recognize parent improve.
Tax short reveal smile argue collection share top. Baby far media explain decide figure person.', '2021-02-25', 'jbarnett', 7),
(22, 'Or right experience.', 'State control interview sort brother arm specific. Close administration next stage study know not positive. Page former wonder special discover one spend which.
Edge else land him charge case.
Interesting though several nor person these. Local almost interesting view career animal. Bring investment day realize manager behind practice what.
Pull meeting run quickly later who. Shoulder of each test pick offer. White industry way share bad.
Light civil early sign president. Thousand sell degree pretty south well. Tell prevent field drop. Wall ball painting memory conference contain.
Find magazine play. Many fast brother evening individual ever mother relate. Policy agent fine station.
Per agreement film less. Main reflect quickly industry expert bed to myself. Tough share plan family daughter town.
Fear research few foreign. Strategy help professional available already return risk. Executive thank catch information.', '2020-03-26', 'grantdaniel', 32),
(23, 'Mission parent particularly particularly.', 'Remain how public. Majority Congress agency account. Treatment true direction red beat million.
Discuss already keep pretty. Debate finish tend since into. Partner book will huge about dinner impact.
Light doctor they detail. Reveal feeling off effort boy.
Old name professor tax. Model out source.
Happy capital decide statement ability nice. His part family turn throughout.
End year kitchen leg poor. Safe house campaign general indicate culture range. Structure evidence my statement resource final position.
Edge visit early professor purpose. Short sign ball current. Theory series just example probably grow beat themselves. Enough trade another in.
Place writer series police. Me tough marriage.
Key degree throw phone common name. Your conference blood road break. Wrong region if have natural.
Building off alone. Artist maybe film image.
Interest bed fish trade of bar major. Matter type world who.', '2021-08-01', 'derekburns', 35),
(24, 'Commercial clearly upon and.', 'Other out professional card gas of. Affect well under citizen five rise. Individual I street turn thought see.
Seven common consider pretty myself. Long idea however some. Since mission chance listen forget. Still behind security increase.
Kid phone hear smile. Law feel certain follow really hand. Major charge suddenly include cover however require. He sure stock home thing population.
Increase son adult music summer rich quite. Writer government light community.
Fall about south hold college. Brother class ago important. Campaign all safe lot movement scene history.
So skill expert author star at soon network. Statement television here local.
Radio poor rise. Eye nor whether under military detail child. Police crime get after.
Whether in accept. Speak concern be cold hair suddenly my design. Yard hard factor.
Rise law word space support free. Anything available author painting table quality fight hit.', '2021-06-30', 'tammyjarvis', 4),
(25, 'Lay spring contain.', 'Meeting family simply under figure task check. Civil by result guy. Foot safe baby father rise foreign early usually.
Rise local site street affect. None thing camera include near.
Democratic reach firm loss writer yeah. Father consumer development avoid seem answer long establish. Rich win member.
Around there hope exactly recognize conference continue. Station sign set possible quality may.
Choice discuss well kitchen seat law next claim. Especially consider good. Red enough various build act hospital ground.
Responsibility any director at house without nice. Away every Mr rather tonight. Produce room oil no Mr among idea.
Anyone across specific election me.
Hit poor staff his need.
Toward interview reach few no team central certain. Deal store show understand east continue.
Race wear trip popular. Allow difference couple election. Drop simply need likely see main great whether.', '2024-07-28', 'xtaylor', 31),
(26, 'Edge six assume.', 'Specific series peace her administration director read year. Seven anything surface identify southern run fact six. Market test reduce popular.
Even truth want early out but pretty. Want various religious newspaper final type. Mouth summer main since Congress low.
Example its wall green. Information amount view upon film mission.
His use project water not. Yeah vote soldier exactly let event blue. Sort could evening player.
Image everyone ever painting second feeling everything read. Foreign scene language local paper teacher plan amount.
Agreement agent surface perform whether per. Least those meet. Message move rule owner last.
Throw toward leg very. Likely eight a subject environmental.
Because control student near power. Community between cover do war some.
Change feel throw price thus look. Near feel finish.
Mr research employee tough such past move. Exist author will far sit arrive.
Explain provide dog community. Kitchen against water gun training today stage his. It and modern.', '2020-10-17', 'ncastaneda', 11),
(27, 'Among election save.', 'Collection me cup. Federal star audience outside form point.
Defense knowledge herself along simple. Personal address whom fear worker later.
Claim test nor house effort difficult. Audience view surface compare security.
Watch professional well kid begin run write. Tv fast until husband participant when.
Manager marriage performance environment. Place always share whole care reach. At individual whether happen system join.
Exist road record deep effect become state. Main fill tough response country. Mouth role hit why.
Build my investment ever. Unit garden her born boy.
Hand indeed art research relate close.
Face great girl center probably. Particular education start fly contain home life.
Total campaign audience direction while analysis. Head billion collection commercial.
Congress start phone people feel rather. Worker still analysis these network smile mouth indicate. Role hit should. Them wonder bring son skin same.', '2023-01-18', 'pmoore', 4),
(28, 'Identify knowledge deep ten.', 'Past something former by table build own low. Seem heart show. Or general put decade behavior rich.
Artist world be week. Glass reveal dinner figure ok east teacher. Sound new attack nearly simply her. Strategy deal stop nice design that develop involve.
Decision suggest question. Range cover wife popular wall until near.
Job work operation word down day certain. Pressure unit future season there expect ask. Law Mrs less catch sure age road.
Plant which eye property interview better. More gas so might. Floor but fight bank environment painting even difficult.
Natural down however evidence green. Natural design more. Suddenly nation help street more upon through today. Plant political question fire a information appear put.
Everyone treatment expect. Age third significant forward right. Here improve similar pressure red staff party.
Fall main occur as rest bad behavior appear. Daughter yet front tax although attention.', '2022-09-20', 'seanreed', 5),
(29, 'Keep feel because.', 'With however buy. Yourself last important page fly range color. Anyone hope what assume successful particular nor.
Own wide lay matter bed. Political owner place condition garden. Same series right.
Own culture assume. Community address else same second kind.
Feel then sister. Image southern remain site so writer future.
Partner hit two everyone. Right home may at building note. Lot fine system response outside job word.
In though usually result have democratic garden.
Receive maintain around discussion. Vote center production.
Third on process true food door. Receive those key event another matter around live. Republican fill popular voice college.
Relationship middle option note experience science arrive. Himself point already full. Democratic short full choose.
Produce road chair stand word write. Change ago partner society yeah. Page eight move same moment worker position human.
Type support production score board individual third. Test nor then upon seat pay.', '2020-12-14', 'renee38', 29),
(30, 'Sport activity.', 'Form country for report federal. Could story quite surface really dinner move. Even reality be available.
Begin appear writer cup power issue. Particularly citizen suddenly once write draw bit. Think half available officer.
Challenge memory way product husband report wife ability. Pretty once all actually. Hotel piece single hand order employee range.
Reach thank financial your tell so. Off back military.
Among write down must field type. More whose lay listen should.
Job enough executive still miss.
Space enough person cover.
Majority next sign air. Month herself major of order involve financial. Product peace prevent get.
Vote prevent PM part address research. Country should speak fire rock question. Despite indeed magazine.
Occur like prove per fill clearly agree. Pay wear hand case can be.
Until audience weight today. Policy bring maybe herself line still company despite. Either identify best energy his what bed chance. Bed meeting start water.', '2021-07-22', 'jbarnett', 5),
(31, 'Serve minute attorney.', 'Article note other from onto.
Feel able try return pattern try century almost. Another especially also sometimes notice.
Style process wide design. Large appear anything stage wonder several parent. Forget must eye near have research.
Relationship school red mission watch. Boy form start certain. Manage sure model represent.
Civil help effort truth about increase. Month own tend country company game. Like contain open market.
Heavy continue actually suddenly. Job computer professor reach among picture.
Hold either enter old. Far force go also mind boy. Improve throughout base project.
Effort around entire ten science everyone say. Agency necessary win economy sometimes.
Get ground music human. Baby sound trial.
Doctor list suddenly someone. Hit worry agreement early whatever bag fire Congress. Statement prove movie. Attack music list collection pull consumer.
Nothing relate learn. Realize actually best huge. Debate phone decide fear subject at one.', '2021-08-29', 'xtaylor', 8),
(32, 'Teach either about before wind.', 'Next pay glass easy. Onto business game reality development tough camera. Approach artist personal life hospital end when. Short race walk space several.
Then tell human. Maybe lot thought capital perform performance mission. Attention consumer eye goal why write popular address.
Stand board may through chair. Cup power cold claim hand require know. Figure action responsibility chair establish marriage throughout.
Daughter manager behavior hard should attack both. Natural next represent car nature near fast they. Heavy fish watch tree worker teach.
What there again. Miss eye most old authority meet attention area. Moment manager nice answer health near.
Alone most commercial carry sometimes total never individual. Maintain film people cold enjoy down. Then each resource strong may.
Ten source truth article say generation large history. All happen beat medical.
Enter worry official likely with. Part reveal present sometimes our entire make. Medical off amount color as.', '2020-05-03', 'ncastaneda', 19),
(33, 'Green save perform eat.', 'Data same executive sort old. Leg window it appear. Work wind it energy heart trade contain.
Western stock heavy short worry writer factor. Usually either such room kitchen. Surface oil field option rest agree wonder rather.
Event offer nature pick. Yourself type hope same.
Only wind purpose rich fact set. Face because newspaper audience fear.
War teacher player own. Participant federal early community.
Need Democrat say vote remember.
Why actually above president thank best. Late finish expert rich deal important. Morning window surface play.
Push tough wonder two learn interesting. Fly both social trial drug single computer hard. Thing decide wrong those area.
Wrong wait them. Style painting easy.
Head consider campaign foreign green kind. Each eight stuff recent everything word me.
Everyone usually from ever let yourself. Eight perhaps follow short. West action middle forget statement owner article still.', '2024-09-15', 'whiteheather', 10),
(34, 'Culture table anyone.', 'Into laugh current main soldier. Within within down to once simply process.
This group kid factor above. Business culture bar view even successful.
Yard morning let drop week order Congress. Available him from view hospital rich.
Research long media billion really scientist. Physical woman state him school. The speak card produce.
Range major strong down single. Forget amount security about matter maybe check.
More another others direction prepare though. Against health pass improve scientist soon. Open draw production account southern mean pretty. Stock growth sound economy.
Management nation account continue age commercial experience. Commercial professor yourself threat success.
Big far church than financial section let. Point middle table hit.
Point threat citizen surface return. We happen store guess fish everyone. Successful wind might report although.
Provide four ground tree sound amount. Year important once high. Everything fall help north relationship.', '2020-01-15', 'mccoywilliam', 14),
(35, 'Challenge guy country.', 'Story discuss visit some drop four. Total reality state study building health. Anyone sell for news blood painting shake.
Science ten cut never rate inside painting. Sure machine where book past which nothing. Room six walk game young new cold.
Left baby record thought full television pretty wonder. Matter enjoy travel peace near alone simply. Somebody board value remember provide lot. Take population firm pass.
Health bill official military. Development drop star part adult but account. Key still letter writer model father. Anyone hear during east understand traditional.
Scientist writer information draw rather social deal. Big campaign value school. Health as since serious.
Board answer authority listen. School strong eight. Right election like.
Purpose choice during million success foot. Glass last spring simply. Matter term gun item type half.', '2022-06-08', 'probinson', 9);

-- Insert statements for table: Meal_Tag
INSERT INTO Meal_Tag (RecipeID, TagID) VALUES
('32', '6'),
('29', '1'),
('17', '1'),
('29', '5'),
('6', '7'),
('27', '9'),
('1', '5'),
('1', '6'),
('35', '4'),
('33', '5'),
('16', '2'),
('5', '7'),
('23', '2'),
('32', '1'),
('22', '7'),
('13', '4'),
('12', '9'),
('4', '8'),
('7', '3'),
('30', '10'),
('4', '7'),
('33', '10'),
('34', '7'),
('8', '5'),
('7', '4'),
('34', '5'),
('19', '5'),
('3', '10'),
('30', '1'),
('28', '2'),
('9', '5'),
('33', '1'),
('12', '1'),
('7', '10'),
('3', '4'),
('13', '8'),
('10', '8'),
('19', '8'),
('5', '2'),
('8', '8'),
('24', '10'),
('14', '2'),
('24', '2'),
('19', '4'),
('16', '4'),
('25', '9'),
('33', '7'),
('12', '10'),
('6', '3'),
('11', '6'),
('28', '5'),
('16', '6'),
('8', '1'),
('11', '2'),
('9', '8'),
('10', '4'),
('9', '2'),
('2', '2'),
('11', '8'),
('26', '3'),
('28', '4'),
('26', '6'),
('15', '1'),
('27', '6'),
('21', '8'),
('27', '10'),
('15', '5'),
('16', '9'),
('5', '6'),
('6', '5'),
('7', '7'),
('14', '9'),
('27', '3'),
('7', '6'),
('8', '3'),
('7', '8'),
('4', '5'),
('7', '5'),
('11', '4'),
('25', '3'),
('23', '9'),
('2', '8'),
('32', '8'),
('2', '4'),
('1', '2'),
('22', '3'),
('15', '3'),
('7', '9'),
('14', '10'),
('32', '10'),
('2', '6'),
('30', '6'),
('32', '9'),
('13', '5'),
('35', '7'),
('31', '6'),
('7', '1'),
('24', '1'),
('31', '9'),
('12', '2'),
('12', '7'),
('17', '9'),
('29', '10'),
('30', '7'),
('2', '3'),
('12', '8'),
('3', '3'),
('18', '1'),
('15', '4'),
('3', '6'),
('18', '3'),
('10', '5'),
('6', '10'),
('9', '9'),
('13', '2'),
('17', '5'),
('21', '4'),
('25', '2'),
('28', '1'),
('14', '4'),
('35', '10'),
('1', '4'),
('20', '1'),
('33', '8'),
('23', '6'),
('14', '7'),
('3', '2'),
('8', '4'),
('11', '1'),
('29', '8'),
('9', '7');

-- Insert statements for table: Saved_Meals
INSERT INTO Saved_Meals (Username, RecipeID) VALUES
('whiteheather', 28),
('emma63', 10),
('manuel99', 18),
('lauramclaughlin', 4),
('manuel99', 17),
('joshuablair', 4),
('whiteheather', 26),
('gentrymelissa', 11),
('derekburns', 33),
('emma63', 32),
('derekburns', 28),
('markrush', 4),
('jbarnett', 17),
('michaelphillips', 31),
('aprilwilkerson', 35),
('philip04', 3),
('probinson', 12),
('aprilwilkerson', 13),
('lauramclaughlin', 30),
('imcdonald', 12),
('joshuablair', 17),
('joshuablair', 29),
('xtaylor', 32),
('gentrymelissa', 13),
('xtaylor', 17),
('bvasquez', 24),
('jacqueline17', 25),
('terrywarren', 10),
('cschultz', 22),
('renee38', 18),
('michaelphillips', 32),
('probinson', 15),
('grantdaniel', 31),
('jbarnett', 26),
('jacqueline17', 34),
('bryangarcia', 21),
('seanreed', 13),
('terrywarren', 21),
('lauramclaughlin', 17),
('derekburns', 2),
('lauramclaughlin', 21),
('grantdaniel', 26),
('philip04', 29),
('nicholas77', 29),
('gentrymelissa', 27),
('lauramclaughlin', 25),
('probinson', 6),
('odonnellmonica', 20),
('cschultz', 6),
('lauramclaughlin', 27),
('tammyjarvis', 11),
('kelsey94', 23),
('seanreed', 14),
('philip04', 35),
('nicholas77', 1),
('stephaniehowe', 3),
('nicholas77', 13),
('manuel99', 32),
('bvasquez', 10),
('tammyjarvis', 5),
('grantdaniel', 1),
('bvasquez', 18),
('manuel99', 21),
('nicholas77', 21),
('jbarnett', 2),
('dianaaguilar', 19),
('dunnjoshua', 10),
('bvasquez', 7),
('aprilwilkerson', 34),
('mccoywilliam', 4),
('kelsey94', 14),
('manuel99', 13),
('grantdaniel', 21),
('jbarnett', 9),
('terrywarren', 16),
('cschultz', 26),
('aprilwilkerson', 21),
('dunnjoshua', 16),
('derekburns', 5),
('dianaaguilar', 17),
('cschultz', 15),
('cschultz', 33),
('emma63', 13),
('derekburns', 30),
('renee38', 35),
('mccoywilliam', 2),
('philip04', 18),
('whiteheather', 23),
('joshuablair', 2),
('nicholas77', 19),
('whiteheather', 6),
('lauramclaughlin', 19),
('gentrymelissa', 16),
('gentrymelissa', 23),
('joshuablair', 22),
('stephaniehowe', 2),
('jacqueline17', 33),
('whiteheather', 11),
('sotoscott', 13),
('lauramclaughlin', 3),
('renee38', 11),
('seanreed', 7),
('grantdaniel', 12),
('lauramclaughlin', 5),
('seanreed', 18),
('joshuablair', 3),
('pmoore', 9),
('jacqueline17', 20),
('philip04', 31),
('dunnjoshua', 20),
('tammyjarvis', 7),
('whiteheather', 30),
('derekburns', 34),
('mccoywilliam', 9),
('seanreed', 19),
('markrush', 30),
('philip04', 34),
('bryangarcia', 4),
('pmoore', 6),
('terrywarren', 12),
('xtaylor', 19),
('shepardamanda', 19),
('gentrymelissa', 2),
('markrush', 33),
('emma63', 16),
('shepardamanda', 31),
('nicholas77', 22),
('joshuablair', 16),
('markrush', 31),
('dunnjoshua', 34),
('markrush', 20),
('dunnjoshua', 17),
('lauramclaughlin', 10),
('markrush', 3),
('kelsey94', 11),
('grantdaniel', 9),
('derekburns', 23),
('odonnellmonica', 3),
('xtaylor', 16),
('odonnellmonica', 13);

-- Insert statements for table: Interaction
INSERT INTO Interaction (InteractionID, Timestamp, InteractionType, RecipeID, UserID) VALUES
(1, '2022-06-26 17:18:52', 'COMMENT', 24, 'seanreed'),
(2, '2023-08-29 17:03:09', 'VIEW', 10, 'manuel99'),
(3, '2022-04-16 03:05:21', 'SHARE', 17, 'imcdonald'),
(4, '2020-05-19 02:49:10', 'LIKE', 6, 'renee38'),
(5, '2023-11-28 02:28:19', 'COMMENT', 3, 'cschultz'),
(6, '2025-03-06 06:58:45', 'VIEW', 6, 'seanreed'),
(7, '2021-12-30 00:41:00', 'SHARE', 20, 'bryangarcia'),
(8, '2023-05-10 11:04:14', 'VIEW', 24, 'dunnjoshua'),
(9, '2024-03-11 03:26:45', 'LIKE', 14, 'joshuablair'),
(10, '2020-09-23 20:04:18', 'LIKE', 12, 'pmoore'),
(11, '2021-11-20 16:36:51', 'LIKE', 33, 'odonnellmonica'),
(12, '2024-12-10 09:20:46', 'LIKE', 25, 'terrywarren'),
(13, '2021-04-14 06:30:05', 'VIEW', 10, 'renee38'),
(14, '2023-05-02 21:18:04', 'COMMENT', 18, 'nicholas77'),
(15, '2023-08-07 15:09:18', 'VIEW', 30, 'nicholas77'),
(16, '2020-10-06 13:44:20', 'SHARE', 24, 'imcdonald'),
(17, '2024-01-08 12:58:31', 'COMMENT', 22, 'xtaylor'),
(18, '2023-01-31 00:15:32', 'VIEW', 21, 'imcdonald'),
(19, '2025-01-15 13:58:54', 'VIEW', 2, 'bryangarcia'),
(20, '2022-06-25 15:11:18', 'SHARE', 33, 'gentrymelissa'),
(21, '2023-11-07 23:57:28', 'COMMENT', 22, 'jacqueline17'),
(22, '2022-10-03 00:48:51', 'LIKE', 35, 'tammyjarvis'),
(23, '2021-03-12 04:47:53', 'SHARE', 13, 'cschultz'),
(24, '2020-10-10 21:20:02', 'LIKE', 6, 'ncastaneda'),
(25, '2023-06-23 12:57:46', 'COMMENT', 19, 'odonnellmonica'),
(26, '2021-06-24 16:05:26', 'VIEW', 17, 'markrush'),
(27, '2020-06-11 10:46:57', 'SHARE', 7, 'jacqueline17'),
(28, '2020-04-20 05:55:47', 'COMMENT', 30, 'manuel99'),
(29, '2021-03-03 18:11:45', 'COMMENT', 17, 'renee38'),
(30, '2020-02-20 02:30:51', 'COMMENT', 15, 'cschultz'),
(31, '2021-09-26 15:52:47', 'SHARE', 9, 'grantdaniel'),
(32, '2023-02-08 13:11:47', 'SHARE', 2, 'bryangarcia'),
(33, '2022-07-13 09:52:18', 'COMMENT', 23, 'odonnellmonica'),
(34, '2021-11-19 21:06:38', 'COMMENT', 4, 'xtaylor'),
(35, '2022-12-04 10:02:09', 'SHARE', 34, 'imcdonald');