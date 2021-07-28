function initPickers(){
    const pickers = document.getElementsByClassName("picker");
    const pickersResult = {};

    for (let pos = 0; pos < pickers.length; pos++) {

    

        
        const picker = pickers[pos];
        const iecID = picker.getAttribute("iec-id") || pos;
        const placeholder = picker.getAttribute("placeholder") || "";

        const pickerObj = { selection : null,
            setError: (hasError)=>{
                hasError ? $(picker).addClass("input-error") : $(picker).removeClass("input-error");
            }
        };

        const elementLabel = picker.querySelector(".picker-label");

        pickerObj.setSelection = (obj)=>{
            pickerObj.selection = obj;
            elementLabel.innerHTML = (obj && pickerObj.objToString?.(obj)) || placeholder;
        }

        pickerObj.getSelection = ()=> pickerObj.selection;

        picker.onclick = ()=>{
            pickerObj.onPick && pickerObj.onPick(iecID);
        }

        pickerObj.setSelection(null);

        pickersResult[iecID] = pickerObj;
    }

    return pickersResult;
}

function initEditables(){
    const editables = document.getElementsByClassName("editable");
     const editablesResult = { editing : false };

    for (let pos = 0; pos < editables.length; pos++) {
 
        const editable = editables[pos];
        const editableObj = { editing : false };

        const toggle = editable.querySelector(".editable-toggle");
        const eId = editable.getAttribute("iec-id")
        const editableContent = editable.querySelector(".editable-editable");
         toggle.onclick = async ()=>{
             if(editableObj.editing){
                 editableContent.setAttribute("readonly", true);
                 const saver = editableObj.saver;
                 if(saver){
                     try {
                         await saver(editableContent.value);
                    } catch (error) {}
                }
                
                editableObj.onSave && editableObj.onSave(editableContent.value);    
                $(toggle).removeClass("editable-toggle-editing").html("edit")
            }else{
                $(toggle).addClass("editable-toggle-editing").html("save");
                editableContent.removeAttribute("readonly");
            }
            editableObj.editing = !editableObj.editing;
        }
        

        editablesResult[eId] = editableObj;
    }

    return editablesResult;
}