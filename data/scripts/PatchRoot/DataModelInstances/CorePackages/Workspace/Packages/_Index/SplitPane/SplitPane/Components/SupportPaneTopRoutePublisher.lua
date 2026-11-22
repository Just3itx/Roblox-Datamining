-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)

local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)
local routeIdentityMatches = require(script.Parent.Parent.Utils.routeIdentityMatches)

local function SupportPaneTopRoutePublisher(tbl1)
    local routeState = tbl1.routeState
    React.useEffect(function()
        if routeState == nil then
            return
        end

        local store = SplitPaneStore.getStore()
        local function func1(str1: string, tbl2)
            return routeIdentityMatches(routeState, str1, tbl2)
        end
        local key = routeState.key
        store.setSupportPaneTopRouteMatcher(func1)
        store.setSupportPaneTopRouteKey(key)
        return function()
            if store.getSupportPaneTopRouteMatcher(false) == func1 then
                store.setSupportPaneTopRouteMatcher(nil)
            end
            if store.getSupportPaneTopRouteKey(false) == key then
                store.setSupportPaneTopRouteKey(nil)
            end
        end
    end, { routeState })
    return nil
end

return SupportPaneTopRoutePublisher
