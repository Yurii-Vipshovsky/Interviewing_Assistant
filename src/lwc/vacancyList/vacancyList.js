import {LightningElement, api, wire} from 'lwc';
import getVacanciesByCompanyId from '@salesforce/apex/VacancyController.getVacanciesByCompanyId';
import addVacancy from '@salesforce/apex/VacancyController.addVacancy';
import { refreshApex } from '@salesforce/apex';

export default class vacancyList extends LightningElement {
    @api recordId;
    showForm=false;
    showSuccess=false;

    @wire(getVacanciesByCompanyId, {companyId:'$recordId'})
    vacancies;

    addVacancy(){
        this.showForm = true;
        this.showSuccess = false;
    }

    handleNameChanged(event){
        this.name = event.target.value;
    }

    handleDescriptionChanged(event){
        this.description = event.target.value;
    }

    handleOfferChanged(event){
        this.offer = event.target.value;
    }

    handleRequireChanged(event){
        this.require = event.target.value;
    }

    vacancyChanged(){
        this.showSuccess = true;
        refreshApex(this.vacancies);
    }

    createVacancy(){
        console.log(this.vacancies);
        if(this.name !== undefined){
            addVacancy({companyId: this.recordId, name: this.name, description: this.description, offer : this.offer, require : this.require} )
                .then( () => {
                        this.showForm = false;
                        this.showSuccess = true;
                        refreshApex(this.vacancies);
                    }
                )
                .catch(error => {
                    console.log(error)
                })
        }
    }
}