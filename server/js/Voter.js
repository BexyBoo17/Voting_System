$( document ).ready(function() {

    const editables = initEditables();
    console.log(editables);

    const edtAddress = editables["edt-address"];


    edtAddress.onSave = (address)=>{
        console.log(address);
    }

    editables.saver = ()=>{
        return new Promise((resolve, reject)=>{
            resolve("");
        });
    }

    const domModal = document.getElementById("modal-voting");
    const modal = new bootstrap.Modal(domModal);

    const rawUser = localStorage.getItem("user");
    var fromDistrict = false;
    if(rawUser){
        const userObj = JSON.parse(rawUser);
        fromDistrict = userObj.upper_type === "district";
        console.log("i as for", fromDistrict);
    }

    const ballotManager = new BallotPaperManager(fromDistrict);
    ballotManager.setOnShowListener((ballot)=>{
        $("#modal-title-voting").html(`Voting - ${ ballot.name } `)
        
        const elementBtnPos = $("#btn-positive-voting").html(ballotManager.hasNext() ? "Next" : "Submit");
        console.log(ballot);
        if(!ballot.selected)
            elementBtnPos.addClass("iec-disabled");
        else
            elementBtnPos.removeClass("iec-disabled");


        $("#btn-negative-voting").html(ballotManager.hasPrevious() ? "Previous" : "Close");

        ballot.setOnSelectOptionListener((selected) => {
            $("#btn-positive-voting").removeClass("iec-disabled");
        })
    })

    document.getElementById("btn-positive-voting").onclick = ()=>{
        if(ballotManager.hasNext())
            ballotManager.next();
        else{
            const votes =  ballotManager.compile();
            const body = { };
            body["vote-ward"] = votes.ward.ward_id;
            body["vote-local-id"] = votes.local_mun.local_muni_id;
            body["vote-ward"] = votes.ward.ward_id;


        } 
    }

    document.getElementById("btn-negative-voting").onclick = ()=>{
        if(ballotManager.hasPrevious())
            ballotManager.previous();
        else
            modal.hide()
    }




    domModal.addEventListener("shown.bs.modal", ()=>{
        const rendered = !!ballotManager.ui;
        console.log(rendered);
        if(!rendered){
            $("#body-ballot").append(ballotManager.render());
        }   
    });

    domModal.addEventListener("hidden.bs.modal", ()=>{
        ballotManager.dispose();
        $("#body-ballot").html(""); 
    });

    const btnVote = document.getElementById("btn-vote");
    btnVote.onclick = ()=>{
        modal.show();
    }

    const userRaw = localStorage.getItem("user");
    console.log("usuu", userRaw);
    if(userRaw){
        const user = JSON.parse(userRaw);
        
        $("#voter-avatar").html(user.first_name[0].toUpperCase());
        $("#voter-name").html(`${user.first_name.toUpperCase()} ${ user.last_name }`);
        $("#voter-id-number").html("ID Number: " + user.voter_id_number);
        $("#voter-ward-id").html(user.ward_id);

    }


  

  
});