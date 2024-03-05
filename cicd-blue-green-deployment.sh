# shellcheck disable=SC1036
param
(
    # shellcheck disable=SC1035
    # shellcheck disable=SC1073
    # shellcheck disable=SC1072
    [Parameter(Mandatory=$true)] [string]$APP,
    [Parameter(Mandatory=$true)] [string]$GREEN_CONTAINER_DEPLOY_TAG
)

$BLUE_CONTAINERS = docker ps -qf "name=$APP"
$BLUE_CONTAINERS_SCALE = ($BLUE_CONTAINERS -split " ").Count

$GREEN_CONTAINERS_SCALE = $BLUE_CONTAINERS_SCALE * 2
if ($BLUE_CONTAINERS_SCALE -eq 0) {
    $GREEN_CONTAINERS_SCALE = 1
}

docker compose up -d $APP --scale "$APP=$GREEN_CONTAINERS_SCALE" --no-recreate --no-build

do {
    Start-Sleep -Milliseconds 100
    $healthyContainers = docker ps -q -f "name=$APP" -f "health=healthy" | Measure-Object -Line | Select-Object -ExpandProperty Lines
} until ($healthyContainers -eq $GREEN_CONTAINERS_SCALE)

if ($BLUE_CONTAINERS_SCALE -gt 0) {
    docker kill --signal=SIGTERM $BLUE_CONTAINERS
}
