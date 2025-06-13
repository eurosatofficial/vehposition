local currentModel = 0 --Hier könnt Ihr eintragen mit welchem Modell ihr beim spawnen starten wollt

bindKey("1", "down", function()
    if currentModel > 611 then
        outputChatBox(" Alle Fahrzeuge durchprobiert!")
        return
    end

    local x, y, z = getElementPosition(localPlayer)
    triggerServerEvent("spawnVehicleByID", localPlayer, currentModel, x + 3, y, z)
    outputChatBox(" Fahrzeug " .. currentModel .. " gespawnt.")
    currentModel = currentModel + 1
end)