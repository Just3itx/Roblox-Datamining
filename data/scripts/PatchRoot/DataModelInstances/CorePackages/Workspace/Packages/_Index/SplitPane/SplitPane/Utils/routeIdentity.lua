-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local FFlagSignalsNavP3Dispatch = require(SplitPaneParent.SharedFlags).FFlagSignalsNavP3Dispatch

local _Navigation = require(SplitPaneParent.Navigation)
local AppNavigationRegistry = require(SplitPaneParent.RobloxAppNavigation).AppNavigationRegistry

local function readNavState(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagSignalsNavP3Dispatch then
        if AppNavigationRegistry.isRegistered() then
            return AppNavigationRegistry.get().getState(false)
        end
        return nil
    end
    local navigation = arg1:getState().Navigation
    return if navigation == nil then nil else navigation.roactNavigationState
end

local function matchesIdentity(arg1, tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.routeName ~= tbl1.name then
        return false
    end
    local params = arg1.params
    return tostring(if params == nil then nil else params.detail) == tostring(tbl1.detail)
end

local function findOnFocusedPath(arg1, func1: (...any) -> (...any))
    while arg1 ~= nil do
        if func1(arg1) then
            return arg1
        end
        local routes = arg1.routes
        if routes == nil then
            return nil
        end
        arg1 = routes[arg1.index]
    end
    return nil
end

return {
    findOnFocusedPath = findOnFocusedPath,
    findOpenRouteIdentity = function(arg1, tbl1)
        return (findOnFocusedPath(readNavState(arg1), function(arg2): boolean
            local tbl2 = tbl1
            return (matchesIdentity(arg2, tbl2))
        end))
    end,
    snapshotRouteKeys = function(arg1)
        local result = {}
        local function visit(arg2)
            if arg2 == nil then
                return
            end
            if arg2.key ~= nil then
                result[arg2.key] = true
            end
            if arg2.routes == nil then
                return
            end

            for _, value in arg2.routes do
                visit(value)
            end
        end

        local var1 = readNavState(arg1)

        if var1 == nil then
            return result
        end
        if var1.key ~= nil then
            result[var1.key] = true
        end
        if var1.routes ~= nil then
            for _, value in var1.routes do
                visit(value)
            end
        end

        return result
    end
}
