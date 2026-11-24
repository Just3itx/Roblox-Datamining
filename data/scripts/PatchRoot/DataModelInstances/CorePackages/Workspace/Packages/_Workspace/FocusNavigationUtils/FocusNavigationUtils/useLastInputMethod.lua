-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)

local getInputMethod = require(script.Parent.getInputMethod)

local function useLastInputMethod()
    local inputMethod = getInputMethod(UserInputService:GetLastInputType()) or "None"
    local var1, var2 = React.useState(inputMethod)
    React.useEffect(function()
        local connection = UserInputService.LastInputTypeChanged:Connect(function(lastInputType: Enum.UserInputType)
            local inputMethod2 = getInputMethod(lastInputType)
            if inputMethod2 then
                var2(inputMethod2)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end

return useLastInputMethod
