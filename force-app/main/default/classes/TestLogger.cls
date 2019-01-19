@IsTest
private class TestLogger {
    @IsTest
    static void testBehavior() {

        Test.startTest();

        Log logVar;

        try {

            Logger.setInstance(new LoggerImpl());

            Logger.debug('test debug message');
            Logger.error('test error message');
            Logger.info('test error message');

            Logger.debug('asd{0}', 1);
            Logger.info('info');
            Logger.info('asdad{0}', 2);
            Logger.error('err');
            Logger.error('asdad{0}', 2);
            Logger.exception('ex');
            Logger.exception('asd', 4);

            System.debug(1 / 0); // simulate exception.

        } catch (Exception ex) {

            Logger.exception(ex);

        } finally {

            logVar = Logger.publish();

            System.debug(logVar.getDetails());
            System.debug(logVar.getLogItems());

        }

        Test.stopTest();
    }

    @IsTest
    static void testBehavior2() {

        Test.startTest();

        ILogger logger = new PlatformEventLoggerImpl();
        logger.debug('test');
        logger.publish();

        Test.stopTest();
    }

    @IsTest
    static void testBehavior3() {
        FlowDebugService.LogRequest request = new FlowDebugService.LogRequest();
        request.message = 'test';
        request.params.add('test');
        FlowDebugService.debug(new List<FlowDebugService.LogRequest>{
            request
        });
    }
}