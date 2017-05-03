remote_file 'C:\\Softwares\\PHPManagerForIIS-1.2.0-x64.msi' do
  source node['jmfe_etaf_server']['PHPManager_IIS_Url']
  action :create_if_missing
end

powershell_script 'PHP Manager for IIS' do
  code <<-EOH
  C:\\Softwares\\PHPManagerForIIS-1.2.0-x64.msi /quiet IACCEPTSQLNCLILICENSETERMS=YES
  Start-Sleep -s 150
  EOH
end
