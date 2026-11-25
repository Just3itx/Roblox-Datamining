-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local usePreferences = require(scriptParentParentParent.Foundation).Hooks.usePreferences
local usePreferredTransparencyBinding = require(scriptParentParent.Hooks.usePreferredTransparencyBinding)
local FFlagPlayerListContrastingTeamText = require(scriptParentParent.Flags.FFlagPlayerListContrastingTeamText)

local function usePreferredBackgroundStyle(tbl1)
    local color3 = tbl1.Color3
    local transparency = tbl1.Transparency

    if not FFlagPlayerListContrastingTeamText then
        local var1 = usePreferredTransparencyBinding()

        return React.useMemo(function()
            return var1:map(function(num1: number)
                return {
                    Color3 = color3,
                    Transparency = transparency * num1
                }
            end)
        end, { var1, color3, transparency })
    end

    local var1 = usePreferences()
    local var2 = if var1.preferredTransparency == nil then 1 else var1.preferredTransparency

    return React.useMemo(function()
        return React.createBinding({ Color3 = color3, Transparency = transparency * var2 })
    end, { color3, transparency, var2 })
end

return usePreferredBackgroundStyle
