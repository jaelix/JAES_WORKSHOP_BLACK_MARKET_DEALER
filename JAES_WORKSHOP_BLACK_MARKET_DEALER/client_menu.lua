RegisterNetEvent("blackmarket:showMenu")
AddEventHandler("blackmarket:showMenu", function()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'blackmarket_menu', {
        title    = "Black Market",
        align    = 'top-left',
        elements = {
            {label = "Combat Pistol - $5000", value = 'weapon_pistol'},
            {label = "SMG - $15000", value = 'weapon_smg'},
            {label = "Molotov - $3000", value = 'weapon_molotov'},
        }
    }, function(data, menu)
        TriggerServerEvent("blackmarket:buyItem", data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end)
