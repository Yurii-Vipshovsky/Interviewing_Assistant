import {LightningElement, api} from 'lwc';
import changeAvailable from '@salesforce/apex/VacancyController.changeAvailable';

export default class VacancyComponent extends LightningElement {
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
}