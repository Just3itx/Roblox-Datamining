-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _ItemSequence = require(ViewRecycler.Core.Virtualizer.ItemSequence)
local _Layout = require(ViewRecycler.Core.Layout)
local PlacementTypes = require(ViewRecycler.Core.Placement.PlacementTypes)

local var1 = table.freeze({
    retainedItems = table.freeze({}),
    additionalItems = table.freeze({}),
    placements = table.freeze({}),
    hasViewportRelativePlacements = false
})

local function buildPlacementPlan(tbl1)
    if tbl1.activeStickyIndex == nil and tbl1.pinnedStartItem == nil and tbl1.pinnedEndItem == nil then
        return var1
    end
    local retainedItems = {}
    local additionalItems = {}
    local placements = ({})
    local mainAxisOffset = if tbl1.pinnedStartItem == nil then 0 else tbl1.pinnedStartItem.length

    local activeStickyIndex = tbl1.activeStickyIndex
    if activeStickyIndex ~= nil then
        local itemLayout = tbl1.layout.getItemLayout(activeStickyIndex)

        local nextStickyIndex = tbl1.nextStickyIndex
        local mainAxisEndLimit = if nextStickyIndex == nil then nil else tbl1.layout.getItemLayout(nextStickyIndex).startOffset + tbl1.contentStartOffset - tbl1.scrollOffset
        local key = tbl1.itemSequence.getItemKey(activeStickyIndex)
        table.insert(retainedItems, { key = key, index = activeStickyIndex })

        placements[key] = {
            mainAxisOffset = mainAxisOffset,
            mainAxisLength = itemLayout.length,
            mainAxisEndLimit = mainAxisEndLimit,
            viewportRelative = true,
            zIndex = 1
        }
    end

    for _, value in { tbl1.pinnedStartItem, tbl1.pinnedEndItem } do
        if value == nil then
            continue
        end

        table.insert(additionalItems, {
            key = value.key,
            identity = {
                kind = PlacementTypes.IdentityKind.Pinned,
                position = value.position,
                revision = value.revision
            }
        })
        local key = value.key
        local tbl5 = {
            mainAxisOffset = if value.position == PlacementTypes.PinnedPosition.Start then 0 else math.max(0, tbl1.viewportLength - value.length),
            mainAxisLength = value.length,
            viewportRelative = true,
            zIndex = 2
        }
        placements[key] = tbl5
    end

    return {
        retainedItems = retainedItems,
        additionalItems = additionalItems,
        placements = placements,
        hasViewportRelativePlacements = activeStickyIndex ~= nil or tbl1.pinnedStartItem ~= nil or tbl1.pinnedEndItem ~= nil
    }
end

return buildPlacementPlan
