/* Справочная база данных */
-- Таблица определения объектов
CREATE TABLE ii_otd (
    "typName" VARCHAR NOT NULL UNIQUE PRIMARY KEY,
    "typProto" VARCHAR,
    "typMembers" VARCHAR NOT NULL,
    "typAlternat" VARCHAR,
    "typDescr" VARCHAR);
-- Перечень таблиц в базе
CREATE TABLE ii_toc (
    "tblName" VARCHAR NOT NULL UNIQUE PRIMARY KEY,
    "tblDescription" VARCHAR,
    "tblVersion" VARCHAR,
    "tblObjects" VARCHAR NOT NULL REFERENCES ii_otd ("typName"),
    "objCount" INTEGER NOT NULL,
    "objTitles" VARCHAR,
    "objDescriptions" VARCHAR);
-- Единицы измерения физических величин
CREATE TABLE edizmerfv (
    "uNazvan" VARCHAR NOT NULL UNIQUE PRIMARY KEY,
    "uObozn" VARCHAR(100),
    "uOsnovn" VARCHAR REFERENCES edizmerfv ("uNazvan"),
    "uPreobr" VARCHAR,
    "uNazvan234" VARCHAR,
    "uNazvanM" VARCHAR,
    "uName" VARCHAR,
    "uNotation" VARCHAR);
CREATE UNIQUE INDEX "uID" on edizmerphv (uNazvan ASC);
-- Перечень физических величин
CREATE TABLE fizvelichin (
    "qNazvan" VARCHAR NOT NULL,
    "qSimbol" VARCHAR(10),
    "qOsnEdIzm" VARCHAR NOT NULL REFERENCES edizmerfv ("uNazvan"),
    "qName" VARCHAR);
CREATE UNIQUE INDEX "qID" on velichin (qNazvan, qOsnEdIzm);
-- Формулы выражения физических величин
CREATE TABLE formulfv (
    "fResult" VARCHAR NOT NULL REFERENCES fizvelichin ("qNazvan"),
    "fArguments" VARCHAR NOT NULL,
    "fUravn" VARCHAR NOT NULL,
    "fDesc" VARCHAR);
CREATE UNIQUE INDEX "fID" on preobrfv (fUravn,fArguments);
-- Запоняем таблицу определений объектов и перечень таблиц базы
BEGIN TRANSACTION;
INSERT INTO ii_otl VALUES('EDIZMER',NULL,'uNazvan,uObozn,uOsnovn,uPreobr,uNazvan234,uNazvanM,uName,uNotation',NULL,'Единицы измерения');
INSERT INTO ii_otl VALUES('VELICHIN',NULL,'qNazvan,qSimbol,qOsnEdIzm,qName',NULL,'Величины');
INSERT INTO ii_otl VALUES('FORMUL',NULL,'fResult,fArguments,fUravn,fDesc',NULL,'Формулы');
INSERT INTO ii_otl VALUES('VESCHESTV',NULL,'sNazvanie,sFormula,sSost,sSvoystva',NULL,'Вещества, материалы, смеси');
INSERT INTO ii_toc VALUES('edizmerfv','Единицы измерения физических величин',1,'EDIZMER',0,'uNazvan',NULL);
INSERT INTO ii_toc VALUES('fizvelichin','Физические величины',1,'VELICHIN',0,'qNazvan',NULL);
INSERT INTO ii_toc VALUES('formulfv','Формулы выражения физических величин',1,'FORMUL',0,NULL,'fDesc');
COMMIT;
-- Заполняем таблицы базы
BEGIN TRANSACTION;
INSERT INTO edizmerfv VALUES('секунда','с',NULL,NULL,'секунды','секунд','second','s');
INSERT INTO edizmerfv VALUES('метр','м',NULL,NULL,'метра','метров','m','meter');
INSERT INTO edizmerfv VALUES('килограмм','кг',NULL,NULL,'килограмма','килограммов','kg','kilogram');
INSERT INTO edizmerfv VALUES('кельвин','К',NULL,NULL,'кельвина','кельвинов','K','kelvin');
INSERT INTO edizmerfv VALUES('ампер','А',NULL,NULL,'ампера',NULL,'A','ampere');
INSERT INTO edizmerfv VALUES('моль','моль',NULL,NULL,'моля','молей','mol','mole');
INSERT INTO edizmerfv VALUES('кандела','кд',NULL,NULL,'канделы','кандел','cd','candela');
INSERT INTO edizmerfv VALUES('минута','мин','секунда','60 с','минуты','минут','min','minute');
INSERT INTO edizmerfv VALUES('час','ч','секунда','3 600 с','часа','часов','h','hour');
INSERT INTO edizmerfv VALUES('сутки','сут','секунда','86 400 с','суток','суток','d','day');
INSERT INTO edizmerfv VALUES('градус Цельсия','°C','кельвин','= К + 273.15','градуса Цельсия','градусов Цельсия','°C','degree Celsius');
INSERT INTO edizmerfv VALUES('радиан','рад',NULL,'м/м','радиана',NULL,'rad','radian');
INSERT INTO edizmerfv VALUES('стерадиан','ср',NULL,'м²/м²','стерадиана',NULL,'sr','steradian');
INSERT INTO edizmerfv VALUES('герц','Гц',NULL,'¹/с','герца',NULL,'Hz','hertz');
INSERT INTO edizmerfv VALUES('ньютон','Н',NULL,'кг·м/c²','ньютона','ньютонов','N','newton');
INSERT INTO edizmerfv VALUES('джоуль','Дж',NULL,'Н·м = кг·м²/c²','джоуля','джоулей','J','joule');
INSERT INTO edizmerfv VALUES('ватт','Вт',NULL,'Дж/с = кг·м²/c³','ватта',NULL,'W','watt');
INSERT INTO edizmerfv VALUES('паскаль','Па',NULL,'Н/м² = кг/м·с²','паскаля','паскалей','Pa','pascal');
INSERT INTO edizmerfv VALUES('люмен','лм',NULL,'кд·ср',NULL,NULL,'lm','lumen');
INSERT INTO edizmerfv VALUES('люкс','лк',NULL,'лм/м² = кд·ср/м²',NULL,NULL,'lx','lux');
INSERT INTO edizmerfv VALUES('кулон','Кл',NULL,'А·с',NULL,NULL,'C','coulomb');
INSERT INTO edizmerfv VALUES('вольт','В',NULL,'Дж/Кл = кг·м²/с³·А','вольта',NULL,'V','volt');
INSERT INTO edizmerfv VALUES('ом','Ом',NULL,'В/А = кг·м²/с³·А²','ома',NULL,'Ω','ohm');
INSERT INTO edizmerfv VALUES('фарад','Ф',NULL,'Кл/В = с⁴·А²/кг·м²','фарада',NULL,'F','farad');
INSERT INTO edizmerfv VALUES('вебер','Вб',NULL,'кг·м²/с²·А','вебера',NULL,'Wb','weber');
INSERT INTO edizmerfv VALUES('тесла','Тл',NULL,'Вб/м² = кг/с²·А','теслы','тесл','T','tesla');
INSERT INTO edizmerfv VALUES('генри','Гн',NULL,'кг·м²/с²·А²',NULL,NULL,'H','henry');
INSERT INTO edizmerfv VALUES('сименс','См',NULL,'¹/Ом = с³·А²/кг·м²',NULL,NULL,'S','siemens');
INSERT INTO edizmerfv VALUES('беккерель','Бк',NULL,'¹/с',NULL,NULL,'Bq','becquerel');
INSERT INTO edizmerfv VALUES('грэй','Гр',NULL,'Дж/кг = м²/c²',NULL,NULL,'Gy','gray');
INSERT INTO edizmerfv VALUES('зиверт','Зв',NULL,'Дж/кг = м²/c²','зиверта','зивертов','Sv','sievert');
INSERT INTO edizmerfv VALUES('катал','кат',NULL,'моль/с',NULL,NULL,'kat','katal');
INSERT INTO edizmerfv VALUES('кубометр','м³',NULL,NULL,'кубометра','кубометров','m³','cubic metre');
INSERT INTO edizmerfv VALUES('литр','л','кубометр','0.001 м³','литра','литров','l;L','litre (liter)');
INSERT INTO edizmerfv VALUES('квадратный метр','м²',NULL,NULL,'квадратных метра','квадратных метров','m²','square metre');
INSERT INTO edizmerfv VALUES('градус','°','радиан','(π/180) рад','градуса','градусов','°','degree');
INSERT INTO edizmerfv VALUES('угловая минута','′','радиан','(1/60)° = (π/10 800)','угловые минуты','угловых минут','′','minute');
INSERT INTO edizmerfv VALUES('угловая секунда','″','радиан','(1/60)′ = (π/648 000)','угловые секунды','угловых секунд','″','second');
INSERT INTO edizmerfv VALUES('тонна','т','килограмм','1000 кг','тонны','тонн','t','tonne');
INSERT INTO edizmerfv VALUES('непер','Нп',NULL,NULL,NULL,NULL,'Np','neper');
INSERT INTO edizmerfv VALUES('бел','Б',NULL,NULL,NULL,NULL,'B','bel');
INSERT INTO edizmerfv VALUES('метр в секунду','м/с',NULL,NULL,'метра в секунду','метров в секунду','m/s',NULL);
INSERT INTO edizmerfv VALUES('метр в секунду в квадрате','м/с²',NULL,NULL,'метра в секунду в квадрате','метров в секунду в квадрате','m/s²',NULL);
INSERT INTO edizmerfv VALUES('электронвольт','эВ',16,'≈1.6021773310⁻¹⁹ Дж','электронвольта',NULL,'eV','electronvolt');
INSERT INTO edizmerfv VALUES('атомная единица массы','а.е.м.',3,'≈1.660540210⁻²⁷ кг',NULL,NULL,'u','unified atomic mass unit');
INSERT INTO edizmerfv VALUES('астрономическая единица','а.е.',2,'≈1.495978706911011 м',NULL,NULL,'ua','astronomical unit');
INSERT INTO edizmerfv VALUES('морская миля','миля',2,'= 1852 м',NULL,NULL,'M','nautical mile');
INSERT INTO edizmerfv VALUES('узел','уз',53,'= 1 миля/ч','узла','узлов',NULL,'knot');
INSERT INTO edizmerfv VALUES('ар','а',34,'= 100 м²',NULL,NULL,'a','are');
INSERT INTO edizmerfv VALUES('гектар','га',34,'= 104 м²',NULL,NULL,'ha','hectare');
INSERT INTO edizmerfv VALUES('бар','бар',18,'= 105 Па',NULL,NULL,'bar','bar');
INSERT INTO edizmerfv VALUES('ангстрем','Å',2,'= 10⁻¹⁰ м',NULL,NULL,'Å','ångström');
INSERT INTO edizmerfv VALUES('барн','б',34,'= 10⁻²⁸ м²',NULL,NULL,'b','barn');
INSERT INTO edizmerfv VALUES('штука','шт.',NULL,NULL,'штуки','штук','pcs','piece');
INSERT INTO edizmerfv VALUES('единица','',NULL,NULL,'единицы','единиц','','unit');

INSERT INTO fizvelichin VALUES('время','t','секунда','time');
INSERT INTO fizvelichin VALUES('длина','l','метр','length');
INSERT INTO fizvelichin VALUES('ширина','w','метр','width');
INSERT INTO fizvelichin VALUES('высота','h','метр','height');
INSERT INTO fizvelichin VALUES('диаметр','d','метр','diametr');
INSERT INTO fizvelichin VALUES('радиус','r','метр','radius');
INSERT INTO fizvelichin VALUES('периметр','P','метр','perimeter');
INSERT INTO fizvelichin VALUES('масса','m','килограмм','mass');
INSERT INTO fizvelichin VALUES('темпрература','Θ','кельвин','temperature');
INSERT INTO fizvelichin VALUES('сила тока','I','ампер','current');
INSERT INTO fizvelichin VALUES('количество вещества','N','моль','amount of substance');
INSERT INTO fizvelichin VALUES('сила света','J','кандела','luminous intensity');
INSERT INTO fizvelichin VALUES('площадь','S','квадратный метр','area');
INSERT INTO fizvelichin VALUES('объем','V','кубометр','volume');
INSERT INTO fizvelichin VALUES('угол','θ','радиан','angle');
INSERT INTO fizvelichin VALUES('скорость','v','метр в секунду','velocity','speed');
INSERT INTO fizvelichin VALUES('ускорение','a','метр в секунду в квадрате','acceleration');
INSERT INTO fizvelichin VALUES('телесный угол','Ω','','solid angle');
INSERT INTO fizvelichin VALUES('частота','f','герц','frequency');
INSERT INTO fizvelichin VALUES('сила','F','ньютон','force');
INSERT INTO fizvelichin VALUES('энергия','E','джоуль','energy');
INSERT INTO fizvelichin VALUES('мощность','P','ватт','power');
INSERT INTO fizvelichin VALUES('давление','p','паскаль','pressure');
INSERT INTO fizvelichin VALUES('световой поток',NULL,'люмен','luminous flux');
INSERT INTO fizvelichin VALUES('освещённость',NULL,'люкс','illuminance');
INSERT INTO fizvelichin VALUES('электрический заряд','Q','кулон','electric charge');
INSERT INTO fizvelichin VALUES('напряжение','U','вольт','voltage');
INSERT INTO fizvelichin VALUES('сопротивление','R','ом','electric resistance');
INSERT INTO fizvelichin VALUES('электроёмкость',NULL,'фарад','electric capacitance');
INSERT INTO fizvelichin VALUES('магнитный поток','Φ','вебер','magnetic flux');
INSERT INTO fizvelichin VALUES('магнитная индукция',NULL,'тесла','magnetic field strength');
INSERT INTO fizvelichin VALUES('индуктивность',NULL,'генри','inductance');
INSERT INTO fizvelichin VALUES('электрическая проводимость',NULL,'сименс','electrical conductance');
INSERT INTO fizvelichin VALUES('активность источника (радиоактивного)',NULL,'беккерель','radioactivity');
INSERT INTO fizvelichin VALUES('поглощённая доза излучения',NULL,'грэй','absorbed dose');
INSERT INTO fizvelichin VALUES('эффективная доза излучения',NULL,'зиверт','equivalent dose');
INSERT INTO fizvelichin VALUES('активность катализатора',NULL,'катал','catalytic activity');

INSERT INTO formulfv VALUES('сила','масса;ускорение','%1*%2','F=m*a');
INSERT INTO formulfv VALUES('мощность','сила;скорость','%1*%2','P=F*v');
INSERT INTO formulfv VALUES('давление','сила;площадь','%1/%2','p=F/S');
INSERT INTO formulfv VALUES('объем','длина;ширина;высота','%1*%2*%3','V=l*w*h');
INSERT INTO formulfv VALUES('сила тока','напряжение;сопротивление','%1/%2','I=U/R');
COMMIT;
/*
    "fResult" VARCHAR NOT NULL REFERENCES fizvelichin ("qNazvan"),
    "fArguments" VARCHAR NOT NULL,
    "fUravn" VARCHAR NOT NULL,
    "fDesc" VARCHAR);
INSERT INTO veschestv VALUES('вакуум',NULL,NULL);
INSERT INTO veschestv VALUES('вода','Н₂O',NULL);
INSERT INTO veschestv VALUES('воздух','[N₂,O₂,Ar,CO₂,Ne,CH₄,He,Kr,H₂,Xe,H₂O]',NULL);
INSERT INTO formul VALUES('1','14','3,12','%1*%2','F=m*a');
INSERT INTO formul VALUES('2','16','14,11','%1*%2','P=F*v');
INSERT INTO fizvelichin VALUES('скорость света','c','','speed of light');
INSERT INTO fizvelichin VALUES('ускорение свободного падения','g','','gravitational acceleration');
INSERT INTO edpreobrfv  VALUES('секунда','минута','%1/60','с=мин/60');
INSERT INTO edpreobrfv  VALUES('секунда','час','%1/3600','с=ч/3600');
INSERT INTO edpreobrfv  VALUES('ампер','вольт;ом','%1/%2','А=В/Ом');
INSERT INTO edpreobrfv  VALUES('кельвин','градус Цельсия','%1+273.15','К=°C+273.15'
*/
