public with sharing class InterviewTriggerHandler {
    public static void handler(List<Interview__c> interviews, TriggerOperation triggerOperation) {
        Set<Id> interviewersIds = new Set<Id>();
        Datetime minDate = interviews[0].Time__c;
        Datetime maxDate = interviews[0].Time__c;
        switch on triggerOperation {
            when BEFORE_INSERT {

                for(Integer i=0; i<interviews.size();++i){
                    if(interviews[i].Time__c<Datetime.now()){
                        interviews[i].addError('Can\'t insert interview with time less than now');
                    }
                    else {
                        if(interviews[i].Time__c<minDate){
                            minDate = interviews[i].Time__c;
                        }
                        if(interviews[i].Time__c>maxDate){
                            maxDate = interviews[i].Time__c;
                        }
                        interviewersIds.add(interviews[i].Interviewer__c);
                    }
                }
                List<Interview__c> interviewsForWeek = InterviewSelector.SelectInterviewsForWeekByInterviewers(interviewersIds,
                                                        WeekDayHelper.previousWeek(minDate), WeekDayHelper.nextWeek(maxDate));
                System.debug('handler empty'+interviewsForWeek);
                for(Integer i =0;i<interviews.size();++i){
                    System.debug('handler'+i+' '+interviewsForWeek);
                    Integer counter = 0;
                    Boolean sameDay = false;
                    for (Integer j =0;j<interviewsForWeek.size();++j){
                        if(interviewsForWeek[j].Time__c.isSameDay(interviews[i].Time__c)
                                && interviewsForWeek[j].Interviewer__c==interviews[i].Interviewer__c){
                            sameDay = true;
                            continue;
                        }
                        if(interviewsForWeek[j].Time__c<WeekDayHelper.nextWeek(interviews[i].Time__c)
                                && interviewsForWeek[j].Time__c>WeekDayHelper.previousWeek(interviews[i].Time__c)
                                && interviewsForWeek[j].Interviewer__c==interviews[i].Interviewer__c){
                            counter++;
                        }
                    }
                    if (counter<3 && sameDay == false) {
                        interviewsForWeek.add(interviews[i]);
                    }
                    else {
                        if (sameDay) {
                            interviews[i].addError('Can\'t insert this interview, because interviewer has already interview in same day');
                        }
                        else {
                            interviews[i].addError('Can\'t insert this interview, because interviewer has already 3 interviews');
                        }

                    }
                }
            }
            when BEFORE_UPDATE {
                for(Integer i=0; i<interviews.size();++i){
                    if(interviews[i].Time__c<minDate){
                        minDate = interviews[i].Time__c;
                    }
                    if(interviews[i].Time__c>maxDate){
                        maxDate = interviews[i].Time__c;
                    }
                    interviewersIds.add(interviews[i].Interviewer__c);
                }
                List<Interview__c> interviewsForWeek = InterviewSelector.SelectInterviewsForWeekByInterviewers(interviewersIds,
                        WeekDayHelper.previousWeek(minDate), WeekDayHelper.nextWeek(maxDate));

                for(Integer i =0;i<interviews.size();++i){
                    Integer counter = 0;
                    for (Integer j =0;j<interviewsForWeek.size();++j){
                        if(interviewsForWeek[j].Time__c<WeekDayHelper.nextWeek(interviews[i].Time__c)
                                && interviewsForWeek[j].Time__c>WeekDayHelper.previousWeek(interviews[i].Time__c)
                                && interviews[i].Id!=interviewsForWeek[j].Id
                                && interviewsForWeek[j].Interviewer__c==interviews[i].Interviewer__c){
                            counter++;
                        }
                    }
                    if (counter<3) {
                        interviewsForWeek.add(interviews[i]);
                    }
                    else {
                        interviews[i].addError('Can\'t update this interview, because interviewer has already 3 interviews');
                    }
                }
            }
        }
    }
}