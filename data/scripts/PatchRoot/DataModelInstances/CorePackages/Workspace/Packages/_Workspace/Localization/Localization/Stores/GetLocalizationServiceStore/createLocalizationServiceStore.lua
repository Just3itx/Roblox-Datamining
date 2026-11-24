-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local LocalizationParent = script:FindFirstAncestor("Localization").Parent

local Signals = require(LocalizationParent.Signals)

return function()
    local tbl1 = {}

    local getRobloxLocaleId, var2 = Signals.createSignal(LocalizationService.RobloxLocaleId)
    local connection = LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
        var2(LocalizationService.RobloxLocaleId)
    end)

    tbl1.robloxLocaleId = connection

    return {
        getRobloxLocaleId = getRobloxLocaleId,
        cleanUp = function()
            for _, value in tbl1 do
                value:Disconnect()
            end
            tbl1 = {}
        end
    }
end
