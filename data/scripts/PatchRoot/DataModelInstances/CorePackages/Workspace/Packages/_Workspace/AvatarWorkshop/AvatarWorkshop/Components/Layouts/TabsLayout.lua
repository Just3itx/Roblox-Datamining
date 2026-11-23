-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)

local function TabsLayout(tbl1)
    return React.createElement(Foundation.View, { tag = "col size-full" }, {
        Tabs = React.createElement(Foundation.Tabs, {
            tabs = tbl1.tabs,
            activeTabId = tbl1.activeTabId,
            onActivated = tbl1.onTabActivated,
            testId = tbl1.testId,
            LayoutOrder = 1
        }),
        ContentContainer = React.createElement(Foundation.View, { tag = "grow size-full-0", LayoutOrder = 2 }, { tbl1.children })
    })
end

return TabsLayout
