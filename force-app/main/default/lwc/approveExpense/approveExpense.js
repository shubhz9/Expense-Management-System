import { api, LightningElement } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Employee__c.Id';
import checkApproveAccess from '@salesforce/apex/ExpenseUtility.checkApproveAccess';


export default class ApproveExpense extends LightningElement {
    @api recordId;
    hasAccess = false;
    connectedCallback(){
        checkApproveAccess({recordId : this.recordId})
        .then( result => {
            console.log('@@-- HAS ACCESS ' + result);
            this.hasAccess = result;
        })
        .catch( error => {
            console.log('@@ error');
        })
    }

    onClickApproveExpense(event){
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields['Status__c'] = 'Approved';

        const recordInput = {
            fields : fields
        };
        updateRecord(recordInput)
        .then((record) => {
            console.log('@@-- ' + record);
            this.hasAccess = true;
        })
        .catch( error => {
            console.log('@@-- ' + error);
        })
        this.connectedCallback();
    }
}