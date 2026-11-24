-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local bool1 = false

task.spawn(function()
    local localPlayer = Players.LocalPlayer
    while not localPlayer do
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        localPlayer = Players.LocalPlayer
    end

    local success, result = pcall(LocalizationService.GetCountryRegionForPlayerAsync, LocalizationService, localPlayer)

    if not success then
        return
    end

    if result == "GB" then
        bool1 = true
    end
end)

local function isShowUKOSAIllegalContentReportingLink()
    return bool1
end

return isShowUKOSAIllegalContentReportingLink
