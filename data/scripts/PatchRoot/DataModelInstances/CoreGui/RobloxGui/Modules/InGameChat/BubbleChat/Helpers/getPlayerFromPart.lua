-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function getPlayerFromPart(arg1)
    if not arg1 then
        return nil
    end

    for _, player in pairs(Players:GetPlayers()) do
        local character = player.Character
        if character and arg1:IsDescendantOf(character) then
            return player
        end
    end

    return nil
end

return getPlayerFromPart
