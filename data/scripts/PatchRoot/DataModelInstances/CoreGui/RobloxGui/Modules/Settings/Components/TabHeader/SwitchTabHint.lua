-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local React = require(CorePackages.Packages.React)
local ReactUtils = require(CorePackages.Packages.ReactUtils)
local Foundation = require(CorePackages.Packages.Foundation)

local HelpPage = require(CorePackages.Workspace.Packages.HelpPage)

local useEventConnection = ReactUtils.useEventConnection
local Icon = Foundation.Icon
local useTokens = Foundation.Hooks.useTokens
local HELP_PAGE = HelpPage.Constants.HELP_PAGE

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagGamepadIconSupportCheck = SharedFlags.FFlagGamepadIconSupportCheck
local FFlagLuaSupportMicroGamepadPreferredInput = SharedFlags.FFlagLuaSupportMicroGamepadPreferredInput

local function getSupportsButton(keyCode: Enum.KeyCode)
    if not FFlagGamepadIconSupportCheck then
        return true
    end
    return UserInputService:GamepadSupports(UserInputService:GetLastInputType(), keyCode)
end

local function isPreferredInputTypeGamepad() -- Luacid: Inlined by compiler; 2 call sites recovered
    return UserInputService.PreferredInput == Enum.PreferredInput.Gamepad
        or FFlagLuaSupportMicroGamepadPreferredInput and UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad
end

local function isPlayStationGamepad(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross"
end

return React.memo(React.forwardRef(function(tbl1, ref) -- name: SwitchTabHint
    local var1 = useTokens()
    local var2, var3 = React.useState(getSupportsButton(tbl1.keycode))
    local var4, var5 = React.useState(not not isPlayStationGamepad())
    local var6, var7 = React.useBinding((isPreferredInputTypeGamepad()))
    useEventConnection(UserInputService:GetPropertyChangedSignal("PreferredInput"), function()
        var7((isPreferredInputTypeGamepad()))
        var5(not not isPlayStationGamepad())
    end, {})
    if FFlagGamepadIconSupportCheck then
        useEventConnection(UserInputService.LastInputTypeChanged, function()
            var3(getSupportsButton(tbl1.keycode))
        end, {})
    end

    local name = React.useMemo(function()
        if var4 then
            return HELP_PAGE.GAMEPAD_ICON_MAP_PLAYSTATION[tbl1.keycode]
        end

        return HELP_PAGE.GAMEPAD_ICON_MAP_XBOX[tbl1.keycode]
    end, { tbl1.keycode, var4 })

    if not var2 then
        return nil
    end

    return (React.createElement(Icon, { name = name, size = var1.Size.Size_800, Visible = var6, ref = ref }))
end))
