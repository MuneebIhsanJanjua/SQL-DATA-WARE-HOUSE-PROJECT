/* Author : MUNEEB IHSAN JANJUA '
CREATE BRONZE table 
script purpose:
this script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
      i also make this to Store procedure so EXEC 'bronze.load_bronze' to run it automatically s
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    BEGIN TRY
    DECLARE @s_time_whole_bronze DATETIME ,@e_time_whole_bronze DATETIME;
        SET @s_time_whole_bronze = GETDATE();
    DECLARE @start_time DATETIME, @end_time DATETIME;
        SET @start_time = GETDATE(); 
            Print 'Customer Information ' ;
            TRUNCATE TABLE bronze.crm_cust_info;
            BULK INSERT bronze.crm_cust_info
            FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
        SET @end_time = GETDATE();
        PRINT('LOADING TIME ' + CAST ( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR(50) ) + 'seconds');
            Print 'prd_info ' ;
            TRUNCATE TABLE bronze.crm_prd_info;
            BULK INSERT bronze.crm_prd_info
            FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
        SET @start_time = GETDATE(); 
            Print 'Sales_deatils ' ;
            TRUNCATE TABLE bronze.crm_sales_details;
            BULK INSERT bronze.crm_sales_details
            FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
        SET @end_time = GETDATE();
        PRINT('LOADING TIME ' + CAST ( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR(50) ) + 'seconds');
            Print 'cust_az12' ;
            TRUNCATE TABLE bronze.erp_cust_az12;
            BULK INSERT bronze.erp_cust_az12
            FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
        SET @start_time = GETDATE(); 
                Print 'loc_a101' ;
            TRUNCATE TABLE bronze.erp_loc_a101;
            BULK INSERT bronze.erp_loc_a101
            FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
            PRINT 'cat_g1v2';
            TRUNCATE TABLE bronze.erp_px_cat_g1v2;
            BULK INSERT bronze.erp_px_cat_g1v2
            FROM 'C:\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
        SET @end_time = GETDATE();
        PRINT('LOADING TIME ' + CAST ( DATEDIFF(second , @start_time , @end_time ) AS NVARCHAR(50) ) + 'seconds');

            SET @e_time_whole_bronze = GETDATE();
        PRINT '==================================' ;
        PRINT ' BRONZE LAYER FULL LOADING TIME :'+ CAST(DATEDIFF(second,@s_time_whole_bronze,@e_time_whole_bronze) AS NVARCHAR(50)) + 'seconds';
        PRINT '==================================';
    END TRY
    BEGIN CATCH

        SELECT
            ERROR_NUMBER()    AS ErrorNumber,
            ERROR_MESSAGE()   AS ErrorMessage,
            ERROR_LINE()      AS ErrorLine,
            ERROR_PROCEDURE() AS ErrorProcedure;

    END CATCH
END;
