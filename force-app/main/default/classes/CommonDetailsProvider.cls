public class CommonDetailsProvider extends AbstractDetailsProvider {
    public override Map<String, Object> onFlushDetails(Map<String, Object> existingDetails) {

        if (!existingDetails.containsKey('dateTime')) {

            existingDetails.put(
                'dateTime',
                Datetime.now().format()
            );

        }

        return existingDetails;
    }
}