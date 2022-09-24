import {LightningElement, api, wire} from 'lwc';
import getVacanciesByCompanyId from '@salesforce/apex/VacancyController.getVacanciesByCompanyId';
import addVacancy from '@salesforce/apex/VacancyController.addVacancy';
import { refreshApex } from '@salesforce/apex';

export default class vacancyList extends LightningElement {
    @api companyId
    showForm=false;
    showSuccess=false;

    @wire(getVacanciesByCompanyId, {companyId:'$companyId'})
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

    createVacancy(){
        addVacancy({companyId: this.companyId, name: this.name, description: this.description} )
            .then( () => {
                    console.log('Vacancy created');
                    this.showForm = false;
                    this.showSuccess = true;
                    refreshApex(this.vacancies);
                }
            )
            .catch(error => console.log(error))
    }
}