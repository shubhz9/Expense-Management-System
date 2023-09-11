import { api, LightningElement, wire } from 'lwc';
import fetchExpense from '@salesforce/apex/ExpenseUtility.fetchExpense';

export default class ExpenseList extends LightningElement {
    records;

    columns = [
        {
            label: 'Expense Number',
            fieldName: 'ExpenseURL',
            type: 'url',
            typeAttributes: {label: { fieldName: 'Name' }, 
            target: '_blank'},
            sortable: true
        },
        {label: 'Amount', fieldName: 'Amount__c'},        
        {
            label: 'Employee',
            fieldName: 'EmployeeLink',
            type: 'url',
            typeAttributes: {label: { fieldName: 'EmployeeName' }, 
            target: '_blank'},
            sortable: true
        },
        {label: 'Status', fieldName: 'Status__c'},
        {label: 'Type', fieldName: 'Type__c'}
    ];

    refreshExpense(event){
        console.log('@@-- ' + event);
        this.connectedCallback();
    }

    connectedCallback(){
        fetchExpense()
        .then(result => {
            result = JSON.parse(JSON.stringify(result));

            result.forEach(res => {
                res.EmployeeLink = '/' + res.Employee__c;
                res.EmployeeName = res.Employee__r.Employee_Name__c;
                res.ExpenseURL = '/' + res.Id;
                console.log('@@-- ' + JSON.stringify(res));
            });
            this.records = result;
            console.log(JSON.stringify(result));
        })
        .catch( error => {
            console.log('@@-- ' + error);
        })
    }
}