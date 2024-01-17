({
    init : function(component, event, helper) {
        helper.getData(component,event,helper);
    },
    handleChange:function(component,event,helper){
        component.set("v.selectedField", []);
        helper.getAllFields(component, event, helper);

    }, 
    handleToChangeSelectedField: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
        //Update the Selected Values  
        component.set("v.selectedField", selectedValues);
        component.set("v.tableColumns", selectedValues);
    },
    // [
    //     { label: selectedValues, fieldName: selectedValues, type: 'text' }
        
    // ]
    processTable : function(component, event, helper){
        var fieldNames=component.get("v.tableColumns");//list of selected fields from picklist       
        // for (var i=0; i < fieldNames.length; i++) {
        //     var column=[                 
        //        {label: fieldNames[i],fieldName:   fieldNames[i]  }     
        //     ]      
        // }       
        var columnsDataTable = [];
        for (var i in fieldNames) {
            columnsDataTable.push({label: fieldNames[i],
                fieldName: fieldNames[i],
                type: 'String'
            });
        }
        component.set("v.tableColumns", columnsDataTable);
        
        var pageNumber = component.get("v.PageNumber"); 
        console.log(component.get("v.PageNumber")); 
        var pageSize = component.find("pageSize").get("v.value");
        //Get selected Genre List on button click 
        // var selectedValues = component.get("v.selectedField");
        // console.log('Selectd Genre-' + selectedValues);
        helper.getRecordsFromServer(component, pageNumber, pageSize);
    },
    pageRecordChange: function(component, event, helper) {
        var page = 1
        var pageSize = component.find("pageSize").get("v.value");
        helper.getRecordsFromServer(component, page, pageSize);
    },
    handlePrev: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber--;
        helper.getRecordsFromServer(component, pageNumber, pageSize);
    },
    // handleFirstPage: function(component, event, helper) {
    //     var pageNumber = component.get("v.PageNumber");  
    //     var pageSize = component.find("pageSize").get("v.value");
    //     helper.getRecordsFromServer(component, pageNumber, pageSize);
    // },
    handleNext: function(component, event, helper) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber++;
        helper.getRecordsFromServer(component, pageNumber, pageSize);
    },
    handleLastPage: function(component, event, helper) {
        var TotalPages = component.get("v.TotalPages");  
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber=TotalPages;
        helper.getRecordsFromServer(component, pageNumber, pageSize);
    },

})