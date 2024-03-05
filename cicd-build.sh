# shellcheck disable=SC1036
# shellcheck disable=SC1088
# shellcheck disable=SC1088
# shellcheck disable=SC1065
# shellcheck disable=SC1088
param (
    [Parameter(Mandatory=$true)] [string]$APP
)

$ROOT = Get-Location

Set-Location "$APP"

./mvnw clean
./mvnw versions:set -DremoveSnapshot
$APP_VERSION = ./mvnw -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec
./mvnw package
./mvnw versions:set -DnextSnapshot

git add pom.xml
git commit -m "cicd: bump version ${APP}:${APP_VERSION}"

Set-Location "$ROOT"
docker compose build --no-cache "$APP"

docker images "dio/${APP}"
