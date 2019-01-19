public class LogViewerCtrl {

    @AuraEnabled
    public static String retrieveMetadata() {
        return JSON.serialize(new Metadata());
    }

    public class Metadata {
        public String currentUserId = UserInfo.getUserId();
    }
}