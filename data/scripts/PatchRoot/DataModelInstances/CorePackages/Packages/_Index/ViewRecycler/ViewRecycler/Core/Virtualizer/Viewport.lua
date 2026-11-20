-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact08
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _Layout = require(ViewRecycler.Core.Layout)
local ReachedThreshold = require(ViewRecycler.Core.ViewportBehavior.ReachedThreshold)
local ScrollAlignment = require(ViewRecycler.Core.Enums.ScrollAlignment)
local Types = require(ViewRecycler.Core.Types)

local var1 = table.freeze({ firstIndex = 1, lastIndex = 0 })

local function resolveOverscan(num1: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = num1 or 1
    assert(num2 >= 0 and num2 % 1 == 0, "Virtualizer: overscan must be a non-negative integer")
    return num2
end

local function validateAlignment(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    assert(
        arg1 == ScrollAlignment.Start or arg1 == ScrollAlignment.Center or arg1 == ScrollAlignment.End,
        "Virtualizer: invalid content alignment"
    )
end

local function validateInset(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    assert(num1 >= 0 and num1 < math.huge, "Virtualizer: content insets must be finite non-negative numbers")
end

local function sameRange(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.firstIndex == arg2.firstIndex and arg1.lastIndex == arg2.lastIndex
end

local function createViewport(tbl1)
    local layout = tbl1.layout
    local overscan = tbl1.overscan or 1
    assert(overscan >= 0 and overscan % 1 == 0, "Virtualizer: overscan must be a non-negative integer")

    local getContentAlignment = tbl1.contentAlignment or ScrollAlignment.Start
    local endThreshold = tbl1.endThreshold
    validateAlignment(getContentAlignment)
    if endThreshold ~= nil then
        ReachedThreshold.validate(endThreshold, "Virtualizer: end threshold")
    end
    local num1 = 0
    local num2 = 0
    local num3 = 0
    local num4 = 0
    local getCrossAxisLength = 0
    local num6 = 0
    local getContentStartOffset = 0
    local getVisibleRange = var1
    local getMountedRange = var1

    local function metrics() -- Luacid: Inlined by compiler; 9 call sites recovered
        local contentLength = layout.getContentLength()
        local num8 = math.max(0, num4 - num1 - num2 - contentLength)
        if getContentAlignment ~= ScrollAlignment.End then
            num8 = if getContentAlignment ~= ScrollAlignment.Center then 0 else num8 / 2
        end
        return num1 + contentLength + num2, num1 + num8
    end

    local function refresh() -- Luacid: Inlined by compiler; 4 call sites recovered
        num6, getContentStartOffset = metrics()
    end

    local function clamp(num8: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
        local var5, _ = metrics()
        return math.clamp(num8, 0, math.max(0, var5 - num4))
    end

    local function scrollTo(num8: number) -- Luacid: Inlined by compiler; 1 call site recovered
        assert(math.abs(num8) < math.huge, "Virtualizer: scroll offset must be finite")
        num3 = clamp(num8)
        return num3
    end

    local function visibleRangeAt(num8: number, num9: number) -- Luacid: Inlined by compiler; 1 call site recovered
        local num10 = num8 + num1 - getContentStartOffset
        local num11 = math.max(num10, num9 - num2 - getContentStartOffset)
        return layout.getIntersectingIndexRange(num10, num11)
    end

    local contentLength = layout.getContentLength()
    local num8 = math.max(0, num4 - num1 - num2 - contentLength)
    local _end = ScrollAlignment.End

    if getContentAlignment ~= _end then
        local center = ScrollAlignment.Center
        num8 = if getContentAlignment ~= center then 0 else num8 / 2
    end
    local var5 = num1 + contentLength + num2
    local num9 = num1 + num8
    num6 = var5
    getContentStartOffset = num9

    return {
        setLayout = function(arg1)
            layout = arg1
            refresh()
        end,
        getLayout = function()
            return layout
        end,
        setScrollOffset = function(arg1): boolean
            if num3 == arg1 then
                return false
            end
            num3 = arg1
            return true
        end,
        scrollTo = scrollTo,
        clamp = clamp,
        setSize = function(arg1, arg2): boolean
            if num4 == arg1 and getCrossAxisLength == arg2 then
                return false
            end
            num4 = arg1
            getCrossAxisLength = arg2
            refresh()
            return true
        end,
        setOverscan = function(arg1)
            local num10 = resolveOverscan(arg1)
            overscan = num10
        end,
        setContentAlignment = function(arg1): boolean
            local var6 = arg1 or ScrollAlignment.Start
            validateAlignment(var6)

            if getContentAlignment == var6 then
                return false
            end
            getContentAlignment = var6
            refresh()
            return true
        end,
        getContentAlignment = function()
            return getContentAlignment
        end,
        setInsets = function(arg1, arg2): boolean
            validateInset(arg1)
            validateInset(arg2)

            if num1 == arg1 and num2 == arg2 then
                return false
            end
            num1 = arg1
            num2 = arg2
            refresh()
            return true
        end,
        setEndThreshold = function(arg1)
            if arg1 ~= nil then
                ReachedThreshold.validate(arg1, "Virtualizer: end threshold")
            end
            endThreshold = arg1
        end,
        refresh = refresh,
        updateRanges = function(): (boolean, boolean)
            local var6 = visibleRangeAt(num3, num3 + num4)
            local var7 = if Types.isIndexRangeEmpty(var6) then var1 else layout.expandIndexRange(var6, overscan, overscan)
            local bool1 = not sameRange(getVisibleRange, var6)
            local bool2 = not sameRange(getMountedRange, var7)
            if bool1 then
                getVisibleRange = table.freeze({ firstIndex = var6.firstIndex, lastIndex = var6.lastIndex })
            end
            if bool2 then
                getMountedRange = table.freeze({ firstIndex = var7.firstIndex, lastIndex = var7.lastIndex })
            end
            return bool1, bool2
        end,
        getScrollOffset = function()
            return num3
        end,
        getLength = function()
            return num4
        end,
        getCrossAxisLength = function()
            return getCrossAxisLength
        end,
        getContentLength = function()
            return num6
        end,
        getContentStartOffset = function()
            return getContentStartOffset
        end,
        getVisibleRange = function()
            return getVisibleRange
        end,
        getMountedRange = function()
            return getMountedRange
        end,
        visibleRangeAt = visibleRangeAt,
        placedItemLayout = function(arg1)
            local itemLayout = layout.getItemLayout(arg1)
            return {
                startOffset = itemLayout.startOffset + getContentStartOffset,
                length = itemLayout.length,
                crossAxisIndex = itemLayout.crossAxisIndex,
                crossAxisCount = itemLayout.crossAxisCount
            }
        end,
        offsetForItem = function(arg1, arg2): number
            local itemCount = layout.getItemCount()
            if itemCount == 0 then
                return 0
            end
            local itemLayout = layout.getItemLayout(math.clamp(arg1, 1, itemCount))
            local var6, num10 = metrics()
            local num11 = math.max(0, num4 - num1 - num2)
            local var7

            if arg2 == ScrollAlignment.Center then
                var7 = num10 + itemLayout.startOffset + itemLayout.length / 2 - num1 - num11 / 2
            elseif arg2 == ScrollAlignment.End then
                var7 = num10 + itemLayout.startOffset + itemLayout.length - num4 + num2
            else
                var7 = num10 + itemLayout.startOffset - num1
            end

            return math.clamp(var7, 0, math.max(0, var6 - num4))
        end,
        scrollState = function(arg1)
            local distanceFromEnd = math.max(0, num6 - num4 - num3)
            local atStart = num3 <= 0
            local atEnd = distanceFromEnd <= ReachedThreshold.resolve(endThreshold, num4, 1)
            if arg1 ~= nil
                and arg1.scrollOffset == num3
                and arg1.viewportLength == num4
                and arg1.contentLength == num6
                and arg1.distanceFromEnd == distanceFromEnd
                and arg1.atStart == atStart
                and arg1.atEnd == atEnd
            then
                return arg1
            end
            return table.freeze({
                scrollOffset = num3,
                viewportLength = num4,
                contentLength = num6,
                distanceFromEnd = distanceFromEnd,
                atStart = atStart,
                atEnd = atEnd
            })
        end,
        scrollBy = if FFlagViewRecyclerReact084 then nil else not FFlagViewRecyclerReact08 and function(arg1)
            assert(math.abs(arg1) < math.huge, "Virtualizer: scroll delta must be finite")
            num3 = scrollTo(num3 + arg1)
            return num3
        end or nil
    }
end

return createViewport
