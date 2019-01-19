public class LimitsDetailsProvider extends AbstractDetailsProvider {

    public override Map<String, Object> onStartDetails(Map<String, Object> existingDetails) {

        this.addLimitsDetails('startLimits', existingDetails);

        return existingDetails;
    }

    public override Map<String, Object> onFlushDetails(Map<String, Object> existingDetails) {

        this.addLimitsDetails('endLimits', existingDetails);

        return existingDetails;
    }


    private void addLimitsDetails(String key, Map<String, Object> existingDetails) {

        if (!existingDetails.containsKey(key)) {

            existingDetails.put(
                key,
                new Map<String, Object>{
                    'Queries' => formatLimit(Limits.getLimitQueries(), Limits.getQueries()),
                    'QueryRows' => formatLimit(Limits.getLimitQueryRows(), Limits.getQueryRows()),
                    'DMLRows' => formatLimit(Limits.getLimitDMLRows(), Limits.getDMLRows()),
                    'DMLStatements' => formatLimit(Limits.getLimitDMLStatements(), Limits.getDMLStatements()),
                    'EmailInvocations' => formatLimit(Limits.getLimitEmailInvocations(), Limits.getEmailInvocations()),
                    'Callouts' => formatLimit(Limits.getLimitCallouts(), Limits.getCallouts()),
                    'FutureCalls' => formatLimit(Limits.getLimitFutureCalls(), Limits.getFutureCalls()),
                    'CpuTime' => formatLimit(Limits.getLimitCpuTime(), Limits.getCpuTime()),
                    'HeapSize' => formatLimit(Limits.getLimitHeapSize(), Limits.getHeapSize())
                }
            );

        }

    }

    private String formatLimit(Integer limitVar, Integer issuedVar) {

        Decimal usagePercentage = limitVar == 0 || limitVar == null ?
            0 :
            (issuedVar / (Decimal) limitVar);

        return String.format(
            '{0} of {1} - {2}%{3}',
            new List<String>{
                String.valueOf(issuedVar),
                String.valueOf(limitVar),
                usagePercentage.setScale(2).toPlainString(),
                usagePercentage > 90 ? '!!!' : usagePercentage > 70 ? '!!' : usagePercentage > 60 ? '!' : ''
            }
        );
    }
}