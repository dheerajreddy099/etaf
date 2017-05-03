# # encoding: utf-8

# Inspec test for recipe jmfe_etaf_server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

# Replace these controls with meaningful controls/tests.

# Controls make it so that the tests can be grouped and can have a compliance
# test run against the node as well.

control 'default-test-1.0' do
  impact 1.0
  title 'An example of inspec testing'
  describe package('some_package') do
    it { should be_installed }
  end
end

unless os.windows?
  control 'default-test-1.1' do
    impact 1.0
    title 'An example of inspec testing'
    describe package('some_package') do
      it { should be_installed }
    end
  end
end
