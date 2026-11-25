-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SettingReactViewParent = script:FindFirstAncestor("SettingReactView").Parent

local _SettingsService = require(SettingReactViewParent.SettingsService)
local React = require(SettingReactViewParent.React)
local Foundation = require(SettingReactViewParent.Foundation)
local Button = Foundation.Button
local Enums = Foundation.Enums
local ButtonVariant = Enums.ButtonVariant
local ButtonSize = Enums.ButtonSize

return function(arg1)
    local text

    if arg1.text and type(arg1.text) == "table" then
        local var1
        text, var1 = React.useState(arg1.text:get())
        arg1.text:connect(var1)
    else
        text = arg1.text
    end

    local isDisabled = not arg1.onActivated
    local onActivated = React.useCallback(function()
        if arg1.onActivated then
            arg1.onActivated:signal():fire()
        end
    end, { arg1.onActivated })

    return React.createElement(Button, {
        onActivated = onActivated,
        text = text,
        isDisabled = isDisabled,
        variant = ButtonVariant.Standard,
        size = ButtonSize.Medium
    })
end
