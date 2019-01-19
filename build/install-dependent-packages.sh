#Installing the Dependent Packages
echo "Installing the Dependent Packages..."
# sfdx force:package:install --package "Logger" --noprompt -w 10 -u ${CIRCLE_BRANCH}
# sfdx force:package:install --package "fflib" --noprompt -w 10 -u ${CIRCLE_BRANCH}