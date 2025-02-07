Config = {}

Config.BlackoutChance = 0.3
Config.BlackoutMinDuration = 300
Config.BlackoutMaxDuration = 600
Config.DefaultManualDuration = 300
Config.BlackoutCheckInterval = 30

Config.BlackoutNotify = {
    title = "Power Outage",
    description = "All lights have gone out!",
    type = "error"
}

Config.RestoreNotify = {
    title = "Power Restored",
    description = "All lights are back on.",
    type = "success"
}

Config.AccessDeniedNotify = {
    title = "Access Denied",
    description = "Only admins can execute this command.",
    type = "error"
}

Config.CommandErrorNotify = {
    title = "Error",
    description = "Invalid option. Use /blackout [on/off] [duration in seconds].",
    type = "error"
}