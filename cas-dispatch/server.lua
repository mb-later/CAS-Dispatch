

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
        if GetJobOfPlayer(xPlayer) == prmtwo.forwho then
            local source = GetSource(xPlayer)
            TriggerClientEvent("cas-sendDispatchToClient",source, dispatchInfos,coords)
        else
            print("none")
        end
    end
end)