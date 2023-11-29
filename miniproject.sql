CREATE DATABASE  IF NOT EXISTS bangalore_residential_analytics;
USE bangalore_residential_analytics;

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `area_name` varchar(100) NOT NULL,
  `division` enum('North','North-East','East','South-East','South','West','Central') NOT NULL,
  `mla_name` varchar(100) DEFAULT NULL,
  `party` varchar(100) DEFAULT NULL,
  
  PRIMARY KEY (`area_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `location` WRITE;

INSERT INTO `location` VALUES 
('Hebbal','North','Byrathi Suresh','INC'),
('Jalahalli','North','Munirathna','INC'),
('Mathikere','North','Dr C.N. Ashwath Narayan','BJP'),
('Peenya','North','R. Manjunatha','JD'),
('RT Nagar','North','Byrathi Suresh','INC'),
('Yelahanka','North','S.R. Vishwanath','BJP'),
('Yeshwantpur','North','S.T. Somashekar','BJP'),
('Banaswadi','North-East','K.J. George','INC'),
('Horamavu','North-East','B.A. Basavaraj','BJP'),
('Kalyan Nagar','North-East','K.J. George','INC'),
('Kammanahalli','North-East','K.J. George','INC'),
('Lingarajapuram','North-East','K.J. George','INC'),
('Ramamurthy Nagar','North-East','B.A. Basavaraj','BJP'),
('Bellandur','East','Aravind Limbavali','BJP'),
('CV Raman Nagar','East','S. Raghu','BJP'),
('Hoodi','East','Aravind Limbavali','BJP'),
('KR Puram','East','B.A. Basavaraj','BJP'),
('Mahadevapuram','East','Manjula S','BJP'),
('Marathahalli','East','Aravind Limbavali','BJP'),
('Varthur','East','Aravind Limbavali','BJP'),
('Whitefield','East','Aravind Limbavali','BJP'),
('Bommanahalli','South-East','Satish Reddy','BJP'),
('Bommasandra','South-East','Satish Reddy','BJP'),
('BTM Layout','South-East','Ramalinga Reddy','INC'),
('Electronic City','South-East','M. Krishnappa', 'BJP'),
('HSR Layout','South-East','Satish Reddy','BJP'),
('Koramangala','South-East','Ramalinga Reddy','INC'),
('Madiwala','South-East','Ramalinga Reddy','INC'),
('Sarjapur','South-East','B. Shivanna','INC'),
('Banashankari','South','M. Krishnappa','BJP'),
('Basavanagudi','South','Ravi Subramanya','BJP'),
('Girinagar','South','Ravi Subramanya','BJP'),
('JP Nagar','South','M. Krishnappa','BJP'),
('Jayanagar','South','C.K. Ramamurthy','BJP'),
('Uttarahalli','South','M. Krishnappa','BJP'),
('Bannerghatta','South','M. Krishnappa','BJP'),
('Basaveshwaranagar','West','S. Suresh Kumar','BJP'),
('Kengeri','West','S.T. Somashekar','INC'),
('Mahalakshmi Layout','West','K. Gopalaiah','INC'),
('Nagarbhavi','West','V. Somanna','BJP'),
('Nayandahalli','West','V. Somanna','BJP'),
('Rajajinagar','West','S. Suresh Kumar','BJP'),
('RR Nagar','West','Munirathna N','BJP'),
('Vijayanagar','West','M. Krishnappa','INC'),
('Cantonment Area','Central','Rizwan Arshad','INC'),
('Domlur','Central','N.A. Harris','INC'),
('Indiranagar','Central','S. Raghu','BJP'),
('Ulsoor','Central','Rizwan Arshad','INC'),
('Malleshwaram','Central','Dr C.N. Ashwath Narayan','BJP'),
('Pete Area','Central','Uday B. Garudachar','BJP'),
('Seshadipuram','Central','Dinesh Gundu Rao','INC'),
('Shivajinagar','Central','Rizwan Arshad','INC'),
('Vasanth Nagar','Central','Rizwan Arshad','INC'),
('Shanti Nagar','Central','N.A. Haris','INC');


UNLOCK TABLES;



DROP TABLE IF EXISTS `safety_and_security`;

CREATE TABLE `safety_and_security` (
  `area_name` varchar(100) NOT NULL,
  `crime_rate` enum('High','Medium','Low') NOT NULL,
  `fire_stn` varchar(100) DEFAULT NULL,
  `police_stn` varchar(100) DEFAULT NULL,

  PRIMARY KEY (`area_name`),
  KEY `fk_area_name_ss` (`area_name`),
  CONSTRAINT `fk_area_name_ss` FOREIGN KEY (`area_name`) REFERENCES `location` (`area_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `safety_and_security` VALUES
('Hebbal','Medium','Fire Station Hebbal','Hebbal Police Station'),
('Jalahalli','Medium','Fire Station Jalahalli','Jalahalli Polica Station'),
('Mathikere','Medium',NULL,NULL),
('Peenya','Medium','Fire Station Peenya','Peenya Police Station'),
('RT Nagar','High',NULL,NULL),
('Yelahanka','Medium',NULL,'Yelahanka Police Station'),
('Yeshwantpur','High','Fire Station Yeshwanthpur','Yeshwantpura Police Station, R.M.C. Yard Police Station'),
('Banaswadi','Medium','Fire Station Cooke Town','Banaswadi Police Station'),
('Horamavu','Medium',NULL,NULL),
('Kalyan Nagar','Medium','HBR Fire Station',NULL),
('Kammanahalli','Medium',NULL,'HBR Police Station'),
('Lingarajapuram','High',NULL,'LIngarajpuram Police Station'),
('Ramamurthy Nagar','Medium',NULL,NULL),
('Bellandur','Medium',NULL,'Bellandur Police Station'),
('CV Raman Nagar','Medium',NULL,NULL),
('Hoodi','Medium',NULL,NULL),
('KR Puram','Medium',NULL,'KR Puram Police Station'),
('Mahadevapuram','Medium',NULL,'Mahadevpura Police Station'),
('Marathahalli','Medium','Marathahalli Fire Station','Marathahalli Police Station, H.A.L. Police Station'),
('Varthur','Medium',NULL,'Varthur Police Station'),
('Whitefield','Medium','Fire Station Whitefield','Whitefield Police Station, Kadugodi Police Station'),
('Bommanahalli','Medium',NULL,NULL),
('Bommasandra','Medium',NULL,NULL),
('BTM Layout','Medium',NULL,'Mico Layout Police Station'),
('Electronic City','Medium','Fire Station Electronic City','Electronic City Police Station'),
('HSR Layout','High',NULL,'HSR Police Station, Bandepalya Police Station'),
('Koramangala','High','Koramangala Fire Station','Koramangala Police Station'),
('Madiwala','High',NULL,'Madiwala Police Station'),
('Sarjapur','Medium','Sarjapur Road Fire Station',NULL),
('Banashankari','High','Fire Station Banashankari 2nd Stage','Banashankari Police Station'),
('Basavanagudi','Low',NULL,'Basavangudi Police Station'),
('Girinagar','Low',NULL,'Girinagar Police Station'),
('JP Nagar','Low',NULL,'JP Nagar Police Station'),
('Jayanagar','High','Fire Station Jayanagar','Jayanagar Police Station, Tilaknagar Police Station'),
('Uttarahalli','Low',NULL,NULL),
('Bannerghatta','Low','Fire Station Hulimavu',NULL),
('Basaveshwaranagar','Low',NULL,NULL),
('Kengeri','Low','Kengeri Fire Station','Kengeri Police Station'),
('Mahalakshmi Layout','Low',NULL,NULL),
('Nagarbhavi','Low',NULL,NULL),
('Nayandahalli','Low',NULL,NULL),
('Rajajinagar','Low','Fire Station Rajajinagar Industrial Estate','Rajajinagar Police Station, Subramanya Nagar Police Station'),
('RR Nagar','Low',NULL,NULL),
('Vijayanagar','Low','Brilliant Fire Services Pvt. Ltd.',NULL),
('Cantonment Area','Low',NULL,NULL),
('Domlur','Low','Global Fire Services',NULL),
('Indiranagar','High',NULL,'Indiranagar Police Station'),
('Ulsoor','Low','Agni Shamaka Dala','Halsoor Police Station'),
('Malleshwaram','Low','Malleshwaram Fire Station',NULL),
('Pete Area','High',NULL,NULL),
('Seshadripuram','Low','Fire Station High Ground','Seshadripuram Police Station'),
('Shivajinagar','High',NULL,'Commercial Street Police Station, Shivajinagar Police Station'),
('Vasanth Nagar','Low','Fire Station Vidhan Soudha','High Ground Police Station'),
('Shanti Nagar','Low','Fire Station Residency Road','Cubbon Park Police Station')
;

DROP TABLE IF EXISTS `external_factors`;

CREATE TABLE `external_factors` (
  `area_name` varchar(100) NOT NULL,
  `aqi` enum('Good','Moderate','Poor','Very Poor') DEFAULT NULL,
  `traffic_density` enum('Very High','High','Medium','Low') DEFAULT NULL,
  `green_spaces` enum('High','Medium','Low') DEFAULT NULL,
  PRIMARY KEY (`area_name`),
  KEY `fk_area_name_external` (`area_name`),
  CONSTRAINT `fk_area_name_external` FOREIGN KEY (`area_name`) REFERENCES `location` (`area_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `external_factors` WRITE;

INSERT INTO `external_factors` VALUES 
('Hebbal','Moderate','Medium','High'),
('Jalahalli','Poor','High','Low'),
('Mathikere','Moderate','Medium','Medium'),
('Peenya','Very Poor','Very High','Low'),
('RT Nagar','Moderate','Medium','Medium'),
('Yelahanka','Poor','High','Medium'),
('Yeshwantpur','Very Poor','Very High','Low'),
('Banaswadi','Moderate','Medium','Medium'),
('Horamavu','Moderate','Medium','Medium'),
('Kalyan Nagar','Poor','High','Medium'),
('Kammanahalli','Moderate','Medium','Medium'),
('Lingarajapuram','Poor','Medium','Low'),
('Ramamurthy Nagar','Moderate','Medium','Medium'),
('Bellandur','Very Poor','Very High','Low'),
('CV Raman Nagar','Poor','High','Medium'),
('Hoodi','Poor','Medium','Low'),
('KR Puram','Very Poor','High','Low'),
('Mahadevapuram','Poor','Medium','Low'),
('Marathahalli','Very Poor','Very High','Low'),
('Varthur','Poor','Very High','Low'),
('Whitefield','Very Poor','Very High','Low'),
('Bommanahalli','Poor','High','Medium'),
('Bommasandra','Very Poor','High','Low'),
('BTM Layout','Very Poor','Very High','Low'),
('Electronic City','Very Poor','Medium','Low'),
('HSR Layout','Poor','Very High','Medium'),
('Koramangala','Very Poor','Very High','Low'),
('Madiwala','Poor','High','Medium'),
('Sarjapur','Moderate','Medium','Medium'),
('Banashankari','Moderate','Medium','Medium'),
('Basavanagudi','Moderate','Medium','Medium'),
('Girinagar','Poor','High','Medium'),
('JP Nagar','Poor','Very High','Medium'),
('Jayanagar','Moderate','Medium','High'),
('Uttarahalli','Moderate','Medium','Medium'),
('Bannerghatta','Very Poor','Medium','High'),
('Basaveshwaranagar','Moderate','Medium','Medium'),
('Kengeri','Moderate','Medium','Medium'),
('Mahalakshmi Layout','Poor','High','Medium'),
('Nagarbhavi','Moderate','Medium','Medium'),
('Nayandahalli','Poor','Medium','Medium'),
('Rajajinagar','Moderate','Medium','Medium'),
('RR Nagar','Moderate','Medium','Medium'),
('Vijayanagar','Moderate','High','High'),
('Cantonment Area','Poor','High','Low'),
('Domlur','Poor','High','High'),
('Indiranagar','Poor','Very High','High'),
('Ulsoor','Moderate','Medium','Medium'),
('Malleshwaram','Moderate','Medium','High'),
('Pete Area','Poor','Medium','Medium'),
('Seshadripuram','Very Poor','Medium','Low'),
('Shivajinagar','Very Poor','Medium','Low'),
('Vasanth Nagar','Moderate','Medium','Medium'),
('Shanti Nagar','Moderate','Medium','High')
;

UNLOCK TABLES;



DROP TABLE IF EXISTS `property`;

CREATE TABLE `property` (
  `area_name` varchar(100) NOT NULL,
  `price_range` int DEFAULT NULL,
  `rental_rate` int DEFAULT NULL,
  `property_type` enum('Villas','Apartments','Independent Houses') NOT NULL,
  `growth_rate` numeric(3,1) DEFAULT NULL,
  PRIMARY KEY (`area_name`),
  KEY `fk_area_name_property` (`area_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `property` WRITE;

INSERT INTO `property` VALUES 
('Hebbal',10000,3,'Apartments',61.3),
('Jalahalli',6950,4,'Apartments',21.9),
('Mathikere',6900,5,'Apartments',NULL),
('Peenya',NULL,1,'Apartments',NULL),
('RT Nagar',7050,6,'Independent Houses',29.4),
('Yelahanka',7200,10,'Apartments',39.8),
('Yeshwantpur',8800,3,'Apartments',32.3),
('Banaswadi',5700,7,'Independent Houses',3.6),
('Horamavu',5100,5,'Apartments',24.4),
('Kalyan Nagar',6050,12,'Villas',15.2),
('Kammanahalli',123000,5,'Independent Houses',NULL),
('Lingarajapuram',6500,4,'Independent Houses',NULL),
('Ramamurthy Nagar',5350,7,'Independent Houses',27.4),
('Bellandur',9500,7,'Apartments',50.8),
('CV Raman Nagar',7900,6,'Apartments',NULL),
('Hoodi',8050,5,'Apartments',4.8),
('KR Puram',6050,5,'Apartments',51.2),
('Mahadevapuram',7500,7,'Apartments',47.1),
('Marathahalli',6700,7,'Apartments',4.7),
('Varthur',9150,7,'Villas',79.4),
('Whitefield',8100,7,'Villas',48.6),
('Bommanahalli',5150,4,'Apartments',12.0),
('Bommasandra',5500,4,'Apartments',37.3),
('BTM Layout',9600,12,'Apartments',69.9),
('Electronic City',4850,7,'Apartments',14.1),
('HSR Layout',7500,8,'Independent Houses',31.6),
('Koramangala',13350,7,'Villas',25.9),
('Madiwala',5600,4,'Apartments',NULL),
('Sarjapur',7850,5,'Villas',68.1),
('Banashankari',7400,8,'Apartments',31.0),
('Basavanagudi',6700,3,'Apartments',19.7),
('Girinagar',5600,3,'Independent Houses',NULL),
('JP Nagar',6050,6,'Independent Houses',13.1),
('Jayanagar',11400,3,'Independent Houses',21.9),
('Uttarahalli',6550,3,'Independent Houses',45.6),
('Bannerghatta',6100,5,'Apartments',29.8),
('Basaveshwaranagar',4500,4,'Independent Houses',NULL),
('Kengeri',5550,4,'Apartments',37.0),
('Mahalakshmi Layout',5000,6,'Independent Houses',NULL),
('Nagarbhavi',5750,5,'Independent Houses',40.2),
('Nayandahalli',5500,2,'Independent Houses',22),
('Rajajinagar',16400,2,'Independent Houses',NULL),
('RR Nagar',6750,3,'Independent Houses',39.2),
('Vijayanagar',7700,3,'Independent Houses',22.2),
('Cantonment Area',6700,7,'Independent Houses',12.3),
('Domlur',8800,12,'Independent Houses',NULL),
('Indiranagar',13200,6,'Independent Houses',18.9),
('Ulsoor',5200,5,'Independent Houses',NULL),
('Malleshwaram',12950,2,'Independent Houses',6.1),
('Pete Area',4000,3,'Independent Houses',NULL),
('Seshadripuram',8900,6,'Independent Houses',NULL),
('Shivajinagar',4000,2,'Independent Houses',NULL),
('Vasanth Nagar',19000,2,'Villas',NULL),
('Shanti Nagar',21000,9,'Villas',45.8)
;

UNLOCK TABLES;

ALTER TABLE `property`
ADD CONSTRAINT `fk_area_name_property`
FOREIGN KEY (`area_name`) REFERENCES `location` (`area_name`) ON DELETE CASCADE;


DROP TABLE IF EXISTS `demography`;

CREATE TABLE `demography` (
  `area_name` varchar(100) NOT NULL,
  `population_density` int NOT NULL,
  `cultural_diversity` enum('Hindu','Muslim','Christian','Jain') DEFAULT NULL,
  `linguistic_diversity` enum('Kannada','Tamil','Hindi','Telugu','Malyalam','Tulu','Urdu','Marathi') DEFAULT NULL,
  PRIMARY KEY (`area_name`),
  CONSTRAINT `fk_area_name_demography` FOREIGN KEY (`area_name`) REFERENCES `property` (`area_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `demography` WRITE;

INSERT INTO `demography` VALUES 
('Hebbal',25,'Hindu','Tamil'),
('Jalahalli',20,'Muslim','Hindi'),
('Mathikere',30,'Hindu','Kannada'),
('Peenya',40,'Hindu','Kannada'),
('RT Nagar',25,'Muslim','Kannada'),
('Yelahanka',35,'Hindu','Kannada'),
('Yeshwantpur',30,'Hindu','Kannada'),
('Banaswadi',25,'Hindu','Tamil'),
('Horamavu',20,'Hindu','Kannada'),
('Kalyan Nagar',30,'Hindu','Tamil'),
('Kammanahalli',25,'Hindu','Tamil'),
('Lingarajapuram',30,'Hindu','Tamil'),
('Ramamurthy Nagar',25,'Hindu','Kannada'),
('Bellandur',30,'Hindu','Kannada'),
('CV Raman Nagar',25,'Hindu','Kannada'),
('Hoodi',30,'Hindu','Kannada'),
('KR Puram',40,'Hindu','Telugu'),
('Mahadevapuram',20,'Hindu','Kannada'),
('Marathahalli',30,'Hindu','Kannada'),
('Varthur',20,'Hindu','Kannada'),
('Whitefield',40,'Hindu','Kannada'),
('Bommanahalli',30,'Hindu','Telugu'),
('Bommasandra',25,'Hindu','Kannada'),
('BTM Layout',30,'Hindu','Kannada'),
('Electronic City',40,'Hindu','Telugu'),
('HSR Layout',30,'Hindu','Kannada'),
('Koramangala',30,'Hindu','Kannada'),
('Madiwala',25,'Hindu','Kannada'),
('Sarjapur',20,'Hindu','Telugu'),
('Banashankari',25,'Hindu','Kannada'),
('Basavanagudi',20,'Hindu','Kannada'),
('Girinagar',30,'Hindu','Kannada'),
('JP Nagar',30,'Hindu','Telugu'),
('Jayanagar',30,'Hindu','Kannada'),
('Uttarahalli',20,'Hindu','Kannada'),
('Bannerghatta',20,'Hindu','Kannada'),
('Basaveshwaranagar',25,'Hindu','Kannada'),
('Kengeri',20,'Hindu','Kannada'),
('Mahalakshmi Layout',30,'Hindu','Kannada'),
('Nagarbhavi',25,'Hindu','Kannada'),
('Nayandahalli',20,'Hindu','Kannada'),
('Rajajinagar',25,'Hindu','Kannada'),
('RR Nagar',30,'Hindu','Kannada'),
('Vijayanagar',25,'Hindu','Kannada'),
('Cantonment Area',30,'Hindu','Kannada'),
('Domlur',30,'Hindu','Kannada'),
('Indiranagar',30,'Hindu','Kannada'),
('Ulsoor',25,'Hindu','Tamil'),
('Malleshwaram',25,'Hindu','Kannada'),
('Pete Area',30,'Muslim','Tamil'),
('Seshadripuram',25,'Hindu','Kannada'),
('Shivajinagar',25,'Muslim','Tamil'),
('Vasanth Nagar',20,'Hindu','Kannada'),
('Shanti Nagar',25,'Hindu','Kannada')
;

UNLOCK TABLES;



DROP TABLE IF EXISTS `infrastructure`;

CREATE TABLE `infrastructure` (
  `area_name` varchar(100) NOT NULL,
  `hospitals` varchar(255) DEFAULT NULL,
  `schools` varchar(255) DEFAULT NULL,
  `colleges` varchar(255) DEFAULT NULL,
  `malls` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`area_name`),
  CONSTRAINT `fk_area_name_infrastructure` FOREIGN KEY (`area_name`) REFERENCES `location` (`area_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `infrastructure` WRITE;

INSERT INTO `infrastructure` VALUES 
('Hebbal','Baptist Hospital,Manipal Hospital,Aster CMI Hospital','Kendriya Vidyalaya, Vidyaniketan','Rajiv Gandhi College of Dental Science',NULL),
('Jalahalli','BEL Hospital','Anthony Claret School, Orchids International',NULL,NULL),
('Mathikere','Vividus Hospital',NULL,'Ramaiah Insitute of Technology, Ramaiah Medical College',NULL),
('Peenya','Shiva Venkateshwara Hospital',NULL,NULL,NULL),
('RT Nagar','Medax Hospital','Florence Public School, Presidency',NULL,NULL),
('Yelahanka','Omega Multispeciality','Mallya Aditi International, Air Force School','MVIT, Reva University, Nitte Meenakshi Insititue of Technology','Phoenix Mall of Asia'),
('Yeshwantpur','Columbia Asia Hospital, Manipal Hospital, People Tree Hospital','Lourdes Academy',NULL,NULL),
('Banaswadi',NULL,'New Baldwins',NULL,'Orion Avenue'),
('Horamavu','Cloud 9 Hospital','Orchids International',NULL,NULL),
('Kalyan Nagar','Trilife Hospital','CMR NPS',NULL,NULL),
('Kammanahalli','Cura Multispeciallity, Akshaya Neuro Hospital','Royal Concorde',NULL,NULL),
('Lingarajapuram',NULL,'St. Charles',NULL,NULL),
('Ramamurthy Nagar','Jyothsna Hospital, Koshys Multispeciality','Sri Chaitanya, Narayana',NULL,NULL),
('Bellandur','Cloudnine Hospital, Parkmed Hospital','Neev Academy',NULL,'Central'),
('CV Raman Nagar',NULL,'HAL Public School, Orchids International',NULL,'Gopalan Signature Mall'),
('Hoodi',NULL,'Bangalore International, Ekya','Kristu Jayanti College','Bhartiya Mall of Bengaluru'),
('KR Puram','Sri Ram Hospital','Cambridge School',NULL,NULL),
('Mahadevapuram','RR Hospital',NULL,NULL,NULL),
('Marathahalli','Rainbow Children Hospital, Sakra World Hospital','New Horizon,Kendriya Vidyalaya','New Horizon College of Engineering',NULL),
('Varthur','Manipal Hospital','Greenwood International',NULL,NULL),
('Whitefield','Manipal Hospital, Aster Whitefield','Inventure Academy','Vydehi Insititute of Medical','Phoenix Marketcity, VR Bengaluru, Park Square Mall, Nexus Shantiniketan, Nexus Whitefield'),
('Bommanahalli',NULL,'St. Josephs Public School',NULL,NULL),
('Bommasandra','Mazumdar Shaw Hospital, Sparsh Hospital',NULL,NULL,NULL),
('BTM Layout','Jayadeva Hospital','Ekya, Orchids International',NULL,NULL),
('Electronic City','Kauvery Hospital','DPS, BS International',NULL,NULL),
('HSR Layout','Narayana Hospital','Cambridge School',NULL,NULL),
('Koramangala','Apollo Hospital','Bethany High, NPS Koramangala','Christ University','Nexus Mall Koramangala'),
('Madiwala',NULL,'Orchids International',NULL,NULL),
('Sarjapur','St. Johns Hospital, Manipal Hospital','Oakridge International, Greenwood High,DPS','St. Johns Medical College',NULL),
('Banashankari',NULL,'Little Flower Public School, Carmel School','Dayanand Sagar, Kempegowda Institute of Medical',NULL),
('Basavanagudi',NULL,'RV Public School','BMS Engineering College, Bangalore Insitute of Technology',NULL),
('Girinagar',NULL,'Shantinikethana',NULL,NULL),
('JP Nagar','Aster RV Hospital','Brigade School','RV Dental College','Forum South Bengaluru'),
('Jayanagar','Manipal Hospital, Sagar Hospital','NPS Jayanagar','Jain Deemed-to-be, Bangalore Insitute of Dental Science',NULL),
('Uttarahalli',NULL,'Sri Kumarans',NULL,NULL),
('Bannerghatta','Fortis Hospital, Apollo Hospital','VIBGYOR High','Christ University, IIM-B','Gopalan Innovation Mall, Vega City'),
('Basaveshwaranagar',NULL,'DPS, Carmel High',NULL,NULL),
('Kengeri','BGS Gleneagles Hospital','BGS International','RV College of Engineering',NULL),
('Mahalakshmi Layout','Sanjeevini Hospital','Orchids International',NULL,NULL),
('Nagarbhavi','Fortis Hospital','Orchids International','Bangalore University',NULL),
('Nayandahalli',NULL,NULL,'PES University',NULL),
('Rajajinagar','Altius Hospital', 'NPS Rajajinagar',NULL,'Lulu Mall'),
('RR Nagar',NULL,'National Hill View Public School',NULL,'Gopalan Arcade Mall'),
('Vijayanagar',NULL,'Canbridge English School',NULL,'GT World Mall'),
('Cantonment Area',NULL,'Clarence High School',NULL,NULL),
('Domlur','Manipal Hospital','Bangalore Public School',NULL,NULL),
('Indiranagar','Chinmaya Mission Hospital, Motherhood Hospital','NPS Indiranagar, New Horizon',NULL,NULL),
('Ulsoor',NULL,'Frank Anthony Public School',NULL,'1MG-Lido Mall'),
('Malleshwaram','Cloudnine Hospital, Manipal Hospital','Kendriya Vidyalaya, Cluny Convent','IISC','Orion Mall, Mantri Square'),
('Pete Area','Victoria Hospital','Orchids International',NULL,NULL),
('Seshadripuram','Apollo Hospital',NULL,NULL,NULL),
('Shivajinagar',NULL,'Sacred Hearts Girls, St. Francis Xaviers, St. Germain, St. Johns',NULL,NULL),
('Vasanth Nagar','Fortis Hospital, Vikram Hospital','Sophia High School','Mt. Carmel College',NULL),
('Shanti Nagar','St. Philomenas, HCG Hospital, Mallya Hospital','Army Public School, Bishop Cottons, St. Josephs','St. Josephs College of Commerce, St. Josephs University','UB City, Forum Rex Walk, Garuda Mall, 1 Sobha')
;

UNLOCK TABLES;



DROP TABLE IF EXISTS `transport`;

CREATE TABLE `transport` (
  `area_name` varchar(100) NOT NULL,
  `bus_stops` varchar(100) NOT NULL,
  `metro` varchar(100) DEFAULT NULL,
  `railway` varchar(100) DEFAULT NULL,
  `airport_proximity` numeric(4,1) NOT NULL,
  PRIMARY KEY (`area_name`),
  CONSTRAINT `fk_area_name_transport` FOREIGN KEY (`area_name`) REFERENCES `location` (`area_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `transport` WRITE;

INSERT INTO `transport` VALUES 
('Hebbal','BMTC Hebbal Depot, Bethel Chruch, Sultan Pallya, Hebbal Kempappura, Hebbal bridge',NULL,'Hebbal Railway Station',27.7),
('Jalahalli','Jalahalli corss, Jalahalli Village, Jalahalli east, Jalahalli Village gate, Airforce station','Jalahalli',NULL,30),
('Mathikere','Mathikere bus stop, MSR Hospital, Divanara palya',NULL,NULL,29.3),
('Peenya','Peenya 1st Stage, Peenya Metro Station, Peenya Industrial Estate, Peenya Junction','Peenya, Peenya Industry',NULL,34.4),
('RT Nagar','RT Nagar Bus Stop, RT Nagar Circle, Royal Towers, Rainbow Avenue, Radiant Park',NULL,NULL,27.9),
('Yelahanka','Yelahanka Bus Stand, Yelahanka New Town, Yelahanka Lake View, Yelahanka Central',NULL,NULL,16.3),
('Yeshwantpur', 'Taj Yeshwantpur, Yeshwantpur Metro, Yeshwantpur Market, Yeshwantpur Railway Station','Yeshwantpur, Yeshwantpur Industry','Yeshwantpur Railway Station',32.5),
('Banaswadi', 'Sevanagar, Jaibharat Nagar, ITC',NULL,'Banaswadi Railway Station, Bangalore East',33.6),
('Horamavu', 'Horamavu Bus Station, Horamavu Market, Horamavu Railway Station',NULL,NULL,25.9),
('Kalyan Nagar', 'Kalyan Nagar Bus Station, Kalyan Nagar Market, Kalyan Nagar Lake',NULL,NULL,31.6),
('Kammanahalli', 'Kammanahalli Bus Station, Kammanahalli Circle, Ring Road',NULL,NULL,32.3),
('Lingarajapuram', 'Lingarajapuram Bus Station, Lingarajapuram Market, Lingarajapuram Temple',NULL,NULL,32.9),
('Ramamurthy Nagar', 'Ramamurthy Nagar Bus Station, Ramamurthy Nagar Market',NULL,NULL,29.9),
('Bellandur', 'Bellandur Bus Station, Bellandur Market, Bellandur IT Park',NULL,'Bellandur Railway Station',47.7),
('CV Raman Nagar', 'CV Raman Nagar Bus Station, CV Raman Nagar Market, CV Raman Nagar Lake','Benniganahalli',NULL,40.7),
('Hoodi', 'Hoodi Circle, Rajapalya, Kothanur',NULL,NULL,22.5),
('KR Puram', 'KR Puram Bus Station, KR Puram Market, KR Puram Metro Station','Tin Factory, KR Puram','KR Puram Railway Station',34.1),
('Mahadevapuram', 'Mahadevapuram Bus Station, Phoenix Marketcity, Mahadevapuram Temple','Seetharampallya, Singayyanapalya, Garudacharpalya',NULL,32.7),
('Marathahalli', 'Marathahalli Bus Station, Marathahalli Market, Marathahalli IT Park',NULL,NULL,43.4),
('Varthur', 'Varthur Bus Station, Varthur Market, Varthur Lake',NULL,NULL,41.3),
('Whitefield', 'Whitefield Bus Station, Whitefield Market, Whitefield IT Park','Whitefield, Kadugodi Tree Park, Hopefarm, Pattandur Agrahara','Whitefield Railway Station',40.1),
('Bommanahalli', 'Bommanahalli Bus Station, Bommanahalli Market',NULL,NULL,42.8),
('Bommasandra', 'Bommasandra Bus Station, Bommasandra Market, Bommasandra IT Park',NULL,NULL,54.7),
('BTM Layout', 'Kuvempunagara, Mico Layout',NULL,NULL,42.3),
('Electronic City', 'Electronic City Bus Station, Electronic City Market, Electronic City IT Park',NULL,NULL,51.2),
('HSR Layout', 'HSR Bus Station, HSR Market, Silk Board',NULL,NULL,46.6),
('Koramangala', 'Koramangala Bus Stop, Koramangala Circle',NULL,NULL,39.8),
('Madiwala', 'Madiwala Bus Station, Madiwala Market',NULL,NULL,39.8),
('Sarjapur', 'Sarjapur Bus Station, Sarjapur Market, Sarjapur IT Park',NULL,NULL,46.7),
('Banashankari', 'Banashankari Bus Station, Banashankari Market, Banashankari Temple','Banashankari',NULL,54.4),
('Basavanagudi', 'Basavanagudi Bus Station, Basavanagudi Market, Basavanagudi Temple','National College, Lalbagh, South End',NULL,32.7),
('Girinagar', 'Girinagar Bus Station, Girinagar Market, Girinagar College',NULL,NULL,41.8),
('JP Nagar', 'JP Nagar 3rd Stage, Konakunte Cross, JP Nagar Metro','JP Nagar, Yelachenahalli, Konakunte Cross',NULL,41.9),
('Jayanagar', 'RV Road, Jayanagar Main, Jayanagar Metro','Jayanagar, RV Road',NULL,43.2),
('Uttarahalli', 'Uttarahalli Bus Stop, Water Tank, Chikkalasandra Bank Colony',NULL,NULL,41.9),
('Bannerghatta', 'Bannerghatta Circle, Bannerghatta National Park, Kalena Agrahara',NULL,NULL,69),
('Basaveshwaranagar', 'Basaveshwaranagar Bus Stop, Basaveshwaranagar Market, Basaveshwaranagar Temple',NULL,NULL,35.8),
('Kengeri', 'Kengeri Bus Terminal, Kengeri Bus Depot, Kengeri Metro','Kengeri, Kengeri Bus Terminal',NULL,54.2),
('Mahalakshmi Layout', 'Mahalakshmipuram, Mahalakshmi Layout Metro, Mahalakshmipuram 2nd Stage','Mahalakshmi Layout',NULL,32.8),
('Nagarbhavi', 'Nagarbhavi Circle, NGEF Layout, Nagarbhavi Village, 12th Block',NULL,NULL,38.9),
('Nayandahalli', 'Nayandahalli Junction, PES, Nayandahalli Metro, Mysore Road Metro','Nayandahalli, Mysore Road, Deepanjali Nagar',NULL,42.6),
('Rajajinagar', 'Rajajinagar 1st Block, Rajkumar Road, Rajajinagar Metro, Dhobi Ghat','Rajajinagar, Sandal Soap Factory',NULL,33.6),
('RR Nagar', 'RR Gate, Pattanagere, RR Nagar Temple','RR Nagar, Jnanabharati',NULL,47.2),
('Vijayanagar', 'Deepanjali Nagar, Attigupe Metro, Vijayanagar Metro Station','Vijaynagar, Attigupe',NULL,40.1),
('Cantonment Area', 'Coles Park, Cantonment Railway Station',NULL,'Cantonment Railway Station',31.8),
('Domlur', 'Domlur Bus Stop, Domlur Market',NULL,NULL,39),
('Indiranagar', 'Swami Vivekananda Road, 100ft Road, Indiranagar Metro Station','Swami Vivekananda, Indiranagar','Byapanahalli Railway Station',36.7),
('Ulsoor', '1 MG, Ulsoor Metro Station, Ulsoor Lake','Halasuru, Trinity',NULL,34.9),
('Malleshwaram', 'Malleshwaram Railway Station, Malleshwaram 18th Cross, Malleshwaram Circle','Srirampura, Mantri Square, Kuvempu','Malleshwaram Railway Station',30.5),
('Pete Area', 'Majestic Bus Stop, KR Market, Central Railway Station','Majestic, KR Market, Chikepete, KSR Railway Stations','Bangalore City Railway Station',33.3),
('Seshadripuram', 'Seshadripuram Bus Station, Seshadripuram Market, Seshadripuram Temple',NULL,NULL,31.9),
('Shivajinagar','Shivajinagar Bus Station, Shivajinagar Market',NULL,NULL,32.7),
('Vasanth Nagar', 'Cunningham Road, Vasanth Nagar, Vidhan Soudha, Indian Express','Vidhan Soudha',NULL,31.5),
('Shanti Nagar', 'MG Road, Residency Road, Shanti Nagar Temple','Cubbon Park, MG Road',NULL,36.9)
;

UNLOCK TABLES;


DROP TABLE IF EXISTS `architectural_heritage`;

CREATE TABLE `architectural_heritage` (
  `area_name` varchar(100) NOT NULL,
  `science_and_art` varchar(100) DEFAULT NULL,
  `gov_office` varchar(100) DEFAULT NULL,
  `temples` varchar(100) DEFAULT NULL,
  `churches` varchar(100) DEFAULT NULL,
  `mosques` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`area_name`),
  CONSTRAINT `fk_area_name_ah` FOREIGN KEY (`area_name`) REFERENCES `location` (`area_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



LOCK TABLES `architectural_heritage` WRITE;

INSERT INTO `architectural_heritage` VALUES 
('Hebbal',NULL,NULL,'Sri Ananda Lingeshwara Temple','Masjid-e-Azam','Bethel Church'),
('Jalahalli',NULL,NULL,NULL,'Masjid-e-Yaseen',NULL),
('Mathikere',NULL,NULL,NULL,'Masjid - E - Taha','St Sebastians Forane Church'),
('Peenya',NULL,NULL,'Sri Anjaneya Swamy Temple',NULL,'C.S.I Holy Cross Tamil Church'),
('RT Nagar',NULL,NULL,'Shree Venkateshwara Swamy Temple',NULL,'Shrine of St. Jude Thaddeus'),
('Yelahanka','Ramaneeya Museum',NULL,'Sri VeerAnjaneya Swamy Temple','Jamia masjid','Holy Rosary Church'),
('Yeshwantpur','Bangalore Creative Circus',NULL,'Shiva Temple','Jamia Masjid','Shalom Faith Church'),
('Banaswadi',NULL,NULL,'Panchamukhi Ganesha Temple','Masjid AlKhair','Ascension Church'),
('Horamavu',NULL,NULL,'Patalamma Temple','Musallah o Madrasa e Khwajah','Jubilee Revival AG Church'),
('Kalyan Nagar',NULL,NULL,'Anjaneya Swami Temple','Masjid-E-Asra','New Jerusalem Church'),
('Kammanahalli',NULL,NULL,'Om Shakthi Temple',NULL,'St. Pius X Church Roman Catholic Church'),
('Lingarajapuram',NULL,NULL,NULL,'Masjid-E-Abdul Malik','Don Bosco Church'),
('Ramamurthy Nagar',NULL,NULL,'Sri Kodandarama Swami Temple','Makkah Masjid','Holy Family Church'),
('Bellandur',NULL,NULL,'Sri Venkateswara Swamy Temple Bellandur','Masjid E Bila',NULL),
('CV Raman Nagar',NULL,NULL,'Shivoham Shiva Temple',NULL,'Philadelphia Prayer Church'),
('Hoodi',NULL,NULL,NULL,'Masjid Al Huda','Kothanur CSI Church'),
('KR Puram','Verde Canvas Art Gallery',NULL,'Sri Sundara Anjaneya Swamy Temple','Masjid-e-Bila',NULL),
('Mahadevapuram',NULL,NULL,'Sri Manjunatheswara Temple',NULL,'Ebenezer Ministries'),
('Marathahalli','HAL Aerospace Museum',NULL,'Shivoham Shiva Temple','Masjid-e-Ameena','Mar Yuhanon Mamdana Orthodox CHURCH'),
('Varthur',NULL,NULL,'Sri Channaraya Swamy Temple',NULL,'El Bethel Church Varthur'),
('Whitefield',NULL,NULL,'Sri Veeranjaneyaswami Temple','Masjid-E-Noor','Our Lady Of Lourdes Church Pattandur Agrahara'),
('Bommanahalli',NULL,NULL,'Sri Mahadeshwaramma Devi Temple','amia Masjid','St. Marys Church'),
('Bommasandra',NULL,NULL,NULL,'Noorani Masjid','E.C.I. Hope Church'),
('BTM Layout',NULL,NULL,'Ragigudda Sri Prasanna Anjaneyaswamy Temple',NULL,'Bethany Baptist Church'),
('Electronic City',NULL,'Begur Fort','Thimmarayaswamy Fort Temple','Masjid Maimun-O-Shams',NULL),
('HSR Layout',NULL,NULL,'Jagannath Temple',NULL,'River of Life Christian Church'),
('Koramangala',NULL,NULL,'Shri Panchamukhi Anjaneya Temple','Masjid E Mamoor','Koramangala Methodist Church'),
('Madiwala',NULL,NULL,'Angala Parameswari Temple','Jamia Masjid','Zion A.G Church'),
('Sarjapur',NULL,NULL,NULL,'Masjid-E-Jadeed','Our Lady of the Sacred Heart Church'),
('Banashankari',NULL,NULL,'Banashankari Amma Temple',NULL,NULL),
('Basavanagudi',NULL,NULL,'Bull Temple',NULL,'Christ Church'),
('Girinagar',NULL,NULL,'Sri Karya Siddhi Anjaneya Swamy Temple','Masjid-E-Asra','Girinagar Church'),
('JP Nagar','Indian Music Experience Museum',NULL,NULL,NULL,'C.S.I Christha Krupalaya Church'),
('Jayanagar',NULL,NULL,'Kote Venkataramana Temple','Jamia Masjid',NULL),
('Uttarahalli',NULL,NULL,'Vasantha Vallabharaya Temple',NULL,NULL),
('Bannerghatta',NULL,NULL,'Hulimavu cave temple','Masjid-e-Aala','Immaculate Heart of Mary Church'),
('Basaveshwaranagar',NULL,NULL,'Sri Ganapathi Temple','Jamia Masjid',NULL),
('Kengeri',NULL,NULL,'Dwadarsha Jyotirlinga','Jamia Masjid','C.S.I Shalom Church - Kengeri'),
('Mahalakshmi Layout',NULL,NULL,'Sri Mookambika Bhakta Mandali',NULL,'Mahalakshmipura Christ Church'),
('Nagarbhavi','Brain Museum',NULL,'Shree Male Mahadeshwara Swamy temple','Masjid-E-Noor',NULL),
('Nayandahalli',NULL,NULL,NULL,'Masjid-E-Asra','St. Anthonys Church'),
('Rajajinagar',NULL,NULL,'ISCON Temple','Masjid-E-noor','Assumption Church'),
('RR Nagar',NULL,NULL,'Rajarajeshwari Temple',NULL,'The Winners Church'),
('Vijayanagar','Sri Vani Science Park',NULL,'Shri Kailaseshwara Swami Temple','Masjid E Munawwara',NULL),
('Cantonment Area',NULL,NULL,'Shri Shivana Temple','The Jumma Masjid','St. Francis Xaviers Church'),
('Domlur',NULL,NULL,'The Chokkanathaswamy Temple','Masjid Al Hafeez','Hope Church of the Nazarene'),
('Indiranagar',NULL,NULL,'Sri Kondaramaswamy Temple','Makkah Masjid','Indiranagar Methodist Church'),
('Ulsoor','Rezwan Museum of Indian Paper Money',NULL,'Sri Someshwara Swamy Temple',NULL,'Holy Trinity Church'),
('Malleshwaram','Karnataka Chitrakala Parishat','Bangalore Palace','Kadu Malleshwara Temple','Jamia Masjid','Christ The King Church'),
('Pete Area',NULL,'Tipu Sultan Fort','Gavi Gangadheshwara Temple','Jamia Masjid','C.S.I St. Matthews Church'),
('Seshadripuram','Jawaharlal Nehru Planetarium',NULL,'Sri Annamma Devi Temple','Masjid-e-Qhadeem','I.U.E.M Church'),
('Shivajinagar','Kashmir Art Gallery',NULL,'Shri Ram Temple','Haji Sir Ismail Sait Mosque','St. Marys Basilica'),
('Vasanth Nagar','National Gallery of Modern Art','Vidhan Soudha','Shrungagiri Sri Shanmuka Temple','Masjid E Khadria','St.Annes Chapel'),
('Shanti Nagar','Visveswaraya Industrial and Technological Museum',NULL,'Prasaneshwara Swamy Devasthana','Masjid-E-Khizar','St Marks Cathedral')
;

UNLOCK TABLES;

/*function to calculate future price price_range*/
DROP FUNCTION IF EXISTS CalculateFuturePrice;
DELIMITER $$
CREATE FUNCTION CalculateFuturePrice(areaName VARCHAR(100)) RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE futurePrice DECIMAL(10, 2);
    DECLARE priceRange DECIMAL(10, 2);
    DECLARE growthRate DECIMAL(5, 2);

    -- Fetch the priceRange and growthRate based on area_name
    SELECT price_range, growth_rate
    INTO priceRange, growthRate
    FROM property
    WHERE area_name = areaName;

    IF growthRate IS NULL THEN
        SET futurePrice = priceRange;
    ELSE
        SET futurePrice = priceRange + (priceRange * (growthRate / 100));
    END IF;

    RETURN futurePrice;
END$$
DELIMITER ;


/*trigger to prevent updating property price_range to below 2500*/
DELIMITER //
CREATE TRIGGER check_property_update
BEFORE UPDATE ON property
FOR EACH ROW
BEGIN
    IF NEW.price_range < 2500 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'TRIGGER: Price range cannot be updated to be below 2500';
    END IF;
END;
//
DELIMITER ;


/*procedure for transportation details*/
DROP PROCEDURE IF EXISTS OrderAreasByAirportProximity;
DELIMITER $$
CREATE PROCEDURE OrderAreasByAirportProximity()
BEGIN
    SELECT t.area_name, t.airport_proximity_in_km,
           IFNULL(t.metro, 'No') AS metro_available,
           IFNULL(t.railway, 'No') AS railway_available,
           IFNULL(t.bus_stops, 'No') AS bus_stops_available
    FROM transport t
    ORDER BY t.airport_proximity_in_km;
END$$
DELIMITER ;

CREATE TRIGGER validate_property_type
BEFORE INSERT ON property
FOR EACH ROW
BEGIN
    IF NEW.property_type NOT IN ('Apartments', 'Villas', 'Independent Houses') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid property type';
    END IF;
END;


/*simple queries*/
SELECT area_name FROM safety_and_security WHERE crime_rate = 'High';

SELECT area_name, population_density FROM demography WHERE cultural_diversity = 'Hindu';

SELECT area_name FROM external_factors WHERE aqi = 'Very Poor';

SELECT area_name, property_type FROM property WHERE rental_rate = (SELECT MIN(rental_rate) FROM property);

/*nested queries*/
SELECT area_name 
FROM transport 
WHERE airport_proximity > (
    SELECT AVG(airport_proximity)
    FROM transport 
    WHERE area_name IN (
        SELECT area_name 
        FROM safety_and_security 
        WHERE crime_rate = 'High'
      )
    );

SELECT l.area_name, d.population_density 
FROM location l 
JOIN demography d ON l.area_name = d.area_name 
WHERE d.population_density > (
    SELECT AVG(population_density)
    FROM demography
)AND l.area_name IN (
    SELECT DISTINCT i.area_name 
    FROM infrastructure i 
    WHERE i.schools IS NOT NULL AND i.hospitals IS NOT NULL AND i.colleges IS NOT NULL AND i.malls IS NOT NULL
    );


/*correlated queries*/
SELECT p1.area_name, p1.growth_rate 
FROM property p1 INNER JOIN location l ON p1.area_name = l.area_name 
WHERE p1.growth_rate > (
    SELECT AVG(p2.growth_rate)
    FROM property p2 INNER JOIN location l2 ON p2.area_name = l2.area_name 
    WHERE l2.division = l.division);

SELECT ss.area_name FROM safety_and_security ss 
WHERE ss.crime_rate = 'High' AND NOT EXISTS (
    SELECT *FROM infrastructure i WHERE i.area_name = ss.area_name AND i.hospitals IS NOT NULL);


/*aggregate queries*/
SELECT division, AVG(population_density) AS avg_density
FROM location l
JOIN demography d ON l.area_name = d.area_name
GROUP BY division
HAVING avg_density > 27;

SELECT property_type, AVG(price_range) AS avg_price_range 
FROM property 
GROUP BY property_type 
HAVING avg_price_range > 9000;



