public with sharing class CustomDataTableAuraPagination {
    @AuraEnabled 
    public static Map<String,String> allObject() {
        Map<String,String> listOfObject = new Map<String,String>();
        List<String> tempLabelName = new List<String>();
        List<String> tempApiName = new List<String>();
        for(SObjectType sType: Schema.getGlobalDescribe().values()) {
            DescribeSObjectResult res = sType.getDescribe();    
            if(res.isCustom()){
                tempLabelName.add(res.getLabel());
                tempApiName.add(res.getName());
            }
        }
        String standardObject = System.Label.StandardObject;
        for(String str:standardObject.split(',')) {
            tempLabelName.add(str.trim());
            tempApiName.add(str.trim());
        }
        tempApiName.sort();
        tempLabelName.sort();
        for(Integer i=0;i<tempApiName.size();i++) {
            listOfObject.put(tempApiName.get(i),tempLabelName.get(i));
        }
        if(listOfObject.size()>0) {
            return listOfObject;
        }
        return null;
    }
    /** 
     Name: allFields,
     description: getting field depend on the object,
     Param:Selected Object ,
     Return Type:Page Reference Null
    **/
    @AuraEnabled
    public static Map<String,String> allFields(String selectedObject) {
        Map<String,String> listOfField = new Map<String,String>();
        // List<String> tempLabelName=new List<String>();
        // List<String> tempApiName=new List<String>();
        if (selectedObject != null) {
            for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
                DescribeFieldResult res = sField.getDescribe();
                if (res.isUpdateable()||res.isCreateable()||res.isCustom()) {
                    // tempLabelName.add(res.getLabel());
                    // tempApiName.add(res.getName());
                    listOfField.put(res.getName(),res.getLabel());
                }
            }
        }
        // tempApiName.sort();
        // tempLabelName.sort();
        // for(Integer i=0;i<tempApiName.size();i++){
        //     listOfField.put(tempApiName.get(i),tempLabelName.get(i));
        // }
        return listOfField;
    }
    /** 
     Name: dataForTable,
     description: getting records depend on the selected field,
     Param:Selected Object, selected field, Pagenumber, PageSize
     Return Type:WrapperClass
    **/
    @AuraEnabled
    public static list<WrapperClass> dataForTable(String selectedObject,List<String> selectedField,Integer pageNumber,Integer pageSize){

            String allFieldsForQuery = '';
            for(Integer i = 0;i<selectedField.size();i++){
               if(i==selectedField.size()-1){
                    allFieldsForQuery+=selectedField.get(i)+' ';
               }
               else{
                allFieldsForQuery+=selectedField.get(i)+',';
               }
            }
            // AggregateResult[] tr = Database.query('SELECT count(id)total from '+selectedObject);
            Integer offset = (pageNumber-1)*pageSize;
            list<sObject> sobjectRecords = Database.query('SELECT '+allFieldsForQuery+' FROM '+selectedObject + ' LIMIT '+pageSize +' OFFSET '+offset);
            List<WrapperClass> wrapperVariableForGettingSobjectRecords = new List<WrapperClass>();

            for(sObject a:sobjectRecords) {
                wrapperVariableForGettingSobjectRecords.add(new WrapperClass(a));
            }
            // wrapperVariableForGettingSobjectRecords.sobj = sobjectRecords;
            return wrapperVariableForGettingSobjectRecords;
    }
    // public static list<Wrapper> tempData(List<sObject> temp){
    //     List<Wrapper> tempData=new List<Wrapper>();
    //     for(sObject a:temp) {
    //         tempData.add(new Wrapper(a));
    //     }
    //     return tempData;
    // }
    /** 
     Name: WrapperClass,
     description: class for making dynamically sObject records
    **/
    @AuraEnabled
    public static Integer getTotalRecords(String selectedObject){
        AggregateResult[] tr = Database.query('SELECT count(id)total from '+selectedObject);
        Integer totalRecords=(Integer)tr[0].get('total');
        return totalRecords;
    }
    public class WrapperClass{
        @AuraEnabled
        public sObject sobj{get;set;}
        @AuraEnabled
        public boolean check{get;set;}
        public WrapperClass(sObject sobj){
            this.sobj=sobj;
            this.check=false;
        }
    }
}