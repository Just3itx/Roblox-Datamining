-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

game:DefineFastString("DSAReportingAndTransparencyOverrideUserIds", "")

function isInDSAFeaturesOverrideList(num1: number?)
    local num2 = 0
    if num1 == nil then
        local localPlayer = Players.LocalPlayer
        while not localPlayer do
            Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            localPlayer = Players.LocalPlayer
        end
        if localPlayer then
            num2 = localPlayer.UserId
        end
    else
        num2 = num1
    end

    for value in game:GetFastString("DSAReportingAndTransparencyOverrideUserIds"):gmatch("%d+") do
        if tonumber(value) == num2 then
            return true
        end
    end

    return false
end

return isInDSAFeaturesOverrideList
