-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local RobloxAppNavigation = require(SplitPaneParent.RobloxAppNavigation)

local FFlagNavigationCommandHandle = require(SplitPaneParent.SharedFlags).FFlagNavigationCommandHandle

local OnScreenStore = require(script.Parent.Parent.Stores.OnScreenStore)

local OnScreenContext = RobloxAppNavigation.OnScreenContext

local function OnScreenCardProvider(tbl1)
    local value = tbl1.value

    local var1 = React.useRef(nil)
    local current = var1.current
    if value ~= nil
        and current ~= nil
        and current.isOnScreen == value.isOnScreen
        and current.currentRouteKey == value.currentRouteKey
    then
        value = current
    elseif value ~= nil then
        var1.current = value
    end

    if FFlagNavigationCommandHandle then
        React.useEffect(function()
            if value == nil or value.isOnScreen ~= true or value.currentRouteKey == nil then
                return function() end
            end

            local currentRouteKey = value.currentRouteKey
            OnScreenStore.setRouteOnScreen(currentRouteKey, value)
            return function()
                OnScreenStore.setRouteOnScreen(currentRouteKey, nil)
            end
        end, { value })
    end

    return React.createElement(OnScreenContext.Provider, { value = value }, tbl1.children)
end

return OnScreenCardProvider
