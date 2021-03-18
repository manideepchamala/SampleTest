@isTest
private class PubSubServiceTest {
    private static final String INCOMING_LEAD_CHANNEL = 'IncomingLeads';
    private static final String EXPECTED_LEAD_NAME = 'Test';

    private static List<Lead> getLeads() {
        return [SELECT Id, FirstName, LastName FROM Lead];
    }

    @isTest
    private static void handleMessage_withLead_expectInsertedWithAlteredAssistantName() {
        Lead testLead = new Lead(
                FirstName = 'Test',
                LastName = 'Tester',
                Company = 'ISC2',
                Email = 'example@example.com');

        IHandleMessages testHandler = new IncomingLeadHandler();
        PubSubService.Instance.subscribe(testHandler);

        List<Lead> leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');

        Test.startTest();
        PubSubService.Instance.emit(INCOMING_LEAD_CHANNEL, testLead);
        Test.stopTest();

        leads = getLeads();

        System.assertEquals(1, leads.size(), 'Expected one lead.');
        System.assertEquals(EXPECTED_LEAD_NAME, leads[0].FirstName, 'Expected the interface implementation to have altered the First name.');
    }
    
}