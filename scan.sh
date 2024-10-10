docker compose up -d
YOUR_CACHE_DIR=/tmp/sonar/cache/
YOUR_REPO=/home/monteshot/ApacheSites/pointspay.test/content/
SONARQUBE_URL="sonarqube:9000"
SONAR_TOKEN="sqp_3fb3dbeea26d6dcf01444c7b1193d5305cddc147"
PROJECT_KEY="pointspay"

docker run \
    --rm \
    --network=content_sonar_network \
    -v ${YOUR_REPO}:/usr/src \
    -v ${YOUR_CACHE_DIR}:/opt/sonar-scanner/.sonar/cache \
    -e SONAR_HOST_URL="http://${SONARQUBE_URL}" \
    -e SONAR_TOKEN="${SONAR_TOKEN}" \
    -e EXTRA_ARGS="-Dsonar.projectKey=${PROJECT_KEY} -Dsonar.qualitygate.wait=true  -Dsonar.exclusions=app/code/Hyva/CmsTailwindJit/view/adminhtml/web/*,app/code/Pointspay/Pointspay/Test  -Dsonar.inclusions=app/code/Perspective/**,app/code/CodeCustom/**,app/design/**,app/code/Pointspay/** "\
    sonarsource/sonarqube-scan
