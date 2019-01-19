public class LoggerSettingsService {

    public static final String DEFAULT_LOGGER_SETTING_NAME = 'DEFAULT_LOGGER';

    public static Logger__mdt getDefaultLoggerSetting() {
        List<Logger__mdt> settings = [
            SELECT Is_Active__c, DeveloperName, Namespace__c, Type__c
            FROM Logger__mdt
            WHERE DeveloperName = :LoggerSettingsService.DEFAULT_LOGGER_SETTING_NAME
            LIMIT 1
        ];
        return settings.isEmpty() ? null : settings.get(0);
    }

    public static Logger__mdt getDefaultActiveLoggerSetting() {
        Logger__mdt setting = getDefaultLoggerSetting();
        return setting.Is_Active__c ? setting : null;
    }

    public static List<Log_Handler__mdt> getDefaultLoggerHandlersSettings() {
        List<Log_Handler__mdt> settings = [
            SELECT DeveloperName, Setting__c, Namespace__c, Type__c, Is_Active__c, Logger__r.Is_Active__c
            FROM Log_Handler__mdt
            WHERE Logger__r.DeveloperName = :LoggerSettingsService.DEFAULT_LOGGER_SETTING_NAME
        ];
        return settings;
    }

    public static List<Log_Handler__mdt> getDefaultActiveLoggerHandlersSettings() {
        List<Log_Handler__mdt> settings = getDefaultLoggerHandlersSettings();

        List<Log_Handler__mdt> activeLogHandlerSettings = new List<Log_Handler__mdt>();

        for (Log_Handler__mdt logHandlerSetting : settings) {
            if (logHandlerSetting.Is_Active__c == true && logHandlerSetting.Logger__r.Is_Active__c == true) {
                activeLogHandlerSettings.add(logHandlerSetting);
            }
        }

        return activeLogHandlerSettings;
    }

}