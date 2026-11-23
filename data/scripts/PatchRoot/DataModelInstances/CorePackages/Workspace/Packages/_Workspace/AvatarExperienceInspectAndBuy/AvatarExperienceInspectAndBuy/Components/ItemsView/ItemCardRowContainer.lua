-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local useItemCardRowProps = require(AvatarExperienceInspectAndBuy.Components.useItemCardRowProps)
local _ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)

local CatalogRowItemCard = AXCommon.Components.CatalogItemCard.CatalogRowItemCard

return function(tbl1)
    local var1 = useItemCardRowProps(tbl1.item, tbl1.LayoutOrder, tbl1.view, tbl1.onItemCardActivated, tbl1.itemCardWidth)
    return React.createElement(CatalogRowItemCard, var1)
end
