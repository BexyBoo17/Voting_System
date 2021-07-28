
 

$( document ).ready(function() {


    document.getElementById("btn-reg-district").onclick  =()=>{
        const elementName = $("#inp-name");
        const elementCode = $("#inp-code");

        elementName.removeClass("input-error");
        elementCode.removeClass("input-error");
        $("#s-error-district").addClass("hidden");      
        
        const name = elementName.val();
        const code = elementCode.val();

        const errors = [];
        if(!name || name == ""){
            errors.push("Name");
            elementName.addClass("input-error");
        }
        if(!code || code == ""){
            errors.push("Code");
            elementCode.addClass("input-error");
        }

        if(errors.length == 0){
            const body = { name, code};
       
            registerDistrict(body)
            .then(district => {
                alert("District Registered")
                location.reload();
            })
            .catch(error => {
                $("#s-error").removeClass("hidden").html("District Code Already Registered");
            })

        }else{
            $("#s-error-district").removeClass("hidden").html("Invalid: " + errors.join(", "));
        }
         return false;
    }

    const container = document.getElementById("list-districts");
    getDistricts()
    .then(districts => {
        for(var pos = 0; pos < districts.length; pos++){
            var district = districts[pos];
            container.appendChild(DistrictItem(district, ()=>{
                WardPicker.onPick && WardPicker.onPick(ward, pos)
            }));
        }
    })
    .catch(error => { console.log("eeror", error)})
});

const DistrictItem = (district, onclick)=>{
    const avatarText = district.name[0];

    const container = document.createElement("div");
    container.className = "list-item";
    container.style.cursor = "pointer";
    container.onclick = onclick;
 

    const ui = `<div class="avatar" style="background-color: orange;"><h6 style="height: fit-content;align-self: center;">${ avatarText }</h6></div>
    <div class="col" style="padding: 8px">
        <h6>${ district.name}</h6>
        <h6 class="subtext-light">CODE: ${ district.upper_muni_id }</h6>
    </div>
    <img class="side-item" src="./img/assets/minus.png" alt=""> `
    container.innerHTML += ui;

return container;

}

