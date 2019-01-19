public class LoggerService {

    public static void handleLogs(List<Log> logs) {

        List<ILogHandler> logHandlers = new LogHandlersFactory().getHandlers();

        for (ILogHandler logHandler : logHandlers) {
            try {
                for (Log logVar : logs) {
                    logHandler.handle(logVar);
                }
            } catch (Exception ex) {
                System.debug(ex.getMessage() + ' ' + ex.getStackTraceString());
            }
        }
    }


    public static void handleLogEvents(List<Log__e> logEvents) {

        List<Log> logs = new List<Log>();
        for (Log__e logEventVar : logEvents) {
            try {
                List<LogItem> logItems = logEventVar.Data__c == null ?
                    null :
                    (List<LogItem>) JSON.deserialize(logEventVar.Data__c, List<LogItem>.class);

                Map<String, Object> detailsMap = logEventVar.Details__c == null ?
                    null :
                    (Map<String, Object>) JSON.deserializeUntyped(logEventVar.Details__c);

                Log logVar = new Log(
                    logItems,
                    detailsMap
                );
                logs.add(logVar);
            } catch (Exception ex) {
                System.debug(ex.getMessage() + ' ' + ex.getStackTraceString());
            }
        }

        LoggerService.handleLogs(logs);
    }

}