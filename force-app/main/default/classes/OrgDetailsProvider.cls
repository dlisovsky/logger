public class OrgDetailsProvider extends AbstractDetailsProvider {

    public override Map<String, Object> onFlushDetails(Map<String, Object> existingDetails) {

        if (!existingDetails.containsKey('organisation')) {

            List<Organization> organizations = [
                SELECT Id, Name, InstanceName, IsSandbox, OrganizationType
                FROM Organization
                WHERE Id = :UserInfo.getOrganizationId()
            ];

            if (!organizations.isEmpty()) {
                existingDetails.put(
                    'organisation',
                    organizations.get(0)
                );
            }

        }

        return existingDetails;
    }
}