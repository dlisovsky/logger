@IsTest
private class TestSlackLogHandler {
    static testMethod void testBehavior() {

        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockImpl());

        Map<String, Object> settings = new Map<String, Object>{
            'token' => '123',
            'channels' => '#general'
        };

        Log logVar = new Log();
        ILogHandler logHandler = new SlackLogHandler();

        Test.startTest();

        logHandler.setSettings(settings);
        logHandler.handle(logVar);

        Test.stopTest();

    }

    public class HttpCalloutMockImpl implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse httpResp = new HttpResponse();
            httpResp.setStatusCode(200);
            httpResp.setBody('{"ok":true}');
            return httpResp;
        }
    }
}