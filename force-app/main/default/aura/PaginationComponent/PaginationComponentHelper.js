({
    getData:function(component,event,helper)  {
        var action=component.get("c.allObject");
        action.setCallback(this,function(response) {
            var state=response.getState();
            if(state=="SUCCESS"||state=="DRAFT") {
                var result=response.getReturnValue();
                var listOfObjects=[];
                for(var key in result)  {
                    listOfObjects.push({key:key,value:result[key]});
                }
                // listOfObjects = listOfObjects.sort(function (a, b) {
                //     return a.val.localeCompare( b.val );
                // });
                component.set("v.allObject",listOfObjects);
            }
            else if(state=="INCOMPLETE")    {
                console.log("No response from server or client is offline.");
            }
            else if(state=="ERROR") {
                if(errors)  {
                    if(errors[0]&&errors[0].message)  {
                        console.log("Error Message: "+ errors[0].message);
                    }
                }
                else{
                    console.log("Unknown Error");
                }
            }
        })
        $A.enqueueAction(action);
    },
    getAllFields:function(component,event,helper){
        // console.log('check himanshu');
        var action=component.get("c.allFields");
        action.setParams({
            selectedObject:component.get('v.selectedObject'),
        })
        action.setCallback(this,function(response)  {
            var state = response.getState();
            if(state==="SUCCESS"||state==="DRAFT") {
                var result=response.getReturnValue();
                var listOfFields=[];
                for (var i = 0; i < result.length; i++) {
                    listOfFields.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.allField",listOfFields);
            }
            else if(state=="INCOMPLETE")    {
                console.log("No response from server or client is offline.");
            }
            else if(state=="ERROR") {
                if(errors)  {
                    if(errors[0]&&errors[0].message)  {
                        console.log("Error Message: "+ errors[0].message);
                    }
                }
                else{
                    console.log("Unknown Error");
                }
            }
        })
        $A.enqueueAction(action);
    }
})