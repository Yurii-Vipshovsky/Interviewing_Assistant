import {LightningElement, api} from 'lwc';
import {NavigationMixin} from "lightning/navigation";

export default class InterviewComponent extends NavigationMixin(LightningElement) {
    @api interview

    viewRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": this.interview.Id,
                "objectApiName": "Interview__c",
                "actionName": "view"
            },
        });
    }
}