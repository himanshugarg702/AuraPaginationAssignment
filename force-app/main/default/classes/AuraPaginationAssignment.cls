public with sharing class AuraPaginationAssignment {
    @AuraEnabled 
    public static Map<String,String> allObject() {
        Map<String,String> listOfObject = new Map<String,String>();
        for(SObjectType sType: Schema.getGlobalDescribe().values()) {
            DescribeSObjectResult res = sType.getDescribe();    
            if(res.isCustom()){
                listOfObject.put(res.getName(),res.getLabel());
            }
        }
        String standardObject= System.Label.StandardObject;
        for(String str:standardObject.split(',')){
            listOfObject.put(str.trim(),str.trim());
        }
        if(listOfObject.size()>0){
            return listOfObject;
        }
        return null;
    }
    @AuraEnabled
    public static Map<String,String> allFields(String selectedObject){
        Map<String,String> listOfField = new Map<String,String>();
        if (selectedObject != null) {
            for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
                DescribeFieldResult res = sField.getDescribe();
                if (res.isUpdateable()||res.isCreateable()||res.isCustom()) {
                    listOfField.put(res.getName(),res.getLabel());
                }
            }
        }
        return listOfField;
    }
    @AuraEnabled
    public static WrapperClass dataForTable(String selectedObject,List<String> selectedField,Integer pageNumber,Integer pageSize){
        
        // try {
            // selectedObject='Account';
            // Type t = Type.forName(selectedObject);
            // sObject obj = (sObject)t.newInstance();
            // sObject obj=Schema.getGlobalDescribe().get(selectedObject).newSObject();
            String allFieldsForQuery = '';
            for(Integer i=0;i<selectedField.size();i++){
               if(i==selectedField.size()-1){
                    allFieldsForQuery+=selectedField.get(i)+' ';
               }
               else{
                allFieldsForQuery+=selectedField.get(i)+',';
               }
            }
            AggregateResult[] tr=Database.query('SELECT count(id)total from '+selectedObject);
            System.debug(tr);
            Integer offset=(pageNumber-1)*pageSize;
            list<sObject> sobjectRecords=Database.query('SELECT '+allFieldsForQuery+' FROM '+selectedObject + ' LIMIT '+pageSize +' OFFSET '+offset);
            WrapperClass wrapperVariableForGettingSobjectRecords=new WrapperClass();
            wrapperVariableForGettingSobjectRecords.pageSize=pageSize;
            wrapperVariableForGettingSobjectRecords.pageNumber=pageNumber;
            wrapperVariableForGettingSobjectRecords.totalRecords=(Integer)tr[0].get('total');
            wrapperVariableForGettingSobjectRecords.sobj=sobjectRecords;
            return wrapperVariableForGettingSobjectRecords;
    }
    public class WrapperClass{
        @AuraEnabled
        public Integer pageSize{get;set;}
        @AuraEnabled
        public Integer pageNumber{get;set;}
        @AuraEnabled
        public Integer totalRecords{get;set;}
        @AuraEnabled
        public List<sObject> sobj{get;set;}
        // @AuraEnabled
        // public Boolean checkBox{get;set;}
    }
}