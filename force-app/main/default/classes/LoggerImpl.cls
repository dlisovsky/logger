public virtual class LoggerImpl implements ILogger {

    protected Log logVar;
    protected List<AbstractDetailsProvider> detailsProviders;
    protected Boolean isOnStartDetailsProvided = false;

    public LoggerImpl() {
        this.reset();
    }

    public virtual void setDetailsProviders(List<AbstractDetailsProvider> detailsProviders) {
        this.detailsProviders = detailsProviders;
    }

    public virtual void setDetailsProviders(IDetailsProvidersFactory detailsProvidersFactory) {
        this.setDetailsProviders(detailsProvidersFactory.getProviders());
    }

    public virtual void log(LogItem logItem) {
        if (this.detailsProviders == null) {
            this.setDetailsProviders(new DefaultDetailsProvidersFactory().getProviders());
        }
        if (!this.isOnStartDetailsProvided) {
            onStartDetailsProviders();
        }

        this.logVar.addLogItem(logItem);
    }

    public virtual void log(String template, Object params, String type) {

        List<String> stringParams = new List<String>();

        if (params == null) {
            stringParams.add(null);
        } else if (params instanceof List<Object>) {
            for (Object param : (List<Object>) params) {
                stringParams.add('' + param);
            }
        } else {
            stringParams.add('' + params);
        }

        String message = String.format(
            template,
            stringParams
        );

        this.log(message, type);
    }

    public virtual void log(Object message, String type) {
        this.log(new LogItem(stringify(message), type));
    }


    public virtual void debug(Object message) {
        this.log(message, 'DEBUG');
    }

    public virtual void debug(String template, Object params) {
        this.log(template, params, 'DEBUG');
    }


    public virtual void info(Object message) {
        this.log(message, 'INFO');
    }

    public virtual void info(String template, Object params) {
        this.log(template, params, 'INFO');
    }


    public virtual void error(Object message) {
        this.log(message, 'ERROR');
    }

    public virtual void error(String template, Object params) {
        this.log(template, params, 'ERROR');
    }


    public virtual void exception(Exception ex) {
        String exceptionDetails = String.format(
            '{0}: {1}\n{2}{3}',
            new List<String>{
                ex.getTypeName(),
                ex.getMessage(),
                ex.getStackTraceString(),
                ex.getCause() == null ? '' : ' Caused by: ' + ex.getCause()
            }
        );
        this.exception(exceptionDetails);
    }

    public virtual void exception(Object message) {
        this.log(message, 'EXCEPTION');
    }

    public virtual void exception(String template, Object params) {
        this.log(template, params, 'EXCEPTION');
    }


    public virtual Log flush() {

        this.onFlushDetailsProviders();

        Log originalLog = logVar;

        this.reset();

        return originalLog;
    }

    public virtual void reset() {
        this.logVar = new Log();
    }

    public String stringify(Object obj) {

        String str;

        if (obj == null) {
            str = '' + null;
        } else if (obj instanceof String) {
            str = (String) obj;
        } else if (obj instanceof List<Object>) {
            str = String.format(
                '[{0}] {1}',
                new List<String>{
                    '' + ((List<Object>) obj).size(),
                    '' + obj
                }
            );
        } else {
            str = '' + obj;
        }

        return str;
    }

    protected void onStartDetailsProviders() {
        Map<String, Object> details = new Map<String, Object>();
        if (detailsProviders != null) {
            for (AbstractDetailsProvider detailsProvider : this.detailsProviders) {
                try {
                    details = detailsProvider.onStartDetails(details);
                } catch (Exception ex) {
                    System.debug(ex.getMessage() + ' ' + ex.getStackTraceString());
                }
            }
        }
        this.logVar.addDetails(details);

        this.isOnStartDetailsProvided = true;
    }

    protected void onFlushDetailsProviders() {
        Map<String, Object> details = new Map<String, Object>();
        if (detailsProviders != null) {
            for (AbstractDetailsProvider detailsProvider : this.detailsProviders) {
                try {
                    details = detailsProvider.onFlushDetails(details);
                } catch (Exception ex) {
                    System.debug(ex.getMessage() + ' ' + ex.getStackTraceString());
                }
            }
        }
        this.logVar.addDetails(details);

        this.isOnStartDetailsProvided = false;
    }

    public virtual Log publish(Log logToPublish) {
        return logToPublish;
    }

    public virtual Log publish() {
        Log logToPublish = this.flush();
        return this.publish(logToPublish);
    }

    public virtual Log publishAsync(Log logToPublish) {

        System.enqueueJob(new AsyncLogPublisher(
            this,
            logToPublish
        ));

        return logToPublish;
    }

    public virtual Log publishAsync() {
        Log logToPublish = this.flush();
        return this.publishAsync(logToPublish);
    }

    class AsyncLogPublisher implements Queueable, Database.AllowsCallouts {

        private ILogger logger;
        private Log logToPublish;

        AsyncLogPublisher(ILogger logger, Log logToPublish) {
            this.logger = logger;
            this.logToPublish = logToPublish;
        }

        public void execute(QueueableContext context) {
            this.logger.publish(this.logToPublish);
        }
    }
}