public interface ILogHandler {

    void handle(Log logVar);

    void setSettings(Map<String, Object> settings);

}