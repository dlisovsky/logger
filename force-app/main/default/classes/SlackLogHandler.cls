public class SlackLogHandler implements ILogHandler, Queueable, Database.AllowsCallouts {

    private Log logVar;
    private Map<String, Object> settings;

    public void setSettings(Map<String, Object> settings) {
        this.settings = settings;
    }

    public void handle(Log logVar) {
        this.logVar = logVar;
        this.handleAsync();
    }

    public void handleAsync() {
        ID jobID = System.enqueueJob(this);
    }

    public void execute(QueueableContext context) {

        String key = String.format(
            '"{0}" on {1}',
            new List<String>{
                UserInfo.getOrganizationName(),
                Datetime.now().format()
            }
        );

        String dataTitle = '1. Data Log from Org: ' + key;
        String detailsTitle = '2. Details Log from Org: ' + key;

        String token = (String) this.settings.get('token');
        String channels = (String) this.settings.get('channels');

        postSlackMessage(
            token,
            channels,
            dataTitle,
            JSON.serializePretty(this.logVar.getLogItems())
        );

        postSlackMessage(
            token,
            channels,
            detailsTitle,
            JSON.serializePretty(this.logVar.getDetails())
        );

    }

    private void postSlackMessage(String token, String channels, String title, String message) {

        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://slack.com/api/files.upload');
        request.setTimeout(120000);

        Map<String, String> requestMap = new Map<String, String>{
            'token' => token,
            'channels' => channels,
            'filetype' => 'javascript',
            'content' => message,
            'title' => title
        };

        request.setBody(mapToFormUrlEncoded(requestMap));

        HttpResponse response = new Http().send(request);

        System.assertEquals(200, response.getStatusCode(), '' + response.getStatus());

        System.assertNotEquals(null, response);
        System.assertNotEquals(null, response.getBody());

        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

        System.assertNotEquals(null, responseMap);

        System.assertEquals(true, responseMap.containsKey('ok'), '' + responseMap);
        System.assertEquals(true, (Boolean) responseMap.get('ok'), '' + responseMap);

    }

    public String mapToFormUrlEncoded(Map<String, String> dataMap) {
        List<String> keyValuePairsEncoded = new List<String>();
        for (String key : dataMap.keySet()) {
            keyValuePairsEncoded.add(String.format('{0}={1}', new List<String>{
                System.EncodingUtil.urlEncode(key, 'UTF-8'),
                System.EncodingUtil.urlEncode(dataMap.get(key), 'UTF-8')
            }));
        }

        return String.join(keyValuePairsEncoded, '&');
    }
}