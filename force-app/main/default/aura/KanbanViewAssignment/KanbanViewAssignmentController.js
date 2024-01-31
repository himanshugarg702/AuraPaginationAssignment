({
    init : function(component, event, helper) {
        helper.getData(component,event,helper);
    },
    handleChange:function(component,event,helper){
        component.set("v.selectedField", []);
        component.set("v.allField", []);
        component.set("v.requiredOptions",[]);
        var requiredOptions1 = ["Name","Id"];
        component.set("v.requiredOptions",requiredOptions1);
        helper.getAllPickListField(component, event, helper);
    }, 
    handleToGetPickListField: function (component, event, helper) {
        helper.getAllFields(component, event, helper);
    },
    handleToChangeSelectedField: function (component, event, helper) {
        var selectedValues = event.getParam("value");
        component.set("v.selectedField", selectedValues);
        console.log(selectedValues,'hello');
        if(selectedValues==0){
            component.set("v.tableColumns", []);
        }
    },
    processTable: function (component, event, helper) {
        component.set('v.totalCountValue',0);
        helper.getAllPickListValues(component, event, helper);
       
    },
    allowDrop: function(component, event, helper) {
        event.preventDefault();
    },
    
    drop: function (component, event, helper) {
        event.preventDefault();
        console.log('drop');
        var data = event.dataTransfer.getData("text");
        console.log(data);
        var tar = event.target;
        console.log(tar);
        while(tar.tagName != 'ul' && tar.tagName != 'UL')
            tar = tar.parentElement;
        tar.appendChild(document.getElementById(data));
        component.set('v.pickVal',tar.getAttribute('data-Pick-Val'));
        console.log('aaaaaaaaaaaaa   :   ' + tar.getAttribute('data-Pick-Val'));
        document.getElementById(data).style.backgroundColor = "#ffb75d";
        helper.updatePickVal(component,data,component.get("v.selectedPickListField"),tar.getAttribute('data-Pick-Val'));
        // component.set('v.totalCountValue',0);
        helper.getAllPickListValues(component, event, helper);

    }
})