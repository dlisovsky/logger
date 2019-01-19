public class LoggerFactory {

    public ILogger getLogger() {
        ILogger loggerImpl;

        try {
            loggerImpl = createInstanceFromSetting();
        } catch (Exception ex) {
            System.debug(ex.getMessage() + ' ' + ex.getStackTraceString());
        }
        if (loggerImpl == null) {
            loggerImpl = new LoggerImpl(); // default logger impl.
        }

        return loggerImpl;
    }

    private ILogger createInstanceFromSetting() {
        Logger__mdt setting = LoggerSettingsService.getDefaultActiveLoggerSetting();

        if (setting != null) {
            return createInstanceFromSetting(setting);
        }

        return null;
    }

    private ILogger createInstanceFromSetting(Logger__mdt loggerSetting) {
        Type loggerType = Type.forName(
            loggerSetting.Namespace__c,
            loggerSetting.Type__c
        );
        return (ILogger) loggerType.newInstance();
    }
}