directory 'C:\\inetpub\\wwwroot\\drupal' do
  recursive true
  action :create
end

remote_file 'C:\\Softwares\\drupal-7.54.zip' do
  source node['jmfe_etaf_server']['drupal_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\wincachedrupal-8.x-1.10.zip' do
  source node['jmfe_etaf_server']['wincache_drupal_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\couchbasedrupal-8.x-1.18.zip' do
  source node['jmfe_etaf_server']['couchbase_drupal_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\supercache-8.x-1.0.zip' do
  source node['jmfe_etaf_server']['supercache_drupal_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\composer_manager-8.x-1.0-rc2.zip' do
  source node['jmfe_etaf_server']['composer_manager_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\sqlsrv-8.x-1.0-rc4.zip' do
  source node['jmfe_etaf_server']['sqlsrv_Url']
  action :create_if_missing
end

powershell_script 'Drupal Unzip' do
  code <<-EOH
  Expand-Archive "C:\\Softwares\\drupal-7.54.zip" -DestinationPath "C:\\Softwares\\drupal-7.54" -Force
  Expand-Archive "C:\\Softwares\\wincachedrupal-8.x-1.10.zip" -DestinationPath "C:\\Softwares\\wincachedrupal-8.x-1.10" -Force
  Expand-Archive "C:\\Softwares\\couchbasedrupal-8.x-1.18.zip" -DestinationPath "C:\\Softwares\\couchbasedrupal-8.x-1.18" -Force
  Expand-Archive "C:\\Softwares\\supercache-8.x-1.0.zip" -DestinationPath "C:\\Softwares\\supercache-8.x-1.0" -Force
  Expand-Archive "C:\\Softwares\\composer_manager-8.x-1.0-rc2.zip" -DestinationPath "C:\\Softwares\\composer_manager-8.x-1.0-rc2" -Force
  Expand-Archive "C:\\Softwares\\sqlsrv-8.x-1.0-rc4.zip" -DestinationPath "C:\\Softwares\\sqlsrv-8.x-1.0-rc4" -Force
  EOH
end

powershell_script 'Copy Drupal Files' do
  code <<-EOH
  Move-Item -Path "C:\\Softwares\\drupal-7.54\\drupal-7.54\\*" -Destination "C:\\inetpub\\wwwroot\\drupal"
  Move-Item -Path "C:\\Softwares\\wincachedrupal-8.x-1.10\\*" -Destination "C:\\inetpub\\wwwroot\\drupal\\modules"
  Move-Item -Path "C:\\Softwares\\couchbasedrupal-8.x-1.18\\*" -Destination "C:\\inetpub\\wwwroot\\drupal\\modules"
  Move-Item -Path "C:\\Softwares\\supercache-8.x-1.0\\*" -Destination "C:\\inetpub\\wwwroot\\drupal\\modules"
  Move-Item -Path "C:\\Softwares\\composer_manager-8.x-1.0-rc2\\*" -Destination "C:\\inetpub\\wwwroot\\drupal\\modules"
  Move-Item -Path "C:\\Softwares\\sqlsrv-8.x-1.0-rc4\\*" -Destination "C:\\inetpub\\wwwroot\\drupal\\modules"
  EOH
  guard_interpreter :powershell_script
  not_if { ::File.exist? 'C:\\inetpub\\wwwroot\\drupal\\modules\\sqlsrv\\sqlsrv.install' }
end

powershell_script 'Adding a new website' do
  code <<-EOH
  New-Website -Name drupal -ApplicationPool drupal -Port 81 -PhysicalPath C:\\inetpub\\wwwroot\\drupal -Force
  EOH
end

# powershell_script 'Registering a new PHP version' do
#  code <<-EOH
#  New-PHPVersion -ScriptProcessor "C:\\PHP\\5_6\\php-cgi.exe"
#  EOH
# end

# not_if '([System.IO.File]::exists("C:\\inetpub\\wwwwroot\\drupal\\modules\\couchbasedrupal\\src\\CouchbaseManager.php"))'
# not_if '([System.IO.File]::exists("C:\\inetpub\\wwwwroot\\drupal\\modules\\couchbasedrupal\\src\\CouchbaseManager.php"))'

# not_if::File.exists?('C:\\inetpub\\wwwwroot\\drupal\\modules\\couchbasedrupal\\src\\CouchbaseManager.php')
