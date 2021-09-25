# **this is the deployment guide for the spring data with react tutorial rest api and front end**

the below Repo contains the following:

# 1- Azure-pipelines.yml :

to run the CI CD pipeline and setup the stages and environments (end to end Config as code)

# 2- Azure ARM Template :

this contains a JSON template to show how IOC can be deployed multiple time with diffrent configurations\Parameters

# 3-Docker Resources:

Docker File and Kubernetes Manifsts file created to push the custom Image of hosting the app to Azure container registry and on the production step to deploy the Image to Kubernetes service cluster

# 4- source code :

the code can be build using an Azure hosted agent and automated code coverage tests to be taken using JaCoco

**Prerequisites**

1-github repo and account

2-Azure Subscription with capacity to create and host the following resources(Azure Web app with deployment slots - Azure Kubernetes service cluster and Azure or mySql Server-azure container registry)

3-Devops Account with ability to create a nd import pipelines as well as setup service connections or service prinicpals nd environment variables

4- Azure account that is sued to create the Service principal for the connections needs to have at least a contributor role on the subscription or resource group where it will host the azure resourced created during the deployment

**Installation**

1-Use the Git to clone the source code [GIT](https://git-scm.com/download/win) foobar.

git clone moragheb/react-and-spring-data-rest

2-create a new Devops project in the dev.azure.com or use and exisitn one

3-create the following service connection and please keep the name so it will be used in the variable section later :

1-Azure Resources Manager Service Connection

2-Kubernetes Service Connection

3-Docker Registry Service Connection

use any existing service as those will be dynamically updated in the build)\*

(alternatively those could be automated using an Azure CLITask and using the az devops service-endpoint cmdlet)\*\*

4-update the Variable values inthe variables section of the pipeline yaml :

5-run the pipeline and observe the stages and environments as they are getting spun up

**CI/CD Stages breakdown**

# 1-Build :

use the Json template to build a azure for mySQL server and azure image registry

# 2-Compile :

use the POM.XML in the project and build a JAR in the target folder and while this is being done run Code Coverage tests using Jacoco and upload the Jar - the Code Coverage tests and the K8S Manifests files to the artifacts drop

# 3-Docker Build:

in this stage docker build and Kubectl maniest is excuted to build the needed image to eb stored in the image registry for usage and the manifests files to be sued when publishing to Azure Kubernetes Service Cluster

#4-Staging Web App with slot and application insight and azure monitor enabled:

push the docker image from the ACR to a web app with staging slot and ASP with auto scaling configured (on a CPU Metric just for POC)

#5-build the Production environment

: create the AKS cluster and upload the DACPAC to the a newly created ny DB ( this feature is not implemented)

#6-publish to AKS Cluster

: publish the docker images to single POD with load balancing enabled for auto monitoring and auditing using an Image pull secret

\*all build agents are cloud hosted so zero deployment or local infrastructure is needed . all configuration also is doene during the pipeline like the connections string config and the firewall access to the database

for more info about the overall design of the solution and the purpose for the approach as well as the breakdown of the environments please refer the HLD located on the GitHub Repo

**License**

[MIT](https://choosealicense.com/licenses/mit/)

![](RackMultipart20210925-4-497lpl_html_2a32c2bc2658c81d.gif)

C2 General
