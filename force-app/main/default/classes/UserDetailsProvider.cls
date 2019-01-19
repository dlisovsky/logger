public class UserDetailsProvider extends AbstractDetailsProvider {

    public override Map<String, Object> onFlushDetails(Map<String, Object> existingDetails) {

        if (!existingDetails.containsKey('user')) {

            List<User> users = [
                SELECT Id, Name, Email, UserType,
                    LanguageLocaleKey, TimeZoneSidKey, LocaleSidKey,
                    ProfileId, Profile.Name
                FROM User
                WHERE Id = :UserInfo.getUserId()
            ];

            if (!users.isEmpty()) {
                existingDetails.put(
                    'user',
                    users.get(0)
                );
            }

        }

        return existingDetails;
    }


}