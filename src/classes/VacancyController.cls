public with sharing class VacancyController {

    @AuraEnabled(Cacheable=true)
    public static  List<Vacancy__c> getVacanciesByCompanyId(Id companyId){
        return [SELECT Name, Description__c,Available__c From Vacancy__c WHERE Related_Company__c =:companyId];
    }

    @AuraEnabled
    public static void addVacancy(Id companyId, String name, String description){
        insert new Vacancy__c(Related_Company__c=companyId, Name=name, Description__c = description);
    }
}