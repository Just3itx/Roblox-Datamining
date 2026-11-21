-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)

local function useFirstSeenImpressionFilter(arg1)
    local var1 = React.useRef({})

    React.useEffect(function()
        var1.current = {}
    end, { arg1 })

    return React.useCallback(function(num1: number): boolean
        if var1.current[num1] then
            return false
        end
        var1.current[num1] = true
        return true
    end, {})
end

return useFirstSeenImpressionFilter
