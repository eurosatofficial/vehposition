addEvent("spawnVehicleByID", true)
addEventHandler("spawnVehicleByID", root, function(model, x, y, z)
    if not model or model < 400 or model > 611 then return end
    local vehicle = createVehicle(model, x, y, z)
    if vehicle then
        warpPedIntoVehicle(source, vehicle)
        outputDebugString("Fahrzeug " .. model .. " gespawnt für " .. getPlayerName(source))
    end
end)