# Salesforce Logger

An exmaple of usage:
```apex
try {
    hey.Logger.debug('Hey Logger!');
} catch (Exception ex) {
    hey.Logger.exception(ex);
    throw ex;
} finally {
    hey.Logger.publish();
}
```

OR

```apex
try {
    hey.Logger.debug('test debug message');
    hey.Logger.debug(new List<Object>{1, 'Test', 2.25});
    hey.Logger.debug('template {0}', new User(Email = 'test@test.com'));
    hey.Logger.debug('template {0} {1}', new List<Object>{
        1,
        2
    });
    
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://slack.com');
    req.setMethod('GET');
    hey.Logger.debug(new Http().send(req).getBody());
    
    hey.Logger.error('test error message');
    hey.Logger.info('test error message');

    System.debug(1 / 0); // simulate exception.
} catch (Exception ex) {
    hey.Logger.exception(ex);
    throw ex;
} finally {
    hey.Logger.publish();
}
```

# Configuration

The logger can be configured via Custom Metadata Types. It supports:

* A `ILogger` implementation that publishes the Log
  * The default `PlatformEventLoggerImpl` implementation publishes the log to Salesforce Platform Event

* A list of the `ILogHandler` implementations to handle the published Log
  * The default `SlackLogHandler` implementation attaches the Log as a snippet to the configured Slack channel
