sfdx force:source:push -u ${CIRCLE_BRANCH}
sfdx force:apex:test:run --testlevel RunLocalTests --outputdir test-results --resultformat tap --targetusername ${CIRCLE_BRANCH}
sfdx force:org:delete -u ${CIRCLE_BRANCH} -p
# sfdx force:apex:test:run -u ${CIRCLE_BRANCH} --wait 10