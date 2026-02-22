# PowerShell script to replace make up_build
Write-Host "Building broker binary..." -ForegroundColor Green
Set-Location "..\broker-service"
$env:GOOS="linux"
$env:GOARCH="amd64"
$env:CGO_ENABLED="0"
go build -o brokerApp ./cmd/api

if ($LASTEXITCODE -eq 0) {
    Write-Host "Broker binary built successfully!" -ForegroundColor Green
    
    Write-Host "Stopping docker images (if running)..." -ForegroundColor Yellow
    Set-Location "..\project"
    docker-compose down
    
    Write-Host "Building (when required) and starting docker images..." -ForegroundColor Yellow
    docker-compose up --build -d
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Docker images built and started!" -ForegroundColor Green
    } else {
        Write-Host "Docker build failed!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Broker build failed!" -ForegroundColor Red
    exit 1
}
