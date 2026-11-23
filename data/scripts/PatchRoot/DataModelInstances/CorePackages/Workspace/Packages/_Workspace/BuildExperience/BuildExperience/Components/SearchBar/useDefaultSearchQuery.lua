-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local createSearchQueryStore = require(BuildExperience.Stores.GetSearchQueryStore.createSearchQueryStore)

local function useDefaultSearchQuery(arg1)
    local var1 = React.useMemo(function()
        return arg1 or createSearchQueryStore()
    end, { arg1 })
    local query = var1.useDraftQuery()
    local debouncedQuery = var1.useDebouncedQuery()

    React.useEffect(function()
        return function()
            if arg1 == nil then
                var1.destroy()
            end
        end
    end, { var1, arg1 })

    return {
        clear = var1.clear,
        debouncedQuery = debouncedQuery,
        query = query,
        setQuery = var1.setQuery
    }
end

return useDefaultSearchQuery
