remote_file 'C:\\Softwares\\SQLEXPR_x64_ENU.exe' do
  source node['jmfe_etaf_server']['sql_express_Url']
  action :create_if_missing
end

template 'C:\\Softwares\\sql_express.ini' do
  source 'sql_express_ini.erb'
  action :create_if_missing
end

powershell_script 'SQL Express Install' do
  code <<-EOH

  C:\\Softwares\\SQLEXPR_x64_ENU.exe /QUIET /SAPWD=C0mp!ex /ConfigurationFile=C:\\Softwares\\sql_express.ini /TCPENABLED=1 /SECURITYMODE="SQL"
  Start-Sleep -s 300

  EOH
end

# Start-Process -filePath ".\\SQLEXPR_x64_ENU.exe" -argumentList "/QUIET /SAPWD=C0mp!ex /ConfigurationFile=C:\\Softwares\\sql_express.ini /TCPENABLED=1 /SECURITYMODE="SQL"" -wait

# C:\\Softwares\\SQLEXPR_x64_ENU.exe /QUIET /SAPWD=C0mp!ex /ConfigurationFile=C:\\Softwares\\sql_express.ini /TCPENABLED=1 /SECURITYMODE="SQL"
# Start-Sleep -s 300
