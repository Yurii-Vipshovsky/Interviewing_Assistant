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

    createVacancy(){
        console.log(this.recordId,  this.name, this.description);
        addVacancy({companyId: this.recordId, name: this.name, description: this.description} )
            .then( () => {
                    console.log('Vacancy created');
                    this.showForm = false;
                    this.showSuccess = true;
                    refreshApex(this.vacancies);
                }
            )
            .catch(error => {
                console.log('Vacancy not created');
                console.log(error)
            })
    }
}