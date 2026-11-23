-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local function useRobloxLocale()
    local var1, var2 = React.useState(LocalizationService.RobloxLocaleId)

    React.useEffect(function()
        local connection = LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
            var2(LocalizationService.RobloxLocaleId)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end

return useRobloxLocale
