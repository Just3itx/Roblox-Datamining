-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcher = script:FindFirstAncestor("AvatarSwitcher")
local AvatarSwitcherParent = AvatarSwitcher.Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)

local OutfitTile = require(AvatarSwitcher.Components.OutfitTile)
local _types = require(AvatarSwitcher.types)

return React.memo(function(tbl1) -- name: OutfitsRow
    local tbl2 = ({})

    for k, outfitInfo in tbl1.outfits do
        local var1 = "Outfit" .. (outfitInfo.id or k)
        tbl2[var1] = React.createElement(OutfitTile, {
            outfitInfo = outfitInfo,
            disabled = tbl1.disabled,
            LayoutOrder = k,
            gridPosition = {
                row = tbl1.rowNumber,
                column = k
            }
        })
    end

    for layoutOrder = #tbl1.outfits + 1, tbl1.desiredItemsCount do
        tbl2["Filler" .. layoutOrder] = React.createElement(Foundation.View, { tag = "size-full-0", LayoutOrder = layoutOrder })
    end

    return React.createElement(
        Foundation.View,
        { tag = "row size-full-0 auto-y gap-medium flex-x-fill padding-bottom-large" },
        tbl2
    )
end)
