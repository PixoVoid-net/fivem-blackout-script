ESX = exports['es_extended']:getSharedObject()

local blackoutActive = false
local blackoutEndTime = 0

local function triggerBlackout(state, duration)
    blackoutActive = state
    blackoutEndTime = state and (os.time() + duration) or 0

    TriggerClientEvent(state and 'custom_blackout:startBlackout' or 'custom_blackout:endBlackout', -1, duration)
end

CreateThread(function()
    while true do
        Wait(Config.BlackoutCheckInterval * 60000)
        if math.random() < Config.BlackoutChance and not blackoutActive then
            local duration = math.random(Config.BlackoutMinDuration, Config.BlackoutMaxDuration)
            print("[Blackout] Automatic blackout triggered for " .. duration .. " seconds.")
            triggerBlackout(true, duration)
        end
    end
end)

AddEventHandler('playerJoining', function()
    local src = source
    if blackoutActive then
        local remainingTime = math.max(0, blackoutEndTime - os.time())
        TriggerClientEvent('custom_blackout:syncBlackout', src, true, remainingTime)
    end
end)

RegisterCommand('blackout', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer or xPlayer.getGroup() ~= 'admin' then
        TriggerClientEvent('esx:showNotification', source, Config.AccessDeniedNotify.description)
        return
    end

    if args[1] == "on" then
        if not blackoutActive then
            local duration = tonumber(args[2]) or Config.DefaultManualDuration
            triggerBlackout(true, duration)
        else
            TriggerClientEvent('esx:showNotification', source, Config.CommandErrorNotify.description)
        end
    elseif args[1] == "off" then
        if blackoutActive then
            triggerBlackout(false)
        else
            TriggerClientEvent('esx:showNotification', source, Config.CommandErrorNotify.description)
        end
    else
        TriggerClientEvent('esx:showNotification', source, Config.CommandErrorNotify.description)
    end
end, false)

RegisterNetEvent('custom_blackout:endBlackoutServer', function()
    local src = source
    if not src or src == 0 then return end
    if blackoutActive then
        triggerBlackout(false)
    end
end)
