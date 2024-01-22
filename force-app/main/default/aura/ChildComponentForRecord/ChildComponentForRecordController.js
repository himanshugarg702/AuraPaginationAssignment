({
    check : function(component, event, helper) {
            var fieldName = component.get('v.fieldName');
            var records = component.get('v.record');
            var recordItem=records[fieldName];
            component.set('v.fieldValue', recordItem);

        //     console.log(fieldName,'fieldName');
        //     console.log(records.sobj,'records');
        //    console.log( records.fieldName,'check');
            // component.set('v.fieldValue', component.getReference('v.record.' + fieldName));``
        }
})
