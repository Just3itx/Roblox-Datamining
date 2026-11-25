-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationService = game:GetService("NotificationService")

local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local React = require(RoactUtilsParent.React)

local function useSelectedTheme()
    local var1, var2 = React.useState(string.lower(NotificationService.SelectedTheme))

    React.useEffect(function()
        local connection = NotificationService:GetPropertyChangedSignal("SelectedTheme"):Connect(function()
            var2(string.lower(NotificationService.SelectedTheme))
        end)

        return function()
            connection:Disconnect()
        end
    end)

    return var1
end

return useSelectedTheme
