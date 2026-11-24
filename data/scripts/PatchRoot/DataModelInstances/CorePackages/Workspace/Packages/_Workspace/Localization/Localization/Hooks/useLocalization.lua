-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Localization = script:FindFirstAncestor("Localization")
local LocalizationParent = Localization.Parent
local LocalizationService = game:GetService("LocalizationService")

local React = require(LocalizationParent.React)
local ArgCheck = require(LocalizationParent.ArgCheck)
local RobloxLocaleIdKey = require(Localization.RobloxLocaleIdKey)
local LocalizationRoactContext = require(Localization.LocalizationRoactContext)
local localizeStrings = require(Localization.localizeStrings)
local useSignal = require(LocalizationParent.RoactUtils).Hooks.useSignal

local function useLocalization(tbl1)
    local var1 = React.useContext(LocalizationRoactContext)

    local var2, var3 = React.useState(LocalizationService.RobloxLocaleId)

    local var4 = React.useCallback(function(arg1)
        arg1 = var1:GetLocale()
        if arg1 ~= var2 then
            var3(arg1)
        end
    end, { var1 })

    useSignal(var1.changed, var4)

    ArgCheck.isType(tbl1, "table", "LocalizationConsumer.props.stringsToBeLocalized")

    local var5 = localizeStrings(var1, tbl1)
    var5[RobloxLocaleIdKey] = var2

    return var5
end

return useLocalization
