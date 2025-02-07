ESX = exports['es_extended']:getSharedObject()

local blackoutActive = false
local blackoutEndTime = 0

RegisterNetEvent('custom_blackout:startBlackout', function(duration)
    blackoutActive = true
    blackoutEndTime = GetGameTimer() + (duration * 1000)

    SetArtificialLightsState(true)
    SetArtificialLightsStateAffectsVehicles(false)
    
    ESX.ShowNotification(Config.BlackoutNotify.description)
end)

RegisterNetEvent('custom_blackout:endBlackout', function()
    blackoutActive = false

    SetArtificialLightsState(false)
    SetArtificialLightsStateAffectsVehicles(true)
    
    ESX.ShowNotification(Config.RestoreNotify.description)
end)

RegisterNetEvent('custom_blackout:syncBlackout', function(isBlackout, remainingTime)
    blackoutActive = isBlackout
    blackoutEndTime = GetGameTimer() + (remainingTime * 1000)

    SetArtificialLightsState(isBlackout)
    SetArtificialLightsStateAffectsVehicles(not isBlackout)
end)

CreateThread(function()
    while true do
        Wait(1000)
        if blackoutActive and GetGameTimer() >= blackoutEndTime then
            TriggerServerEvent('custom_blackout:endBlackoutServer')
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        SetArtificialLightsState(false)
    end
end)