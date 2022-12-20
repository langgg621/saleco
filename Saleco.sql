IF (OBJECT_ID('V_CODE', 'F') IS NOT NULL) ALTER TABLE dbo.ORDER1 DROP CONSTRAINT V_CODE ;
IF (OBJECT_ID('CUS_CODE', 'F') IS NOT NULL) ALTER TABLE dbo.INVOICE DROP CONSTRAINT CUS_CODE;
IF (OBJECT_ID('EMP_CODE', 'F') IS NOT NULL) ALTER TABLE dbo.INVOICE DROP CONSTRAINT EMP_CODE;
IF (OBJECT_ID('ORD_NUM', 'F') IS NOT NULL) ALTER TABLE dbo.ORD_LINE DROP CONSTRAINT ORD_NUM;
IF (OBJECT_ID('DIS_CODE', 'F') IS NOT NULL) ALTER TABLE dbo.INV_LINE DROP CONSTRAINT DIS_CODE;
IF (OBJECT_ID('INV_NUM', 'F') IS NOT NULL) ALTER TABLE dbo.INV_LINE DROP CONSTRAINT INV_NUM;
IF (OBJECT_ID('P_CODEinv', 'F') IS NOT NULL) ALTER TABLE dbo.INV_LINE DROP CONSTRAINT P_CODEinv;
IF (OBJECT_ID('P_CODE1', 'F') IS NOT NULL) ALTER TABLE dbo.DISCOUNT DROP CONSTRAINT P_CODE1;
IF (OBJECT_ID('P_CODE', 'F') IS NOT NULL) ALTER TABLE dbo.ORD_LINE DROP CONSTRAINT P_CODE;
DROP TABLE IF EXISTS dbo.VENDOR;
DROP TABLE IF EXISTS dbo.ORDER1;
DROP TABLE IF EXISTS dbo.PRODUCT;
DROP TABLE IF EXISTS dbo.ORD_LINE;
DROP TABLE IF EXISTS dbo.CUSTOMER;
DROP TABLE IF EXISTS dbo.INVOICE;
DROP TABLE IF EXISTS dbo.INV_LINE;
DROP TABLE IF EXISTS dbo.EMPLOYEE;
DROP TABLE IF EXISTS dbo.DISCOUNT;

CREATE TABLE VENDOR (
    V_CODE INT PRIMARY KEY,
    V_NAME VARCHAR(50),
    V_CONTACT VARCHAR(20),
    V_AREACODE INT,
    V_PHONE VARCHAR(8),
    V_ORDER VARCHAR(1)
);
INSERT INTO VENDOR(V_CODE, V_NAME, V_CONTACT, V_AREACODE, V_PHONE, V_ORDER) VALUES
(21225,	'Bryson.Inc',           'Simmon',   615,	'223-2234', 'Y'),
(21226,	'SuperLeo.Inc',         'Pluking',  904,	'215-8995', 'N'),
(21231,	'OSB Supply',           'Singh',    615,	'224-2245', 'N'),
(21323,	'NAM VIET ET CO .,LTD',	'Donald',   311,	'888-6656', 'Y'),
(21344,	'Oomez Ente',           'Ortega',   615,	'889-2546', 'N'),
(22567,	'Oone Supply',          'Smith',    901,	'678-1419', 'N'),
(23119,	'Randsets Ltd',         'Anderson', 901,	'678-3936', 'Y'),
(23121,	'CIDE .,JSC',           'Alexander',121,	'645-4565', 'N'),
(24266,	'C&DVA Inc',            'Brewing',  615,	'228-1410', 'N'),
(24804,	'Brackman Bros',        'Huskford', 615,	'898-1234', 'Y'),
(25443,	'B&H.Inc',              'Smith',    904,	'227-0083', 'Y'),
(26601,	'Onal Supplies',        'Sneythe',  615,	'898-3629', 'N'),
(29595,	'Rubicon Systems',      'Orion',    904,	'456-0092', 'Y'),
(32121,	'NICESPACES CO., LTD',	'Matthew',  313,	'234-2344', 'N'),
(32242,	'TAGENCY CO.,LTD',      'Philip',   321,	'423-2344', 'N'),
(34343,	'BMT TPC CO .,LTD',     'Louis',    211,	'234-4111', 'N'),
(34423,	'Food Quest',           'Joyce',    211,	'234-5654', 'Y'),
(34535,	'Hungry Helpers',       'Kathleen', 121,	'645-4544', 'N'),
(42342,	'BMS NEW .,JSC',        'Louis',    311,	'888-3211', 'N'),
(42442,'The Flavor of Home',	'Judy',     332,	'353-4222', 'N'),
(43422,	'Family Secret Recipe',	'Ruth',     322,	'435-3524', 'Y'),
(65446,	'Vintage Food',         'Nicole',   322,	'786-5353', 'Y');
GO
CREATE TABLE ORDER1 ( 
    ORD_NUM INT PRIMARY KEY,
    V_CODE INT,
    ORD_DATE TIME,
    CONSTRAINT V_CODE FOREIGN KEY(V_CODE) REFERENCES VENDOR(V_CODE)
);
INSERT INTO ORDER1( ORD_NUM,	ORD_DATE,	V_CODE) VALUES
(2001,	'05-Mar-17',	29595),
(2002,	'06-Mar-17',	21225),
(2003,	'27-Jan-17',	23119),
(2004,	'13-Nov-17',	65446),
(2005,	'17-Mar-23',	34423),
(2006,	'08-Nov-17',	43422),
(2007,	'13-Sep-17',	21231),
(2008,	'17-Feb-17',	25443),
(2009,	'09-Oct-17',	24804);
GO
CREATE TABLE PRODUCT(
    P_CODE VARCHAR(10) PRIMARY KEY,
    P_NAME VARCHAR(20),
    P_INDATE DATE,
    P_QOH INT,
    P_MIN INT,
    P_PRICE FLOAT(8),
    P_TYPE VARCHAR(20)
);
INSERT INTO PRODUCT(P_CODE,	P_INDATE,	P_NAME,	P_QOH,	P_MIN,	P_PRICE,	P_TYPE) VALUES
('D432NJUE',	'2017-3-5',	'Dishwasher',   	14, 5,	'65.43',	'Electronic device'),
('HUFD324W',	'2017-3-5',	'Clothes dryer',	9,	3,	'89.8',	'Electronic device'),
('JDS345MK',	'2017-3-5',	'Electric fan', 	34,	10,	'30.3',	'Electronic device'),
('JFHEW23',	    '2017-3-6',	'Blender',          10, 3,	'45.4',	'Electronic device'),
('JFIE32NJ',	'2017-3-6',	'Aircondition', 	23,	6,	'64.3',	'Electronic device'),
('KFSDJ342',	'2017-3-6',	'Heater',           23,	8,	'76.55',	'Electronic device'),
('KGDSF34F',	'2017-1-27',	'Hair dryer',   	10,	5,	'12.34',	'Electronic device'),
('SRE-657UO',	'2017-1-27',	'Power plant',  	8,	5,	'109.99',	'Electronic device'),
('ZZX3245Q',	'2017-1-27',	'Light bulb',   	32,	12,	'14.95',	'Electronic device'),
('123-21UUY',	'2017-11-13',	'Milks',            12,	5,	'5.99',	'Food'),
('DJFW394W',	'2017-3-23',	'Jam',          	23,	2,	'35.4',	'Food'),
('EWRION23',	'2017-11-13',	'Bread',        	12,	3,	'0.32',	'Food'),
('FDSJ23NJ',	'2017-11-13',	'Cheese',       	33,	12,	'2.1',	'Food'),
('FSFE-2342',	'2017-3-23',	'Meat',             12,	3,	'12',     'Food'),
('HUEEEW24',	'2017-11-13',	'Butcher',      	20,	5,	'2.3',	'Food'),
('SDF-457YU',	'2017-11-8',	'Snacks',           33,	10,	'0.5',	'Food'),
('JDSFK23A',	'2017-3-1',	'Cushion',          31,	12,	'23.23',	'Make up'),
('KEJW230J',	'2017-3-17',	'Lipstick',     	21,	12,	'31.12',	'Make up'),
('UEHRW21',	    '2017-3-12',	'Bronzer',          34,	29,	'23.2',	'Make up'),
('001278-AB',	'2017-10-9',	'Nails',            15,	8,	'0.99',	'Tool'),
('FHUIEW23',	'2017-10-9',	'Screwdrivers', 	102,30,	'0.21',	'Tool'),
('QER-34258',	'2017-10-9',	'Chainsaw',         18,	12,	'199.99',	'Tool');
GO
CREATE TABLE ORD_LINE(
    ORD_NUM INT ,
    ORD_LINE_NUM INT ,
    P_CODE VARCHAR(10),
    ORD_LINE_UNITS INT,
    PRIMARY KEY (ORD_NUM, ORD_LINE_NUM),
    CONSTRAINT ORD_NUM FOREIGN KEY (ORD_NUM) REFERENCES ORDER1(ORD_NUM),
    CONSTRAINT P_CODE FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE)
);
INSERT INTO ORD_LINE(ORD_NUM,	ORD_LINE_NUM,	P_CODE,	ORD_LINE_UNITS) VALUES
(2001,	1,	'D432NJUE',	5),
(2001,	2,	'HUFD324W',	3),
(2001,	3,	'JDS345MK',	1),
(2002,	1,	'JFHEW23',  1),
(2002,	2,	'JFIE32NJ',	2),
(2002,	3,	'KFSDJ342',	3),
(2003,	1,	'KGDSF34F',	3),
(2003,	2,	'SRE-657UO',2),
(2003,	3,	'ZZX3245Q',	3),
(2004,	1,	'123-21UUY',6),
(2004,	2,	'FDSJ23NJ',	3),
(2004,	3,	'HUEEEW24',	4),
(2005,	1,	'DJFW394W',	4),
(2005,	2,	'FSFE-2342',2),
(2006,	1,	'SDF-457YU',3),
(2007,	1,	'EWRION23',	1),
(2008,	1,	'JDSFK23A',	8),
(2008,	2,	'KEJW230J',	10),
(2008,	3,	'UEHRW21',   8),
(2009,	1,	'001278-AB',3),
(2009,	2,	'FHUIEW23',	10),
(2009,	3,	'QER-34258',10);
GO
CREATE TABLE DISCOUNT(
    P_CODE  VARCHAR(10),
    DIS_CODE INT ,
    DIS_CONDITION VARCHAR(20),
    DIS_PERCENTAGE FLOAT(8),
    DIS_TIME TIME,
    PRIMARY KEY (P_CODE, DIS_CODE),
    CONSTRAINT P_CODE1 FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE)
);
INSERT INTO DISCOUNT(P_CODE,	DIS_CODE,	DIS_CONDITION,	DIS_PERCENTAGE,	DIS_TIME) VALUES
('KEJW230J',	40027,	'Women Day',	    '7',	'2017-3-8'),
('JDS345MK',	40026,	'Women Day',	    '10',	'2017-3-8'),
('FSFE-2342',	40021,	'Black-Friday',	    '5',	'2017-11-28'),
('HUFD324W',	40028,	'Black-Friday',	    '20',	'2017-11-28'),
('123-21UUY',	40022,	'Black-Friday',	    '2',	'2017-11-29'),
('D432NJUE',	40029,	'Black-Friday', 	'15',	'2017-11-30'),
('JFIE32NJ',	40023,	'Christmas',    	'3',	'2017-12-24'),
('JDSFK23A',	40025,	'Christmas',	    '40',	'2017-12-25'),
('FSFE-2342',	40024,	'Christmas',	    '23',	'2017-12-25');
GO
CREATE TABLE EMPLOYEE(
    EMP_CODE INT PRIMARY KEY,
    EMP_NAME VARCHAR(50),
    EMP_DOB DATE,
    EMP_GENDER VARCHAR(1),
    EMP_MANAGER INT
);
INSERT INTO EMPLOYEE(EMP_CODE,	EMP_NAME,	EMP_GENDER,	EMP_DOB,	EMP_MANAGER) VALUES
(100001,	'James',	'M',	'1999-6-15',	100004),
(100002,	'Smith',	'M',	'1998-12-13',	100004),
(100003,	'John',	'M',	'1988-6-4',	100004),
(100004,	'Marry',	'F',	'1980-12-13',	100006),
(100005,	'Gomez',	'M',	'1997-1-3',	100008),
(100006,	'Isabella','F',	'1981-2-3',	NULL),
(100007,	'Kayla',	'F',	'1987-12-3',	100008),
(100008,	'Brittany','F',	'1984-7-6',	100006),
(100009,	'Juan',	'M',	'1985-5-15',	100010),
(100010,	'Gabriel','M',	'1986-6-05',	100006),
(100011,	'Marie',	'F',	'1995-5-3',	100010),
(100012,	'Sophia',	'F',	'1983-5-5',	100010),
(100013,	'Joe',	'M',	'1993-7-23',	100008),
(100014,	'Willie',	'M','1996-5-26',	100010);
GO
CREATE TABLE CUSTOMER(
    CUS_CODE INT PRIMARY KEY,
    CUS_LNAME VARCHAR(20),
    CUS_FNAME VARCHAR(20),
    CUS_INITIAL CHAR,
    CUS_AREACODE INT,
    CUS_PHONE VARCHAR(8),
    CUS_BALANCE NUMERIC(9,2) 
);
INSERT INTO CUSTOMER(CUS_CODE,	CUS_LNAME,	CUS_FNAME,	CUS_INITIAL,	CUS_AREACODE,	CUS_PHONE,	CUS_BALANCE) VALUES
(10010,	'Ramas',	    'Albefred',	'A',	615,	'844-2573',	0),
(10011,	'Dunno',	    'Leoba',    'K',	713,	'894-1238',	0),
(10012,	'Smith',	    'Katthy',   'W',	615,	'894-2295',	345.86),
(10013,	'Gtiowati',	    'Paul',	    'F',	615,	'894-2180',	538.75),
(10014,	'Grianado',	    'Myron',	'',     615,	'222-1672',	0),
(10015,	'Ofhrian',	    'Amy',	    'B',	713,	'442-3381',	0),
(10016,	'Ethwin',	    'James',    'G',	615,	'297-1228',	221.19),
(10017,	'Williams',	    'George',	'',     615,	'290-2588',	788.93),
(10018,	'Fannes', 	    'Annie',    'G',	713,	'382-7185',	216.55),
(10019,	'Smith',	    'Olive',    'K',	615,	'297-3809',	0),
(10020,	'Adams',	    'John',		 '',       123,	'423-4533',	313.12),
(10021,	'Roberts',	    'Micheal',		'',    233,	'432-3243',	123.42),
(10022,	'Campbell',	    'Adela',    'D',	233,	'324-5345',	32.43),
(10023,	'Dyson',	    'Acacia',		 '',   324,	'323-3433',	34.2),
(10024,	'Gtiowati',	    'John',	    'E',	123,    '543-4534',	344.23),
(10025,	'Taylor',	    'Adriel',	   '' ,	123,	'232-3242',	345.65),
(10026,	'Moore',	    'Max'	,	    '' ,   324,	'787-6554',	436.56),
(10027,	'Miller',	    'Ashton',		 '' ,  345,	'645-6456',	5543.3),
(10028,	'Jones',	    'Daisy',    'D',    345,		   ''    , 0),
(10029,	'Miller',	    'Reese',		  '' , 615,	'324-6867',	56.45),
(10030,	'Smith',	    'Thisga',   'W',	324,	'435-6564',	35.34);
GO
CREATE TABLE INVOICE(
    INV_NUM INT PRIMARY KEY,
    CUS_CODE INT,
    INV_DATE TIME,
    EMP_CODE INT,
    CONSTRAINT CUS_CODE FOREIGN KEY (CUS_CODE) REFERENCES CUSTOMER(CUS_CODE),
    CONSTRAINT EMP_CODE FOREIGN KEY (EMP_CODE) REFERENCES EMPLOYEE(EMP_CODE)
);
INSERT INTO INVOICE(INV_NUM,	CUS_CODE,	INV_DATE,	EMP_CODE) VALUES 
(1801,	10012,	'2017-1-16',	100014),
(1802,	10013,	'2017-1-16',	100005),
(1803,	10016,	'2017-1-17',	100008),
(1804,	10017,	'2017-1-17',	100007),
(1805,	10018,	'2017-1-17',	100011),
(1806,	10020,	'2017-1-17',	100013),
(1807,	10021,	'2017-1-17',	100003),
(1808,	10022,	'2017-1-17',	100014),
(1809,	10023,	'2017-3-8',	100012),
(1810,	10024,	'2017-1-20',	100007),
(1811,	10025,	'2017-1-21',	100010),
(1812,	10026,	'2017-1-21',	100005),
(1813,	10027,	'2017-1-30',	100008),
(1814,	10029,	'2017-2-4',	100001),
(1815,	10012,	'2017-2-5',	100013),
(1816,	10013,	'2017-2-6',	100003),
(1817,	10016,	'2017-2-7',	100009),
(1818,	10017,	'2017-3-8',	100007),
(1819,	10018,	'2017-3-8',	100012),
(1825,	10020,	'2017-3-8',	100013),
(1826,	10021,	'2017-3-8',	100011),
(1827,	10022,	'2017-3-8',	100010),
(1828,	10023,	'2017-11-28',	100005),
(1829,	10024,	'2017-11-28',	100004),
(1830,	10025,	'2017-11-28',	100001),
(1831,	10026,	'2017-11-28',	100013),
(1837,	10027,	'2017-11-29',	100013),
(1838,	10029,	'2017-11-29',	100003),
(1839,	10012,	'2017-11-29',	100013),
(1840,	10013,	'2017-11-29',	100011),
(1841,	10016,	'2017-11-30',	100010),
(1842,	10017,	'2017-12-1',	100005),
(1843,	10018,	'2017-12-6',	100005),
(1844,	10020,	'2017-12-7',	100009),
(1845,	10021,	'2017-12-8',	100010),
(1846,	10022,	'2017-12-17',	100007),
(1847,	10023,	'2017-12-20',	100003),
(1848,	10024,	'2017-12-24',	100013),
(1849,	10025,	'2017-12-24',	100011),
(1850,	10026,	'2017-12-25',	100010),
(1851,	10027,	'2017-12-25',	100005);
GO
CREATE TABLE INV_LINE(
    INV_NUM INT ,
    LINE_NUM INT ,
    P_CODE  VARCHAR(10),
    LINE_UNITS INT,
    DIS_CODE INT,
    PRIMARY KEY (INV_NUM, LINE_NUM),
    CONSTRAINT INV_NUM FOREIGN KEY (INV_NUM) REFERENCES INVOICE(INV_NUM),
    CONSTRAINT P_CODEinv FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE)
);
INSERT INTO INV_LINE(INV_NUM,	LINE_NUM,	P_CODE,	LINE_UNITS,		DIS_CODE) VALUES

(1801,	1,	'D432NJUE',	3,  NULL),
(1801,	2,	'001278-AB',4,  NULL),	
(1801,	3,	'123-21UUY',4,  NULL),
(1802,	1,	'D432NJUE',	3,  NULL),
(1803,	1,	'DJFW394W',	2,	NULL),
(1804,	1,	'EWRION23',	4,	NULL),
(1805,	1,	'FDSJ23NJ',	3,	NULL),
(1806,	1,	'FHUIEW23',	2,	NULL),
(1807,	1,	'FSFE-2342',3,	NULL),
(1808,	1,	'HUEEEW24',	4,	NULL),
(1809,	1,	'HUFD324W',	4,	NULL),
(1809,	2,	'JDS345MK',	3,	40026),
(1809,	3,	'JDSFK23A',	2,	NULL),
(1810,	1,	'JFHEW23',	5,	40027),
(1810,	2,	'JFIE32NJ',	4,	NULL),
(1810,	3,	'KEJW230J',	3,	NULL),
(1810,	4,	'KFSDJ342',	3,	NULL),
(1811,	1,	'KGDSF34F',	1,  NULL),
(1812,	1,	'QER-34258',3,  NULL),
(1813,	1,	'SDF-457YU',5,	40028),
(1814,	1,	'SRE-657UO',2,	NULL),
(1815,	1,	'UEHRW21',	1,	NULL),
(1816,	1,	'ZZX3245Q',	3,  NULL),
(1816,	2,	'123-21UUY',2,	NULL),
(1817,	1,	'FSFE-2342',2,	NULL),
(1817,	2,	'KGDSF34F',	5,	NULL),
(1817,	3,	'ZZX3245Q',	5,	NULL),
(1817,	4,	'UEHRW21',	2,	NULL),
(1817,	5,	'JDSFK23A',	1,	40028),
(1818,	1,	'JDS345MK',	4,	40026),
(1819,	1,	'KEJW230J',	3,	NULL),
(1825,	1,	'DJFW394W',	2,	NULL),
(1826,	1,	'JFHEW23',	2,	NULL),
(1826,	2,	'JFIE32NJ',	4,  NULL),
(1827,	1,	'D432NJUE',	4,	NULL),
(1827,	2,	'KFSDJ342',	2,	NULL),
(1828,	1,	'HUFD324W',	3,	40028),
(1829,	1,	'SRE-657UO',3,	NULL),
(1830,	1,	'KGDSF34F',	4,	NULL),
(1830,	2,	'KFSDJ342',	1,	NULL),
(1830,	3,	'KEJW230J',	4,	NULL),
(1830,	4,	'JFIE32NJ',	1,	NULL),
(1831,	1,	'JFHEW23',	2,	NULL),
(1837,	1,	'JDSFK23A',	2,	NULL),
(1838,	1,	'JDS345MK',	2,	NULL),
(1839,	1,	'HUFD324W',	2,	NULL),
(1839,	2,	'HUEEEW24',	3,	NULL),
(1840,	1,	'FSFE-2342',1,	NULL),
(1841,	1,	'FHUIEW23',	1,	NULL),
(1841,	2,	'FDSJ23NJ',	3,	NULL),
(1841,	3,	'EWRION23',	5,	NULL),
(1842,	1,	'KEJW230J',	1,	NULL),
(1843,	1,	'DJFW394W',	2,	NULL),
(1844,	1,	'JFHEW23',	3,	NULL),
(1845,	1,	'JFIE32NJ',	3,	NULL),
(1845,	2,	'D432NJUE',	1,	NULL),
(1845,	3,	'KFSDJ342',	5,	NULL),
(1846,	1,	'HUFD324W',	1,	NULL),	
(1847,	1,	'SRE-657UO',1,	NULL),
(1848,	1,	'KGDSF34F',	5,	NULL),
(1849,	1,	'KFSDJ342',	4,	NULL),
(1850,	1,	'KEJW230J',	1,	NULL),
(1850,	2,	'JFIE32NJ',	5,	NULL),	
(1851,	1,	'JFHEW23',	3,	NULL),	
(1851,	2,	'JDS345MK',	3,	40025);
GO
