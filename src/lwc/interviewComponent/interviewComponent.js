import {LightningElement, api} from 'lwc';
import {NavigationMixin} from "lightning/navigation";
import createOffer from '@salesforce/apex/InterviewController.createOffer';

export default class InterviewComponent extends NavigationMixin(LightningElement) {
    @api interview
    showForm=false;
    showSuccess=false;

    createOfferShowForm(){
        this.showForm = true;
        this.showSuccess = false;
    }
    cancelCreation(){
        this.showForm = false;
        this.showSuccess = false;
    }
    handleSalaryChanged(event){
        this.salary = event.target.value;
    }
    handleFeedbackChanged(event){
        this.feedback = event.target.value;
    }
    handleStartChanged(event){
        this.start = event.target.value;
    }
    handleHoursChanged(event){
        this.hours = event.target.value;
    }
    createOffer(){
            createOffer({interviewId: this.interview.Id, salary: this.salary, feedback: this.feedback, startDate : this.start, hours : this.hours} )
                .then( () => {
                        this.showForm = false;
                        this.showSuccess = true;
                    }
                )
                .catch(error => {
                    console.log(error)
                })

    }

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