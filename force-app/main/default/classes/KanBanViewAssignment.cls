public class KanBanViewAssignment {
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
                String fldType = string.valueOf(res.getType());
                // if(dfield.isGroupable() && dfield.isUpdateable() && fldType == 'PICKLIST')
                // res.isUpdateable()||res.isCreateable()||res.isCustom()||
                // if (res.isGroupable() && res.isUpdateable() && fldType == 'PICKLIST') {
                    if ((res.isUpdateable()||res.isCreateable()||res.isCustom())&& fldType != 'PICKLIST' ) {
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
    @AuraEnabled
    public static Map<String,String> pickListFields(String selectedObject) {
        Map<String,String> listOfField = new Map<String,String>();
        // List<String> tempLabelName=new List<String>();
        // List<String> tempApiName=new List<String>();
        if (selectedObject != null) {
            for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
                DescribeFieldResult res = sField.getDescribe();
                String fldType = string.valueOf(res.getType());
                // if(dfield.isGroupable() && dfield.isUpdateable() && fldType == 'PICKLIST')
                // res.isUpdateable()||res.isCreateable()||res.isCustom()||
                if (res.isGroupable() && res.isUpdateable() && fldType == 'PICKLIST') {
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
    // @AuraEnabled
    // public static Map<String,String> pickListData(String selectedObject) {

      
    //     Map<String,String> listOfField = new Map<String,String>();
    //     // List<String> tempLabelName=new List<String>();
    //     // List<String> tempApiName=new List<String>();
    //     if (selectedObject != null) {
    //         for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
    //             DescribeFieldResult res = sField.getDescribe();
    //             String fldType = string.valueOf(res.getType());
    //             // if(dfield.isGroupable() && dfield.isUpdateable() && fldType == 'PICKLIST')
    //             // res.isUpdateable()||res.isCreateable()||res.isCustom()||
    //             if (res.isGroupable() && res.isUpdateable() && fldType == 'PICKLIST') {
    //                 // tempLabelName.add(res.getLabel());
    //                 // tempApiName.add(res.getName());
    //                 listOfField.put(res.getName(),res.getLabel());
    //             }
    //         }
    //     }
    //     // tempApiName.sort();
    //     // tempLabelName.sort();
    //     // for(Integer i=0;i<tempApiName.size();i++){
    //     //     listOfField.put(tempApiName.get(i),tempLabelName.get(i));
    //     // }
    //     return listOfField;
    // }
    @AuraEnabled
    public static KanbanViewWrapperClass getPickVals(String fieldName, String selectedObject,List<String> selectedField){
        // Map<String,String> listOfField = new Map<String,String>();
        // // List<String> tempLabelName=new List<String>();
        // // List<String> tempApiName=new List<String>();
        // if (selectedObject != null) {
        //     for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
        //         DescribeFieldResult res = sField.getDescribe();
        //         String fldType = string.valueOf(res.getType());
        //         // if(dfield.isGroupable() && dfield.isUpdateable() && fldType == 'PICKLIST')
        //         // res.isUpdateable()||res.isCreateable()||res.isCustom()||
        //         if (res.isGroupable() && res.isUpdateable() && fldType == 'PICKLIST') {
        //             // tempLabelName.add(res.getLabel());
        //             // tempApiName.add(res.getName());
        //             listOfField.put(res.getLabel(),res.getName());
        //         }
        //     }
        // }
        String apiName=fieldName;
        List<String> plist = new List<String>();

        Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().get(apiName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple) {
            plist.add(f.getValue());
        }       	
        String query = 'SELECT Id,'+apiName+',';
        for(String s:selectedField){
            query += s+',';
        }
        query = query.removeEnd(',');
        query += ' FROM ' + selectedObject;        
        return new KanbanViewWrapperClass(Database.query(query), plist);
        
    }
    @AuraEnabled
    public static String getUpdateStage(String selectedObject,Id recId, String kanbanField, String kanbanNewValue) {
        // Map<String,String> listOfField = new Map<String,String>();
        // // List<String> tempLabelName=new List<String>();
        // // List<String> tempApiName=new List<String>();
        // if (selectedObject != null) {
        //     for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
        //         DescribeFieldResult res = sField.getDescribe();
        //         String fldType = string.valueOf(res.getType());
        //         // if(dfield.isGroupable() && dfield.isUpdateable() && fldType == 'PICKLIST')
        //         // res.isUpdateable()||res.isCreateable()||res.isCustom()||
        //         if (res.isGroupable() && res.isUpdateable() && fldType == 'PICKLIST') {
        //             // tempLabelName.add(res.getLabel());
        //             // tempApiName.add(res.getName());
        //             listOfField.put(res.getLabel(),res.getName());
        //         }
        //     }
        // }
        //  kanbanField=listOfField.get(kanbanField);
        SObject o1 = recId.getSObjectType().newSObject(recId);
        o1.put(kanbanField,kanbanNewValue);
        update o1;
        return 'Success';
    }
    // @AuraEnabled
    // public static String getApiName(String selectedObject,String selectedField){
    //     Map<String,String> listOfField = new Map<String,String>();
    //     // List<String> tempLabelName=new List<String>();
    //     // List<String> tempApiName=new List<String>();
    //     if (selectedObject != null) {
    //         for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
    //             DescribeFieldResult res = sField.getDescribe();
    //             String fldType = string.valueOf(res.getType());
    //             // if(dfield.isGroupable() && dfield.isUpdateable() && fldType == 'PICKLIST')
    //             // res.isUpdateable()||res.isCreateable()||res.isCustom()||
    //             if (res.isGroupable() && res.isUpdateable() && fldType == 'PICKLIST') {
    //                 // tempLabelName.add(res.getLabel());
    //                 // tempApiName.add(res.getName());
    //                 listOfField.put(res.getLabel(),res.getName());
    //             }
    //         }
    //     }
    //     String apiName=listOfField.get(selectedField);
    //     return apiName;
    // }
 /** 
     Name: KanbanViewWrapperClass,
     description: class for getting picklist values and records
    **/
    public class KanbanViewWrapperClass{
        @AuraEnabled
        public List<sObject> records {get;set;}
        @AuraEnabled
        public List<String> pickValues {get;set;}
        public KanbanViewWrapperClass(List<sObject> records, List<String> pickValues){
            this.records = records;
            this.pickValues = pickValues;
        }
    }
}