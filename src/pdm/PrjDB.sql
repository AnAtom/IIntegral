/* База данных проекта */
CREATE TABLE objects (
    "obID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "obName" VARCHAR(100) NOT NULL,
    "obType" VARCHAR(100) NOT NULL DEFAULT ('OBJECT'),
    "obOwner" INTEGER DEFAULT (1),
    "obState" INTEGER DEFAULT (1),
    "obSource" VARCHAR NOT NULL DEFAULT ('USER_INPUT'),
    "obVersion" INTEGER NOT NULL DEFAULT (0),
    "obTime" DATETIME NOT NULL,
    "obDesc" VARCHAR);
CREATE TABLE atributes (
    "atID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "atName" VARCHAR(100) NOT NULL,
    "atType" VARCHAR(100) NOT NULL DEFAULT ('NUMBER'),
    "atSize" INTEGER NOT NULL DEFAULT (1),
    "atContner" INTEGER,
    "atOwner" INTEGER NOT NULL DEFAULT (1),
    "atDesc" VARCHAR);
CREATE TABLE programs (
    "prID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "prName" VARCHAR(100) NOT NULL,
    "prType" VARCHAR(100) NOT NULL DEFAULT ('FUNCTION'),
    "prInput" VARCHAR,
    "prOutput" VARCHAR,
    "prLocal" VARCHAR,
    "prUses" VARCHAR,
    "prBody" VARCHAR,
    "prDesc" VARCHAR);
CREATE TABLE blocks (
    "blID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "blVars" VARCHAR,
    "blDesc" VARCHAR);
CREATE TABLE results (
    "rsID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "rsBlock" INTEGER NOT NULL DEFAULT (1),
    "rsTime" DATETIME NOT NULL,
    "rsData" VARCHAR NOT NULL,
    "rsDesc" VARCHAR);
BEGIN TRANSACTION;
INSERT INTO objects VALUES (1, 'Тестовый проект', 'PROJECT', NULL, 1, 'USER_INPUT', 0, 'now', 'Проект создан для тестирования процесса разработки');
INSERT INTO objects VALUES (2, 'Тестовая задача', 'TASK', NULL, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (3, 'Объект исследования', 'OBJECT', NULL, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (4, 'Схема расчета', 'SOLUTION', 2, 1, 'AUTO', 0, 'now', NULL);
INSERT INTO objects VALUES (5, 'Тестовое решение', 'RESULT', 4, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (6, 'Исходные данные', 'OBJECT', 2, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (7, 'Текущее состояние', 'STATE', 3, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (8, 'Новая задача', 'TASK', NULL, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (9, 'Схема объекта', 'SCHEME', 3, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (10, 'Схема в проекте', 'SCHEME', NULL, 1, 'USER_INPUT', 0, 'now', NULL);
INSERT INTO objects VALUES (11, 'Функция вычисления', 'SCRIPT', NULL, 1, 'USER_INPUT', 0, 'now', NULL);
COMMIT;

