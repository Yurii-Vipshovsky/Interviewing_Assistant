import {LightningElement, api} from 'lwc';
import declineOffer from '@salesforce/apex/InterviewController.declineOffer';
import acceptOffer from '@salesforce/apex/InterviewController.acceptOffer';

export default class InterviewComponentForContact extends LightningElement {
    @api interview

    acceptOffer(){
        acceptOffer({interviewId: this.interview.Id} )
            .then( () => {
                    this.dispatchEvent(new CustomEvent('changed', {detail: this.interview.Id}));
                }
            )
            .catch(error => {
                console.log(error)
            })
    }

    declineOffer(){
        declineOffer({interviewId: this.interview.Id} )
            .then( () => {
                    this.dispatchEvent(new CustomEvent('changed', {detail: this.interview.Id}));
                }
            )
            .catch(error => {
                console.log(error)
            })
    }
}