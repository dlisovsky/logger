public class ContextDetailsProvider extends AbstractDetailsProvider {

    public override Map<String, Object> onFlushDetails(Map<String, Object> existingDetails) {

        if (!existingDetails.containsKey('context')) {

            existingDetails.put(
                'context',
                new Map<String, Object>{
                    'applicationReadWriteMode' => System.getApplicationReadWriteMode(),
                    'isBatch' => System.isBatch(),
                    'isFuture' => System.isFuture(),
                    'isQueueable' => System.isQueueable(),
                    'isScheduled' => System.isScheduled(),
                    'isTest' => Test.isRunningTest(),
                    'page' => getPageDetails(),
                    'REST' => getRESTDetails(),
                    'trigger' => getTriggerDetails(),
                    'isEmailsTurnedOn' => isEmailsTurnedOn()
                }
            );

        }

        return existingDetails;
    }

    private Map<String, Object> getPageDetails() {
        PageReference ref = System.currentPageReference();

        if (ref == null) {
            return null;
        }

        return new Map<String, Object>{
            'URL' => ref.getUrl(),
            'Parameters' => ref.getParameters()
        };
    }

    private Map<String, Object> getRESTDetails() {
        RestRequest req = System.RestContext.request;

        if (req == null) {
            return null;
        }

        return new Map<String, Object>{
            'URL' => req.requestURI,
            'HTTP_Method' => req.httpMethod
        };
    }

    private Map<String, Object> getTriggerDetails() {

        if (Trigger.isExecuting != true && !Test.isRunningTest()) {
            return null;
        }

        String triggerOn = String.format(
            '{0} {1}',
            new List<String>{
                Trigger.isBefore == true ? 'BEFORE' : Trigger.isAfter == true ? 'AFTER' : 'UNKNOWN',
                Trigger.isInsert == true ?
                    'INSERT' :
                    Trigger.isUpdate == true ?
                        'UPDATE' :
                        Trigger.isDelete == true ?
                            'DELETE' :
                            Trigger.isUndelete == true ?
                                'UNDELETE' :
                                'UNKNOWN'
            }
        );

        SObject firstObjVar = Trigger.new != null && !Trigger.new.isEmpty() ?
            Trigger.new.get(0) :
            Trigger.old != null && !Trigger.old.isEmpty() ?
                Trigger.old.get(0) :
                null;

        return new Map<String, Object>{
            'on' => triggerOn,
            'size' => Trigger.size,
            'SObjectType' => firstObjVar == null ? 'UNKNOWN' : '' + firstObjVar.getSObjectType()
        };
    }

    private Boolean isEmailsTurnedOn() {
        Boolean emailsTurnedOn = false;
        try {
            Messaging.reserveSingleEmailCapacity(0);
            emailsTurnedOn = true;
        } catch (System.NoAccessException e) {
        }
        return emailsTurnedOn;
    }

}