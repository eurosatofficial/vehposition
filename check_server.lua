local offsetFilePath = "blinkeroffsets.txt"

function isModelFullySaved(model)
    if not fileExists(offsetFilePath) then return false end
    local file = fileOpen(offsetFilePath)
    local content = fileRead(file, fileGetSize(file))
    fileClose(file)

    local pattern = string.format("Modell: %d", model)
    return content:find(pattern) ~= nil
end

addEvent("checkBlinkerOffsetStatus", true)
addEventHandler("checkBlinkerOffsetStatus", root, function(model)
    local player = client
    outputDebugString("[Server] Empfangen von " .. getPlayerName(player) .. ", Modell: " .. tostring(model))

    local found = isModelFullySaved(model)
    triggerClientEvent(player, "receiveBlinkerOffsetStatus", player, model, found)
end)