public class SubscribedList
{
    public List<IncomingLeadHandler> Subscriptions = new List<IncomingLeadHandler>();
    
    public static SubscribedList Instance {
        get {
            if (Instance == null)
            {
                Instance = new SubscribedList();
            }

            return Instance;
        }

        set;
    }
    
}