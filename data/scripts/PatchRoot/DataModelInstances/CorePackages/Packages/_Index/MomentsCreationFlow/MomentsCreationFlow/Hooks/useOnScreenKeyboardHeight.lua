-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local React = require(MomentsCreationFlowParent.React)
local UserInputService = game:GetService("UserInputService")

local useEffect = React.useEffect
local useState = React.useState

return function()
    local var1, var2 = useState(0)

    useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(function()
            var2(UserInputService.OnScreenKeyboardVisible and UserInputService.OnScreenKeyboardSize.Y or 0)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end
