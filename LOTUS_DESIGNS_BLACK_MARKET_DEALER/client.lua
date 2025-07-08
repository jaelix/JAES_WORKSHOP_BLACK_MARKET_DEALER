local dealerActive = false
local dealerCoords = nil
local dealerPed = nil

local possibleLocations = {
    vector3(-1151.6, -1566.0, 4.3),
    vector3(1324.0, -1650.0, 52.2),
    vector3(-72.6, -812.3, 326.2),
    vector3(1692.0, 3758.0, 34.7),
    vector3(-3187.0, 1290.0, 12.5)
}

function SpawnDealer()
    local index = math.random(#possibleLocations)
    dealerCoords = possibleLocations[index]

    RequestModel("g_m_m_chigoon_01")
    while not HasModelLoaded("g_m_m_chigoon_01") do Wait(0) end

    dealerPed = CreatePed(4, "g_m_m_chigoon_01", dealerCoords.x, dealerCoords.y, dealerCoords.z - 1.0, 0.0, false, true)
    SetEntityInvincible(dealerPed, true)
    FreezeEntityPosition(dealerPed, true)
    TaskStartScenarioInPlace(dealerPed, "WORLD_HUMAN_SMOKING", 0, true)

    dealerActive = true
end

function RemoveDealer()
    if dealerPed then
        DeleteEntity(dealerPed)
    end
    dealerActive = false
end

Citizen.CreateThread(function()
    while true do
        Wait(600000) -- every 10 minutes
        if not dealerActive then
            SpawnDealer()
            TriggerEvent("chat:addMessage", {
                args = { "^5[Black Market]", "Rumors say someone shady is around town..." }
            })

            -- Dealer disappears after 5 minutes
            Wait(300000)
            RemoveDealer()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if dealerActive and dealerCoords then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - dealerCoords)
            if distance < 2.0 then
                DrawText3D(dealerCoords.x, dealerCoords.y, dealerCoords.z + 1.0, "[E] Talk to Dealer")

                if IsControlJustReleased(0, 38) then -- E key
                    TriggerServerEvent("blackmarket:openMenu")
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
