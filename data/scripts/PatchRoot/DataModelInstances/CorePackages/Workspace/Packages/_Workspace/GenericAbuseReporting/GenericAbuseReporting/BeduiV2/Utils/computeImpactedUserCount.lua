-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function computeImpactedUserCount(arg1, str1: string)
    if not (arg1 and arg1.participants) then
        return 0
    end
    local playerByUserId = Players:GetPlayerByUserId(tonumber(str1))
    if not (playerByUserId and playerByUserId.Character and playerByUserId.Character.PrimaryPart) then
        return 0
    end
    local primaryPartPosition = playerByUserId.Character.PrimaryPart.Position
    local num1 = 0
    for k in pairs(arg1.participants) do
        local var1 = tonumber(k)
        if not var1 or var1 == playerByUserId.UserId then
            continue
        end

        local player = Players:GetPlayerByUserId(var1)
        if player
            and player.Character
            and player.Character.PrimaryPart
            and (player.Character.PrimaryPart.Position - primaryPartPosition).Magnitude <= 160
        then
            num1 += 1
        end
    end

    return num1
end

return computeImpactedUserCount
