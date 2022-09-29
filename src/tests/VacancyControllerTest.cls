@IsTest
private class VacancyControllerTest {

    private static Id getCompanyId(){
        return [SELECT Id FROM Account LIMIT 1].Id;
    }

    @TestSetup
    static void prepareData () {
        Account testCompany = new Account(
                Name='Test record',
                Phone='12345786');
        insert testCompany;

        Vacancy__c testVacancy = new Vacancy__c(
                Name='Test record',
                Related_Company__c=getCompanyId(),
                Description__c='test Description',
                Available__c=true,
                We_Offer__c='test offer',
                Requirements__c='test requirements');
        insert testVacancy;

    }

    @IsTest
    static void testGetVacanciesByCompanyId() {
        Test.startTest();
        List<Vacancy__c> result = VacancyController.getVacanciesByCompanyId(getCompanyId());
        Test.stopTest();

        System.assertEquals(1, result.size(), 'One Vacancy record expected');
        System.assertEquals('Test record', result[0].Name, 'Name expected "Test Record"');
    }

    @IsTest
    static void testAddVacancy() {

        Test.startTest();
        List<Vacancy__c> result = VacancyController.getVacanciesByCompanyId(getCompanyId());
        System.assertEquals(1, result.size(), 'One Vacancy record expected');
        VacancyController.addVacancy(getCompanyId(),'Test record 1','test description', 'test offer','test require');
        result = VacancyController.getVacanciesByCompanyId(getCompanyId());
        System.assertEquals(2, result.size(), 'One Vacancy + one new Vacancy record expected');
        Test.stopTest();

        System.assertEquals('Test record', result[0].Name, 'Name expected "Test Record"');
        System.assertEquals('Test record 1', result[1].Name, 'Name expected "Test Record 1"');
    }

    @IsTest
    static void testChangeAvailable() {

        Test.startTest();
        List<Vacancy__c> result = VacancyController.getVacanciesByCompanyId(getCompanyId());
        System.assertEquals(1, result.size(), 'One Vacancy record expected');
        System.assertEquals(true, result[0].Available__c, 'Available Vacancy expected');
        VacancyController.changeAvailable(result[0].Id);
        result = VacancyController.getVacanciesByCompanyId(getCompanyId());
        System.assertEquals(1, result.size(), 'One Vacancy record expected');
        System.assertEquals(false, result[0].Available__c, 'Unavailable Vacancy expected');
        VacancyController.changeAvailable(result[0].Id);
        result = VacancyController.getVacanciesByCompanyId(getCompanyId());
        System.assertEquals(1, result.size(), 'One Vacancy record expected');
        System.assertEquals(true, result[0].Available__c, 'Available Vacancy expected');
        Test.stopTest();

    }
}