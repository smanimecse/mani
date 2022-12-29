# 1. Change the patch and name of each run D:\Source\SQL_Patch\CU_info.html
# 2. Change the query: Namelevel like '%2014%' & and P.servername not like '%server name%'
# 3. Check the path, make sure the file is exists : $patch_path ="\\share\SQL Service Pack All versions\SQL2014\"
# 4. Change the version name $version = '2014SP3'
# 5. Make sure PS version on remote server is above 3.0 and remoting Enable-PSRemoting with port opened 5985

#Method 1 - Get data from table and write results into different table
#You should have a table which will have at least servername and version number
#In this I used my automon table description, version_number
Get-DbaBuildReference -Update
$Instance = "servername"
$Database = "DBName"
$InstancesTable = "dbo.DBA_ALL_SERVERS"
$SQLServersBuilds = Invoke-DbaQuery -SqlInstance $Instance -Database $Database -Query "SELECT description, version_number FROM $InstancesTable where SVR_status ='running'" #-SqlCredential 'domain\user'
$Data = $SQLServersBuilds | ForEach-Object {
    $build = $_.version_number.SubString(0, $_.version_number.LastIndexOf('.'))
    $serverName = $_.description
    Test-DbaBuild -Build $build  -MaxBehind "0CU" | Select-Object @{Name="ServerName";Expression={$serverName}}, *
} #| export-csv -Path D:\Source\SQL_Patch\All_SP_CU_maxbehind_1_CU.csv -NoTypeInformation
Write-DbaDbTableData -SqlInstance $Instance -InputObject $Data -table dbo.SQLPatch_05_april_2020 -database DBAdata -AutoCreateTable -Confirm
 

# Method 2 - Load into a table set server from txt file

$servers = get-content '\\Share\Powershell\Server.txt' | Test-DbaBuild  -MaxBehind "0CU"
Write-DbaDbTableData -SqlInstance Localinstance -InputObject $servers -table dbo.SQLPatch_05_april_2020  -database DBAdata -AutoCreateTable -Confirm