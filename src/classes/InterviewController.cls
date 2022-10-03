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
    @AuraEnabled
    public static void acceptOffer(Id interviewId){
        Interview__c toChange = InterviewSelector.SelectInterviewById(interviewId);
        toChange.Accept__c = true;
        update toChange;
    }
    @AuraEnabled
    public static void declineOffer(Id interviewId){
        Interview__c toChange = InterviewSelector.SelectInterviewById(interviewId);
        toChange.Declined__c = true;
        update toChange;
    }
}