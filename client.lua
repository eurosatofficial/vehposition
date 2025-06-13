-- Blinker-Offset-Devtool (Mac-kompatibel mit 4 Positionen + gedrückt-halten)
local offsetX, offsetY, offsetZ = 0, 0, 0
local step = 0.05

local directions = {
    ["a"] = "left",      -- X-
    ["d"] = "right",     -- X+
    ["w"] = "up",        -- Y+
    ["s"] = "down",      -- Y-
    ["z"] = "zUp",       -- Z+
    ["k"] = "zDown",     -- Z-
}

local heldKeys = {}
local moveTimer

function adjustOffsetLoop()
    if not getPedOccupiedVehicle(localPlayer) then return end

    if heldKeys["a"] then offsetX = offsetX - step end
    if heldKeys["d"] then offsetX = offsetX + step end
    if heldKeys["w"] then offsetY = offsetY + step end
    if heldKeys["s"] then offsetY = offsetY - step end
    if heldKeys["z"] then offsetZ = offsetZ + step end
    if heldKeys["k"] then offsetZ = offsetZ - step end
end

addEventHandler("onClientKey", root, function(key, press)
    if not directions[key] then return end
    heldKeys[key] = press

    if press and not isTimer(moveTimer) then
        moveTimer = setTimer(adjustOffsetLoop, 50, 0)
    elseif not press and not next(heldKeys) then
        if isTimer(moveTimer) then killTimer(moveTimer) end
    end
end)

function drawMarkerPreview()
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then return end

    local tx, ty, tz = getPositionFromElementOffset(veh, offsetX, offsetY, offsetZ)
    dxDrawLine3D(tx, ty, tz, tx, ty, tz + 0.3, tocolor(255, 255, 0, 255), 2)
    dxDrawText(string.format("X: %.2f | Y: %.2f | Z: %.2f", offsetX, offsetY, offsetZ), 100, 100, 400, 140, tocolor(255, 255, 255, 255), 1, "default-bold")
end
addEventHandler("onClientRender", root, drawMarkerPreview)

function sendOffsetToServer(positionName)
    local veh = getPedOccupiedVehicle(localPlayer)
    if veh then
        local model = getElementModel(veh)
        triggerServerEvent("saveBlinkerOffsetServerMulti", localPlayer, model, positionName, offsetX, offsetY, offsetZ)
        outputChatBox("[BlinkerDev] Gesendet: Modell " .. model .. " → " .. positionName, 0, 255, 0)
    end
end

bindKey("3", "down", function() sendOffsetToServer("vorne links") end)
bindKey("4", "down", function() sendOffsetToServer("vorne rechts") end)
bindKey("5", "down", function() sendOffsetToServer("hinten links") end)
bindKey("6", "down", function() sendOffsetToServer("hinten rechts") end)

function getPositionFromElementOffset(element, offX, offY, offZ)
    if not isElement(element) then return end
    local matrix = getElementMatrix(element)
    local x = offX * matrix[1][1] + offY * matrix[2][1] + offZ * matrix[3][1] + matrix[4][1]
    local y = offX * matrix[1][2] + offY * matrix[2][2] + offZ * matrix[3][2] + matrix[4][2]
    local z = offX * matrix[1][3] + offY * matrix[2][3] + offZ * matrix[3][3] + matrix[4][3]
    return x, y, z
end