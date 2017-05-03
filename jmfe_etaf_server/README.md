jmfe_etaf_server
================
[Enter the cookbook description here.]

Supports
------------
* [List of Operating System and OS Versions Supported by the cookbook]

Requirements
------------
#### Software
* [None | List of Required software, ie. Chef 12+]

#### Dependent Cookbooks
* [None | List of names of dependent cookbook]

#### Secrets
The vault-base should always be variablized in the cookbook to be

*vault-base = node['DeploymentStage']

* [None | List of required vault paths and secrets]

*Example and Notes*
```
* #{vault-base}/common/certificate-cld.jmfamily.com : The certificate used in the cookbook to configure the NGINX server to listen securely.  This is a common secret.
* #{vault-base}/common/user-appingix : The service account used to run nginx.  This is a common secret.
* #{vault-base}/common/artifactory/credentials : Contains username and password to connect to artifactory. This is a common secret.
* #{vault-base}/#{app_name}/#{role}/user-db-user : The service account used to run the database for this application.  This application and role specific secert.
* #{vault-base}/#{app_name}/common/appname-generated-oid : This is a secret that the app has written that other roles in the app may need to read. Its the only location the application can write and read secrets.
```
The idea of this is that this section should tell the user what secrets to create and where so that the cookbook will work.

For a concrete example, see https://git.jmfamily.com/cookbooks/jmfe_vault

Attributes
-------------
* [None | List of attributes and meaning, Each attribute should take the form of [Attribute Name]: [Attribute Usage]]

Resources
-------------
#### Resource/Provider
* [None | List of Resource/Provider]

#### Libraries
* [None | List of Libraries]

#### Exception/Report Handlers
* [None | List of Exceptions and Report Handlers]

#### Matchers
* [None | List of matchers]

Usage
-------------
[Add common usages here.]

Recipes
-------------
#### jmfe_etaf_server::default
[Description of the default cookbook recipe]

#### jmfe_etaf_server::some_other_recipe
[Description of another recipe]
... Continue to add Recipes and their descriptions.

TODO
-------------
* [None | List of items to be refactored or added to this cookbook.]
