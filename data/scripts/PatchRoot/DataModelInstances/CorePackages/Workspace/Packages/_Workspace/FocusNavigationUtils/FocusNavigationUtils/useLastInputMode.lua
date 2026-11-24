-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local UserInputService = game:GetService("UserInputService")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent
local React = require(FocusNavigationUtilsParent.React)
local useLastInputMethod = require(script.Parent.useLastInputMethod)
local useFocusedTextBox = require(script.Parent.useFocusedTextBox)
local VRService = require(FocusNavigationUtilsParent.MockableProxyServices).VRService
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local SharedFlags = require(FocusNavigationUtilsParent.SharedFlags)
local FFlagFixSelectionWithWebViews = SharedFlags.FFlagFixSelectionWithWebViews
local FFlagEnableFocusNavTelemetry = SharedFlags.FFlagEnableFocusNavTelemetry

local tbl1 = {
    Keyboard = "Focus",
    Gamepad = "Focus",
    Mouse = "Cursor",
    Touch = "Cursor",
    None = "None"
}

local tbl2 = {
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true,
    [Enum.KeyCode.Left] = true,
    [Enum.KeyCode.Right] = true,
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Escape] = true
}

return function()
    local var1 = useLastInputMethod()

    local var2 = tbl1[var1]
    local var3 = useFocusedTextBox()
    local var4, var5 = React.useState(GamepadService.GamepadCursorEnabled)

    local var6, var7 = React.useState(false)
    local var8 = React.useRef(if var1 == "Keyboard" then "Cursor" else var2)
    local var9 = if FFlagEnableFocusNavTelemetry then React.useRef(nil) else nil

    React.useEffect(function()
        local connection = UserInputService.InputBegan:Connect(function(input: InputObject)
            local bool1 = not FFlagFixSelectionWithWebViews or GuiService.CoreGuiNavigationEnabled

            if not tbl2[input.KeyCode] or var3 ~= nil or not bool1 then
                var7(false)

                return
            end

            if FFlagEnableFocusNavTelemetry and var9 then
                var9.current = input.KeyCode
            end
            var7(true)
        end)
        return function()
            connection:Disconnect()
        end
    end, { var3 })
    React.useEffect(function()
        local connection = GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(function()
            var5(GamepadService.GamepadCursorEnabled)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    local current = if VRService.VREnabled then "Cursor" elseif var1 == "Keyboard" then if var6 or var8.current == "Focus" then "Focus" else "Cursor" else var1 == "Gamepad" and (if var4 then "Cursor" else "Focus") or var2
    var8.current = current
    if FFlagEnableFocusNavTelemetry and var9 and current == "Focus" and var1 == "Keyboard" then
        return current, var9.current
    end
    return current
end
