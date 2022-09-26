public with sharing class VacancyController {

    @AuraEnabled(Cacheable=true)
    public static  List<Vacancy__c> getVacanciesByCompanyId(Id companyId){
        return [SELECT Id, Name, Description__c, Available__c, We_Offer__c, Requirements__c FROM Vacancy__c WHERE Related_Company__c =:companyId];
    }

    @AuraEnabled(Cacheable=true)
    public static  List<Interview__c> getInterviewsByVacancyId(Id vacancyId){
        return [SELECT Id FROM Interview__c WHERE Vacancy__c =:vacancyId];
    }

    @AuraEnabled
    public static void addVacancy(Id companyId, String name, String description, String offer, String require){
        insert new Vacancy__c(Related_Company__c = companyId, Name = name, Description__c = description, We_Offer__c = offer, Requirements__c = require);
    }

    @AuraEnabled
    public static void changeAvailable(Id vacancyId){
        Vacancy__c toChange = [SELECT Id, Available__c FROM Vacancy__c WHERE Id=:vacancyId LIMIT 1];
        toChange.Available__c = !toChange.Available__c;
        update toChange;
    }
}