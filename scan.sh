docker compose up -d

if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

docker run \
    --rm \
    --network=content_sonar_network \
    -v ${YOUR_REPO}:/usr/src \
    -v ${YOUR_CACHE_DIR}:/opt/sonar-scanner/.sonar/cache \
    -e SONAR_HOST_URL="http://${SONARQUBE_URL}" \
    -e SONAR_TOKEN="${SONAR_TOKEN}" \
    -e EXTRA_ARGS="-Dsonar.projectKey=${PROJECT_KEY} \
    -Dsonar.qualitygate.wait=true \
    -Dsonar.exclusions=app/code/Hyva/CmsTailwindJit/view/adminhtml/web/*,app/code/Pointspay/Pointspay/Test \
    -Dsonar.inclusions=app/code/Perspective/**,app/code/CodeCustom/**,app/design/**,app/code/Pointspay/** \
     "\
    sonarsource/sonarqube-scan
