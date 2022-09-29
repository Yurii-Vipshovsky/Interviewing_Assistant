@IsTest
private class InterviewControllerTest {

    private static Id getCompanyId(Integer num){
        return [SELECT Id FROM Account][num].Id;
    }
    private static Id getContactId(Integer num){
        return [SELECT Id FROM Contact][num].Id;
    }
    private static Id getVacancyId(Integer num){
        return [SELECT Id FROM Vacancy__c][num].Id;
    }

    @TestSetup
    static void prepareData () {
        List<Account> testCompanies = new List<Account>();
        testCompanies.add(new Account(
                Name='Test company 0',
                Phone='12345786'));
        testCompanies.add(new Account(
                Name='Test company 1',
                Phone='12345786'));
        insert testCompanies;
        //2 companies

        List<Contact> testContacts = new List<Contact>();
        testContacts.add(new Contact(
                LastName='Test Contact 0',
                Phone='12345786'));
        testContacts.add(new Contact(
                LastName='Test Contact 1',
                Phone='12345786'));
        testContacts.add(new Contact(
                LastName='Test Contact 2',
                Phone='12345786'));
        insert testContacts;
        //3 contacts

        List<Vacancy__c> testVacancies = new List<Vacancy__c>();
        testVacancies.add(new Vacancy__c(
                Name='Test record com0',
                Related_Company__c=getCompanyId(0),
                Description__c='test Description',
                Available__c=true,
                We_Offer__c='test offer',
                Requirements__c='test requirements'));
        testVacancies.add(new Vacancy__c(
                Name='Test record1 com0',
                Related_Company__c=getCompanyId(0),
                Description__c='test Description',
                Available__c=true,
                We_Offer__c='test offer',
                Requirements__c='test requirements'));
        testVacancies.add(new Vacancy__c(
                Name='Test record2 com0',
                Related_Company__c=getCompanyId(0),
                Description__c='test Description',
                Available__c=true,
                We_Offer__c='test offer',
                Requirements__c='test requirements'));
        testVacancies.add(new Vacancy__c(
                Name='Test record3 com1',
                Related_Company__c=getCompanyId(1),
                Description__c='test Description',
                Available__c=true,
                We_Offer__c='test offer',
                Requirements__c='test requirements'));
        testVacancies.add(new Vacancy__c(
                Name='Test record4 com1',
                Related_Company__c=getCompanyId(1),
                Description__c='test Description',
                Available__c=true,
                We_Offer__c='test offer',
                Requirements__c='test requirements'));
        insert testVacancies;
        //5 vacancies 3 for 0 company and 2 for 1 company

        List<Interview__c> testInterviews = new List<Interview__c>();
        testInterviews.add(new Interview__c(
                Name = 'Test record 0',
                Vacancy__c = getVacancyId(0),
                To_Interview__c = getContactId(0),
                Time__c = Datetime.now())); //time now comp0
        testInterviews.add(new Interview__c(
                Name = 'Test record 1',
                Vacancy__c = getVacancyId(0),
                To_Interview__c = getContactId(1),
                Time__c = Datetime.now().addDays(2))); // now+2  comp0
        testInterviews.add(new Interview__c(
                Name = 'Test record 2',
                Vacancy__c = getVacancyId(0),
                To_Interview__c = getContactId(2),
                Time__c = Datetime.now().addDays(1))); // now+1 comp0
        testInterviews.add(new Interview__c(
                Name = 'Test record 3',
                Vacancy__c = getVacancyId(1),
                To_Interview__c = getContactId(0),
                Time__c = Datetime.now().addDays(3))); // now+3 comp0
        testInterviews.add(new Interview__c(
                Name = 'Test record 4',
                Vacancy__c = getVacancyId(1),
                To_Interview__c = getContactId(1),
                Time__c = Datetime.now().addDays(1))); // now+1 comp0
        testInterviews.add(new Interview__c(
                Name = 'Test record 5',
                Vacancy__c = getVacancyId(2),
                To_Interview__c = getContactId(1),
                Time__c = Datetime.now())); // now comp0
        testInterviews.add(new Interview__c(
                Name = 'Test record 6',
                Vacancy__c = getVacancyId(3),
                To_Interview__c = getContactId(2),
                Time__c = Datetime.now().addDays(10))); // now+10 comp1
        testInterviews.add(new Interview__c(
                Name = 'Test record 7',
                Vacancy__c = getVacancyId(4),
                To_Interview__c = getContactId(0),
                Time__c = Datetime.now().addDays(8)));// now+8 comp1

        insert testInterviews;
        //3 for vacancy 0
        //2 for vacancy 1
        //1 for vacancy 2,3,4

        //3 for contact 0,1
        //2 for contact 2
    }

    @IsTest
    static void testGetInterviewsByVacancyId() {
        Test.startTest();
        List<Interview__c> result0 = InterviewController.getInterviewsByVacancyId(getVacancyId(0));
        List<Interview__c> result1 = InterviewController.getInterviewsByVacancyId(getVacancyId(1));
        List<Interview__c> result2 = InterviewController.getInterviewsByVacancyId(getVacancyId(2));
        List<Interview__c> result3 = InterviewController.getInterviewsByVacancyId(getVacancyId(3));
        List<Interview__c> result4 = InterviewController.getInterviewsByVacancyId(getVacancyId(4));
        Test.stopTest();

        System.assertEquals(3, result0.size(), '3 Interviews record expected');
        System.assertEquals(2, result1.size(), '3 Interviews record expected');
        System.assertEquals(1, result2.size(), '3 Interviews record expected');
        System.assertEquals(1, result3.size(), '3 Interviews record expected');
        System.assertEquals(1, result4.size(), '3 Interviews record expected');
    }

    @IsTest
    static void testGetInterviewsByContactId() {
        Test.startTest();
        List<Interview__c> result0 = InterviewController.getInterviewsByContactId(getContactId(0));
        List<Interview__c> result1 = InterviewController.getInterviewsByContactId(getContactId(1));
        List<Interview__c> result2 = InterviewController.getInterviewsByContactId(getContactId(2));
        Test.stopTest();

        System.assertEquals(3, result0.size(), '3 Interviews record expected');
        System.assertEquals(3, result1.size(), '3 Interviews record expected');
        System.assertEquals(2, result2.size(), '3 Interviews record expected');
    }

    @IsTest
    static void testGetInterviewsForWeek() {
        Date today = Date.today();
        Date weekStart = today.toStartOfWeek();
        Integer dayOfWeek = weekStart.daysBetween(today);

        Test.startTest();
        List<Interview__c> result0 = InterviewController.getInterviewsForWeek(getCompanyId(0));
        List<Interview__c> result1 = InterviewController.getInterviewsForWeek(getCompanyId(1));
        Test.stopTest();

        switch on dayOfWeek{
            when 6{
                System.assertEquals(2, result0.size(), '2 Interviews record expected');
            }
            when 5{
                System.assertEquals(4, result0.size(), '3 Interviews record expected');
            }
            when 4{
                System.assertEquals(5, result0.size(), '5 Interviews record expected');
            }
            when else {
                System.assertEquals(6, result0.size(), '6 Interviews record expected');
            }
        }

        System.assertEquals(0, result1.size(), '0 Interviews record expected. All Interviews next week');
    }

}