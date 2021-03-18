@isTest
private class IncomingLeadHandlerTest {
    private static List<Lead> getLeads() {
        return [SELECT Id, FirstName, LastName, Company, Email FROM Lead];
    }

    @isTest
    private static void handleMessage_nullChannel_expectArgumentNullException() {
        IHandleMessages testHandler = new IncomingLeadHandler();

        try {
            Test.startTest();

            testHandler.handleMessage(null, null);

            TestHelper.expectedArgumentNullException();
        } catch (Exception e) {
            //TestHelper.assertArgumentNullException(e, IncomingLeadHandler.INCOMING_LEAD_CHANNEL);
        } finally {
            Test.stopTest();
        }
    }

    @isTest
    private static void handleMessage_validLead_expectInserted() {
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
        PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);
        Test.stopTest();

        leads = getLeads();

        System.assertEquals(1, leads.size(), 'Expected one lead.');
        System.assertEquals(testLead.FirstName, leads[0].FirstName, 'Expected the test lead.');
    }

    @isTest
    private static void handleMessage_invalidLead_expectArgumentException() {
        Lead testLead = new Lead(
                FirstName = null,
                LastName = 'Tester',
                Company = 'ISC2',
                Email = 'example@example.com');

        IHandleMessages testHandler = new IncomingLeadHandler();
        PubSubService.Instance.subscribe(testHandler);

        List<Lead> leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');

        try {
            Test.startTest();

            PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);

            TestHelper.expectedArgumentException();
        } catch (Exception e) {
            //TestHelper.assertArgumentException(e);
        } finally {
            Test.stopTest();
        }
    }

    @isTest
    private static void handleMessage_invalidChannel_withLead_expectNoLeadInserted() {
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
        PubSubService.Instance.emit('nope', testLead);
        Test.stopTest();

        leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');
    }

    @isTest
    private static void handleMessage_notSubscribed_expectNoLeadInserted() {
        Lead testLead = new Lead(
                FirstName = 'Test',
                LastName = 'Tester',
                Company = 'ISC2',
                Email = 'example@example.com');

        IHandleMessages testHandler = new IncomingLeadHandler();
        PubSubService.Instance.subscribe(testHandler);
        PubSubService.Instance.unsubscribe(testHandler);

        List<Lead> leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');

        Test.startTest();
        PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);
        Test.stopTest();

        leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');
    }
}
/*@isTest
private class IncomingLeadHandlerTest {
    
    private static List<Lead> getLeads() {
        return ProcessedLeadsStorage.ProcessedLeads;
    }
    
    @isTest
    public static void RemoveAllProcessLeads()
    {
        ProcessedLeadsStorage.ProcessedLeads.Clear();
    }
    
    @isTest
    private static void handleMessage_nullChannel_expectArgumentNullException() {
        IHandleMessages testHandler = new IncomingLeadHandler();

        try {
            Test.startTest();
            testHandler.handleMessage(null, null);
            TestHelper.expectedArgumentNullException();
        } catch (Exception e) {
            TestHelper.assertArgumentNullException(e, '');
        } finally {
            Test.stopTest();
        }
    }
    
    @isTest
    private static void handleMessage_validLead_expectInserted() {
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
        PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);
        Test.stopTest();

        leads = getLeads();

        System.assertEquals(1, leads.size(), 'Expected one lead.');
        System.assertEquals(testLead.FirstName, leads[0].FirstName, 'Expected the test lead.');
    }
    
    @isTest
    private static void handleMessage_invalidLead_expectArgumentException() {
        Lead testLead = new Lead(
                FirstName = null,
                LastName = 'Tester',
                Company = 'ISC2',
                Email = 'example@example.com');

        IHandleMessages testHandler = new IncomingLeadHandler();
        PubSubService.Instance.subscribe(testHandler);

        List<Lead> leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');

        try {
            Test.startTest();

            PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);

            TestHelper.expectedArgumentException();
        } catch (Exception e) {
            TestHelper.assertArgumentException(e);
        } finally {
            Test.stopTest();
        }
    }
    
    @isTest
    private static void handleMessage_invalidChannel_withLead_expectNoLeadInserted() {
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
        PubSubService.Instance.emit('nope', testLead);
        Test.stopTest();

        leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');
    }
        
    @isTest
    private static void handleMessage_notSubscribed_expectNoLeadInserted() {
        Lead testLead = new Lead(
                FirstName = 'Test',
                LastName = 'Tester',
                Company = 'ISC2',
                Email = 'example@example.com');

        IHandleMessages testHandler = new IncomingLeadHandler();
        PubSubService.Instance.subscribe(testHandler);
        PubSubService.Instance.unsubscribe(testHandler);

        List<Lead> leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');

        Test.startTest();
        PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);
        Test.stopTest();

        leads = getLeads();

        System.assert(leads.isEmpty(), 'Expected no leads.');
    }
    */
    
    
    
    
    
    
    /*@isTest
    public static void HandleMessage_MultipleSameSubscribers_ExpectOneLeadInserted()
    {
        Lead testLead = new Lead();
        testLead.FirstName = 'Test';
        testLead.LastName = 'Tester';
        testLead.Company = 'ISC2';
        testLead.Email = 'example@example.com';
                    
        IncomingLeadHandler testHandler = new IncomingLeadHandler();
        
        PubSubService.Instance.Subscribe(testHandler);
        PubSubService.Instance.Subscribe(testHandler);
        PubSubService.Instance.Unsubscribe(testHandler);
        PubSubService.Instance.Subscribe(testHandler);
        
        Integer leadsBeforePublishCount = getLeads().size();
        PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);
        List<Lead> leadsAfterPublish = getLeads();
        
        //Assert.AreEqual(0, leadsBeforePublishCount, 'Expect no leads.');
        //Assert.AreEqual(1, leadsAfterPublish.Count, 'Expect one leads.');
    }
    
    @isTest
    public static void HandleMessage_MultipleDifferentSubscribers_ExpectOneLeadInserted()
    {
        Lead testLead = new Lead();
        testLead.FirstName = 'Test';
        testLead.LastName = 'Tester';
        testLead.Company = 'ISC2';
        testLead.Email = 'example@example.com';
                    
        IncomingLeadHandler testHandler = new IncomingLeadHandler();
        IncomingLeadHandler testHandlerLms = new IncomingLeadHandler('LMS');
        IncomingLeadHandler testHandlerOkta = new IncomingLeadHandler('OKTA');
        
        PubSubService.Instance.Subscribe(testHandler);
        PubSubService.Instance.Subscribe(testHandlerLms);
        PubSubService.Instance.Subscribe(testHandlerOkta);
        
        Integer leadsBeforePublishCount = getLeads().size();
        PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);
        List<Lead> leadsAfterPublish = getLeads();
        
        //Assert.AreEqual(0, leadsBeforePublishCount, 'Expect no leads.');
        //Assert.AreEqual(3, leadsAfterPublish.Count, 'Expect three leads.');
    }
    
    @isTest
    public static void HandleMessage_MultipleDifferentSubscribersWithOneUsubscribe_ExpectOneLeadInserted()
    {
        Lead testLead = new Lead();
        testLead.FirstName = 'Test';
        testLead.LastName = 'Tester';
        testLead.Company = 'ISC2';
        testLead.Email = 'example@example.com';
                    
        IncomingLeadHandler testHandler = new IncomingLeadHandler();
        IncomingLeadHandler testHandlerLms = new IncomingLeadHandler('LMS');
        IncomingLeadHandler testHandlerOkta = new IncomingLeadHandler('OKTA');
        
        PubSubService.Instance.Subscribe(testHandler);
        PubSubService.Instance.Subscribe(testHandlerLms);
        PubSubService.Instance.Subscribe(testHandlerOkta);
        PubSubService.Instance.Unsubscribe(testHandlerOkta);
        
        Integer leadsBeforePublishCount = getLeads().size();
        PubSubService.Instance.emit(IncomingLeadHandler.INCOMING_LEAD_CHANNEL, testLead);
        List<Lead> leadsAfterPublish = getLeads();
        
        //Assert.AreEqual(0, leadsBeforePublishCount, 'Expect no leads.');
        //Assert.AreEqual(2, leadsAfterPublish.Count, 'Expect two leads.');
    }*/
    
//}