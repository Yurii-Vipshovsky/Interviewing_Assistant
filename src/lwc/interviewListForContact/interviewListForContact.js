import {LightningElement, api, wire} from 'lwc';
import getInterviewsByContactId from '@salesforce/apex/InterviewController.getInterviewsByContactId';

export default class InterviewListForContact extends LightningElement {
    @api recordId

    @wire(getInterviewsByContactId, {contactId:'$recordId'})
    interviews;

    acceptOffer(){

    }
    declineOffer(){

    }
}