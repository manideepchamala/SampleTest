/**
 * @description An implementation of IHandleMessages which validates the passed in Lead and inserts it.
 */
public with sharing class IncomingLeadHandler implements IHandleMessages {
    
    public static final String INCOMING_LEAD_CHANNEL = 'IncomingLeads';
    
    /**
     * @description Constructs an instance of IncomingLeadHandler.
     */
    public IncomingLeadHandler() { }

    /**
     * @description Handles a message on a subscribed channel.
     * @param channel The channel emitting the message.
     * @param data The accompanying data for the message.
     * @throws ArgumentNullException if channel is null.
     * @throws ArgumentException if the lead is missing a FirstName.
     */
    public void handleMessage(String channel, Object data) {
        
        if (!(data instanceof Lead) || !channel.equalsIgnoreCase(INCOMING_LEAD_CHANNEL)) {
            throw new ArgumentException('Expecting a Lead record, but received another type.');
        }
        
		if (String.isBlank(channel)) ArgumentNullException.throwIfNull(lead.FirstName, 'channel');

        if (data == null) ArgumentNullException.throwIfNull(lead.FirstName, 'data');
        
        Lead lead = (Lead)data;

        if(String.isBlank(lead.FirstName)) ArgumentNullException.throwIfNull(lead.FirstName, 'FirstName');

        List<String> subscribedChannels = getSubscribedChannels();

        if (!subscribedChannels.Contains(channel)) SubscribedChannelNamesStorage.Names.add(channel);
        
        Database.insert(lead);
        
    }

    /**
     * @description Gets a list of channels an implementation subscribes to.
     * @return A List<String> of channel names this implementation is subscribed to.
     */
    public List<String> getSubscribedChannels() {
        return SubscribedChannelNamesStorage.Names;
    }
}

/*public with sharing class IncomingLeadHandler implements IHandleMessages {

    public static final String INCOMING_LEAD_CHANNEL = 'IncomingLeads';

    public string Subscriber { get; set; }

    public IncomingLeadHandler() { }

    public IncomingLeadHandler(string incomingSubscriber)
    {
        Subscriber = (incomingSubscriber == null)? INCOMING_LEAD_CHANNEL : incomingSubscriber;
    }

    public void handleMessage(String channel, Object data) 
    {
        if (String.isBlank(channel) || data == null) throw new ArgumentNullException();
        
        Lead lead = (Lead)data;

        if(String.isBlank(lead.FirstName)) throw new ArgumentNullException();

        List<String> subscribedChannels = getSubscribedChannels();

        if (!subscribedChannels.Contains(channel)) SubscribedChannelNamesStorage.Names.add(channel);

    }

    public static List<String> getSubscribedChannels() 
    {
        return SubscribedChannelNamesStorage.Names;
    }

}*/