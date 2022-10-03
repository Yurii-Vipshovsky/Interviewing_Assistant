import {LightningElement, api, wire} from 'lwc';
import getInterviewsByVacancyId from '@salesforce/apex/InterviewController.getInterviewsByVacancyId';
import { NavigationMixin } from 'lightning/navigation';

export default class InterviewList extends NavigationMixin(LightningElement) {
    @api recordId
    @wire(getInterviewsByVacancyId, {vacancyId:'$recordId'})
    interviews;
    createNewInterview() {
        console.log('test');
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Interview__c',
                actionName: 'new'
            },
        });
    }
}