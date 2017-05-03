remote_file 'C:\\Softwares\\sqlsrv-8.x-1.0-rc4.zip' do
  source node['jmfe_etaf_server']['sqlsrv_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\netutilities_2_0_0_8.zip' do
  source node['jmfe_etaf_server']['net_utilities_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\oleview2.zip' do
  source node['jmfe_etaf_server']['oleview2_Url']
  action :create_if_missing
end

remote_file 'C:\\Softwares\\AjaxMinSetup.msi' do
  source node['jmfe_etaf_server']['AjaxMinSetup_Url']
  action :create_if_missing
end

powershell_script 'Expand Files' do
  code <<-EOH
  Expand-Archive "C:\\Softwares\\sqlsrv-8.x-1.0-rc4.zip" -DestinationPath "C:\\inetpub\\wwwroot\\drupal\\modules" -Force
  Expand-Archive "C:\\Softwares\\netutilities_2_0_0_8.zip" -DestinationPath "C:\\php\\5_6" -Force
  Expand-Archive "C:\\Softwares\\oleview2.zip" -DestinationPath "C:\\php\\5_6\\" -Force
  EOH
end

powershell_script 'Copy the files' do
  code <<-EOH
  Copy-Item -Path "C:\\inetpub\\wwwroot\\drupal\\modules\\sqlsrv\\drivers\\*" -Destination "C:\\inetpub\\wwwroot\\drupal\\drivers\\"
  EOH
  guard_interpreter :powershell_script
  not_if { ::File.exist? 'C:\\inetpub\\wwwroot\\drupal\\drivers\\lib' }
end

# Deploying Netphp

powershell_script 'Registering types in CMD' do
  cwd 'C:\\php\\5_6\\'
  code <<-EOH
  cmd.exe /c "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\RegAsm.exe netutilities.dll /codebase"
  EOH
end

# AjaxMinSetup

powershell_script 'ajax file install' do
  code <<-EOH
  msiexec.exe /I C:\\Softwares\\AjaxMinSetup.msi /quiet
  EOH
end

# This can be done only if there is libraries folder created already

# powershell_script 'Ajax dll file copy' do
#  code <<-EOH
#  Copy-Item -Path "C:\\Program Files (x86)\\Microsoft\\Microsoft Ajax Minifier\\AjaxMin.dll" -DestinationPath "C:\\inetpub\\wwwroot\\drupal\\libraries\\_bin\\AjaxMin\\"
#  Copy-Item -Path "C:\\Program Files (x86)\\Microsoft\\Microsoft Ajax Minifier\\AjaxMinTask.dll" -DestinationPath "C:\\inetpub\\wwwroot\\drupal\\libraries\\_bin\\AjaxMin\\"
#  EOH
# end

# Access control to folder c:\inetpub\wwwroot

powershell_script 'Access Control' do
  code <<-EOH
  $Acl = Get-Acl "C:\\inetpub\\wwwroot"
  $Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
  $Acl.SetAccessRule($Ar)
  Set-Acl "C:\\inetpub\\wwwroot" $Acl

  $Acl = Get-Acl "C:\\inetpub\\wwwroot"
  $Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
  $Acl.SetAccessRule($Ar)
  Set-Acl "C:\\inetpub\\wwwroot" $Acl
  EOH
end

# not_if '[System.IO.File]::exists("C:\\inetpub\\wwwroot\\drupal\\drivers\\lib")'
