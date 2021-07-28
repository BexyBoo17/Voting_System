$( document ).ready(function() {

    const container = document.getElementById("list-voters");
    console.log("here");

    getVoters()
    .then(voters => {
        for(var pos = 0; pos < voters.length; pos++){
            var voter = voters[pos];
            container.appendChild(VoterItem(voter, ()=>{
                WardPicker.onPick && WardPicker.onPick(ward, pos)
            }));
        }
    })
    .catch(error => { console.log("eeror", error)})

});

const VoterItem = (voter, onclick)=>{
    const avatarText = voter.first_name[0];

    const container = document.createElement("div");
    container.className = "list-item";
    container.style.cursor = "pointer";
    container.onclick = onclick;
 

    const ui = `<div class="avatar"><h6 style="height: fit-content;align-self: center;">${ avatarText }</h6></div>
    <div class="col" style="padding: 8px">
        <h6>${ voter.first_name} ${ voter.last_name }</h6>
        <h6 class="subtext-light">ID NUMBER: ${ voter.voter_id_number }</h6>
    </div>
    <img class="side-item" src="./img/assets/remove-user.svg" alt=""> `
    container.innerHTML += ui;

return container;

}