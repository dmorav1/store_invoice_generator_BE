CREATE TABLE `CLIENTS` (
  `CLIENT_ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `LASTNAME` VARCHAR(45) NOT NULL,
  `DOCUMENT_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`),
  UNIQUE INDEX `DOCUMENT_ID_UNIQUE` (`DOCUMENT_ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE `PRODUCTS` (
  `PRODUCT_ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `PRODUCT_VALUE` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`PRODUCT_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE `PROMOCODES` (
  `PROMOCODE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `VALID_FROM` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `VALID_TO` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DESCRIPTION` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PERCENTAGE` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`PROMOCODE_ID`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`,`VALID_FROM`,`VALID_TO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `INVOICES` (
  `INVOICE_ID` INT NOT NULL AUTO_INCREMENT,
  `PAYMENT_DATE` DATETIME NULL,
  `ACTIVE_FLAG` TINYINT NOT NULL DEFAULT 1,
  `CLIENT_ID` INT NOT NULL,
  `PROMOCODE_ID` INT NULL,
  PRIMARY KEY (`INVOICE_ID`),
  INDEX `CLIENT_ID_idx` (`CLIENT_ID` ASC),
  INDEX `PROMOCODE_ID_idx` (`PROMOCODE_ID` ASC),
  CONSTRAINT `CLIENT_ID`
    FOREIGN KEY (`CLIENT_ID`)
    REFERENCES `CLIENTS` (`CLIENT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PROMOCODE_ID`
    FOREIGN KEY (`PROMOCODE_ID`)
    REFERENCES `PROMOCODES` (`PROMOCODE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE `PRODUCTS_INVOICES` (
  `INVOICE_ID` INT NOT NULL,
  `PRODUCT_ID` INT NOT NULL,
  `QUANTITY` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`INVOICE_ID`, `PRODUCT_ID`),
  INDEX `PRODUCT_ID_idx` (`PRODUCT_ID` ASC),
  CONSTRAINT `PRODUCT_ID`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `PRODUCTS` (`PRODUCT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `INVOICE_ID`
    FOREIGN KEY (`INVOICE_ID`)
    REFERENCES `INVOICES` (`INVOICE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

delete from CLIENTS;
INSERT INTO CLIENTS (NAME,LASTNAME, DOCUMENT_ID) VALUES('Diego','Mora','123456789');
INSERT INTO CLIENTS (NAME,LASTNAME, DOCUMENT_ID) VALUES('Diana','Uribe','123456781');
INSERT INTO CLIENTS (NAME,LASTNAME, DOCUMENT_ID) VALUES('Pancracio','Perez','123456782');
INSERT INTO CLIENTS (NAME,LASTNAME, DOCUMENT_ID) VALUES('Penelope','Cruz','123456783');

delete from PRODUCTS;
INSERT INTO PRODUCTS (NAME,PRODUCT_VALUE) VALUES ('Ice Cream', 5);
INSERT INTO PRODUCTS (NAME,PRODUCT_VALUE) VALUES ('Yogurt', 2);
INSERT INTO PRODUCTS (NAME,PRODUCT_VALUE) VALUES ('Cheese', 7);
INSERT INTO PRODUCTS (NAME,PRODUCT_VALUE) VALUES ('Milk', 1);


delete from PROMOCODES;
INSERT INTO PROMOCODES (CODE,VALID_FROM,VALID_TO,DESCRIPTION,PERCENTAGE) 
	VALUES ('VALIDCODE',STR_TO_DATE('2021-02-11', '%Y-%m-%d'),NULL,'This is a valid code',30);
INSERT INTO PROMOCODES (CODE,VALID_FROM,VALID_TO,DESCRIPTION,PERCENTAGE) 
	VALUES ('INVALIDCODE',STR_TO_DATE('2021-02-11', '%Y-%m-%d'),STR_TO_DATE('2021-04-11', '%Y-%m-%d'),'This is an invalid code',50);

delete from INVOICES;
INSERT INTO INVOICES (PAYMENT_DATE,ACTIVE_FLAG,CLIENT_ID,PROMOCODE_ID) 
	VALUES (STR_TO_DATE('2021-10-15 13:00:15', '%Y-%m-%d %H:%i:%s'), 1, 1, 1) ;
INSERT INTO INVOICES (PAYMENT_DATE,ACTIVE_FLAG,CLIENT_ID,PROMOCODE_ID) 
	VALUES (STR_TO_DATE('2021-10-14 12:00:27', '%Y-%m-%d %H:%i:%s'), 0, 2, 1);
INSERT INTO INVOICES (PAYMENT_DATE,ACTIVE_FLAG,CLIENT_ID,PROMOCODE_ID) 
	VALUES (STR_TO_DATE('2021-10-15 17:05:00', '%Y-%m-%d %H:%i:%s'), 1, 3, NULL) ;
INSERT INTO INVOICES (PAYMENT_DATE,ACTIVE_FLAG,CLIENT_ID,PROMOCODE_ID) 
	VALUES (STR_TO_DATE('2021-03-15 13:00:15', '%Y-%m-%d %H:%i:%s'), 0, 4, 2) ;
INSERT INTO INVOICES (PAYMENT_DATE,ACTIVE_FLAG,CLIENT_ID,PROMOCODE_ID) 
	VALUES (STR_TO_DATE('2021-03-16 13:00:15', '%Y-%m-%d %H:%i:%INVOICESs'), 0, 4, NULL) ;
    
delete from PRODUCTS_INVOICES;
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (1,1,2);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (1,2,3);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (1,3,4);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (2,4,5);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (2,1,1);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (2,2,2);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (2,3,3);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (3,1,4);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (3,3,4);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (4,4,5);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (4,1,1);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (5,2,2);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (5,3,3);
INSERT INTO PRODUCTS_INVOICES(INVOICE_ID,PRODUCT_ID,QUANTITY) VALUES (5,1,4);
    