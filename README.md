# CAS-Dispatch


Usage;


##
Some Infos about script;
Press "Z" For waypoint.
This script working with ESX And QBCore Frameworks.
Resmon Values - None (0.00ms)




```lua

GetStreetName = function(coords)
    local hashKey = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName = GetStreetNameFromHashKey(hashKey)
    return streetName
end


CAS = {
    DispatchInfo = {
        header = "POLICE ALERT", -- Dispatch Header
        event = "Fleeca Bank Robbery", -- Dispatch footer
        callsign = "Unknown", -- Event Code
        forwho = "ambulance", -- For who? police or ems or law etc.
        blips = {
            blipText = "Fleeca Bank Robbery", -- Blip Name
            blipSprite = 153, -- Blip icon
            blipColour = 71, -- Blip colour
            blipScale = 0.7, -- Blip scale
            blipTime = 2, -- minute
        }
    }
}

RegisterCommand("sign14" ,function() -- example
    local coords = GetEntityCoords(PlayerPedId()) 
    TriggerServerEvent("cas-sendDispatch",coords, CAS.DispatchInfo, GetStreetName(coords))
end)
```
