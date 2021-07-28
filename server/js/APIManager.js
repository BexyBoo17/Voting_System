
const ERROR_CLIENT = 0;

function execute(url, method, body){
    return new Promise((resolve, reject) => {
        var options = {
            method : method
        };

        if(method.toUpperCase() !== "GET")
            options.body =  new URLSearchParams(body);
        
        fetch(url, options)
        .then(response => {
            console.log(response.ok, ": is ok")
            if(response.ok)
                return response.json()
            else
                return Promise.reject({ errorCode: response.status, subCode : 0})
        })
        .then( data => { console.log("got data", data); resolve(data)})
        .catch(error => {reject({ errorCode : ERROR_CLIENT, subCode : 0}), console.log("error : (")})
    });
}

function getWards(){
    return execute("/ice/api/wards.php", "GET", null);
}

function getVoters(){
    return execute("/ice/api/voters.php", "GET", null);
}

function getParties(){
    return execute("/ice/api/parties.php", "GET", null);
}

function getDistricts(){
    return execute("/ice/api/upper_mun.php", "GET", null);
}


function registerVoter(voter){
    return execute("/ice/api/register_user.php", "POST", voter);
}


function registerParty(party){
    return execute("/ice/api/register_party.php", "POST", party);
}

function registerDistrict(district){
    return execute("/ice/api/register_upper_mun.php", "POST", district);
}

function authVoter(body){
    return execute("/ice/api/login_voter.php", "POST", body);
}

function authIEC(body){
    return execute("/ice/api/login_IEC.php", "POST", body);
}

function authVote(body){
    return execute("/ice/api/vote.php", "POST", body);
}