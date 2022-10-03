trigger InterviewTrigger on Interview__c (before insert, before update) {
    System.debug(Trigger.new);
    InterviewTriggerHandler.handler(Trigger.new);
}