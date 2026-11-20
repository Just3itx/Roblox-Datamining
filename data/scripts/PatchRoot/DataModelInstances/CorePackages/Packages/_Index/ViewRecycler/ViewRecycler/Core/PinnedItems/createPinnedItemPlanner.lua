-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _ItemSequence = require(ViewRecycler.Core.Virtualizer.ItemSequence)
local _Layout = require(ViewRecycler.Core.Layout)
local PlacementTypes = require(ViewRecycler.Core.Placement.PlacementTypes)
local ShallowTable = require(ViewRecycler.Internal.ShallowTable)
local _Types = require(ViewRecycler.Core.Types)
local buildPlacementPlan = require(ViewRecycler.Core.PinnedItems.buildPlacementPlan)
local StickyIndexResolver = require(ViewRecycler.Core.PinnedItems.StickyIndexResolver)

local var1 = table.freeze({ "key" })

local function sameItem(tbl1, tbl2) -- Luacid: Inlined by compiler; 6 call sites recovered
    return tbl1 == tbl2 or not (tbl1 == nil or tbl2 == nil) and ShallowTable.containsEqual(tbl1, tbl2, var1)
end

local estimatedLength = nil
local lengthOf = nil
if FFlagViewRecyclerReact084 then
    estimatedLength = function(tbl1): number
        local estimatedLength2 = if tbl1 == nil then nil else tbl1.estimatedLength

        if estimatedLength2 == nil then
            return 0
        end
        assert(
            estimatedLength2 >= 0 and estimatedLength2 < math.huge,
            "PinnedItems: estimated length must be finite and non-negative"
        )
        return estimatedLength2
    end

    lengthOf = function(tbl1)
        if tbl1.item == nil then
            return 0
        end

        return tbl1.measuredLength or estimatedLength(tbl1.item)
    end
end

local function createPinnedItemPlanner(arg1, tbl1)
    local tbl2 = tbl1
    local var2 = StickyIndexResolver(arg1, tbl2.isItemStickyKey)

    if FFlagViewRecyclerReact084 then
        estimatedLength(tbl2.pinnedStartItem)
        estimatedLength(tbl2.pinnedEndItem)
    end
    local tbl3 = {
        item = tbl2.pinnedStartItem,
        revision = 1,
        measuredLength = nil,
        length = if FFlagViewRecyclerReact084 then nil else 0
    }
    local tbl4 = {
        item = tbl2.pinnedEndItem,
        revision = 1,
        measuredLength = nil,
        length = if FFlagViewRecyclerReact084 then nil else 0
    }

    local function setItem(tbl5, tbl6): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        local item = tbl5.item

        if item == tbl6 or not (sameItem(nil, item) or sameItem(nil, tbl6)) and ShallowTable.containsEqual(item, tbl6, var1) then
            local var3

            if FFlagViewRecyclerReact084 then
                var3 = lengthOf(tbl5)
                tbl5.item = tbl6
            else
                var3 = nil
            end
            return if FFlagViewRecyclerReact084 then lengthOf(tbl5) ~= var3 else false
        end
        tbl5.item = tbl6
        tbl5.revision += 1

        if FFlagViewRecyclerReact084 then
            tbl5.measuredLength = nil
        else
            tbl5.length = 0
        end
        return true
    end

    local function getContentInsets()
        return {
            start = if FFlagViewRecyclerReact084 then lengthOf(tbl3) elseif tbl3.item == nil then 0 else tbl3.length,
            finish = if FFlagViewRecyclerReact084 then lengthOf(tbl4) elseif tbl4.item == nil then 0 else tbl4.length
        }
    end

    local function resolvedItem(tbl5, position): {key: any, length: number, position: number, revision: any}? -- Luacid: Inlined by compiler; 2 call sites recovered
        local item = tbl5.item
        if item == nil then
            return nil
        end
        return {
            key = item.key,
            revision = tbl5.revision,
            length = if FFlagViewRecyclerReact084 then lengthOf(tbl5) else tbl5.length,
            position = position
        }
    end

    return {
        getContentInsets = getContentInsets,
        update = function(arg2)
            var2.setItemSequence(arg2.itemSequence)
            local var3 = if FFlagViewRecyclerReact084 then lengthOf(tbl3) elseif tbl3.item == nil then 0 else tbl3.length

            local activeStickyIndex, nextStickyIndex = var2.resolveActive(function(arg3): boolean
                return arg2.layout.getItemLayout(arg3).startOffset + arg2.contentStartOffset - arg2.scrollOffset < var3
            end)
            return buildPlacementPlan({
                itemSequence = arg2.itemSequence,
                layout = arg2.layout,
                activeStickyIndex = activeStickyIndex,
                nextStickyIndex = nextStickyIndex,
                scrollOffset = arg2.scrollOffset,
                viewportLength = arg2.viewportLength,
                contentStartOffset = arg2.contentStartOffset,
                pinnedStartItem = resolvedItem(tbl3, PlacementTypes.PinnedPosition.Start),
                pinnedEndItem = resolvedItem(tbl4, PlacementTypes.PinnedPosition.Finish)
            })
        end,
        applyDataSourceChange = function(arg2)
            var2.applyDataSourceChange(arg2)
        end,
        updatePinnedMeasurement = function(start, arg2, revision, length)
            assert(length >= 0 and length < math.huge, "PinnedItems: measured length must be finite and non-negative")
            local tbl5 = if start == PlacementTypes.PinnedPosition.Start then tbl3 else tbl4
            local item = tbl5.item

            if not (if FFlagViewRecyclerReact084 then item == nil else item == nil or item.key ~= arg2) then
                local var3 = if FFlagViewRecyclerReact084 then item.key else tbl5.revision

                if not FFlagViewRecyclerReact084 then
                    arg2 = revision
                end
                if var3 == arg2 and not (if FFlagViewRecyclerReact084 then tbl5.revision ~= revision else tbl5.length == length) then
                    if FFlagViewRecyclerReact084 then
                        local var4 = lengthOf(tbl5)
                        tbl5.measuredLength = length
                        if length == var4 then
                            return nil, true
                        end
                        return getContentInsets(), true
                    end
                    tbl5.length = length
                    return (getContentInsets())
                end
            end

            if FFlagViewRecyclerReact084 then
                return nil, false
            end
            return nil
        end,
        setOptions = function(arg2)
            if FFlagViewRecyclerReact084 then
                estimatedLength(arg2.pinnedStartItem)
                estimatedLength(arg2.pinnedEndItem)
            end
            tbl2 = arg2
            local var3 = var2.setPredicate(arg2.isItemStickyKey)
            local var4 = setItem(tbl3, arg2.pinnedStartItem) or var3
            return setItem(tbl4, arg2.pinnedEndItem) or var4
        end,
        setItemSequence = var2.setItemSequence,
        destroy = function() end
    }
end

return createPinnedItemPlanner
