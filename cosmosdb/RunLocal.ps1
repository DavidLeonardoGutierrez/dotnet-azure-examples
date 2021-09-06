#------------------------------------------------------------------------- Global variables
$imagename='cosmosdb-example-image'

#------------------------------------------------------------------------- Functions Library
function Build-Image {
    Set-Location ./src
    Write-Host "Compiling And Building Image..." -ForeGround Yellow

    #Remove old image 
    docker rmi --force $(docker images -q $imagename | uniq)

    #Create Image
    docker build -t $imagename -f ./Dockerfile . 

    Set-Location ..
}

function Start-Container{
    Write-Host "Starting Container Execution..." -ForeGround Yellow

    #Create Container and run the container
    docker run -d $imagename

    Write-Host "The application is running. See the Docker logs to check the results..." -ForeGround Black -BackgroundColor Green
}

function Remove-Container{
    Write-Host "Removing Container..." -ForeGround Yellow

    #remove any old container for the image
    docker rm $(docker stop $(docker ps -a -q -f ancestor=$imagename))
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

function Wait-ForUser{
    Write-Host -ForeGround Yellow -NoNewLine 'Press any key to continue...';

    #Wait for the user :) 
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}

#----------------------------------------------------------------Main Process Definition
function Main{

    Build-Image
    New-Infrastructure
    Start-Container
    Wait-ForUser
    Remove-Container
    Remove-Infrastructure
}

#----------------------------------------------------------------Entrypoint
Main