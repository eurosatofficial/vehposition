-- addEventHandler("onPlayerJoin", root, function()
--     fadeCamera(source, true)
--     setCameraTarget(source, source)
--     spawnPlayer(source, 0, 0, 5, 0) -- Position irgendwo auf der Karte
-- end)

local offsetFilePath = "blinkeroffsets.txt"
local modelOffsets = {}

addEvent("saveBlinkerOffsetServerMulti", true)
addEventHandler("saveBlinkerOffsetServerMulti", root, function(model, positionName, x, y, z)
    if not modelOffsets[model] then
        modelOffsets[model] = {
            ["vorne links"] = nil,
            ["vorne rechts"] = nil,
            ["hinten links"] = nil,
            ["hinten rechts"] = nil
        }
    end

    modelOffsets[model][positionName] = { x = x, y = y, z = z }

    outputChatBox("[BlinkerDev] Empfangen: Modell " .. model .. ", Position: " .. positionName, source, 0, 200, 0)

    if modelOffsets[model]["vorne links"] and modelOffsets[model]["vorne rechts"]
        and modelOffsets[model]["hinten links"] and modelOffsets[model]["hinten rechts"] then

        -- Alles vorhanden: jetzt speichern
        local file = fileExists(offsetFilePath) and fileOpen(offsetFilePath) or fileCreate(offsetFilePath)
        if file then
            fileSetPos(file, fileGetSize(file))
            fileWrite(file, string.format("Modell: %d\n", model))
            for _, pos in ipairs({ "vorne links", "vorne rechts", "hinten links", "hinten rechts" }) do
                local v = modelOffsets[model][pos]
                fileWrite(file, string.format("%s: %.3f, %.3f, %.3f\n", pos, v.x, v.y, v.z))
            end
            fileWrite(file, "\n")
            fileClose(file)
            outputDebugString("[BlinkerDev] Gespeichert: Modell " .. model)
            modelOffsets[model] = nil -- Reset für nächsten Eintrag
        else
            outputDebugString("[BlinkerDev] Fehler beim Dateizugriff!", 1)
        end
    end
end)