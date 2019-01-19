global virtual class Log {
    protected final List<LogItem> logItems;
    protected final Map<String, Object> details;

    global Log() {
        this(
            new List<LogItem>(),
            new Map<String, Object>()
        );
    }

    public Log(List<LogItem> logItems, Map<String, Object> details) {
        this.logItems = logItems;
        this.details = details;
    }

    global void addDetails(Map<String, Object> details) {
        this.details.putAll(details);
    }

    global void addLogItem(LogItem logItem) {
        this.logItems.add(logItem);
    }

    global Map<String, Object> getDetails() {
        return this.details;
    }

    global List<LogItem> getLogItems() {
        return this.logItems;
    }

    global Boolean isEmpty() {
        return logItems.isEmpty();
    }
}