

$( document ).ready(function() {
    const checkers = initCheckers();
    const loginChecker = checkers["login-options"];
    loginChecker.onCheck = (parentId, itemId)=>{
        const elementLink = $("#link-register");
        const elementLabelPassword = $("#label-password");
        const elementLabelUsername = $("#label-username");
        if(itemId == "iec_member"){
            elementLink.removeClass("hidden");
            elementLabelPassword.html("Password")
            elementLabelUsername.html("IEC ID")

        }else{
            elementLink.addClass("hidden");
            elementLabelPassword.html("Registraction Code")
            elementLabelUsername.html("ID Number")
        }
 
    }

    $("#auth-form").submit(function(e){
        const loginType = loginChecker.getSelected();
        const username = $("#inp-username").val();
        const password = $("#inp-password").val();

        const body = { voter_id_number : username, registration_code : password};
        console.log("my body", body)
        var nextUrl = "#";
        if(loginType == "voter"){
            authVoter(body)
            .then(voter => {
                nextUrl = "./voter.html"
                localStorage.setItem("user", JSON.stringify(voter))
                window.location.href = nextUrl;
            })
            .catch(error => {
                console.log("eeeeee");
                $("#s-error").removeClass("hidden").html("Invalid ID Number or Password");
            })
        }else{

            authIEC({ iec_number : username, password : password})
            .then(voter => {
                nextUrl = "./iec_voter.html"
                localStorage.setItem("user", JSON.stringify(voter))
                window.location.href = nextUrl;
            })
            .catch(error => {
                console.log("eeeeee");
                $("#s-error").removeClass("hidden").html("Invalid ID Number or Password");
            })

        }


        return false;
    });
});


function initCheckers(){
    const checkers = document.getElementsByClassName("iec-checker");
    const result = {};
    for(var pos = 0; pos < checkers.length; pos++){
        const checker = checkers[pos];
        const  checkerObject = ()=>{}
        checkerObject.getSelected = ()=>{
            return checker.getAttribute("data-selected") || 0;
        }
        const selectedItemKey = checker.getAttribute("data-selected") || 0;
        const parentId = checker.getAttribute("ice-id") || pos
        const items = checker.querySelectorAll(".iec-checker-item");

        function selectItem(checker, selectedItemKey){
            checker.setAttribute("data-selected", selectedItemKey)
            const items = checker.querySelectorAll(".iec-checker-item");

            for(var index = 0; index < items.length;  index++){
                const item = items[index];
                const keyItem = item.getAttribute("key") || index;
                item.className = "iec-checker-item";
                if(keyItem == selectedItemKey){
                    item.className += " iec-checker-item-selected"
                }
            }
        }

        for(var index = 0; index < items.length;  index++){
            const item = items[index];
            const keyItem = item.getAttribute("key") || index;
            item.className = "iec-checker-item";
            if(keyItem == selectedItemKey){
                item.className += " iec-checker-item-selected"
            }

            item.onclick = ()=>{
                selectItem(checker, keyItem);
                checkerObject.onCheck && checkerObject.onCheck(parentId, keyItem)
            }
        }


 
        result[parentId] = checkerObject;
    }

    return result;
}