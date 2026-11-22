-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local Cryo = require(SocialTabsPageParent.Cryo)
local React = require(SocialTabsPageParent.React)
local useLocalization = require(SocialTabsPageParent.Localization).Hooks.useLocalization

local _Types = require(SocialTabsPage.Common.Types)

local function useLocalizedTabs(arg1)
    local var1 = React.useMemo(function()
        local result = {}
        for _, value in arg1 do
            result[value.id] = value.tabLabelKey
        end
        return result
    end, { arg1 })

    local var2 = useLocalization(var1)

    return React.useMemo(function()
        return Cryo.List.map(arg1, function(arg2)
            return {
                id = arg2.id,
                text = var2[arg2.id]
            }
        end)
    end, { arg1, var2 })
end

return useLocalizedTabs
