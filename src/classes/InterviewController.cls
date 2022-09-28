public with sharing class InterviewController {
    @AuraEnabled(Cacheable=true)
    public static  List<Interview__c> getInterviewsByVacancyId(Id vacancyId){
        return [SELECT Id FROM Interview__c WHERE Vacancy__c =:vacancyId];
    }

    @AuraEnabled(Cacheable=true)
    public static  List<Interview__c> getInterviewsByContactId(Id contactId){
        return [SELECT Id FROM Interview__c WHERE To_Interview__c =:contactId];
    }

    @AuraEnabled(Cacheable=true)
    public static  List<Interview__c> getInterviewsForWeek(Id companyId){
        List<Vacancy__c> ids = [SELECT Id FROM Vacancy__c WHERE Related_Company__c=:companyId];
        return [SELECT Id  FROM Interview__c WHERE Vacancy__c IN :ids AND Time__c<NEXT_WEEK AND Time__c>LAST_WEEK];
    }
}