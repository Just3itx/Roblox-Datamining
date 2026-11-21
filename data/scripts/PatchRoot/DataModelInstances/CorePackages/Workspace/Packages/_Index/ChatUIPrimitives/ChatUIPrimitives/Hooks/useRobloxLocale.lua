-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local useEventConnection = require(ChatUIPrimitivesParent.ReactUtils).useEventConnection

local function useRobloxLocale()
    local var1, var2 = React.useState(LocalizationService.RobloxLocaleId)

    useEventConnection(LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"), function()
        var2(LocalizationService.RobloxLocaleId)
    end, {})

    return var1
end

return useRobloxLocale
