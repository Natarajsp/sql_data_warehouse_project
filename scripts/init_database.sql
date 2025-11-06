/*
=========================================================================================
 Script Name   : Create_DataWarehouse_With_Medallion_Schemas.sql
 Author         : Nataraj Patil
 Created Date   : 09 / 11 / 2025
 Project        : [SQL Data Warehouse Project]
 Description    : 
     This script is used to safely drop and recreate the 'DataWarehouse' database 
     in Microsoft SQL Server. It initializes the Medallion Architecture by creating 
     three schemas — BRONZE, SILVER, and GOLD — which are used to organize data 
     across different transformation layers:

         • BRONZE – Raw, ingested data (as-is from source systems)
         • SILVER – Cleansed, validated, and standardized data
         • GOLD   – Aggregated, business-ready, and analytics data

     This setup provides a clear data lineage structure for ETL/ELT processes 
     in a Data Warehouse or Lakehouse environment.

-----------------------------------------------------------------------------------------
 PURPOSE:
     • Ensure a clean rebuild of the 'DataWarehouse' database.
     • Set up logical data layers (bronze, silver, gold) to support Medallion Architecture.
     • Useful for ETL testing, data model initialization, or environment setup automation.

-----------------------------------------------------------------------------------------
 WARNINGS / PRECAUTIONS:
     ⚠️  This script PERMANENTLY DELETES the 'DataWarehouse' database if it already exists.
         ➤ All data, tables, views, and stored procedures will be lost.

     ⚠️  It forcibly disconnects all active users and rolls back open transactions using:
         ➤ ALTER DATABASE ... SET SINGLE_USER WITH ROLLBACK IMMEDIATE

     ⚠️  Use ONLY in DEVELOPMENT or TEST environments.
         ➤ Never run this in production.

     ⚠️  Requires elevated permissions:
         ➤ User must have sysadmin or db_owner privileges to drop and create databases.

     ⚠️  Backup Recommended:
         ➤ Always ensure a backup exists before running this script.

-----------------------------------------------------------------------------------------
 VERSION HISTORY:
     Version   Date         Author        Description
     -------   ----------   ------------  -----------------------------------------------
     1.0       09/ 11/ 2025 [Nataraj Patil]   Initial version
=========================================================================================
*/

-- Step 1: Drop database if it already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    PRINT 'Database exists. Dropping...';
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
    PRINT 'Database dropped successfully.';
END
GO

-- Step 2: Create new DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

-- Step 3: Switch context to the new database
USE DataWarehouse;
GO

-- Step 4: Create Medallion Architecture Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

PRINT 'Database and schemas created successfully.';
GO
