-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local FFlagSignalsNavP3Dispatch = require(SplitPaneParent.SharedFlags).FFlagSignalsNavP3Dispatch

local NavigateDown = require(SplitPaneParent.NavigationRodux).Thunks.NavigateDown

local RobloxAppNavigation = require(SplitPaneParent.RobloxAppNavigation)
local NavigationCommands = RobloxAppNavigation.NavigationCommands
local AppNavigationRegistry = RobloxAppNavigation.AppNavigationRegistry

local createNavigationHandle = require(script.Parent.Parent.Utils.createNavigationHandle)
local routeIdentity = require(script.Parent.Parent.Utils.routeIdentity)

return function(tbl1, tbl2)
    return function(arg1)
        local bool1 = not (tbl2 == nil) and tbl2.deduplicate == true
        local bypassNavigationLock = if tbl2 == nil then nil else tbl2.bypassNavigationLock

        local function matchesIdentity(arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
            if arg2.routeName ~= tbl1.name then
                return false
            end
            local params = arg2.params
            return tostring(if params == nil then nil else params.detail) == tostring(tbl1.detail)
        end

        if bool1 then
            local openRouteIdentity = routeIdentity.findOpenRouteIdentity(arg1, tbl1)
            if openRouteIdentity ~= nil then
                local var1 = if FFlagSignalsNavP3Dispatch then createNavigationHandle.new(AppNavigationRegistry.get().getState, openRouteIdentity.key) else createNavigationHandle.fromRoduxStore(arg1, openRouteIdentity.key)
                var1.deduplicated = true
                return var1
            end
        end

        local var1 = routeIdentity.snapshotRouteKeys(arg1)
        local function matchesNewPush(arg2): boolean
            return matchesIdentity(arg2) and var1[arg2.key] == nil
        end

        if not FFlagSignalsNavP3Dispatch then
            arg1:dispatch(NavigateDown(tbl1, bypassNavigationLock))

            return createNavigationHandle.fromRoduxStore(arg1, matchesNewPush)
        end

        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1), bypassNavigationLock)
        if not AppNavigationRegistry.isRegistered() then
            return nil
        end

        return createNavigationHandle.new(AppNavigationRegistry.get().getState, matchesNewPush)
    end
end
