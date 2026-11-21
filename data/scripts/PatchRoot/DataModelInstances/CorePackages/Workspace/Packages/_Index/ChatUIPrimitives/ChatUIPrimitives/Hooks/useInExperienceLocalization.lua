-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Localization = require(ChatUIPrimitivesParent.InExperienceLocales).Localization

local useRobloxLocale = require(script.Parent.useRobloxLocale)

local function useInExperienceLocalization()
    local var1 = useRobloxLocale()
    return React.useMemo(function()
        local localization = Localization.new(var1)
        return function(str1: string, tbl1)
            return localization:Format(str1, tbl1)
        end
    end, { var1 })
end

return useInExperienceLocalization
