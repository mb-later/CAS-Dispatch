window.addEventListener("message",function(event){
    let data = event.data
    if (data.action == "show") {
        Dispatch(data.info)
    }
})

const Dispatch = function(data) {
    const activeContainers = $(".d-container:visible");
    $.each(data, function(key, value) {
        var content =  `        
        <div class="d-container">
        <div class="ellipsetop-left"></div>
        <div class="ellipsetop-right"></div>
        <div class="d-header">
            <div class="nearest-pd-cont">
                <img class="nearest-pd-img" src="https://prod.cloud.rockstargames.com/crews/sc/0291/19566919/publish/emblem/emblem_512.png">
                <div class="nearest-police-infos">
                    <h1 class="nearest-police">Nearest Police</h1>
                    <p class="nearest-name">${value.nPolice}</p>
                </div>
            </div>
            <div class="d-main-cont">
                <h1 class="header-text">${value.header}</h1>
                <p class="d-event">${value.event}.</p>
            </div>
            <div class="nearest-ems-cont">
                <img class="nearest-ems-img" src="https://www.pngmart.com/files/21/Doctor-PNG-Free-Download.png">
                <div class="nearest-ems-infos">
                    <h1 class="nearest-ems">Nearest EMS</h1>
                    <p class="nearest-ems-name">${value.nEms}</p>
                </div>
               
            </div>
        </div>
        <div class="alt-box">
            <div class="callsignmain">
                <div class="callsign-cont">
                    <svg width="12" height="10" viewBox="0 0 12 10" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.64175 0.872375H3.40111C1.82892 0.872375 0.780792 1.65847 0.780792 3.4927V7.16115C0.780792 8.99537 1.82892 9.78147 3.40111 9.78147H8.64175C10.2139 9.78147 11.2621 8.99537 11.2621 7.16115V3.4927C11.2621 1.65847 10.2139 0.872375 8.64175 0.872375ZM3.2701 7.42318C3.2701 7.63804 3.09192 7.81623 2.87705 7.81623C2.66218 7.81623 2.484 7.63804 2.484 7.42318V3.23066C2.484 3.0158 2.66218 2.83762 2.87705 2.83762C3.09192 2.83762 3.2701 3.0158 3.2701 3.23066V7.42318ZM4.84229 7.42318C4.84229 7.63804 4.66411 7.81623 4.44924 7.81623C4.23438 7.81623 4.05619 7.63804 4.05619 7.42318V6.89911C4.05619 6.68425 4.23438 6.50607 4.44924 6.50607C4.66411 6.50607 4.84229 6.68425 4.84229 6.89911V7.42318ZM4.84229 5.32692C4.84229 5.54179 4.66411 5.71997 4.44924 5.71997C4.23438 5.71997 4.05619 5.54179 4.05619 5.32692V3.23066C4.05619 3.0158 4.23438 2.83762 4.44924 2.83762C4.66411 2.83762 4.84229 3.0158 4.84229 3.23066V5.32692ZM6.41448 7.42318C6.41448 7.63804 6.2363 7.81623 6.02143 7.81623C5.80657 7.81623 5.62839 7.63804 5.62839 7.42318V3.23066C5.62839 3.0158 5.80657 2.83762 6.02143 2.83762C6.2363 2.83762 6.41448 3.0158 6.41448 3.23066V7.42318ZM7.98667 7.42318C7.98667 7.63804 7.80849 7.81623 7.59363 7.81623C7.37876 7.81623 7.20058 7.63804 7.20058 7.42318V5.32692C7.20058 5.11205 7.37876 4.93387 7.59363 4.93387C7.80849 4.93387 7.98667 5.11205 7.98667 5.32692V7.42318ZM7.98667 3.75473C7.98667 3.96959 7.80849 4.14778 7.59363 4.14778C7.37876 4.14778 7.20058 3.96959 7.20058 3.75473V3.23066C7.20058 3.0158 7.37876 2.83762 7.59363 2.83762C7.80849 2.83762 7.98667 3.0158 7.98667 3.23066V3.75473ZM9.55887 7.42318C9.55887 7.63804 9.38069 7.81623 9.16582 7.81623C8.95095 7.81623 8.77277 7.63804 8.77277 7.42318V3.23066C8.77277 3.0158 8.95095 2.83762 9.16582 2.83762C9.38069 2.83762 9.55887 3.0158 9.55887 3.23066V7.42318Z" fill="#757CEC"/></svg>
                    <h1 class="callsign-text">Callsign</h1>              
                </div>
                <div class="player-callsign">
                    <h1 class="txttest callsign">${value.callsign}</h1>
                </div>
            </div>
            <div class="namemain">
                <div class="name-cont">
                    <svg width="12" height="11" viewBox="0 0 12 11" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9.60551 0.375061H2.61799C1.33112 0.375061 0.288818 1.41154 0.288818 2.68677V8.54464C0.288818 9.81986 1.33112 10.8563 2.61799 10.8563H9.60551C10.8924 10.8563 11.9347 9.81986 11.9347 8.54464V2.68677C11.9347 1.41154 10.8924 0.375061 9.60551 0.375061ZM4.07373 2.80322C4.81324 2.80322 5.41882 3.40881 5.41882 4.14832C5.41882 4.88784 4.81324 5.49342 4.07373 5.49342C3.33421 5.49342 2.72863 4.88784 2.72863 4.14832C2.72863 3.40881 3.33421 2.80322 4.07373 2.80322ZM6.3272 8.32919C6.2748 8.38742 6.19327 8.42236 6.11175 8.42236H2.0357C1.95418 8.42236 1.87266 8.38742 1.82025 8.32919C1.79359 8.29917 1.77317 8.26414 1.76018 8.22616C1.74718 8.18817 1.74187 8.14798 1.74455 8.10792C1.79322 7.63301 2.00487 7.1896 2.3435 6.85309C2.68213 6.51658 3.12686 6.30773 3.60207 6.26205C3.91389 6.23294 4.22774 6.23294 4.53956 6.26205C5.51781 6.35522 6.30391 7.12967 6.39708 8.10792C6.40872 8.18944 6.37961 8.27096 6.3272 8.32919ZM10.1878 8.3816H9.02322C8.78448 8.3816 8.5865 8.18362 8.5865 7.94488C8.5865 7.70614 8.78448 7.50816 9.02322 7.50816H10.1878C10.4265 7.50816 10.6245 7.70614 10.6245 7.94488C10.6245 8.18362 10.4265 8.3816 10.1878 8.3816ZM10.1878 6.05242H7.85863C7.61989 6.05242 7.42191 5.85444 7.42191 5.6157C7.42191 5.37696 7.61989 5.17898 7.85863 5.17898H10.1878C10.4265 5.17898 10.6245 5.37696 10.6245 5.6157C10.6245 5.85444 10.4265 6.05242 10.1878 6.05242ZM10.1878 3.72325H7.27634C7.0376 3.72325 6.83962 3.52527 6.83962 3.28653C6.83962 3.04779 7.0376 2.84981 7.27634 2.84981H10.1878C10.4265 2.84981 10.6245 3.04779 10.6245 3.28653C10.6245 3.52527 10.4265 3.72325 10.1878 3.72325Z" fill="#757AEC"/></svg>
                    <h1 class="name-text">Name</h1>              
                </div>
                <div class="player-name">
                    <h1 class="txttest name">33-38PD</h1>
                </div>
            </div>
            <div class="locmain">
                <div class="loc-cont">
                    <img class="img-loc" src="https://cdn.discordapp.com/attachments/1103809702212685877/1122100424716075068/image.png">
                    <h1 class="loc-text">Location</h1>              
                </div>
                <div class="loc-name">
                    <h1 class="txttest loc">${value.street}</h1>
                </div>
            </div>
        </div>
    </div>`
    if (activeContainers.length > 0) {
        $("div.main-container").append(content)
    } else {
        $("div.main-container").empty()
        $("div.main-container").append(content)
    }
    })
    setTimeout(function() {
        $(".d-container").each(function() {
            var container = $(this);
            setTimeout(function() {
                container.fadeOut(750);
            }, 6000);
        });
    }, 2000);
}



