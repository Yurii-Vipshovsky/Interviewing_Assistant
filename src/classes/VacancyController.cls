public with sharing class VacancyController {

    @AuraEnabled(Cacheable=true)
    public static  List<Vacancy__c> getVacanciesByCompanyId(Id companyId){
        return VacancySelector.SelectVacanciesByCompanyId(companyId);
    }

    @AuraEnabled
    public static void addVacancy(Id companyId, String name, String description, String offer, String require){
        insert new Vacancy__c(Related_Company__c = companyId, Name = name, Description__c = description, We_Offer__c = offer, Requirements__c = require);
    }

    @AuraEnabled
    public static void changeAvailable(Id vacancyId){
        Vacancy__c toChange = VacancySelector.SelectVacancyById(vacancyId);
        toChange.Available__c = !toChange.Available__c;
        update toChange;
    }
}