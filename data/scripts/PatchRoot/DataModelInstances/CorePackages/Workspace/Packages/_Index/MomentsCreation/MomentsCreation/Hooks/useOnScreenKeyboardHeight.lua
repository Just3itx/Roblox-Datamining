-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local React = require(MomentsCreationParent.React)

local UserInputService = game:GetService("UserInputService")

local function useOnScreenKeyboardHeight()
    local var1, var2 = React.useState(0)

    React.useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(function()
            var2(if UserInputService.OnScreenKeyboardVisible then UserInputService.OnScreenKeyboardSize.Y else 0)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end

return useOnScreenKeyboardHeight
