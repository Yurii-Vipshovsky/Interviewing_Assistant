public with sharing class InterviewController {
    @AuraEnabled(Cacheable=true)
    public static  List<Interview__c> getInterviewsByVacancyId(Id vacancyId){
        return InterviewSelector.SelectInterviewsByVacancyId(vacancyId);
    }

    @AuraEnabled(Cacheable=true)
    public static  List<Interview__c> getInterviewsByContactId(Id contactId){
        return InterviewSelector.SelectInterviewsByContactId(contactId);
    }

    @AuraEnabled(Cacheable=true)
    public static  List<Interview__c> getInterviewsForWeek(Id companyId){
        return InterviewSelector.SelectInterviewsForWeekForCompany(companyId);
    }
}