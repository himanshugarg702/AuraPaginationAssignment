public with sharing class AuraPaginationAssignment {
   
    // public list<SelectOption> listOfObject {get;set;}  
    // public AuraPaginationAssignment() {
    //     listOfObject = new List<SelectOption>{new SelectOption('', '-- none --') };
    //     for(SObjectType sType: Schema.getGlobalDescribe().values()) {
    //         DescribeSObjectResult res = sType.getDescribe();    
    //         if(res.isCustom()){
    //             listOfObject.add(new SelectOption(res.getName(), res.getLabel()));
    //         }
    //     }
    // String standardObject= System.Label.StandardObject;
    // for(String str:standardObject.split(',')){
    //     listOfObject.add(new SelectOption(str.trim(),str.trim()));
    // }
    // listOfObject.sort();
    
    // }
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
        // listOfObject.values().sort();
        if(listOfObject.size()>0){
            return listOfObject;
        }
        return null;
    }
    @AuraEnabled
    public static List<String> allFields(String selectedObject){
        Map<String,String> listOfField = new Map<String,String>();
        if (selectedObject != null) {
            for (SObjectField sField : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
                DescribeFieldResult res = sField.getDescribe();
                if (res.isUpdateable()||res.isCreateable()||res.isCustom()) {
                    listOfField.put(res.getName(),res.getLabel());
                }
            }
        }
        return listOfField.values();
    }
    // public 
}