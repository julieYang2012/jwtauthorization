DROP SCHEMA IF EXISTS AUTH;

CREATE SCHEMA IF NOT EXISTS AUTH DEFAULT CHARACTER SET utf8;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ALLOW_INVALID_DATES';

USE AUTH;

CREATE TABLE IF NOT EXISTS OAUTH_CLIENT_DETAILS (
	CLIENT_ID VARCHAR(256) NOT NULL,
	CLIENT_SECRET VARCHAR(256) NOT NULL,
	WEB_SERVER_REDIRECT_URI VARCHAR(2048) DEFAULT NULL,
	SCOPE VARCHAR(256) DEFAULT NULL,
	ACCESS_TOKEN_VALIDITY INT(11) DEFAULT NULL,
	REFRESH_TOKEN_VALIDITY INT(11) DEFAULT NULL,
	RESOURCE_IDS VARCHAR(1024) DEFAULT NULL,
	AUTHORIZED_GRANT_TYPES VARCHAR(1024) DEFAULT NULL,
	AUTHORITIES VARCHAR(1024) DEFAULT NULL,
	ADDITIONAL_INFORMATION VARCHAR(4096) DEFAULT NULL,
	AUTOAPPROVE VARCHAR(256) DEFAULT NULL,
	PRIMARY KEY (CLIENT_ID)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS USER (
	ID INT(11) NOT NULL AUTO_INCREMENT,
	USERNAME VARCHAR(100) NOT NULL,
	PASSWORD VARCHAR(1024) NOT NULL,
	EMAIL VARCHAR(1024),
	ENABLED TINYINT(4) NOT NULL,
	ACCOUNTNONEXPIRED TINYINT(4) NOT NULL,
	CREDENTIALSNONEXPIRED TINYINT(4) NOT NULL,
	ACCOUNTNONLOCKED TINYINT(4) NOT NULL,
	PRIMARY KEY (ID),
	UNIQUE KEY USERNAME (USERNAME)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ROLE (
	ID INT(11) NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(256) DEFAULT NULL,
	PRIMARY KEY (ID),
	UNIQUE KEY NAME (NAME)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ROLE_USER (
	ROLE_ID INT(11) DEFAULT NULL,
	USER_ID INT(11) DEFAULT NULL,
	KEY ROLE_ID (ROLE_ID),
	KEY USER_ID (USER_ID),
	CONSTRAINT ROLE_USER_IBFK_1 FOREIGN KEY (ROLE_ID) REFERENCES ROLE (ID),
	CONSTRAINT ROLE_USER_IBFK_2 FOREIGN KEY (USER_ID) REFERENCES USER (ID)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS PERMISSION (
	ID INT(11) NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(512) DEFAULT NULL,
	PRIMARY KEY (ID),
	UNIQUE KEY NAME (NAME)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS PERMISSION_ROLE (
	PERMISSION_ID INT(11) DEFAULT NULL,
	ROLE_ID INT(11) DEFAULT NULL,
	KEY PERMISSION_ID (PERMISSION_ID),
	KEY ROLE_ID (ROLE_ID),
	CONSTRAINT PERMISSION_ROLE_IBFK_1 FOREIGN KEY (PERMISSION_ID) REFERENCES PERMISSION (ID),
	CONSTRAINT PERMISSION_ROLE_IBFK_2 FOREIGN KEY (ROLE_ID) REFERENCES ROLE (ID)
) ENGINE=INNODB;

-- TOKEN STORE
CREATE TABLE IF NOT EXISTS OAUTH_CLIENT_TOKEN (
	TOKEN_ID VARCHAR(256),
	TOKEN LONG VARBINARY,
	AUTHENTICATION_ID VARCHAR(256) PRIMARY KEY,
	USER_NAME VARCHAR(256),
	CLIENT_ID VARCHAR(256)
);

CREATE TABLE IF NOT EXISTS OAUTH_ACCESS_TOKEN (
	TOKEN_ID VARCHAR(256),
	TOKEN LONG VARBINARY,
	AUTHENTICATION_ID VARCHAR(256) PRIMARY KEY,
	USER_NAME VARCHAR(256),
	CLIENT_ID VARCHAR(256),
	AUTHENTICATION LONG VARBINARY,
	REFRESH_TOKEN VARCHAR(256)
);

CREATE TABLE IF NOT EXISTS OAUTH_REFRESH_TOKEN (
	TOKEN_ID VARCHAR(256),
	TOKEN LONG VARBINARY,
	AUTHENTICATION LONG VARBINARY
);

CREATE TABLE IF NOT EXISTS OAUTH_CODE (
	CODE VARCHAR(256),
	AUTHENTICATION LONG VARBINARY
);

CREATE TABLE IF NOT EXISTS OAUTH_APPROVALS (
	USERID VARCHAR(256),
	CLIENTID VARCHAR(256),
	SCOPE VARCHAR(256),
	STATUS VARCHAR(10),
	EXPIRESAT TIMESTAMP,
	LASTMODIFIEDAT TIMESTAMP
);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO OAUTH_CLIENT_DETAILS (CLIENT_ID, CLIENT_SECRET, WEB_SERVER_REDIRECT_URI, SCOPE, ACCESS_TOKEN_VALIDITY, REFRESH_TOKEN_VALIDITY, RESOURCE_IDS, AUTHORIZED_GRANT_TYPES, ADDITIONAL_INFORMATION) VALUES 
('DEFAULT', '$2a$10$Bj5thlLKvHSJSKVmu8NgXukkeQNMdfKzktZIL64Vudh6z/GNK9rbG', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM01', '$2a$10$7BISVZriIunVAcuMvR3wm.85DuzoCqBb8Veqli4caGYMv9olKA5nm', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM02', '$2a$10$SGBgmKSmvYbRzOyyMmWXSubkbyTbVJLE74.c6tkwwPcs1eCiUxfba', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM03', '$2a$10$2zmA.tskK9REh4qMd00lVu6uqAbqhioJ71I1hwujaNwWbJvNdocNO', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM04', '$2a$10$lHpLKGslju.NnpW6dSYahudtfUsbFEhNjZiF11GiG0fxs231x1s0a', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM05', '$2a$10$4BJ55vOWEPxlb1orulX4MOUOtAfWD7b2DQsINwW7wNJOd2TpYWGvK', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM06', '$2a$10$cKcRL7htOSh1lsyrcyg2dOat8943ALZ.SuQUvl9Xt4DdujX35d1jq', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM07', '$2a$10$QiTNR7YALrQeZpx4eyVBI.SAlzxxSp7T/G4GYM4macXI7B/r0SOW6', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM08', '$2a$10$1GdcqmTbmBYTVmOGku0QRu.jAG4QgJuTwpWnCl8d1s5/BZClShWCy', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM09', '$2a$10$w6H61u.AgF6gzRXUDKdonui9pzF6VwzxfmrKnk6RB2yEF0rgRZBcK', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM10', '$2a$10$SoE1vmt.wwj5jNwXgIJEj.YIpmCT0zVBUrtAgf7xcwJSSo/8o/k.i', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM11', '$2a$10$bQfTn5bALaoLLHIK0.TjmOra8t0TJG7Xi3dm4WyckfMTBkKKf9Q1y', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM12', '$2a$10$iUirbdQmvQQee9nOm27ULOVXma0D0cz2teOEzyWQhn3R6VG6Rhl5q', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM13', '$2a$10$K2pQfkGzVMcbq6z0fCoT1O/dYNs4XWZomP4lL0VSNdO8vS6xpr8OW', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM14', '$2a$10$ANWUL34vR.2k/GVv/5V/0OIPDpXB0W51RauTbIBVc9Mncyzpohzai', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM15', '$2a$10$ryug.vsNbt.NU9R0DF3LwOg0f2k99elwijfGa0KzsFE1of.DBUkjq', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM16', '$2a$10$P3o5iKOQmRcSNcWbHKJ4Z.N6vZltrsBNb4nBFOpPf.8.UNkUiyCaa', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM17', '$2a$10$BkUmG082ggQh4UYDxz/AVumdRxL.EQHdzF1F2ZujDAqiwRiWeyxr.', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TM18', '$2a$10$RNJnhvkc9h32QEFK7EzK0ucIzGEVsbsw/i7ID2bQV9KgWb4X/yYc6', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TMV01', '$2a$10$uEQT8flFaNiH6kq3y.QfJemdptWCcjZ87Aoiay2jSOhztiWEc/P9i', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TMV02', '$2a$10$sBlBDS.h9jbJ8oAQ.FAQvu/Vbl5iV.v5lEa5z.xDlQgdAHyapbHoe', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TMV03', '$2a$10$pP8M0TnrWD9oklmVt9utwOO3KVJrTYyQMGBiER0EXVZxWisWdnvmS', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('TMV04', '$2a$10$088zoLiNzXQ/fJMVjrRoMeKIQFTudNsCXI4jniHKg9ZQzteJWTNNC', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('LAB01', '$2a$10$ZO0LaYfJxMmrod3.ywJMweh.vY0AWwmYxrdaTyCJPb4zMQi2khBgK', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('LAB02', '$2a$10$qzDFfZrFn2i01fsJ54JnTOP.0I1A0VGcoytRJrAkPI2V4S0M5AxhS', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('LAB03', '$2a$10$pU.ftTc1fTgN/J7UGsevzOM85tROBvSijgdGKSgc.fQ2MP1BFpHpC', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('LAB04', '$2a$10$1t4Yzwna8oeTrgh0zaLt3OuAbZgX9N6TvJjYy7L/qA1JTNGoKg8by', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('LAB05', '$2a$10$vG.IsHeyf3r1FmBXtLg7E.NkHs4Q2iM97m8tViKHNoPR7o0UMU7Uu', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SCPROD', '$2a$10$D2qVEeUbIo4DLOfQdgRAge.5hQNkKX7ScRLb8FLO4904KGtPgyDS.', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SCQA', '$2a$10$iqVhMI4GPgITxBBTG0cJcuSM7oP0AcJ1oK32ngHoX5TGyo4vyYyve', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SCUAT', '$2a$10$RoIrqJQNpsPgoZvq5lgvEeYC90VwnSYL4YoaTC9y4tYUdke3uKJ8.', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SCSIT', '$2a$10$t0IDjQr.7Hnpza6iBuMCQOvrjE/Lyx.8kNhPLh0MG3bjY7wk4i50m', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SMPROD', '$2a$10$V48JzWI2U32ZcconC7Eh0eisadqTf4vh5MPObpNaVMA6WFiYKh9w.', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SMKEAL', '$2a$10$fpPIq6dJan3gEDrOyynltOgKU1C/J6tXtEZ9p.NfzT2pllKn2L/ym', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SMKEALUAT', '$2a$10$W4PWcBWpUsko.4zMUjO51uq.EevXZibLqodstrzz5QDV0HVZWHSQq', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SMQA', '$2a$10$3MqEnTbu9AHNigxuADg3G.q26jx8ZLwzXpBWgeapdhNOsu3KmZUai', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SMUAT', '$2a$10$w06aPDnUW.EFQoZlbpyMWOTedo.9ddzsmSxNwiLaxYJbJIDO4yqPO', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SMSIT', '$2a$10$aNXpGrwf2IIdOkGE7dKuVunYNE2Txc1mw0Du9nDr7GnCLRIXzK.1a', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}'),
('SMSTAGE', '$2a$10$Jf7/trxWDOqgb4BMUlAtcOwp5EqhqW3AohX.TzlCtPFPKSQxlHSgC', null, 'READ,WRITE', '120', '10000000', 'inventory,payment', 'authorization_code,password,refresh_token,implicit,client_credentials', '{}');

INSERT INTO PERMISSION (NAME) VALUES 
('create_profile'),
('read_profile'),
('update_profile'),
('delete_profile');

INSERT INTO role (NAME) VALUES 
('ROLE_admin'),
('ROLE_editor'),
('ROLE_operator');

INSERT INTO PERMISSION_ROLE (PERMISSION_ID, ROLE_ID) VALUES 
(1,1), /*create-> admin */
(2,1), /* read admin */
(3,1), /* update admin */
(4,1), /* delete admin */
(2,2),  /* read Editor */
(3,2),  /* update Editor */
(2,3);  /* read operator */

-- INSERT INTO USER (ID, USERNAME,PASSWORD, EMAIL, ENABLED, ACCOUNTNONEXPIRED, CREDENTIALSNONEXPIRED, ACCOUNTNONLOCKED) VALUES 
-- ('1', 'kealSM', '$2a$10$UBRf8GOSDcG2SG/fW4JsiOW7sinCWpPD/urEFeGwiFLm5llLLSdea', null, '1', '1', '1', '1'),
-- ('2', 'xenexSM', '$2a$10$sEtD5TmLYp/WXwJMZrjaeeW4Eq3xi9wHYCw8Pc5bnhme51Cpuyo82', null, '1', '1', '1', '1');

-- INSERT INTO ROLE_USER (ROLE_ID, USER_ID) VALUES 
-- (1, 1),
-- (2, 2);