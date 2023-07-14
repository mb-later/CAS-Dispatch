if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
else
    ESX = export["es_extended"]:getSharedObject()
end
GetFwPlayers = function()
    if Config.Framework == "qb" then
        return QBCore.Functions.GetPlayers()
    else
        return ESX.GetPlayers()
    end
end

GetPlayerById = function(playerId)
    if Config.Framework == "qb" then
        return QBCore.Functions.GetPlayer(playerId)
    else
        return ESX.GetPlayerFromId(playerId)
    end
end


GetNameOfPlayer = function(xPlayer)
    if Config.Framework == "qb" then
        return xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
    else
        return xPlayer.getName()
    end
end

GetJobOfPlayer = function(xPlayer)
    if Config.Framework == "qb" then
        return xPlayer.PlayerData.job.name
    else
        return xPlayer.job.name
    end
end

GetSource = function(xPlayer)
    if Config.Framework == "qb" then
        return xPlayer.PlayerData.source
    else
        return xPlayer.source
    end
end
