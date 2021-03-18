/**
 * @description A simple Pub/Sub pattern implementation
 */
public with sharing class PubSubService {
    private PubSubService() { }

    /**
     * @description A singleton for service interaction.
     */
    public static PubSubService Instance {
        get {
            if (Instance == null) {
                Instance = new PubSubService();
            }

            return Instance;
        }

        private set;
    }

    /**
     * @description Subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void subscribe(IHandleMessages implementation) {
		if (implementation == null) ArgumentNullException.throwIfNull(implementation, 'implementation');

        IncomingLeadHandler incoming = (IncomingLeadHandler)implementation;

        Integer previouslySubscribed = SubscribedList.Instance.Subscriptions.size();

        if (previouslySubscribed == 0)
        {
            SubscribedList.Instance.Subscriptions.Add(incoming);
        }
    }

    /**
     * @description Un-subscribes a given IHandleMessages implementation to the channels it returns.
     * @param implementation An instance of IHandleMessages.
     * @throws ArgumentNullException if implementation is null.
     */
    public void unsubscribe(IHandleMessages implementation) {
		if (implementation == null) ArgumentNullException.throwIfNull(implementation, 'implementation');

        IncomingLeadHandler tobeRemoved = (IncomingLeadHandler)implementation;

        Integer existing = 0;

        if (existing != null)
        {
            SubscribedList.Instance.Subscriptions.Remove(existing);
        }
    }

    /**
     * @description Emits a message to a given channel containing the specified data.
     * @param channel The channel to emit a message on.
     * @param data The data to emit.
     * @throws ArgumentNullException if channel is null.
     */
    public void emit(String channel, Object data) {
        
		if (channel == null || String.isBlank(channel)) ArgumentNullException.throwIfNull(lead.FirstName, 'channel');

        if (data == null) ArgumentNullException.throwIfNull(lead.FirstName, 'data');

        if (channel == IncomingLeadHandler.INCOMING_LEAD_CHANNEL)
        {
            if (!SubscribedList.Instance.Subscriptions.isEmpty())
            {
                for(IncomingLeadHandler subscriber : SubscribedList.Instance.Subscriptions)
                {
                    subscriber.HandleMessage(channel, data);
                }
            }
        }
        
    }
}