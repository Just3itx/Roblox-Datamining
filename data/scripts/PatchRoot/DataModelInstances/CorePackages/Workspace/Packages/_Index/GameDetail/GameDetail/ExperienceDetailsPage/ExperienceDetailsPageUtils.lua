-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent
local _Navigation = require(GameDetailParent.Navigation)

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local param = tbl1.navigation and tbl1.navigation.getParam("extraProps")
    return tbl1[str1] or param and param[str1]
end

return {
    getFromPropsOrNavigationParams = getFromPropsOrNavigationParams,
    getUniverseId = function(tbl1)
        return getFromPropsOrNavigationParams(tbl1, "universeId") or tbl1.navigation and tbl1.navigation.getParam("detail")
    end,
    getAnalyticsSource = function(tbl1)
        return getFromPropsOrNavigationParams(tbl1, "source") or "None"
    end,
    getTilePositionIndex = function(tbl1)
        local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "index")

        if type(fromPropsOrNavigationParams) == "number" then
            return fromPropsOrNavigationParams
        end
        if type(fromPropsOrNavigationParams) == "string" then
            local var1 = tonumber(fromPropsOrNavigationParams)
            if var1 then
                return var1
            end
        end

        return -1
    end,
    getResolvedIdentifier = function(str1: string, str2: string): string
        return str1 .. "_" .. str2
    end
}
