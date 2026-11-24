-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:11:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local Foundation = require(scriptParentParentParent.Foundation)
local InputTypesEnum = require(scriptParentParent.Enums.InputTypesEnum)
local Responsive = require(scriptParentParentParent.Responsive)
local KeyboardHelpPage = require(scriptParentParent.Components.Keyboard.KeyboardHelpPage)
local GamepadHelpPage = require(scriptParentParent.Components.Gamepad.GamepadHelpPage)
local TouchHelpPage = require(scriptParentParent.Components.Touch.TouchHelpPage)
local CCLTouchHelpPageContainer = require(scriptParentParent.Components.Touch.CCLTouchHelpPage.CCLTouchHelpPageContainer)
local FFlagHelpPageCCL = require(scriptParentParent.Flags.FFlagHelpPageCCL)
local HelpPageTelemetry = require(scriptParentParent.Telemetry.HelpPageTelemetry)
local RobloxAppHooks = require(scriptParentParentParent.RobloxAppHooks)
local _RobloxAppEnums = require(scriptParentParentParent.RobloxAppEnums)

local View = Foundation.View
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation

local function func1(arg1, bool1: boolean, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if bool1 then
        return InputTypesEnum.InputType.SPATIAL_GAMEPAD
    end

    if arg1 ~= nil then
        arg2 = arg1
    end

    if arg2 == Responsive.Input.Pointer then
        return InputTypesEnum.InputType.KEYBOARD
    end

    if arg2 == Responsive.Input.Directional then
        return InputTypesEnum.InputType.GAMEPAD
    end

    if arg2 == Responsive.Input.Touch then
        return InputTypesEnum.InputType.TOUCH
    end

    return InputTypesEnum.InputType.KEYBOARD
end

return React.memo(function() -- name: HelpPageContainer
    local var1 = Responsive.useLastInput()
    local var2 = Responsive.useIsSpatial()
    local var3 = Responsive.usePreferredInput()
    local lastInputType = if var2 then func1(nil, true, nil) else func1(var1, false, var3)
    local orientation = useDeviceOrientation()

    React.useEffect(function()
        HelpPageTelemetry.default:logHelpPageInteraction(
            "Help_Interaction",
            { orientation = orientation, last_input_type = lastInputType }
        )
    end, { orientation, lastInputType })

    if lastInputType == InputTypesEnum.InputType.KEYBOARD then
        return React.createElement(KeyboardHelpPage)
    end

    if lastInputType == InputTypesEnum.InputType.GAMEPAD or lastInputType == InputTypesEnum.InputType.SPATIAL_GAMEPAD then
        return React.createElement(GamepadHelpPage, { isSpatial = lastInputType == InputTypesEnum.InputType.SPATIAL_GAMEPAD })
    end

    if lastInputType ~= InputTypesEnum.InputType.TOUCH then
        return React.createElement(View, nil, {})
    end

    return React.createElement(if FFlagHelpPageCCL then CCLTouchHelpPageContainer else TouchHelpPage)
end)
