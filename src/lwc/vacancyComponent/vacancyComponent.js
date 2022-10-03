import {LightningElement, api} from 'lwc';
import changeAvailable from '@salesforce/apex/VacancyController.changeAvailable';
import {NavigationMixin} from "lightning/navigation";

export default class VacancyComponent extends NavigationMixin(LightningElement) {
    @api vacancy

    changeAvailable(){
        console.log(this.vacancy);
            changeAvailable({vacancyId: this.vacancy.Id} )
                .then( () => {
                        console.log('Available changed');
                        this.dispatchEvent(new CustomEvent('changed', {detail: this.vacancy.Id}));
                    }
                )
                .catch(error => {
                    console.log('Available not changed');
                    console.log(error)
                })
    }

    createInterview(){
        console.log('test');
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Interview__c',
                actionName: 'new'
            },
        });
    }

    viewRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": this.vacancy.Id,
                "objectApiName": "Vacancy__c",
                "actionName": "view"
            },
        });
    }
}