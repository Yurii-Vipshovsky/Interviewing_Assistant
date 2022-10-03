import {LightningElement, api, wire} from 'lwc';
import getInterviewsByContactId from '@salesforce/apex/InterviewController.getInterviewsByContactId';
import { refreshApex } from '@salesforce/apex';

export default class InterviewListForContact extends LightningElement {
    @api recordId

    @wire(getInterviewsByContactId, {contactId:'$recordId'})
    interviews;

    interviewChanged(){
        refreshApex(this.interviews);
    }
}