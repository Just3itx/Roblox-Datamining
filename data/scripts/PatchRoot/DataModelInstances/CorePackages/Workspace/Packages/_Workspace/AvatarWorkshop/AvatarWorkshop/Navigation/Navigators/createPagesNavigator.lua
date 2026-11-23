-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local _React = require(AvatarWorkshopParent.React)
local RoactNavigation = require(AvatarWorkshopParent.RoactNavigation)

local function createPagesNavigator(arg1, tbl1, tbl2)
    local var1 = RoactNavigation.SwitchRouter(tbl1, { initialRouteName = if tbl2 then tbl2.initialRouteName else nil })

    return RoactNavigation.createNavigator(arg1, var1, {})
end

return createPagesNavigator
