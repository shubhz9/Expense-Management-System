/**
 * @description       : 
 * @author            : Shubham Raut
 * @group             : 
 * @last modified on  : 09-11-2023
 * @last modified by  : Shubham Raut
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   09-07-2023   Shubham Raut   Initial Version
**/
public with sharing class ExpenseUtility {
    @AuraEnabled(cacheable=true)
    public static List<Expense__c> fetchExpense(){
        try {
            return [SELECT Name, Id, Employee__c, Employee__r.Employee_Name__c, Amount__c, Type__c, Status__c, Comment__c, Description__c FROM Expense__c LIMIT 49999];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Boolean checkApproveAccess(String recordId){
        try {
            System.debug('@@-- recordId' + recordId);
            Expense__c expense = [SELECT Id, Status__c, Employee__r.Reports_To__r.User__c FROM Expense__c WHERE Id = :recordId LIMIT 1];
            
            if(expense != null && expense.Status__c != 'Approved' && expense.Employee__r != null && expense.Employee__r.Reports_To__r.User__c != null && expense.Employee__r.Reports_To__r.User__c.equals(UserInfo.getUserId())){
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}