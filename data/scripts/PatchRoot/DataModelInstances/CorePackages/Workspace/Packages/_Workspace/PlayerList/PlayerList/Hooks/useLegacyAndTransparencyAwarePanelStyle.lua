-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local useTokens = require(scriptParentParentParent.Foundation).Hooks.useTokens

local usePreferredBackgroundStyle = require(scriptParentParent.Hooks.usePreferredBackgroundStyle)

local function useLegacyAndTransparencyAwarePanelStyle(bool1: boolean?)
    local var1 = useTokens()
    local var2 = usePreferredBackgroundStyle(var1.Color.OverMedia.OverMedia_0)

    local tbl1 = {
        panelTag = React.useMemo(function()
            return {
                ["col fill size-full-0 padding-large gap-medium align-x-center align-y-center"] = true
            }
        end, {}),
        backgroundStyle = 0
    }

    if bool1 == true then
        var2 = nil
    end

    tbl1.backgroundStyle = var2
    return tbl1
end

return useLegacyAndTransparencyAwarePanelStyle
