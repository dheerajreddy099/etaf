remote_file 'C:\\Softwares\\SQLManagementStudio_x64_ENU.exe' do
  source node['jmfe_etaf_server']['SQLManagementStudio_Url']
  action :create_if_missing
end

template 'C:\\Softwares\\sql_management_studio.ini' do
  source 'sql_management_studio_ini.erb'
  action :create_if_missing
end

powershell_script 'Install SQL Management Studio' do
  code <<-EOH

  C:\\Softwares\\SQLManagementStudio_x64_ENU.exe /QUIET /SAPWD=C0mp!ex /ConfigurationFile=C:\\Softwares\\sql_management_studio.ini /TCPENABLED=1 /SECURITYMODE="SQL"
  Start-Sleep -s 300

  EOH
end

# C:\\Softwares\\SQLManagementStudio_x64_ENU.exe /QUIET /SAPWD=C0mp!ex /ConfigurationFile=C:\\Softwares\\sql_management_studio.ini /TCPENABLED=1 /SECURITYMODE="SQL"
