-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Localization = script:FindFirstAncestor("Localization")
local LocalizationParent = Localization.Parent
local LocalizationService = game:GetService("LocalizationService")

local React = require(LocalizationParent.React)
local abbreviateCount = require(Localization.abbreviateCount)
local LocalizationRoactContext = require(Localization.LocalizationRoactContext)
local useSignal = require(LocalizationParent.RoactUtils).Hooks.useSignal

local function useAbbreviatedNumberLocalization(num1: number?)
    local var1 = React.useContext(LocalizationRoactContext)

    local var2, var3 = React.useState(LocalizationService.RobloxLocaleId)

    local var4 = React.useCallback(function(arg1)
        arg1 = var1:GetLocale()
        if arg1 ~= var2 then
            var3(arg1)
        end
    end, { var1 })

    useSignal(var1.changed, var4)

    return React.useMemo(function()
        if num1 == nil then
            return nil
        end

        return abbreviateCount(num1, var2)
    end, { num1, var2 })
end

return useAbbreviatedNumberLocalization
