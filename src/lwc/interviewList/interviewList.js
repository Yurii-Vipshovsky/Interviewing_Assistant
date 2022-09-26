import {LightningElement, api, wire} from 'lwc';
import getInterviewsByVacancyId from '@salesforce/apex/VacancyController.getInterviewsByVacancyId';

export default class InterviewList extends LightningElement {
    @api recordId
    @wire(getInterviewsByVacancyId, {vacancyId:'$recordId'})
    interviews;
    testLog(){
        console.log(this.interviews);
    }
}