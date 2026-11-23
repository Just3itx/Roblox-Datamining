-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")

local Screens = require(AvatarWorkshop.Navigation.Screens)
local InventoryPagesData = require(AvatarWorkshop.Constants.InventoryPagesData)
local WorkshopNavigatorView = require(AvatarWorkshop.Navigation.NavigatorViews.WorkshopNavigatorView)
local InventoryGridContainer = require(AvatarWorkshop.Components.Inventory.InventoryGrid.InventoryGridContainer)
local CustomizeActionBar = require(AvatarWorkshop.Components.ActionBars.CustomizeActionBar)
local YourAvatarsActionBar = require(AvatarWorkshop.Components.ActionBars.YourAvatarsActionBar)
local createPagesNavigator = require(script.Parent.createPagesNavigator)
local InventoryNavigator = require(script.Parent.InventoryNavigator)

return createPagesNavigator(WorkshopNavigatorView, {
    {
        [Screens.Workshop.YourAvatars] = {
            screen = InventoryGridContainer,
            params = {
                pageData = InventoryPagesData[Screens.Inventory.Avatars]
            },
            navigationOptions = { actionBar = YourAvatarsActionBar }
        }
    },
    {
        [Screens.Workshop.Customize] = {
            screen = InventoryNavigator,
            navigationOptions = { actionBar = CustomizeActionBar }
        }
    }
})
