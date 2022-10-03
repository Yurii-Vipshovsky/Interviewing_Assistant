public with sharing class VacancySelector {
    public static List<Vacancy__c> SelectVacanciesByCompanyId(Id companyId){
        return [SELECT Id, Name, Description__c, Available__c, We_Offer__c, Requirements__c
                FROM Vacancy__c WHERE Related_Company__c =:companyId];
    }

    public static Vacancy__c SelectVacancyById(Id vacancyId){
        return [SELECT Id, Available__c FROM Vacancy__c WHERE Id=:vacancyId LIMIT 1];
    }

    public static List<Vacancy__c> SelectVacanciesByRelatedCompany(Id companyId){
        return [SELECT Id FROM Vacancy__c WHERE Related_Company__c=:companyId];
    }
}