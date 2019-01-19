public class LogHandlersFactory {

    public List<ILogHandler> getHandlers() {

        List<ILogHandler> logHandlers = new List<ILogHandler>();

        if (Test.isRunningTest()) {
            return logHandlers;
        }

        List<Log_Handler__mdt> settings = LoggerSettingsService.getDefaultActiveLoggerHandlersSettings();

        for (Log_Handler__mdt setting : settings) {

            Map<String, Object> settingMap;
            try {
                settingMap = (Map<String, Object>) JSON.deserializeUntyped(setting.Setting__c);
            } catch (Exception ex) {
                System.debug(ex.getMessage() + ' ' + ex.getStackTraceString());
                settingMap = new Map<String, Object>();
            }

            try {
                Type handlerType = Type.forName(
                    setting.Namespace__c,
                    setting.Type__c
                );
                ILogHandler logHandler = (ILogHandler) handlerType.newInstance();
                logHandler.setSettings(settingMap);

                logHandlers.add(logHandler);
            } catch (Exception ex) {
                System.debug(ex.getMessage() + ' ' + ex.getStackTraceString());
            }
        }

        return logHandlers;
    }

}