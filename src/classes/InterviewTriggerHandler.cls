public with sharing class InterviewTriggerHandler {
    public static void handler(List<Interview__c> interviews) {
        Set<Id> interviewersIds = new Set<Id>();
        for(Integer i=0; i<interviews.size();++i){
            interviewersIds.add(interviews[i].Interviewer__c);
        }
        List<Interview__c> interviewsForWeek = InterviewSelector.SelectInterviewsForWeekByInterviewers(interviewersIds);
        Map<Id,Integer> interviewersCount = new Map<Id, Integer>();
        for(Integer i=0;i<interviewsForWeek.size();++i){
            if(interviewersCount.containsKey(interviewsForWeek[i].Interviewer__c)){
                Integer tempCount = interviewersCount.get(interviewsForWeek[i].Interviewer__c) + 1;
                interviewersCount.remove(interviewsForWeek[i].Interviewer__c);
                interviewersCount.put(interviewsForWeek[i].Interviewer__c,tempCount);
            }
            else {
                interviewersCount.put(interviewsForWeek[i].Interviewer__c,1);
            }
        }
        System.debug(interviewersCount.get(interviews[0].Interviewer__c));
        for(Integer i=0; i<interviews.size();++i){
            if(interviewersCount.get(interviews[i].Interviewer__c) > 3){
                interviews[i].addError('Can\'t insert this interview, because interviewer has already 3 interviews');
            }
        }
    }
}