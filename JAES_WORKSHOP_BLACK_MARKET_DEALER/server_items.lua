ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent("blackmarket:buyItem")
AddEventHandler("blackmarket:buyItem", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local prices = {
        weapon_pistol = 5000,
        weapon_smg = 15000,
        weapon_molotov = 3000
    }

    if prices[item] and xPlayer.getMoney() >= prices[item] then
        xPlayer.removeMoney(prices[item])
        xPlayer.addWeapon(item, 250)
        TriggerClientEvent("esx:showNotification", source, "Purchase successful.")
    else
        TriggerClientEvent("esx:showNotification", source, "You can't afford that.")
    end
end)
