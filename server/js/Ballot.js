

function partiesLoader(){
    return new Promise((resolve, reject)=>{
        resolve([{ id: 182781, name : "ANC"}, { id: 457152, name : "DA"}, { id: 457152, name : "DA"}]);
    })
}

function candidatesLoader(){
    return new Promise((resolve, reject)=>{
        resolve([{ id: 182781, name : "Asanda"}, { id: 457152, name : "Tuto"}, { id: 457152, name : "Kah"}]);
    })
}

class BallotPaperManager{

    constructor(votesForDistrict){
        this.BallotPapers = [ new BallotPaper("Ward", "ward", candidatesLoader)
            ,new BallotPaper("Local Municipality", "local_mun", partiesLoader)];

        if(votesForDistrict)
            this.BallotPapers.push(new BallotPaper("Districts", "district", partiesLoader))

        this.onShowListener = null;
        this.position = 0;
        this.ui = null;
        this.indicator = new Indicator(this.BallotPapers.length);
    }

    compile(){
        const compiled = {};
        this.BallotPapers.forEach(ballotPaper => compiled[ballotPaper.id] = ballotPaper.selected);
        return compiled;
    }

    dispose(){
        this.position = 0;
        this.ui = null;
        this.BallotPapers.forEach(ballotPaper => ballotPaper.dispose())
    }

    hasNext(){
        return  this.position < this.BallotPapers.length - 1;
    }

    hasPrevious(){
        return this.position > 0;
    }

    show(id){
        console.log("showing", id)
        this.BallotPapers.forEach((ballotPaper, pos)=> {
            if(ballotPaper.id == id){
                ballotPaper.show();
                if(this.onShowListener){
                    this.onShowListener(ballotPaper);
                }
                this.position = pos;
                this.indicator.select(this.position);
            }else{
                ballotPaper.hide();
            }
        })
    }

    next(){
        this.position++;
        this.position = Math.max(0, Math.min(this.BallotPapers.length - 1, this.position));
        this.show(this.getId(this.position));
    }

    previous(){
        this.position--;
        this.position = Math.max(0, Math.min(this.BallotPapers.length - 1, this.position));
        this.show(this.getId(this.position));
    }

    render(){
        const container = document.createElement("div");
        container.className = 'ballot-paper-container';

        this.BallotPapers.forEach((ballotPaper, pos) => {
            container.appendChild(ballotPaper.render());
        })

        const footer = document.createElement("div");
        footer.className = "footer-ballots";
        footer.appendChild(this.indicator.render());

        container.appendChild(footer);

        this.show(this.getId(this.position));
        this.ui = container;
        return container;
    }

    getId(pos){
        return this.BallotPapers[pos]?.id;
    }

    setOnShowListener(listener){
        this.onShowListener = listener;
    }

}

class Indicator{
    

    constructor(pMax){
        this.max = pMax;
        this.position = 0;
        this.dots = []
    }

    select(index){
        this.position = Math.max(0, Math.min(this.max - 1, index));

        this.dots.forEach((dot, pos) => {
            if(pos == index){
                $(dot).addClass("dot-active")
            }else{
                $(dot).removeClass("dot-active")
            }
        })
    }

    render(){
        const container = document.createElement("div");
        container.className = "container-indicator";
        const dots = [];

        for (let pos = 0; pos < this.max; pos++) {
            const dot =    document.createElement("p");
            dot.className = "dot";
            container.appendChild(dot);
            dots.push(dot);
        }

        this.ui = container;
        this.dots = dots;

        return this.ui;
    }
}
 

class BallotPaper{
    
    constructor(pName, pId, pLoader){
        this.selected = null;
        this.id = pId || pName;
        this.name = pName;
        this.ui = null;
        this.loadOptions = pLoader;
        this.onSelectOptionListener = null;
    }

    dispose(){
        this.selected = null;
        this.ui = null;
        this.onSelectOptionListener = null;
    }

    show(){
        if(!this.ui)
            this.render();

        $(this.ui).removeClass("hidden");
    }

    hide(){
        if(this.ui){
            $(this.ui).addClass("hidden");
        }
    }

    setOnSelectOptionListener(listener){
        this.onSelectOptionListener = listener;
    }


    render(){
        const container = document.createElement("div");
        container.className = "ballot-paper";

        this.loadOptions()
        .then(options => {
            options.forEach((party, pos)=>{
                const listItem = document.createElement("div");
                listItem.className = 'list-item-col';

                listItem.appendChild(BallotItem(party, ()=>{
                    this.selected = party;
                    if(this.onSelectOptionListener)
                        this.onSelectOptionListener(party);
                }))

       
               if(pos < options.length -1 ){
                const divider = document.createElement("div");
                divider.className = "divider";
                divider.style.marginBottom =  "0px";
                listItem.appendChild(divider);
               }
          
                container.appendChild(listItem);
            });
    
        })
        .catch(error => {

        });


        this.ui = container;
        return container;
    }
}
 

function BallotItem(item, onclick){

    const container = document.createElement("div");
    container.className = "form-check iec-row";
    container.style.alignItems = "center";
    container.style.padding = "0px 16px";
    container.setAttribute("data-bs-target", `#radio-party-id-${ item.id }`)

    const radioBtn = document.createElement("input");
    radioBtn.className="form-check-input";
    radioBtn.type = "radio";
    radioBtn.name = `radio-party`;
    radioBtn.id = `radio-party-id-${ item.id }`;

    container.onclick = ()=>{        
        radioBtn.checked = true;
        onclick();
    }
    const content = `<img src="/ice/party_logos/${ item.id }.png" alt="" class="logo-small circle-logo"/>
    <h5 style="margin: 0px; flex: 1; padding: 8px; height: fit-content; align-self: center">${ item.name }</h5>
     `;

    container.innerHTML = content;
    container.appendChild(radioBtn);

    return container;
}