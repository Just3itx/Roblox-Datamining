-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local UserInputService = require(Foundation.Utility.Wrappers.Services).UserInputService

local function usePreferredInput()
    local var1, var2 = React.useState(UserInputService.PreferredInput)

    React.useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
            var2(UserInputService.PreferredInput)
        end)

        var2(UserInputService.PreferredInput)

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, {})

    return var1
end

return usePreferredInput
