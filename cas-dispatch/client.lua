local lastDispatch = nil
RegisterNetEvent("cas-sendDispatchToClient")
AddEventHandler("cas-sendDispatchToClient",function(info,coords)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    SendNUIMessage({
        action = "show",
        info = info
    })
    lastDispatch = coords
    for i,j in pairs(info) do
        CreateDispatchBlip(coords, j.blips)
        break
    end
end)

CreateThread(function()
    RegisterKeyMapping("waypointDispatch", "Dispatch Waypoint", "keyboard", Config.SetWaypoint)
end)

RegisterCommand("waypointDispatch",function()
    if lastDispatch then
        SetNewWaypoint(lastDispatch.x, lastDispatch.y)
    end
end)


CreateDispatchBlip = function(coords,settings)
    local alpha = 150
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, settings.blipSprite)
    SetBlipColour(blip, settings.blipColour)
    SetBlipScale(blip, settings.blipScale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(settings.blipText)
    EndTextCommandSetBlipName(blip)
    while alpha ~= 0 do
        Citizen.Wait(120 * 4)
        alpha = alpha - 1
        SetBlipAlpha(blip, alpha)
        if alpha == 0 then
            RemoveBlip(blip)
            return
        end
    end
end




GetStreetName = function(coords)
    local hashKey = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(hashKey)
    return streetName
end


CAS = {
    DispatchInfo = {
        header = "POLICE ALERT",
        event = "Fleeca Bank Robbery",
        callsign = "Unknown",
        forwho = "police",
        blips = {
            blipText = "Fleeca Bank Robbery",
            blipSprite = 153,
            blipColour = 71,
            blipScale = 0.7,
            blipTime = 2, -- minute
        }
    }
}

RegisterCommand("dispatch" ,function()
    local coords = GetEntityCoords(PlayerPedId()) 
    TriggerServerEvent("cas-sendDispatch",coords, CAS.DispatchInfo, GetStreetName(coords))
end)
