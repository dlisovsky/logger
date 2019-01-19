global class Logger {

    private static ILogger loggerImpl;

    global static ILogger getInstance() {
        if (loggerImpl == null) {
            loggerImpl = new LoggerFactory().getLogger();
        }
        return loggerImpl;
    }

    global static void setInstance(ILogger loggerImpl) {
        Logger.loggerImpl = loggerImpl;
    }

    global static void setDetailsProviders(List<AbstractDetailsProvider> detailsProviders) {
        getInstance().setDetailsProviders(detailsProviders);
    }

    global static void setDetailsProviders(IDetailsProvidersFactory detailsProvidersFactory) {
        getInstance().setDetailsProviders(detailsProvidersFactory.getProviders());
    }

    global static void log(LogItem logItem) {
        getInstance().log(logItem);
    }

    global static void log(String template, Object params, String type) {
        getInstance().log(template, params, type);
    }

    global static void log(Object message, String type) {
        getInstance().log(message, type);
    }

    global static void debug(Object message) {
        getInstance().debug(message);
    }

    global static void debug(String template, Object params) {
        getInstance().debug(template, params);
    }

    global static void info(Object message) {
        getInstance().info(message);
    }

    global static void info(String template, Object params) {
        getInstance().info(template, params);
    }

    global static void error(Object message) {
        getInstance().error(message);
    }

    global static void error(String template, Object params) {
        getInstance().error(template, params);
    }

    global static void exception(Exception ex) {
        getInstance().exception(ex);
    }

    global static void exception(Object message) {
        getInstance().exception(message);
    }

    global static void exception(String template, Object params) {
        getInstance().exception(template, params);
    }

    global static Log flush() {
        return getInstance().flush();
    }

    global static void reset() {
        getInstance().reset();
    }

    global static Log publish() {
        return getInstance().publish();
    }

    global static Log publishAsync() {
        return getInstance().publishAsync();
    }

}