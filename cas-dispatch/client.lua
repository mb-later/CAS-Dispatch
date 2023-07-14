local weaponNames = {
    [584646201]   = "AP-Pistol",
    [453432689]   = "Baretta",
    [3219281620]  = "Pistol MK2",
    [1593441988]  = "Combat Pistol",
    [-1716589765] = "Heavy Pistol",
    [-1076751822] = "SNS-Pistol",
    [-771403250]  = "Desert Eagle",
    [137902532]   = "Vintage Pistol",
    [-598887786]  = "Marksman Pistol",
    [-1045183535] = "Revolver",
    [911657153]   = "Taser",
    [324215364]   = "Micro-SMG",
    [-619010992]  = "Machine-Pistol",
    [736523883]   = "SMG",
    [2024373456]  = "SMG MK2",
    [-270015777]  = "Assault SMG",
    [171789620]   = "Combat PDW",
    [-1660422300] = "Combat MG",
    [3686625920]  = "Combat MG MK2",
    [1627465347]  = "Gusenberg",
    [-1121678507] = "Mini SMG",
    [-1074790547] = "Assaultrifle",
    [961495388]   = "Assaultrifle MK2",
    [-2084633992] = "Carbinerifle",
    [4208062921]  = "Carbinerifle MK2",
    [-1357824103] = "Advancedrifle",
    [-1063057011] = "Specialcarbine",
    [2132975508]  = "Bulluprifle",
    [1649403952]  = "Compactrifle",
    [100416529]   = "Sniperrifle",
    [205991906]   = "Heavy Sniper",
    [177293209]   = "Heavy Sniper MK2",
    [-952879014]  = "Marksmanrifle",
    [487013001]   = "Pumpshotgun",
    [2017895192]  = "Sawnoff Shotgun",
    [-1654528753] = "Bullupshotgun",
    [-494615257]  = "Assaultshotgun",
    [-1466123874] = "Musket",
    [984333226]   = "Heavyshotgun",
    [-275439685]  = "Doublebarrel Shotgun",
    [317205821]   = "Autoshotgun",
    [-1568386805] = "GRENADE LAUNCHER",
    [-1312131151] = "RPG",
    [125959754]   = "Compactlauncher",
    [-1768145561] = "Scar-L"
}


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


local isShooting = false 
local dispatchCooldown = 15000 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) then
            if not isShooting then
                isShooting = true
                local coords = GetEntityCoords(PlayerPedId()) 
                Config.ShotAlert.event = ""
                local weaponHash = GetSelectedPedWeapon(PlayerPedId())
                print(weaponHash, GetHashKey(weaponHash))
                local weaponName = weaponNames[weaponHash]
              if IsPedDoingDriveby(PlayerPedId()) then
                Config.ShotAlert.event = Config.DriveByHeader
              else
                Config.ShotAlert.event = Config.ShotAlert.event.." "..weaponName
              end
              TriggerServerEvent("cas-sendDispatch",coords, Config.ShotAlert, GetStreetName(coords))
              Citizen.Wait(dispatchCooldown) 
              isShooting = false
            end
        else
            isShooting = false
        end
    end
end)


local isHotwiring = false 
Citizen.CreateThread(function()
  while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        if IsPedTryingToEnterALockedVehicle(playerPed) then
            local vehicle = GetVehiclePedIsTryingToEnter(playerPed)
            if DoesEntityExist(vehicle) and not isHotwiring then
                Config.CarJackingAlert.event = ""
              local vehicleModel = GetEntityModel(vehicle)
              local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
              isHotwiring = true
              Config.CarJackingAlert.event = Config.CarJackingAlert.event.. " Car Model: " ..vehicleName
              TriggerServerEvent("cas-sendDispatch",coords, Config.CarJackingAlert, GetStreetName(coords))
              Citizen.Wait(5000)
              isHotwiring = false
            end
        else
            isHotwiring = false
        end
    end
end)


RegisterNetEvent("civDown")
AddEventHandler("civDown",function(job,name)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    Config.CivDown.event = name.. " is down!"
    TriggerServerEvent("cas-sendDispatch",coords, Config.CivDown, GetStreetName(coords))
end)
