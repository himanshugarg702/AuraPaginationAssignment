({
    init : function(component, event, helper) {
        helper.getData(component,event,helper);
    },
    handleChange:function(component,event,helper){
        helper.getAllFields(component, event, helper);

    }, 
    handleToChangeSelectedField: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
        console.log(selectedValues);
          console.log('v.allField');
        //Update the Selected Values  
        component.set("v.fieldTable", selectedValues);
    },
      
    processTable : function(component, event, helper){
        //Get selected Genre List on button click 
        var selectedValues = component.get("v.fieldTable");
        console.log('Selectd Genre-' + selectedValues);
    }
})