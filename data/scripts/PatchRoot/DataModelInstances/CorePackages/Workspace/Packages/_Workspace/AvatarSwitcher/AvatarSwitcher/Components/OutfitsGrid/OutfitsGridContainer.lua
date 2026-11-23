-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)

local OutfitsGrid = require(AvatarSwitcher.Components.OutfitsGrid.OutfitsGrid)
local useOutfitsGridProps = require(AvatarSwitcher.Components.OutfitsGrid.useOutfitsGridProps)

local function OutfitsGridContainer()
    local var1 = useOutfitsGridProps()
    return React.createElement(OutfitsGrid, var1)
end

return OutfitsGridContainer
