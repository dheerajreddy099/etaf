powershell_script 'Enable Webserver IIS' do
  code <<-EOH
  Install-WindowsFeature Web-Server,Web-Net-Ext,Web-Net-Ext45,Web-ASP,Web-ASP-Net,Web-ASP-Net45,Web-CGI,Web-Mgmt-Tools,Web-Mgmt-Console,Web-Mgmt-Compat
  EOH
end
