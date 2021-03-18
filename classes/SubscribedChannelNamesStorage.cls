public class SubscribedChannelNamesStorage
{
    SubscribedChannelNamesStorage()
    {
        if (Names == null)
        {
            Names = new List<string>();
        }
    }
    
    public static List<string> Names = new List<string>();
}