directory 'C:\\Softwares' do
  recursive true
  action :create
end

remote_file 'C:\\Softwares\\php_5.6.zip' do
  source node['jmfe_etaf_server']['PHP_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\php_wincache.zip' do
  source node['jmfe_etaf_server']['PHP_Wincache_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\phptwig56nts.dll' do
  source node['jmfe_etaf_server']['PHP_twig_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\php_xdebug.zip' do
  source node['jmfe_etaf_server']['PHP_Xdebug_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\php_couchbase.zip' do
  source node['jmfe_etaf_server']['PHP_Couchbase_Url']
  action :create_if_missing
end

directory 'C:\\php\\5_6' do
  recursive true
  action :create
end

powershell_script 'unzip a file' do
  code <<-EOH
  Expand-Archive -Path "C:\\Softwares\\php_5.6.zip" -DestinationPath "C:\\php\\5_6" -Force
  Expand-Archive -Path "C:\\Softwares\\php_wincache.zip" -DestinationPath "C:\\Softwares\\php_wincache" -Force
  Expand-Archive -Path "C:\\Softwares\\php_xdebug.zip" -DestinationPath "C:\\Softwares\\php_xdebug" -Force
  Expand-Archive -Path "C:\\Softwares\\php_couchbase.zip" -DestinationPath "C:\\Softwares\\php_couchbase" -Force
  EOH
end

powershell_script 'Copying files' do
  code <<-EOH
  Copy-Item -Path "C:\\Softwares\\php_wincache\\php_wincache.dll" -Destination "C:\\php\\5_6\\ext\\"
  Copy-Item -Path "C:\\Softwares\\phptwig56nts.dll" -Destination "C:\\php\\5_6\\ext\\php_twig.dll"
  Copy-Item -Path "C:\\Softwares\\php_xdebug\\php_xdebug.dll" -Destination "C:\\php\\5_6\\ext\\"
  Copy-Item -Path "C:\\Softwares\\php_couchbase\\php_couchbase.dll" -Destination "C:\\php\\5_6\\ext\\"
  Copy-Item -Path "C:\\Softwares\\php_couchbase\\libcouchbase.dll" -Destination "C:\\php\\5_6\\"
  EOH
end

directory 'C:\\Users\\Administrator\\Downloads\\php_sqlsrv' do
  recursive true
  action :create
end

remote_file 'C:\\Softwares\\sqlsrv32.exe' do
  source node['jmfe_etaf_server']['php_sql_url_exe']
  action :create_if_missing
end

powershell_script 'PHP_SQL' do
  code <<-EOH
  Start-Process -FilePath "C:\\Softwares\\sqlsrv32.exe" -ArgumentList "/C /Q /T:C:\\Users\\Administrator\\Downloads\\php_sqlsrv"
  EOH
end

remote_file 'C:\\Softwares\\cacert.pem' do
  source node['jmfe_etaf_server']['cacert_pem_Url']
  action :create_if_missing
end

powershell_script 'copy item' do
  code <<-EOH
  Copy-Item -Path "C:\\Users\\Administrator\\Downloads\\php_sqlsrv\\php_pdo_sqlsrv_56_nts.dll" -Destination "C:\\php\\5_6\\ext\\php_pdo_sqlsrv.dll"
  Copy-Item -Path "C:\\php\\5_6\\php.ini-development" -Destination "C:\\php\\5_6\\php.ini"
  Copy-Item -Path "C:\\Softwares\\cacert.pem" -Destination "C:\\php\\5_6\\"
  EOH
end

template 'C:\\Softwares\\php_ini.ps1' do
  source 'php_ini.ps1.erb'
  action :create_if_missing
  variables(
    config_file: node['jmfe_etaf_server']['php_ini_entry']
  )
end

powershell_script 'run script' do
  code 'C:\\Softwares\\php_ini.ps1'
  guard_interpreter :powershell_script
  not_if '[System.IO.File]::exists("c:\\php\\5_6\\php.ini.chefbak")'
end

env 'path' do
  delim ';'
  value 'C:\\php\\5_6'
  action :modify
end
