
 

$( document ).ready(function() {

    const pickers = initPickers();
    const wardPicker = pickers["picker-reg-user"];
    wardPicker.objToString = (ward)=>{
        return `${ward.name} ( ${ ward.local_muni_id } )`;
    }


    wardPicker.onPick = ()=>{
        console.log("icking")
        const content = $("#container-picker").children().first();
        content.addClass("hidden");

        WardPicker.onPick = (ward, pos)=>{
            wardPicker.setSelection(ward)
            content.removeClass("hidden");
            WardPicker.hide()
        }
        $("#container-picker").append(WardPicker.show());
    }

    document.getElementById("btn-reg-user").onclick = function(e){
        const elementUsername = $("#inp-id-number");
        const elementFirstName = $("#inp-first-name");
        const elementLastName = $("#inp-last-name");
        const elementAddress = $("#inp-address");
 
        elementUsername.removeClass("input-error");
        elementFirstName.removeClass("input-error");
        elementLastName.removeClass("input-error");
        elementAddress.removeClass("input-error");
        wardPicker.setError(false);
        $("#s-error").addClass("hidden");

        const username = elementUsername.val();
        const first_name = elementFirstName.val();
        const last_name = elementLastName.val();
        const address = elementAddress.val();
        const ward = wardPicker.selection;

        const errors = [];
        if(!username || username == ""){
            errors.push("ID Number");
            elementUsername.addClass("input-error");
        }
        if(!first_name || first_name == ""){
            errors.push("First name");
            elementFirstName.addClass("input-error");
        }
        if(!last_name || last_name == ""){
            errors.push("Last name");
            elementLastName.addClass("input-error");
        }
        if(!address || address == ""){
            errors.push("Address");
            elementAddress.addClass("input-error");
        }

        if(!ward){
            errors.push("Ward");
            wardPicker.setError(true);
        }

        if(errors.length == 0){
            const body = { voter_id_number: username, first_name, last_name, physical_address: address, ward_id: ward.ward_id, iec_member_registrant_id : "IEC-JD"};
            console.log("body--", body);
            registerVoter(body)
            .then(user => {
                alert("Voter Registered")
                location.reload();
            })
            .catch(error => {
                $("#s-error").removeClass("hidden").html("ID Number Already Registered");
            })

        }else{
            $("#s-error").removeClass("hidden").html("Invalid: " + errors.join(", "));
        }
         return false;
    }
});

