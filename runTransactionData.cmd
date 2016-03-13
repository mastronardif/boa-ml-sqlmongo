echo . |time|findstr [0-9]
echo off

rem set MY_DB=iclicker
set MY_DB=webclicker
set MY_USER=iclicker
set MY_PW=iclicker 

	rem Step: 1. export transactions.
rem bcp "[%MY_DB%].[dbo].[UT_USED_REMOTE_TRANSACTION_LOG]" out animal.Dat -n -S WIN-TJV44UC3B0B -U "%MY_USER%" -P iclicker

	rem Step: 2. import transactions local database.
rem bcp "[%MY_DB%].[dbo].[UT_USED_REMOTE_TRANSACTION_LOG]" in  animal.Dat -n -S localhost -U "%MY_USER%" -P iclicker
bcp "[%MY_DB%].[dbo].[TaxByZip_OUT_US]" in  animal.Dat -n -S localhost -U "%MY_USER%" -P iclicker

rem sqlcmd  -b -E -S USSMAHMASTRONF\SQLXD1 -d "%MY_DB%" -y 0 -w 999 -s ", " -Q "select * from clickers"
rem sqlcmd  -b -E  -d "%MY_DB%" -y 0 -w 999 -s ", " -Q "select * from clickers"

	rem Step: 3. Parse the transaction data.
rem sqlcmd  -b -S localhost -U "%MY_USER%" -P iclicker -d "%MY_DB%" -h -1 -W -s ", " -i  exportTransactions.sql -o TheTransactions.sql

	rem Step: 4 import the transactions.
rem sqlcmd  -b -S localhost -U "%MY_USER%" -P iclicker -d "%MY_DB%" -h -1 -W -s ", " -i  TheTransactions.sql -o 222.msg

	rem now see: script_Purchase_transactions.sql - now you have the data in a table 
rem time/T
echo . |time|findstr [0-9]