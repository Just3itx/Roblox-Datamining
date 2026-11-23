-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local React = require(AvatarWorkshopParent.React)

local _InventoryPagesData = require(AvatarWorkshop.Constants.InventoryPagesData)
local useNavigation = require(AvatarWorkshop.Hooks.useNavigation)
local _InventoryGridTypes = require(script.Parent.InventoryGridTypes)
local InventoryGridView = require(script.Parent.InventoryGridView)
local useInventoryGridViewModel = require(script.Parent.useInventoryGridViewModel)

local function InventoryGridContainer(_)
    local pageData = useNavigation().getParam("pageData")

    local var2 = useInventoryGridViewModel({ pageData = pageData })
    return React.createElement(InventoryGridView, var2)
end

return InventoryGridContainer
