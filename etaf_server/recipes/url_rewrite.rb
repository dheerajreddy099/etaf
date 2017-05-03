remote_file 'C:\\Softwares\\rewrite_amd64.msi' do
  source node['jmfe_etaf_server']['rewrite_Url']
  action :create_if_missing
end

windows_package 'IIS Rewrite' do
  source 'C:\\Softwares\\rewrite_amd64.msi'
  action :install
end
