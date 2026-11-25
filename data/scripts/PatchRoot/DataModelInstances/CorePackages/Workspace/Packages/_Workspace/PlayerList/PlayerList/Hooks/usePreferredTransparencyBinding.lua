-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

local function usePreferredTransparencyBinding()
    local var1, var2 = React.useBinding(UserGameSettings.PreferredTransparency)

    React.useEffect(function()
        var2(UserGameSettings.PreferredTransparency)
        local connection = UserGameSettings:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
            var2(UserGameSettings.PreferredTransparency)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end

return usePreferredTransparencyBinding
