({
    init : function(component, event, helper) {
        component.set('v.loaded', !component.get('v.loaded'));
        helper.getData(component,event,helper);
    },
    handleChange:function(component,event,helper){
        component.set('v.loaded', !component.get('v.loaded'));
        component.set("v.selectedField", []);
        component.set("v.tableColumns", []);
        helper.getAllFields(component, event, helper);

    }, 
    handleToChangeSelectedField: function (component, event, helper) {
        component.set('v.loaded', !component.get('v.loaded'));
        //Get the Selected values   
        // var tempList=[];
        //  console.log(' component.get("v.allField") ', JSON.stringify(component.get("v.allField")).length);
        //  for(let i=0;i<JSON.stringify(component.get("v.allField")).length;i++){
        //     console.log(JSON.stringify(component.get("v.allField"))[i]);
        //  }
        var selectedValues = event.getParam("value");
        // var labels = component.get("v.allField")
        // .filter(option => selectedValues.indexOf(option.value) > -1)
        // .map(option => option.label);
        component.set("v.selectedField", selectedValues);
        if(selectedValues==0){
            component.set("v.tableColumns", []);
        }
        // component.set("v.tableColumns", selectedValues);
    },
    processTable : function(component, event, helper){
        // component.set('v.loaded', !component.get('v.loaded'));
        var selectedValues=component.get("v.selectedField");
        component.set("v.tableColumns", selectedValues);
        // var fieldNames=component.get("v.selectedField");//list of selected fields from picklist       
        // var columnsDataTable = [];
        // for (var i in fieldNames) {
        //     columnsDataTable.push({label: fieldNames[i],
        //         fieldName: fieldNames[i],
        //         type: 'String',
        //         sortable:true
        //     });
        // }
        // component.set("v.tableColumns", columnsDataTable);
        var pageNumber = component.get("v.PageNumber"); 
        var pageSize = component.find("pageSize").get("v.value");
        helper.getRecordsFromServer(component, pageNumber, pageSize);
        helper.totalRecords(component, pageNumber, pageSize);
    },
    pageRecordChange: function(component, event, helper) {
        var page = 1
        var pageSize = component.find("pageSize").get("v.value");
        helper.getRecordsFromServer(component, page, pageSize);
        helper.totalRecords(component, page, pageSize);
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
    handleChangeSorting:function(component,event,helper){
        var selectedItem = event.currentTarget;
        var selectedField = selectedItem.dataset.tit;
        console.log(selectedField);
        console.log(selectedItem);
        component.set("v.selectedSortingField", selectedField);
        helper.sortData(component);
    },
    // handleSort: function(component,event,helper){
    //     var sortBy = event.getParam("fieldName");
    //     var sortDirection = event.getParam("sortDirection");
    //     component.set("v.sortBy",sortBy);
    //     component.set("v.sortDirection",sortDirection);
    //     helper.sortData(component,sortBy,sortDirection);
    // },
    selectDeselectAll: function(component, event, helper){
        //  alert('In selectDeselectAll');
          var trueFalseCheck=event.getSource().get("v.value");
          var conList=component.get("v.contactList");
          var pagnitaList=component.get("v.sObjectList");
          var conListUpd=[];
          var pagnitaListUpd=[];
          for(var i=0;i<conList.length;i++)
              {
                  if(trueFalseCheck==true)
                  {
                      conList[i].check=true;
                  }
                  else
                  {
                      conList[i].check=false;
                  }
                  conListUpd.push(conList[i]);
              }
          component.set("v.contactList",conListUpd);
          for(var i=0;i<pagnitaList.length;i++)
              {
                  if(trueFalseCheck==true)
                  {
                      pagnitaList[i].check=true;
                  }
                  else
                  {
                      pagnitaList[i].check=false;
                  }
                  pagnitaListUpd.push(pagnitaList[i]);
              }
               component.set("v.contactListPaginateWise",pagnitaListUpd);
     
      }
})