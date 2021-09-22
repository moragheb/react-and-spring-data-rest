
#create the web service plan
az appservice plan create --name myspringbootasp --resource-group devopslinerg --is-linux --sku S1

#set the auto Scale on the  app service plan
az monitor autoscale create  --resource-group devopslinerg   --resource myspringbootasp --resource-type Microsoft.Web/serverFarms --name autoscale --count 2 --min-count 2 --max-count 5 --count 2
az monitor autoscale rule create  --resource-group devopslinerg   --autoscale-name autoscale  --condition "CpuPercentage > 70 avg 10m" --scale out 3
az monitor autoscale rule create  --resource-group devopslinerg   --autoscale-name autoscale  --condition "CpuPercentage < 30  avg 10m" --scale in 1

#create the Web App
az webapp create --resource-group devopslinerg --plan myspringbootasp --name raghebspringbootwebapp --deployment-container-image-name acrspringbootimages.azurecr.io/springappimage:latest

#create the Deployment Slot
az webapp deployment slot create --name raghebspringbootwebapp --resource-group devopslinerg --slot staging

#set the web app ruunning port
az webapp config appsettings set --resource-group devopslinerg  --name raghebspringbootwebapp --settings WEBSITES_PORT=8080
#use the esystem amanged identity to reach the image in the image registry
az webapp identity assign --resource-group devopslinerg --name raghebspringbootwebapp  --query principalId
az role assignment create --assignee b501742d-8a8a-42f5-9547-dfe96698f2c3 --scope /subscriptions/2a22bfca-1d56-46ef-9b7a-0a93d5552606/resourceGroups/devopslinerg/providers/Microsoft.ContainerRegistry/registries/acrspringbootimages --role "AcrPull"
az resource update --ids /subscriptions/2a22bfca-1d56-46ef-9b7a-0a93d5552606/resourceGroups/devopslinerg/providers/Microsoft.Web/sites/raghebspringbootwebapp/config/web --set properties.acrUseManagedIdentityCreds=True

#pull the image and deploy it 
az webapp config container set  --name raghebspringbootwebapp  --resource-group devopslinerg --docker-custom-image-name acrspringbootimages.azurecr.io/springappimage:latest --docker-registry-server-url https://acrspringbootimages.azurecr.io


