#Global variables
$imagename='cosmosdb-example-image'


#-------------------------------------------------------------------------
function Main{

    Build-Image

    New-Infrastructure

    Start-Container

    Remove-Infrastructure
}

#-------------------------------------------------------------------------
function Build-Image {
    Set-Location ./src
    Write-Host "Compiling Dotnet Code And Building Docker Image..." -ForeGround Yellow

    #Remove old image 
    docker rmi --force $(docker images -q $imagename | uniq)

    #Create Image
    docker build -t cosmosdb-example-image -f ./Dockerfile . 

    Set-Location ..
}

function Start-Container{
    Write-Host "Starting Container Execution..." -ForeGround Yellow

    #remove any old container for the image
    docker rm $(docker stop $(docker ps -a -q -f ancestor=$imagename))

    #Create Container and run the container
    docker run -d $imagename
}

function New-Infrastructure{
    Set-Location ./terraform
    Write-Host "Building Infrastructure..." -ForeGround Yellow

    #terraform initialization
    terraform init

    #applies terraform to azure. Not confirmation required.
    terraform apply -auto-approve

    Set-Location ..
}

function Remove-Infrastructure{
    Set-Location ./terraform
    Write-Host "Destroying Infrastructure..." -ForeGround Yellow

    #deletes the infrastructure
    terraform destroy -auto-approve

    Set-Location ..
}

#-------------------------------------------------------------------------s
Main