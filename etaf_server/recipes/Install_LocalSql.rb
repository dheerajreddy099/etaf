#
# Cookbook Name:: JMFE_BIZTALK
# Recipe:: InstallSQL_AllFeatures
#
# Copyright (C) 2016  Dwight Goins
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# curl -u myUser:myP455w0rd! -X PUT "http://localhost:8081/artifactory/my-repository/my/new/artifact/directory/file.txt" -T Desktop/myNewFile.txt
# requires the JMFE_BizTalk::Default recipe to be run first

reboot 'now' do
  action :nothing
  reason 'Needs SQLPS installed properly'
  delay_mins 5
end

directory 'c:\Setup\SQL' do
  recursive true
  action :create
end

directory 'D:\Program Files (x86)\Microsoft SQL Server\DReplayClient\WorkingDir' do
  recursive true
  action :create
end

directory 'D:\Program Files (x86)\Microsoft SQL Server\DReplayClient\ResultDir' do
  recursive true
  action :create
end

remote_file 'c:\\setup\\sql\\en_sql_server_2014_developer_edition_with_service_pack_2_x64_dvd_8967821.iso' do
  source node['JMFE_BIZTALK']['SQL_ISOUrl']
  action :create_if_missing
end
log "#{cookbook_name}::SQL Iso downloaded from Artifactory to c:\\setup\\sql successfully"

template 'c:\\setup\\sql\\Configuration.ini' do
  source 'SQL_server_config.erb'
  action :create_if_missing
end
log "#{cookbook_name}::SQL Conifguration.ini  C:\\setup\\sql\\Configuration.ini successfully"

cookbook_file 'c:\\setup\\sql\\InstallSQL.ps1' do
  source 'InstallSQL.ps1'
  action :create_if_missing
  # file name in in ur files dir
end
log "#{cookbook_name}::InstallSQL.ps1 Silently Powershell script downloaded"

powershell_script 'Install SQL' do
  code <<-EOH

    $sqlIsoFile = "#{node.default['JMFE_BIZTALK']['SQL_ISO_FILE']}"
    $sqlMountResult = (Mount-DiskImage $sqlIsoFile -PassThru)
    $sqlDriveLetter = ($sqlMountResult | Get-Volume).Driveletter
    $sqlDrive = $sqlDriveLetter + ":"
    cd $sqlDrive

    start-Process -filePath ".\\setup.exe" -argumentList "/q /ACTION=Install /UpdateEnabled=false /ConfigurationFile=c:\\setup\\SQL\\configuration.ini /SAPWD=pass@word1 /SECURITYMODE=SQL /IACCEPTSQLSERVERLICENSETERMS=true" -wait
    dismount-diskimage $sqlIsoFile

    EOH
  guard_interpreter :powershell_script
  notifies :reboot_now, 'reboot[now]', :immediately
  not_if '[System.IO.File]::Exists("D:\\Program Files\\Microsoft SQL Server\\MSSQL12.MSSQLSERVER\\MSSQL\\Binn\\sqlservr.exe")'
end
log "#{cookbook_name}::Installed SQL 2014 Successfully"
