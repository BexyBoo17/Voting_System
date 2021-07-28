$( document ).ready(function() {

    const pickers = initPickers();
    const wardPicker = pickers["picker-reg-candi"];
    wardPicker.objToString = (obj)=>{
        return obj.name;
    }


    wardPicker.onPick = ()=>{
        console.log("onpick");
        const content = $("#container-picker-candi").children().first();
        content.addClass("hidden");

        console.log(content.html())

        WardPicker.onPick = (ward, pos)=>{
            wardPicker.setSelection(ward)
            content.removeClass("hidden");
            WardPicker.hide()
        }
        $("#container-picker-candi").append(WardPicker.show());
    }



    document.getElementById("btn-reg-party").onclick  =()=>{
        const elementName = $("#inp-name");
        const elementLogo = $("#inp-logo");
 
 
        elementName.removeClass("input-error");
        elementLogo.removeClass("input-error");
 
        $("#s-error").addClass("hidden");

        const name = elementName.val();
        const files = elementLogo.prop("files");
        const logo = files[0];


        const errors = [];
        if(!name || name == ""){
            errors.push("Name");
            elementName.addClass("input-error");
        }
        if(!logo){
            errors.push("Logo");
            elementLogo.addClass("input-error");
        } 
        if(errors.length == 0){
            const body = { name };
            registerParty(body)
            .then(party => {
                alert("Party Registered")
                location.reload();
            })
            .catch(error => {
                $("#s-error").removeClass("hidden").html("Party Already Registered");
            })

        }else{
            $("#s-error").removeClass("hidden").html("Invalid: " + errors.join(", "));
        }
         return false;
    }

    document.getElementById("btn-reg-candi").onclick  =()=>{
        const elementName = $("#inp-name-candi");
  
 
        elementName.removeClass("input-error");
        wardPicker.setError(false);
        $("#s-error-candi").addClass("hidden");      
        
        const name = elementName.val();
        const ward = wardPicker.selection;




        const errors = [];
        if(!name || name == ""){
            errors.push("Name");
            elementName.addClass("input-error");
        }
        if(!ward){
            errors.push("Ward");
            wardPicker.setError(true);
        }

        if(errors.length == 0){
            const body = { name, ward};
            console.log("reg", body);

        }else{
            $("#s-error-candi").removeClass("hidden").html("Invalid: " + errors.join(", "));
        }
         return false;
    }

    const container = document.getElementById("list-parties");
    getParties()
    .then(parties => {
        for(var pos = 0; pos < parties.length; pos++){
            var party = parties[pos];
            container.appendChild(PartyItem(party, ()=>{
                WardPicker.onPick && WardPicker.onPick(ward, pos)
            }));
        }
    })
    .catch(error => { console.log("eeror", error)})
});



const PartyItem = (party, onclick)=>{
    const avatarText = party.name[0];

    const container = document.createElement("div");
    container.className = "list-item";
    container.style.cursor = "pointer";
    container.style.flexDirection = "column"
    container.onclick = onclick;
 

    const ui = `<div class="row" style="width: 100%;">
    <div class="avatar"><h6 style="height: fit-content;align-self: center;">${ avatarText }</h6></div>
    <div class="col" style="padding: 8px">
        <h6>${ party.name }</h6>
        <h6 class="subtext-light">---</h6>
    </div>
    <img class="side-item" src="./img/assets/minus.png" alt="">  
  </div>
  <div data-bs-toggle="modal" data-bs-target="#register_candi" class="col btn-primary" style="align-self: flex-end; padding: 4px 16px; border-radius: 5px; cursor: pointer;">
    Register Candidate
  </div>`
    container.innerHTML += ui;

return container;

}