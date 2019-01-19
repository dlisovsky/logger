#Creating Package Version
echo "Creating Package Version..."
VERSION_ID=`sfdx force:package:version:create -p "Logger" -d force-app --wait 30 -x -v DevHub --json | json result.SubscriberPackageVersionId`
echo ${VERSION_ID}

PACKAGE_DETAILS="Logger: \`/packaging/installPackage.apexp?p0=${VERSION_ID}\`"
echo "${PACKAGE_DETAILS}"

# echo "Promoting a Package Version..."
# sfdx force:package:version:promote -p ${VERSION_ID} -n -v DevHub && PACKAGE_DETAILS="RELEASE! ${PACKAGE_DETAILS}" || PACKAGE_DETAILS="BETA! ${PACKAGE_DETAILS}"

PACKAGE_REPORT=$(sfdx force:package:version:report -v DevHub -p ${VERSION_ID})
echo "${PACKAGE_REPORT}"
PACKAGE_DETAILS="${PACKAGE_DETAILS} \`\`\`${PACKAGE_REPORT}\`\`\`"

echo ${PACKAGE_DETAILS}

slackcli -h ${SLACK_CHANNEL} -m "${PACKAGE_DETAILS}" --pin -u "Circle CI" -e ":the_horns:"
