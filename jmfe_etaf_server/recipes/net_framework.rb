powershell_script 'Enable .Net Framework' do
  code <<-EOH
  Install-WindowsFeature -Name "Net-framework-Core" -Source "C:\\Windows\\SoftwareDistribution"
  EOH
end
