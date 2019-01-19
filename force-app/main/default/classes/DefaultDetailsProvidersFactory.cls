public class DefaultDetailsProvidersFactory implements IDetailsProvidersFactory {

    public virtual List<AbstractDetailsProvider> getProviders() {
        return new List<AbstractDetailsProvider>{
            new CommonDetailsProvider(),
            new UserDetailsProvider(),
            new OrgDetailsProvider(),
            new LimitsDetailsProvider(),
            new ContextDetailsProvider()
        };
    }

}