-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local UserInputService = game:GetService("UserInputService")

return function()
    local isKeyboardShowing, var2 = React.useState(false)
    local onScreenKeyboardHeight, var4 = React.useState(0)
    local keyboardPositionY, var6 = React.useState(0)

    React.useEffect(function()
        local function updateKeyboardState() -- Luacid: Inlined by compiler; 1 call site recovered
            local onScreenKeyboardVisible = UserInputService.OnScreenKeyboardVisible
            local onScreenKeyboardSizeY = UserInputService.OnScreenKeyboardSize.Y
            local onScreenKeyboardPositionY = UserInputService.OnScreenKeyboardPosition.Y

            var2(onScreenKeyboardVisible)
            var4(if onScreenKeyboardVisible then onScreenKeyboardSizeY else 0)
            var6(if onScreenKeyboardVisible then onScreenKeyboardPositionY else 0)
        end

        updateKeyboardState()
        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(updateKeyboardState)
        local connection2 = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardSize"):Connect(updateKeyboardState)
        local connection3 = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardPosition"):Connect(updateKeyboardState)

        return function()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
            if connection3 then
                connection3:Disconnect()
            end
        end
    end, {})

    return {
        isKeyboardShowing = isKeyboardShowing,
        onScreenKeyboardHeight = onScreenKeyboardHeight,
        keyboardPositionY = keyboardPositionY
    }
end
