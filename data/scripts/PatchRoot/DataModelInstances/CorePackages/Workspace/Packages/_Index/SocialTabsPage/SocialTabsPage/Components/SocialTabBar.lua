-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPageParent = script:FindFirstAncestor("SocialTabsPage").Parent

local React = require(SocialTabsPageParent.React)
local Foundation = require(SocialTabsPageParent.Foundation)

local Tabs = Foundation.Tabs
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize
local View = Foundation.View

local useNavigation = require(SocialTabsPageParent.Navigation).useNavigation

local function SocialTabBar(tbl1)
    local var1 = useNavigation()
    local routeName = var1.state.routes[var1.state.index].routeName
    local activeTabId, var3 = React.useState(routeName)

    local onActivated = React.useCallback(function(arg1)
        var3(arg1)
        var1.navigate(arg1)
    end, { var1 })

    React.useEffect(function()
        var3(function(arg1)
            return if arg1 == routeName then arg1 else routeName
        end)
    end, { routeName })

    return React.createElement(View, {
        tag = "size-full-0 auto-y bg-surface-0",
        LayoutOrder = tbl1.layoutOrder
    }, {
        SocialTabs = React.createElement(Tabs, {
            activeTabId = activeTabId,
            size = InputSize.Medium,
            fillBehavior = FillBehavior.Fill,
            onActivated = onActivated,
            tabs = tbl1.tabs
        })
    })
end

return SocialTabBar
