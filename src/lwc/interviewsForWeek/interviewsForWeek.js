import {LightningElement, api, wire} from 'lwc';
import getInterviewsForWeek from '@salesforce/apex/InterviewController.getInterviewsForWeek';

export default class InterviewsForWeek extends LightningElement {
    @api recordId;
    @wire(getInterviewsForWeek, {companyId:'$recordId'})
    interviews;
}