/**
 * @description       : 
 * @author            : Shubham Raut
 * @group             : 
 * @last modified on  : 09-11-2023
 * @last modified by  : Shubham Raut
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   09-11-2023   Shubham Raut   Initial Version
**/
trigger EmployeeTrigger on Employee__c (before insert, before update) {
    if(Trigger.isInsert){
        Map<Id, User> userToEmployee = new Map<Id, User>();
        for(Employee__c emp: Trigger.New){
            if(String.isNotBlank(emp.User__c)){
                userToEmployee.put(emp.User__c, null);
            }
        }

        userToEmployee.putAll([SELECT Id, (SELECT Id FROM Employees__r) FROM User WHERE Id IN :userToEmployee.keySet()]);

        for(Employee__c emp: Trigger.New){
            if(String.isNotBlank(emp.User__c) && userToEmployee.containsKey(emp.User__c) && userToEmployee.get(emp.User__c).Employees__r != null && !userToEmployee.get(emp.User__c).Employees__r.isEmpty()){
                emp.addError('THIS USER IS ALREADY ASSIGNED');
            }
        }
    }

    if(Trigger.isUpdate){
        Map<Id, User> userToEmployee = new Map<Id, User>();
        for(Employee__c emp: Trigger.New){
            Employee__c oldEmp = Trigger.oldMap.get(emp.Id);
            System.debug('@@-- oldEmp - ' + oldEmp);
            System.debug('@@-- emp - ' + emp);
            if(String.isNotBlank(emp.User__c) &&(String.isBlank(oldEmp.User__c) || !oldEmp.User__c.equals(emp.User__c))){
                userToEmployee.put(emp.User__c, null);
            }
        }
        userToEmployee.putAll([SELECT Id, (SELECT Id FROM Employees__r) FROM User WHERE Id IN :userToEmployee.keySet()]);

        for(Employee__c emp: Trigger.New){
            if(String.isNotBlank(emp.User__c) && userToEmployee.containsKey(emp.User__c) && userToEmployee.get(emp.User__c).Employees__r != null && !userToEmployee.get(emp.User__c).Employees__r.isEmpty()){
                emp.addError('THIS USER IS ALREADY ASSIGNED');
            }
        }
    }
}