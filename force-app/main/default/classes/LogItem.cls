global virtual class LogItem {
    protected String message;
    protected String type;

    global LogItem(Object message, String type) {
        this.message = '' + message;
        this.type = type;
    }

    global LogItem(Object message) {
        this(message, 'DEBUG');
    }
}