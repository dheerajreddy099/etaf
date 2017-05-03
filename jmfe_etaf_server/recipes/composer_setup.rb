remote_file 'C:\\Softwares\\Composer-Setup.exe' do
  source node['jmfe_etaf_server']['composer_setup_exe_Url']
  action :create_if_missing
end

# powershell_script 'Composer Setup Silent Install' do
#  code <<-EOH
#  C:\\Softwares\\Composer-Setup.exe /SILENT
#  EOH
# end
