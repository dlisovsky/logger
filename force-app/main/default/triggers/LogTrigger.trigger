trigger LogTrigger on Log__e (after insert) {
    LoggerService.handleLogEvents(Trigger.new);
}