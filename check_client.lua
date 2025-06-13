addEventHandler("onClientVehicleEnter", root, function(player, seat)
    if player ~= localPlayer then return end
    local veh = getPedOccupiedVehicle(localPlayer)
    if seat ~= 0 or not veh then return end

    local model = getElementModel(veh)

    -- Sicherheitsprüfung: echte Fahrzeuge haben IDs zwischen 400 und 611
    if model < 400 or model > 611 then
        outputDebugString("[Client] Ungültige Modell-ID (" .. tostring(model) .. "), Abbruch")
        return
    end

    outputDebugString("[Client] Gültiges Fahrzeugmodell: " .. tostring(model))
    triggerServerEvent("checkBlinkerOffsetStatus", localPlayer, model)
end)

addEvent("receiveBlinkerOffsetStatus", true)
addEventHandler("receiveBlinkerOffsetStatus", root, function(model, found)
    if found then
        outputChatBox("OK - OK - Blinker für Modell " .. model .. " sind bereits gespeichert.", 0, 255, 0)
    else
        outputChatBox("XXX Blinker für Modell " .. model .. " fehlen noch!", 255, 0, 0)
    end
end)