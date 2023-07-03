

GetPlayerNameByCoords = function(coords)
    local players = GetFwPlayers()
    local playerName = "Unknown"
    local closestPlayer = nil
    local closestDistance = -1
    for _, player in ipairs(players) do
        local playerCoords = GetEntityCoords(GetPlayerPed(player))
        local distance = #(playerCoords - coords)

        if closestPlayer == nil or distance < closestDistance then
            closestPlayer = player
            closestDistance = distance
        end
    end
    if closestPlayer ~= nil then
        local player = GetPlayerById(closestPlayer)

        if player ~= nil and player.PlayerData ~= nil and player.PlayerData.charinfo ~= nil then
            playerName = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
        end
    end
    return {
        name = playerName,
        nEms = GetClosestJobPerson(coords, Config.AmbulancePerm) or Config.UnknownName,
        nPolice = GetClosestJobPerson(coords, Config.PolicePerm) or Config.UnknownName
    }
end




GetClosestJobPerson = function(coords, job)
    local closestDistance = math.huge
    local closestPlayer = nil

    local players = GetFwPlayers()
    for _, player in ipairs(players) do
        local xPlayer = GetPlayerById(player)
        if GetJobOfPlayer(xPlayer) == job then 
            local ped = GetPlayerPed(player)
            local playerCoords = GetEntityCoords(ped)
            local distance = #(coords - playerCoords)

            if distance < closestDistance then
                closestDistance = distance 
                closestPlayer = GetNameOfPlayer(xPlayer)
            end
        end
    end
    return closestPlayer
end



RegisterServerEvent("cas-sendDispatch")
AddEventHandler("cas-sendDispatch",function(coords, prmtwo,street)
    local dispatchInfos = {}
    local playerInfos = GetPlayerNameByCoords(coords)
    table.insert(dispatchInfos, {
        nPolice = playerInfos.nPolice,
        nEms = playerInfos.nEms,
        header = prmtwo.header,
        street = street,
        callsign = prmtwo.callsign,
        event = prmtwo.event,
        victimName = playerInfos.name,
        blips = prmtwo.blips
    })
    local players = GetFwPlayers()
    for _, player in ipairs(players) do
        local xPlayer = GetPlayerById(player)
        print(type(prmtwo.forwho))
        if type(prmtwo.forwho) == "table" then
            for key,value in pairs(prmtwo.forwho) do
                if GetJobOfPlayer(xPlayer) == value then
                    local source = GetSource(xPlayer)
                    TriggerClientEvent("cas-sendDispatchToClient",source, dispatchInfos,coords)
                end
            end
        else
            if GetJobOfPlayer(xPlayer) == prmtwo.forwho then
                local source = GetSource(xPlayer)
                TriggerClientEvent("cas-sendDispatchToClient",source, dispatchInfos,coords)
            else
                print("none")
            end
        end
    end
end)

RegisterServerEvent("baseevents:onPlayerKilled")
AddEventHandler("baseevents:onPlayerKilled",function()
    local src = source
    local player = GetPlayerById(src)
    if player then
        if GetJobOfPlayer(player) == Config.AmbulancePerm or GetJobOfPlayer(player) == Config.PolicePerm then
            TriggerClientEvent("civDown", src, GetJobOfPlayer(player), GetNameOfPlayer(player))
        end 
    end
end)
