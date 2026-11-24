-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParent.React)

local useEffect = React.useEffect
local useState = React.useState

return function()
    local var1, var2 = useState(UserInputService.KeyboardEnabled)

    useEffect(function()
        local connection = UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(function()
            var2(UserInputService.KeyboardEnabled)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end
