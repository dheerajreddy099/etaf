remote_file 'C:\\Softwares\\sqlncli.msi' do
  source node['jmfe_etaf_server']['sqlncli_msi_Url']
  action :create_if_missing
end

powershell_script 'PHP_SQL' do
  code <<-EOH
  C:\\Softwares\\sqlncli.msi /quiet IACCEPTSQLNCLILICENSETERMS=YES
  EOH
end
