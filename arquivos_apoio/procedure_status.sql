CREATE TABLE  ADMIN.DWH_LOAD_STATS 
   (	DWH_LOAD_ID NUMBER(5,0) PRIMARY KEY, 
	DWH_LOAD_STATUS VARCHAR2(100), 
    PIPELINE_NAME_TASK_RUN VARCHAR2(100),
	DWH_LOAD_DATE DATE);

CREATE SEQUENCE  ADMIN.DWH_PK  INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;

CREATE OR REPLACE PROCEDURE ADMIN.OCIDI_RESULT (IN_DI_RESULT VARCHAR2, PIPELINE_NAME_TASK_RUN VARCHAR2 )
IS
 BEGIN
     IF IN_DI_RESULT='SUCCESS' THEN 
    INSERT INTO ADMIN.DWH_LOAD_STATS VALUES (DWH_PK.NEXTVAL , 'OCI Data Integration pipeline was executed successfully.' , PIPELINE_NAME_TASK_RUN, to_date(sysdate,'DD-MM-YYYY'));

     ELSIF IN_DI_RESULT='ERROR' THEN
    INSERT INTO ADMIN.DWH_LOAD_STATS VALUES (DWH_PK.NEXTVAL , 'OCI Data Integration pipeline was not executed. Please check the errors in OCI DI.' , PIPELINE_NAME_TASK_RUN, to_date(sysdate,'DD-MM-YYYY'));

     END IF;

END;
/