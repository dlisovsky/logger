public class PlatformEventsListenerCtrl {

    @AuraEnabled
    public static String getSessionId() {
        return UserInfo.getSessionId();
    }

}