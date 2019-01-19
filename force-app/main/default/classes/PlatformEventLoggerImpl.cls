public class PlatformEventLoggerImpl extends LoggerImpl {

    public override Log publish(Log logToPublish) {

        if (logToPublish.isEmpty()) {
            return logToPublish;
        }

        Database.SaveResult saveResult = EventBus.publish(
            new Log__e(
                Details__c = JSON.serialize(logToPublish.getDetails(), false),
                Data__c = JSON.serialize(logToPublish.getLogItems(), false)
            )
        );

        return logToPublish;
    }

}