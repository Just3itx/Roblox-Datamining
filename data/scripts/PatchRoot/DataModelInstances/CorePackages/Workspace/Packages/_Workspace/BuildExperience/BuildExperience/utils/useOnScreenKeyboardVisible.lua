-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local React = require(script:FindFirstAncestor("BuildExperience").Parent.React)

local function useOnScreenKeyboardVisible()
    local var1, var2 = React.useState(UserInputService.OnScreenKeyboardVisible)

    React.useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(function()
            var2(UserInputService.OnScreenKeyboardVisible)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end

return useOnScreenKeyboardVisible
