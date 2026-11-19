-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:41Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local _ColorMode = require(Foundation.Enums.ColorMode)
local _Device = require(Foundation.Enums.Device)
local Flags = require(Foundation.Utility.Flags)
local _ThemeName = require(Foundation.Enums.ThemeName)
local _Tokens = require(Foundation.Providers.Style.Tokens)
local _createStyleSheetRules = require(script.Parent.createStyleSheetRules)
local getOverrideAttributes = require(script.Parent.getOverrideAttributes)
local scaleValue = require(Foundation.Utility.scaleValue)

local function updateTokenOverrides(arg1, arg2, arg3, arg4, num1: number, arg5, arg6)
    for value, value2 in (getOverrideAttributes(arg2, arg3, arg4, arg5)) do
        if not Flags.FoundationDisableTokenScaling then
            value2 = scaleValue(value2, num1)
        end

        arg1:SetAttribute(value, value2)
        if arg6 then
            arg6[value] = value2
        end
    end
end

return updateTokenOverrides
