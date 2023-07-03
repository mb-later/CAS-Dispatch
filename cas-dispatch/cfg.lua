Config = {}
Config.Framework = "qb"

Config.AmbulancePerm = "ambulance"
Config.PolicePerm = "police"
Config.UnknownName = "Unknown"

Config.SetWaypoint = "Z"

Config.DriveByHeader = "Drive By Shooting"
Config.ShotAlert = {
    header = "Gun Shot",
    event = "Weapon Model",
    callsign = "33-50",
    forwho = "police",
    blips = {
        blipText = "Gun Shot",
        blipSprite = 153,
        blipColour = 71,
        blipScale = 0.7,
        blipTime = 2,
    }
}

Config.CarJackingAlert = {
    header = "Car Jacking",
    event = "",
    callsign = "21-49",
    forwho = "police",
    blips = {
        blipText = "Car Jacking",
        blipSprite = 153,
        blipColour = 71,
        blipScale = 0.7,
        blipTime = 2,
    }
}


Config.CivDown = {
    header = "Person Down",
    event = "",
    callsign = "55-88",
    forwho = {"police", "ems"},
    blips = {
        blipText = "Shutdown",
        blipSprite = 153,
        blipColour = 71,
        blipScale = 0.7,
        blipTime = 2,
    }
}
