

const WardPicker = {
    ui : null,
    hide: ()=>{
        WardPicker.ui && $(WardPicker.ui).addClass("hidden");
    },
    render : ()=>{
        const container = document.createElement("div");
        container.className = "list";
    
 
       
        container.style.width= "100%";
        container.style.height = "100%";

        getWards()
        .then(wards => {
            container.innerHTML = ""
            for (let pos = 0; pos < wards.length; pos++) {
                const ward = wards[pos];
                container.appendChild(WardItem(ward, ()=>{
                    WardPicker.onPick && WardPicker.onPick(ward, pos)
                }));
            }
        })
        .catch( error => {
            alert("No Internet Connection");
        })

        container.innerHTML = "Loading..."
        


    
        return container;
    },
    show: ()=>{
        if(!WardPicker.ui){
            WardPicker.ui = WardPicker.render();
        }

        $(WardPicker.ui).removeClass("hidden");
        return WardPicker.ui;
    }
}

const WardItem = (ward, onclick)=>{
    const avatarText = ward.name[0];

    const container = document.createElement("div");
    container.className = "list-item";
    container.style.cursor = "pointer";
    container.onclick = onclick;
 

    const ui = `<div class="avatar"><h6 style="height: fit-content;align-self: center;">${ avatarText.toUpperCase() }</h6></div>
    <div class="col" style="padding: 8px">
        <h6>${ ward.name }</h6>
        <h6 class="subtext-light">Local Municipality: ${ward.local_muni_id}</h6>
    </div>`
    container.innerHTML += ui;

return container;

}