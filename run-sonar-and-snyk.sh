#!/bin/bash

echo "----------------------------------------------"
echo "Inciando Scan SonarCloud..."
echo "----------------------------------------------"

mvn sonar:sonar \
   -Dsonar.projectKey=rabay_spring-security-example \
   -Dsonar.organization=rabay \
   -Dsonar.sources=src/main/java,src/main/resources \
   -Dsonar.tests=src/test/java \
   -Dsonar.qualitygate.wait=true \
   -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml \
   -Dsonar.host.url=https://sonarcloud.io \
   -Dsonar.token=a3e6ef22a6a816a697284eec95c597cfa080e5d3

echo "----------------------------------------------"
echo "Inciando Scan de Dependências com Snyk..."
echo "----------------------------------------------"

snyk test --fail-on=all \
          --severity-threshold=high \
          --sarif-file-output=reports/snyk-scan.sarif
# Exit codes
#   Possible exit codes and their meaning:
#   0: success (scan completed), no vulnerabilities found
#   1: action_needed (scan completed), vulnerabilities found
#   2: failure, try to re-run the command. Use -d to output the debug logs.
#   3: failure, no supported projects detected

echo "----------------------------------------------"
echo "Inciando SAST com Snyk..."
echo "----------------------------------------------"

snyk code test --sarif-file-output=./reports/snyk-code.sarif

## snyk code --sarif
## --sarif-file-output=<OUTPUT_FILE_PATH>
## --severity-threshold=<low|medium|high>