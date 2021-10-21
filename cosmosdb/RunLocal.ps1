#------------------------------------------------------------------------- Global variables
$imagename='cosmosdb-example-image'
$containerRegistryDomain = 'cloudpracticescontainerregistry01'
$imageTag = 'v.0.0.1'

#------------------------------------------------------------------------- Functions Library
function Build-Image {
    Write-Host "Compiling And Building Image..." -ForeGround Yellow
    Set-Location ./src

    #Remove old image 
    docker rmi --force $(docker images -q $imagename | uniq)

    #Create Image
    docker build -t $imagename -f ./Dockerfile . 

    Set-Location ..
    Write-Host "Completed...:)" -ForeGround Green
}

function Push-ContainerToRegistry {
    Write-Host "Uploading the image to the Azure container registry..." -ForeGround Yellow

    $imageContainerRegistryPath = [string]::Format("{0}.azurecr.io/{1}:{2}", $containerRegistryDomain, $imagename, $imageTag)

    docker tag $imagename $imageContainerRegistryPath
    az acr login -n $containerRegistryDomain
    docker push $imageContainerRegistryPath

    Write-Host "Completed...:)" -ForeGround Green
}

function Deploy-KubernetesManifest {
    Write-Host "Starting the deployment to the cluster..." -ForeGround Yellow
    Set-Location ./kubernetes

    kubectl apply -f ./demoapp.yaml

    Set-Location ..
    Write-Host "Completed...:)" -ForeGround Green

}

function Start-Container{
    Write-Host "Starting container execution..." -ForeGround Yellow

    #Create Container and run the container
    docker run -d $imagename

    Write-Host "Completed...:)" -ForeGround Green

    Write-Host "The application is running. See the Docker logs to check the results..." -ForeGround Black -BackgroundColor Green
}

function Remove-Container{
    Write-Host "Removing container..." -ForeGround Yellow

    #remove any old container for the image
    docker rm $(docker stop $(docker ps -a -q -f ancestor=$imagename))

    Write-Host "Completed...:)" -ForeGround Green
}

function New-Infrastructure{
    Write-Host "Building infrastructure..." -ForeGround Yellow
    Set-Location ./terraform

    #terraform initialization
    terraform init

    #applies terraform to azure. Not confirmation required.
    terraform apply -auto-approve

    Set-Location ..
    Write-Host "Completed...:)" -ForeGround Green
}

function Remove-Infrastructure{
    Write-Host "Destroying infrastructure..." -ForeGround Yellow
    Set-Location ./terraform

    #deletes the infrastructure
    terraform destroy -auto-approve

    Set-Location ..
    Write-Host "Completed...:)" -ForeGround Green
}

function Wait-ForUser{
    Write-Host -ForeGround Yellow -NoNewLine 'Press any key to continue...';

    #Wait for the user :) 
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}

#----------------------------------------------------------------Main Process Definition
function Main{

    #Build-Image
    #New-Infrastructure
    #Push-ContainerToRegistry
    Deploy-KubernetesManifest
    #Start-Container
    Wait-ForUser
    #Remove-Container
    #Remove-Infrastructure
}

#----------------------------------------------------------------Entrypoint
Main