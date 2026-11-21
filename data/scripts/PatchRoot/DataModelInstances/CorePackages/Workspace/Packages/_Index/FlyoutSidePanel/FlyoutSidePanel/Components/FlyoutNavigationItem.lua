-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local _FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)
local PrimaryNavigationItem = require(script.Parent.PrimaryNavigationItem)

local useFlyoutItemNavigation = require(script.Parent.Parent.Hooks.useFlyoutItemNavigation)

local function FlyoutNavigationItem(arg1)
    local onActivated = useFlyoutItemNavigation(arg1.item, arg1.closeDrawer, arg1.buildCreatorWebNavUrl)

    local var2 = useLocalization({ text = arg1.item.textKey })

    return React.createElement(PrimaryNavigationItem, {
        layoutOrder = arg1.layoutOrder,
        onActivated = onActivated,
        icon = arg1.item.icon,
        text = var2.text,
        notificationCount = arg1.item.notificationCount,
        testId = arg1.item.itemType
    })
end

return FlyoutNavigationItem
