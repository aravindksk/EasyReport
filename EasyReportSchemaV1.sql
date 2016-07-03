----------------------------------------------------------------------------------------
--  Oracle Version : Oracle 11G
--  EasyReport Schema Creation
--  Create User with relevant permissions and connect to the user and run this script
-----------------------------------------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence APP_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "APP_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence DEPT_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "DEPT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence EMP_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "EMP_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MON_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MON_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence RAW_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "RAW_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence RLSE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "RLSE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STRM_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "STRM_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TP_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "TP_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TST_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "TST_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table ER_APP
--------------------------------------------------------

  CREATE TABLE "ER_APP" 
   (	"APP_ID" VARCHAR2(40), 
	"APP_NAME" VARCHAR2(200)
   ) ;
--------------------------------------------------------
--  DDL for Table ER_RAWDATA
--------------------------------------------------------

  CREATE TABLE "ER_RAWDATA" 
   (	"TRAN_ID" VARCHAR2(40), 
	"TRANSACTION_NAME" VARCHAR2(80), 
	"MINIMUM" FLOAT(126), 
	"AVERAGE" FLOAT(126), 
	"MAXIMUM" FLOAT(126), 
	"STD_DEVIATION" FLOAT(126), 
	"NINTY_PERCEN" NUMBER, 
	"PASS" NUMBER, 
	"FAIL" NUMBER, 
	"STOP" NUMBER, 
	"TEST_ID" VARCHAR2(40)
   ) ;
--------------------------------------------------------
--  DDL for Table ER_RELEASE
--------------------------------------------------------

  CREATE TABLE "ER_RELEASE" 
   (	"RLSE_ID" VARCHAR2(40), 
	"RLSE_NAME" VARCHAR2(40), 
	"APP_ID" VARCHAR2(40)
   ) ;
--------------------------------------------------------
--  DDL for Table ER_RLSE_DATA
--------------------------------------------------------

  CREATE TABLE "ER_RLSE_DATA" 
   (	"RLSE_NAME" VARCHAR2(20)
   ) ;
--------------------------------------------------------
--  DDL for Table ER_STREAM
--------------------------------------------------------

  CREATE TABLE "ER_STREAM" 
   (	"STRM_ID" VARCHAR2(40), 
	"STRM_NAME" VARCHAR2(60)
   ) ;
--------------------------------------------------------
--  DDL for Table ER_TEST
--------------------------------------------------------

  CREATE TABLE "ER_TEST" 
   (	"TEST_ID" VARCHAR2(40), 
	"TEST_NME" VARCHAR2(200), 
	"STRT_DATE" TIMESTAMP (6), 
	"END_DATE" TIMESTAMP (6), 
	"NOTES" LONG, 
	"RLSE_ID" VARCHAR2(40), 
	"ISVALID" VARCHAR2(10), 
	"TYPE" VARCHAR2(40)
   ) ;
--------------------------------------------------------
--  DDL for Table ER_TEST_TYPE
--------------------------------------------------------

  CREATE TABLE "ER_TEST_TYPE" 
   (	"ISBASELINE" VARCHAR2(20)
   ) ;
--------------------------------------------------------
--  DDL for View ER_TEST_DTL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ER_TEST_DTL" ("APP_ID", "APP_NAME", "RLSE_ID", "RLSE_NAME", "TEST_ID", "TEST_NME", "STRT_DATE", "END_DATE", "NOTES", "ISVALID", "TYPE") AS 
  SELECT
c.APP_ID,
c.APP_NAME,
b.RLSE_ID,
b.RLSE_NAME,
a.TEST_ID,
a.TEST_NME,
a.STRT_DATE,
a.END_DATE,
a.NOTES,
a.ISVALID,
a.TYPE
FROM  ER_TEST a,
ER_RELEASE b, ER_app c
where b.app_id=c.app_id and b.RLSE_ID=a.RLSE_ID;
--------------------------------------------------------
--  Insert sample data
--------------------------------------------------------
REM INSERTING into ER_RLSE_DATA
SET DEFINE OFF;
Insert into ER_RLSE_DATA (RLSE_NAME) values ('R1');
Insert into ER_RLSE_DATA (RLSE_NAME) values ('R1.1');
Insert into ER_RLSE_DATA (RLSE_NAME) values ('R2');
Insert into ER_RLSE_DATA (RLSE_NAME) values ('NON RLSE');
REM INSERTING into ER_TEST_TYPE
SET DEFINE OFF;
Insert into ER_TEST_TYPE (ISBASELINE) values ('BASELINE');
Insert into ER_TEST_TYPE (ISBASELINE) values ('REGRESSION');
Insert into ER_TEST_TYPE (ISBASELINE) values ('PROGRESSION');
Insert into ER_TEST_TYPE (ISBASELINE) values ('SOAK');
Insert into ER_TEST_TYPE (ISBASELINE) values ('SCALABILITY');
Insert into ER_TEST_TYPE (ISBASELINE) values ('CAPACITY');
Insert into ER_TEST_TYPE (ISBASELINE) values ('LOAD');

--------------------------------------------------------
--  DDL for Index PK_ER_APP
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_ER_APP" ON "ER_APP" ("APP_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_ER_RAWDATA
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_ER_RAWDATA" ON "ER_RAWDATA" ("TRAN_ID", "TEST_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_ER_RELEASE
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_ER_RELEASE" ON "ER_RELEASE" ("RLSE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_ER_STREAM
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_ER_STREAM" ON "ER_STREAM" ("STRM_ID") 
  ;
--------------------------------------------------------
--  DDL for Index PK_ER_TEST
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_ER_TEST" ON "ER_TEST" ("TEST_ID") 
  ;
--------------------------------------------------------
--  Constraints for Table ER_APP
--------------------------------------------------------

  ALTER TABLE "ER_APP" MODIFY ("APP_ID" CONSTRAINT "NN_ER_APP_APP_ID" NOT NULL ENABLE);
  ALTER TABLE "ER_APP" ADD CONSTRAINT "PK_ER_APP" PRIMARY KEY ("APP_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table ER_RAWDATA
--------------------------------------------------------

  ALTER TABLE "ER_RAWDATA" MODIFY ("TRAN_ID" CONSTRAINT "NN_ER_RAWDATA_TRAN_ID" NOT NULL ENABLE);
  ALTER TABLE "ER_RAWDATA" MODIFY ("TEST_ID" NOT NULL ENABLE);
  ALTER TABLE "ER_RAWDATA" ADD CONSTRAINT "PK_ER_RAWDATA" PRIMARY KEY ("TRAN_ID", "TEST_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table ER_RELEASE
--------------------------------------------------------

  ALTER TABLE "ER_RELEASE" MODIFY ("RLSE_ID" NOT NULL ENABLE);
  ALTER TABLE "ER_RELEASE" ADD CONSTRAINT "PK_ER_RELEASE" PRIMARY KEY ("RLSE_ID") ENABLE;
  ALTER TABLE "ER_RELEASE" MODIFY ("RLSE_NAME" NOT NULL ENABLE);
  ALTER TABLE "ER_RELEASE" MODIFY ("APP_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ER_STREAM
--------------------------------------------------------

  ALTER TABLE "ER_STREAM" MODIFY ("STRM_ID" CONSTRAINT "NN_ER_STREAM_STRM_ID" NOT NULL ENABLE);
  ALTER TABLE "ER_STREAM" ADD CONSTRAINT "PK_ER_STREAM" PRIMARY KEY ("STRM_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table ER_TEST
--------------------------------------------------------

  ALTER TABLE "ER_TEST" ADD CONSTRAINT "PK_ER_TEST" PRIMARY KEY ("TEST_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ER_RAWDATA
--------------------------------------------------------

  ALTER TABLE "ER_RAWDATA" ADD CONSTRAINT "ER_TEST_ER_RAWDATA" FOREIGN KEY ("TEST_ID")
	  REFERENCES "ER_TEST" ("TEST_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ER_RELEASE
--------------------------------------------------------

  ALTER TABLE "ER_RELEASE" ADD CONSTRAINT "ER_APP_ER_RELEASE" FOREIGN KEY ("APP_ID")
	  REFERENCES "ER_APP" ("APP_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ER_TEST
--------------------------------------------------------

  ALTER TABLE "ER_TEST" ADD CONSTRAINT "ER_RELEASE_ER_TEST" FOREIGN KEY ("RLSE_ID")
	  REFERENCES "ER_RELEASE" ("RLSE_ID") ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ER_APP1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_ER_APP1" 
BEFORE INSERT ON ER_APP
FOR EACH ROW
BEGIN
IF :new.APP_ID is NULL THEN
	SELECT 'APP'||APP_SEQ.NEXTVAL INTO :new.APP_ID FROM DUAL;
END IF;
END;
/
ALTER TRIGGER "TRG_ER_APP1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ER_RAWDATA1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_ER_RAWDATA1" 
BEFORE INSERT ON ER_RAWDATA
FOR EACH ROW
BEGIN
IF :new.TRAN_ID is NULL THEN
	SELECT 'RAW'||RAW_SEQ.NEXTVAL INTO :new.TRAN_ID FROM DUAL;
END IF;
END;
/
ALTER TRIGGER "TRG_ER_RAWDATA1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ER_RELEASE1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_ER_RELEASE1" 
BEFORE INSERT ON ER_RELEASE
FOR EACH ROW
BEGIN
IF :new.RLSE_ID is NULL THEN
	SELECT 'RLSE'||RLSE_SEQ.NEXTVAL INTO :new.RLSE_ID FROM DUAL;
END IF;
END;
/
ALTER TRIGGER "TRG_ER_RELEASE1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ER_STREAM1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_ER_STREAM1" 
BEFORE INSERT ON ER_STREAM
FOR EACH ROW
BEGIN
IF :new.STRM_ID is NULL THEN
	SELECT 'STRM'||STRM_SEQ.NEXTVAL INTO :new.STRM_ID FROM DUAL;
END IF;
END;
/
ALTER TRIGGER "TRG_ER_STREAM1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ER_TEST1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRG_ER_TEST1" 
BEFORE INSERT ON ER_TEST
FOR EACH ROW
BEGIN
IF :new.TEST_ID is NULL THEN
	SELECT 'TST'||TST_SEQ.NEXTVAL INTO :new.TEST_ID FROM DUAL;
END IF;
END;
/
ALTER TRIGGER "TRG_ER_TEST1" ENABLE;
