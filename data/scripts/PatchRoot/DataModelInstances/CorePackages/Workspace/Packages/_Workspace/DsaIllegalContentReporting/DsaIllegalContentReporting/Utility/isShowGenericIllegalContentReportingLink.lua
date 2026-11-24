-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local bool1 = game:DefineFastFlag("EnableGenericIllegalContentReporting3", false)
local str1 = game:DefineFastString(
    "CountriesWithGenericIllegalContentReporting2",
    "AT,BE,BG,CY,CZ,DE,DK,EE,ES,FI,FR,GR,HR,HU,IE,IT,LT,LU,LV,MT,NL,PL,PT,RO,SE,SI,SK,GB,AU"
)

local bool2 = false

if bool1 then
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

        local tbl1 = str1:split(",")
        for _, value in ipairs(tbl1) do
            if result == value then
                bool2 = true
                return
            end
        end
    end)
end

local function isShowGenericIllegalContentReportingLink(): boolean
    return bool1 and bool2
end

return isShowGenericIllegalContentReportingLink
