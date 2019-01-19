global abstract class AbstractDetailsProvider {
    global virtual Map<String, Object> onStartDetails(Map<String, Object> existingDetails) {
        return existingDetails;
    }

    global virtual Map<String, Object> onFlushDetails(Map<String, Object> existingDetails) {
        return existingDetails;
    }
}