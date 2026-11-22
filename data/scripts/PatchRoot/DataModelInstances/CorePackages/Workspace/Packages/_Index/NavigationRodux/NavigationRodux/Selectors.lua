-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")

local _Navigation = require(NavigationRodux.Parent.Navigation)

local _types = require(NavigationRodux.types)

local function selectNavigationState(arg1) -- Luacid: Inlined by compiler; 7 call sites recovered
    return arg1.Navigation
end

local function selectLegacyHistory(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return selectNavigationState(arg1).history
end

local function selectCurrentLegacyRoute(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = selectLegacyHistory(arg1)

    return var1[#var1]
end

return {
    selectCurrentRoactNavigationRoute = function(arg1)
        return selectNavigationState(arg1).currentRoute
    end,
    selectLegacyHistory = selectLegacyHistory,
    selectNavigationLocked = function(arg1)
        return selectNavigationState(arg1).lockNavigationActions
    end,
    selectBackNavigationDisableCounter = function(arg1)
        return selectNavigationState(arg1).backNavigationDisableCounter
    end,
    selectCurrentPageName = function(arg1)
        local var1 = selectCurrentLegacyRoute(arg1)
        return var1[#var1].name
    end,
    selectCurrentLegacyRoute = selectCurrentLegacyRoute,
    selectCurrentLegacyPage = function(arg1)
        local var1 = selectCurrentLegacyRoute(arg1)
        return var1[#var1]
    end
}
