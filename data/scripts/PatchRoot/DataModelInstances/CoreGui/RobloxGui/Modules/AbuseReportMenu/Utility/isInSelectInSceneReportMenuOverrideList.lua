-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

game:DefineFastString("SelectInSceneReportMenuOverrideUserIds", "")

function isInSelectInSceneReportMenuOverrideList()
    local localPlayer = Players.LocalPlayer
    while not localPlayer do
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = Players.LocalPlayer
    end

    for value in game:GetFastString("SelectInSceneReportMenuOverrideUserIds"):gmatch("%d+") do
        if localPlayer and tonumber(value) == localPlayer.UserId then
            return true
        end
    end

    return false
end

return isInSelectInSceneReportMenuOverrideList
