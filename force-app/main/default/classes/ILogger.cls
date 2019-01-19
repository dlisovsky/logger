global interface ILogger {

    void setDetailsProviders(List<AbstractDetailsProvider> detailsProviders);
    void setDetailsProviders(IDetailsProvidersFactory detailsProvidersFactory);


    void log(LogItem logItem);
    void log(String template, Object params, String type);
    void log(Object message, String type);


    void debug(Object message);
    void debug(String template, Object params);


    void info(Object message);
    void info(String template, Object params);


    void error(Object message);
    void error(String template, Object params);


    void exception(Exception ex);
    void exception(Object message);
    void exception(String template, Object params);


    Log flush();
    void reset();

    Log publish();
    Log publish(Log logToPublish);

    Log publishAsync();
    Log publishAsync(Log logToPublish);

}