global class FlowDebugService {

    @InvocableMethod(label='Debug')
    global static void debug(List<LogRequest> requests) {

        for (LogRequest logRequest : requests) {

            Logger.debug(logRequest.message);

            if (logRequest.params != null) {
                for (String param : logRequest.params) {
                    Logger.debug(param);
                }
            }
        }

        Logger.publish();

    }

    global class LogRequest {
        @InvocableVariable(label='Message' required=true description='Message')
        global String message;

        @InvocableVariable(label='Params' required=false description='Params')
        global List<String> params = new List<String>();
    }
}