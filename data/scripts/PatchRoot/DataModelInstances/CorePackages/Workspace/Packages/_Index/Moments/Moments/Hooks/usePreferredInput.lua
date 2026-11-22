-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local UserInputService = game:GetService("UserInputService")

local React = require(MomentsParent.React)

return function()
    local var1, var2 = React.useState(UserInputService.PreferredInput)

    React.useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
            var2(UserInputService.PreferredInput)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end
