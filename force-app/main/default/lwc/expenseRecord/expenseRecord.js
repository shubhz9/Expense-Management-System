import { api, LightningElement } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Expense__c.Name';
import AMOUNT_FIELD from '@salesforce/schema/Expense__c.Amount__c';
import COMMENT_FIELD from '@salesforce/schema/Expense__c.Comment__c';
import DESCRIPTION_FIELD from '@salesforce/schema/Expense__c.Description__c';
import EMPLOYEE_FIELD from '@salesforce/schema/Expense__c.Employee__c';
import TYPE_FIELD from '@salesforce/schema/Expense__c.Type__c';

export default class ExpenseRecord extends LightningElement {
    @api recordId;
    fields = [NAME_FIELD, AMOUNT_FIELD,COMMENT_FIELD, DESCRIPTION_FIELD, EMPLOYEE_FIELD, TYPE_FIELD];
}