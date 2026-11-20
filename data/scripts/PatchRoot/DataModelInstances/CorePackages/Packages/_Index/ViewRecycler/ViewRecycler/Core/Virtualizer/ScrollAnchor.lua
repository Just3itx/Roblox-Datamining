-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact08
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local AutoScrollPolicy = require(ViewRecycler.Core.Enums.AutoScrollPolicy)
local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local Diagnostics = require(ViewRecycler.Core.Diagnostics)
local _ItemSequence = require(ViewRecycler.Core.Virtualizer.ItemSequence)
local ReachedThreshold = require(ViewRecycler.Core.ViewportBehavior.ReachedThreshold)
local ScrollAlignment = require(ViewRecycler.Core.Enums.ScrollAlignment)
local Types = require(ViewRecycler.Core.Types)
local _Viewport = require(ViewRecycler.Core.Virtualizer.Viewport)
local var1, followedEdge, validate

if FFlagViewRecyclerReact084 then
    var1 = 1

    followedEdge = function(arg1)
        if arg1 == AutoScrollPolicy.WhenAtStart then
            return ScrollAlignment.Start
        end

        if arg1 == AutoScrollPolicy.WhenAtEnd then
            return ScrollAlignment.End
        end

        return nil
    end

    validate = function(tbl1)
        local initialScrollAlignment = tbl1.initialScrollAlignment
        assert(
            initialScrollAlignment == nil
                or initialScrollAlignment == ScrollAlignment.Start
                or initialScrollAlignment == ScrollAlignment.End,
            "Virtualizer: initialScrollAlignment must be ScrollAlignment.Start or ScrollAlignment.End"
        )

        assert(
            tbl1.autoScrollOnChange == nil or followedEdge(tbl1.autoScrollOnChange) ~= nil,
            "Virtualizer: autoScrollOnChange must be AutoScrollPolicy.WhenAtStart or AutoScrollPolicy.WhenAtEnd"
        )

        if tbl1.autoScrollThreshold ~= nil then
            ReachedThreshold.validate(tbl1.autoScrollThreshold, "Virtualizer: autoScrollThreshold")
        end
    end
else
    var1 = nil
    followedEdge = nil
    validate = nil
    if FFlagViewRecyclerReact08 then
        var1 = 1

        followedEdge = function(arg1)
            if arg1 == AutoScrollPolicy.WhenAtStart then
                return ScrollAlignment.Start
            end

            if arg1 == AutoScrollPolicy.WhenAtEnd then
                return ScrollAlignment.End
            end

            return nil
        end

        validate = function(tbl1)
            local initialScrollAlignment = tbl1.initialScrollAlignment
            assert(
                initialScrollAlignment == nil
                    or initialScrollAlignment == ScrollAlignment.Start
                    or initialScrollAlignment == ScrollAlignment.End,
                "Virtualizer: initialScrollAlignment must be ScrollAlignment.Start or ScrollAlignment.End"
            )

            assert(
                tbl1.autoScrollOnChange == nil or followedEdge(tbl1.autoScrollOnChange) ~= nil,
                "Virtualizer: autoScrollOnChange must be AutoScrollPolicy.WhenAtStart or AutoScrollPolicy.WhenAtEnd"
            )

            if tbl1.autoScrollThreshold ~= nil then
                ReachedThreshold.validate(tbl1.autoScrollThreshold, "Virtualizer: autoScrollThreshold")
            end
        end
    end
end

local function projectIndex(num1: number?, arg1)
    if num1 == nil or arg1.type == DataSourceChangeType.Reset or arg1.type == DataSourceChangeType.Reorder then
        return nil
    end

    if arg1.type == DataSourceChangeType.Insert then
        if arg1.index <= num1 then
            return num1 + #arg1.keys
        end

        return num1
    end

    if arg1.type == DataSourceChangeType.Remove then
        if num1 < arg1.index then
            return num1
        end

        if arg1.index + #arg1.keys <= num1 then
            return num1 - #arg1.keys
        end

        return nil
    end

    if arg1.type == DataSourceChangeType.Move then
        if num1 == arg1.fromIndex then
            return arg1.toIndex
        end

        if arg1.fromIndex < num1 and num1 <= arg1.toIndex then
            return num1 - 1
        end

        if arg1.toIndex <= num1 and num1 < arg1.fromIndex then
            return num1 + 1
        end
    end
    return num1
end

local function createScrollAnchor(tbl1)
    local viewport = tbl1.viewport
    local isLaidOut, var2

    if FFlagViewRecyclerReact084 then
        isLaidOut = tbl1.isLaidOut
        var2 = tbl1.config
        validate(var2)
    else
        isLaidOut = nil
        var2 = nil
        if FFlagViewRecyclerReact08 then
            isLaidOut = tbl1.isLaidOut
            var2 = tbl1.config
            validate(var2)
        end
    end
    local var3 = nil

    local bool1 = nil
    local var4, bool2, bool3, hasItems, distanceFrom, edgeOffset, followThreshold, hold, holdsItemTarget, edgeHolds, opensAtInitialEdge, observe

    if FFlagViewRecyclerReact084 then
        var4 = nil
        bool2 = false

        bool3 = true
        bool1 = false

        hasItems = function(): boolean
            return tbl1.getItemSequence().getItemCount() > 0
        end

        distanceFrom = function(start)
            local scrollOffset = viewport.getScrollOffset()
            if start == ScrollAlignment.Start then
                return scrollOffset
            end
            return math.max(0, viewport.getContentLength() - viewport.getLength() - scrollOffset)
        end

        edgeOffset = function(start): number
            if start == ScrollAlignment.Start then
                return 0
            end

            return math.max(0, viewport.getContentLength() - viewport.getLength())
        end

        followThreshold = function()
            return ReachedThreshold.resolve(var2.autoScrollThreshold, viewport.getLength(), var1)
        end

        hold = function(arg1)
            bool2 = bool2 and arg1 == var4
            var4 = arg1
        end

        holdsItemTarget = function(): boolean
            return not (var3 == nil) and var3.kind == "itemTarget"
        end

        edgeHolds = function(): boolean
            return not (var4 == nil) and not holdsItemTarget()
        end

        opensAtInitialEdge = function()
            local bool4 = bool3
            return bool4 and var2.initialScrollAlignment ~= nil and hasItems() and isLaidOut()
        end

        observe = function()
            local var5 = followThreshold()
            local var6 = var4
            if var6 ~= nil and distanceFrom(var6) <= var5 then
                return
            end
            local var7 = followedEdge(var2.autoScrollOnChange)
            local func1 = hold

            if var7 == nil or not (distanceFrom(var7) <= var5) then
                var7 = nil
            end

            func1(var7)
        end
    else
        var4 = nil
        bool2 = nil
        bool3 = nil
        hasItems = nil
        distanceFrom = nil
        edgeOffset = nil
        followThreshold = nil
        hold = nil
        holdsItemTarget = nil
        edgeHolds = nil
        opensAtInitialEdge = nil
        observe = nil
        if FFlagViewRecyclerReact08 then
            var4 = nil
            bool2 = false

            bool3 = true

            hasItems = function(): boolean
                return tbl1.getItemSequence().getItemCount() > 0
            end

            distanceFrom = function(start)
                local scrollOffset = viewport.getScrollOffset()
                if start == ScrollAlignment.Start then
                    return scrollOffset
                end
                return math.max(0, viewport.getContentLength() - viewport.getLength() - scrollOffset)
            end

            edgeOffset = function(start): number
                if start == ScrollAlignment.Start then
                    return 0
                end

                return math.max(0, viewport.getContentLength() - viewport.getLength())
            end

            followThreshold = function()
                return ReachedThreshold.resolve(var2.autoScrollThreshold, viewport.getLength(), var1)
            end

            hold = function(arg1)
                bool2 = bool2 and arg1 == var4
                var4 = arg1
            end

            holdsItemTarget = function(): boolean
                return not (var3 == nil) and var3.kind == "itemTarget"
            end

            edgeHolds = function(): boolean
                return not (var4 == nil) and not holdsItemTarget()
            end

            opensAtInitialEdge = function()
                local bool4 = bool3
                return bool4 and var2.initialScrollAlignment ~= nil and hasItems() and isLaidOut()
            end

            observe = function()
                local var5 = followThreshold()
                local var6 = var4
                if var6 ~= nil and distanceFrom(var6) <= var5 then
                    return
                end
                local var7 = followedEdge(var2.autoScrollOnChange)
                local func1 = hold

                if var7 == nil or not (distanceFrom(var7) <= var5) then
                    var7 = nil
                end

                func1(var7)
            end
        end
    end

    local function findKeyIndex(str1: string, num1: number?) -- Luacid: Inlined by compiler; 1 call site recovered
        local itemSequence = tbl1.getItemSequence()
        local itemCount = itemSequence.getItemCount()
        if num1 ~= nil and num1 >= 1 and num1 <= itemCount and itemSequence.getItemKey(num1) == str1 then
            return num1
        end
        for i = 1, itemCount do
            if itemSequence.getItemKey(i) == str1 then
                return i
            end
        end
        return nil
    end

    local function captureViewport(scrollOffset: number, num1: number?)
        local itemSequence = tbl1.getItemSequence()
        local itemCount = itemSequence.getItemCount()
        local viewportLength = viewport.getLength()
        if itemCount == 0 or viewportLength <= 0 then
            return nil
        end

        if num1 == nil then
            local var5 = viewport.visibleRangeAt(scrollOffset, scrollOffset + viewportLength)
            if Types.isIndexRangeEmpty(var5) then
                return nil
            end
            num1 = var5.firstIndex

            local isItemMeasured = viewport.getLayout().isItemMeasured
            if isItemMeasured ~= nil then
                local firstIndex = var5.firstIndex
                local lastIndex = var5.lastIndex

                for i = firstIndex, math.min(lastIndex, itemCount) do
                    if isItemMeasured(i) then
                        num1 = i
                        break
                    end
                end
            end
        end

        local indexHint = math.clamp(num1, 1, itemCount)
        local var5 = viewport.placedItemLayout(indexHint)
        return {
            kind = "viewport",
            key = itemSequence.getItemKey(indexHint),
            indexHint = indexHint,
            viewportCoordinate = var5.startOffset - scrollOffset,
            itemLength = var5.length,
            scrollOffset = scrollOffset,
            viewportLength = viewportLength
        }
    end

    local function captureEvidence()
        local scrollOffset = viewport.getScrollOffset()
        local viewportLength = viewport.getLength()
        local visibleRange = viewport.getVisibleRange()
        if Types.isIndexRangeEmpty(visibleRange) then
            return nil
        end
        local itemSequence = tbl1.getItemSequence()
        local itemCount = itemSequence.getItemCount()
        local items = {}
        local firstIndex = visibleRange.firstIndex
        local lastIndex = visibleRange.lastIndex

        for i = firstIndex, math.min(lastIndex, itemCount) do
            local var5 = viewport.placedItemLayout(i)
            table.insert(
                items,
                {
                    key = itemSequence.getItemKey(i),
                    viewportCoordinate = var5.startOffset - scrollOffset,
                    itemLength = var5.length
                }
            )
        end

        return { scrollOffset = scrollOffset, viewportLength = viewportLength, items = items }
    end

    local function prepareDataChange(arg1, tbl2)
        local var5 = var3
        if var5 == nil then
            return
        end
        local indexHint = var5.indexHint
        for _, value in arg1.changes do
            indexHint = projectIndex(indexHint, value)
        end
        var5.indexHint = indexHint
        if var5.kind == "itemTarget" or findKeyIndex(var5.key, indexHint) ~= nil then
            return
        end

        if tbl2 ~= nil and tbl2.viewportLength > 0 then
            for _, item in tbl2.items do
                local keyIndex = findKeyIndex(item.key, nil)
                if keyIndex == nil then
                    continue
                end

                var3 = {
                    kind = "viewport",
                    key = item.key,
                    indexHint = keyIndex,
                    viewportCoordinate = item.viewportCoordinate,
                    itemLength = item.itemLength,
                    scrollOffset = tbl2.scrollOffset,
                    viewportLength = tbl2.viewportLength
                }
                return
            end
        end

        var3 = nil
    end

    local function resolve(tbl2)
        local var5 = var3
        if var5 == nil then
            var3 = captureViewport(viewport.getScrollOffset(), nil)
            return nil
        end
        local indexHint = findKeyIndex(var5.key, var5.indexHint)
        if indexHint == nil then
            var3 = captureViewport(viewport.getScrollOffset(), nil)
            return nil
        end
        local source = tbl2.source
        local scrollOffset = viewport.getScrollOffset()
        local var6

        if var5.kind == "itemTarget" then
            var5.indexHint = indexHint
            source = Diagnostics.ScrollCorrectionSource.ProgrammaticScroll
            var6 = viewport.offsetForItem(indexHint, var5.alignment) - scrollOffset
        else
            if not (if FFlagViewRecyclerReact084 then var2.preserveScrollPositionOnChange elseif FFlagViewRecyclerReact08 then var2.preserveScrollPositionOnChange else tbl1.shouldPreserveUserPosition()) then
                var3 = captureViewport(scrollOffset, nil)
                return nil
            end
            var5.indexHint = indexHint
            local var7 = viewport.placedItemLayout(indexHint).startOffset - scrollOffset
            local startInsetDelta = tbl2.startInsetDelta or 0
            var6 = var7 - var5.viewportCoordinate - startInsetDelta
            if tbl2.preserveStartAnchor and scrollOffset > 0 then
                var6 += startInsetDelta
            end
        end
        local delta = viewport.clamp(scrollOffset + var6) - scrollOffset
        if var5.kind == "viewport" then
            local scrollOffset2 = scrollOffset + (if math.abs(delta) < 1 then 0 else delta)
            local var8 = viewport.placedItemLayout(indexHint)
            local viewportCoordinate = var8.startOffset - scrollOffset2
            local viewportLength = viewport.getLength()
            if viewportCoordinate < viewportLength and viewportCoordinate + var8.length > 0 then
                var3 = {
                    kind = "viewport",
                    key = var5.key,
                    indexHint = indexHint,
                    viewportCoordinate = viewportCoordinate,
                    itemLength = var8.length,
                    scrollOffset = scrollOffset2,
                    viewportLength = viewportLength
                }
            else
                var3 = captureViewport(scrollOffset2, nil)
            end
        end
        return if math.abs(delta) < 1 then nil else { delta = delta, source = source }
    end

    local function setViewport(scrollOffset: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        local var5 = var3
        if var5 ~= nil and var5.kind == "viewport" then
            local viewportCoordinate = var5.viewportCoordinate - (scrollOffset - var5.scrollOffset)
            if viewportCoordinate < var5.viewportLength and viewportCoordinate + var5.itemLength > 0 then
                var5.viewportCoordinate = viewportCoordinate
                var5.scrollOffset = scrollOffset
                return
            end
        end
        var3 = captureViewport(scrollOffset, nil)
    end

    return {
        configure = FFlagViewRecyclerReact084 and function(arg1)
            validate(arg1)
            var2 = arg1
        end or FFlagViewRecyclerReact08 and function(arg1)
            validate(arg1)
            var2 = arg1
        end or nil,
        setItemTarget = function(arg1, alignment)
            local itemSequence = tbl1.getItemSequence()
            local itemCount = itemSequence.getItemCount()
            if itemCount == 0 then
                var3 = nil
                return
            end
            local indexHint = math.clamp(arg1, 1, itemCount)
            var3 = {
                kind = "itemTarget",
                key = itemSequence.getItemKey(indexHint),
                indexHint = indexHint,
                alignment = alignment or ScrollAlignment.Start
            }
        end,
        setViewport = setViewport,
        observeHost = function(scrollOffset)
            if if FFlagViewRecyclerReact084 then not holdsItemTarget() elseif FFlagViewRecyclerReact08 then not holdsItemTarget() else var3 == nil or var3.kind == "viewport" then
                setViewport(scrollOffset)
            end
        end,
        scrolledProgrammatically = FFlagViewRecyclerReact084 and function(arg1)
            bool3 = false
            if arg1 ~= nil then
                var4 = arg1
                bool2 = true
            end
        end or FFlagViewRecyclerReact08 and function(arg1)
            bool3 = false
            if arg1 ~= nil then
                var4 = arg1
                bool2 = true
            end
        end or nil,
        beginMotion = FFlagViewRecyclerReact084 and function()
            bool3 = false
            var4 = nil
            bool2 = false
            bool1 = true
            if holdsItemTarget() then
                var3 = captureViewport(viewport.getScrollOffset(), nil)
            end
        end or nil,
        endMotion = FFlagViewRecyclerReact084 and function()
            bool1 = false
        end or nil,
        restore = function(arg1, scrollOffset)
            local keyIndex = if arg1.anchorKey == nil then nil else findKeyIndex(arg1.anchorKey, arg1.anchorIndex)
            var3 = captureViewport(scrollOffset, keyIndex)
        end,
        snapshotOffset = function(arg1)
            if arg1.anchorKey ~= nil then
                local keyIndex = findKeyIndex(arg1.anchorKey, arg1.anchorIndex)
                if keyIndex ~= nil then
                    return viewport.placedItemLayout(keyIndex).startOffset + arg1.offsetWithinItem
                end
            end
            return arg1.fallbackScrollOffset
        end,
        preserve = function(arg1, callback)
            local dataSourceChange, var5, bool4

            if FFlagViewRecyclerReact084 then
                dataSourceChange = arg1.dataSourceChange
                var5 = followedEdge(var2.autoScrollOnChange)

                if dataSourceChange == nil then
                    bool4 = false
                else
                    bool4 = not bool1

                    if bool4 then
                        if var5 == nil then
                            bool4 = false
                        else
                            bool4 = distanceFrom(var5) <= followThreshold()
                        end
                    end
                end
            elseif FFlagViewRecyclerReact08 then
                dataSourceChange = arg1.dataSourceChange
                var5 = followedEdge(var2.autoScrollOnChange)

                if dataSourceChange == nil or var5 == nil then
                    bool4 = false
                else
                    bool4 = distanceFrom(var5) <= followThreshold()
                end
            else
                dataSourceChange = nil
                bool4 = nil
                var5 = nil
            end

            if (if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then dataSourceChange else arg1.dataSourceChange) ~= nil then
                prepareDataChange(
                    if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then dataSourceChange else arg1.dataSourceChange,
                    (captureEvidence())
                )
            end
            callback()

            if FFlagViewRecyclerReact084 then
                if dataSourceChange ~= nil and not (holdsItemTarget() or opensAtInitialEdge()) then
                    if bool4 then
                        hold(var5)
                    elseif not bool2 then
                        hold(nil)
                    end
                end
                local var6 = resolve(arg1)
                if var6 == nil or not (edgeHolds() or opensAtInitialEdge()) then
                    return var6
                end

                setViewport((viewport.getScrollOffset()))
                return nil
            end

            if not FFlagViewRecyclerReact08 then
                return (resolve(arg1))
            end

            if dataSourceChange ~= nil and not (holdsItemTarget() or opensAtInitialEdge()) then
                if bool4 then
                    hold(var5)
                elseif not bool2 then
                    hold(nil)
                end
            end
            local var6 = resolve(arg1)
            if var6 == nil or not (edgeHolds() or opensAtInitialEdge()) then
                return var6
            end

            setViewport((viewport.getScrollOffset()))
            return nil
        end,
        settle = FFlagViewRecyclerReact084 and function(arg1, callback)
            if bool3 and hasItems() and isLaidOut() then
                bool3 = false

                local initialScrollAlignment = var2.initialScrollAlignment
                if initialScrollAlignment ~= nil then
                    hold(initialScrollAlignment)
                    callback(edgeOffset(initialScrollAlignment))
                    return
                end
            end
            local var5 = var4
            if arg1.dataChange ~= nil then
                if var5 ~= nil and edgeHolds() then
                    callback(edgeOffset(var5))
                end
                return
            end
            local var6 = isLaidOut()
            local var7 = if arg1.contentLengthChanged and var5 ~= nil and edgeHolds() then edgeOffset(var5) else nil
            local var8 = if arg1.replaced then 0 else var7

            if arg1.viewportChanged then
                local keptDistanceFromEnd = arg1.keptDistanceFromEnd
                if var6 and var5 ~= nil and edgeHolds() then
                    var8 = edgeOffset(var5)
                elseif keptDistanceFromEnd ~= nil and not holdsItemTarget() then
                    var8 = viewport.getContentLength() - viewport.getLength() - keptDistanceFromEnd
                end
            end
            if var8 ~= nil then
                callback(var8)
            end
            if var6 and not bool1 and (arg1.replaced or arg1.viewportChanged or arg1.scrollMoved) then
                observe()
            end
        end or FFlagViewRecyclerReact08 and function(arg1, callback)
            if bool3 and hasItems() and isLaidOut() then
                bool3 = false

                local initialScrollAlignment = var2.initialScrollAlignment
                if initialScrollAlignment ~= nil then
                    hold(initialScrollAlignment)
                    callback(edgeOffset(initialScrollAlignment))
                    return
                end
            end
            local var5 = var4
            if arg1.dataChange ~= nil then
                if var5 ~= nil and edgeHolds() then
                    callback(edgeOffset(var5))
                end
                return
            end
            local var6 = isLaidOut()
            local var7 = if arg1.contentLengthChanged and var5 ~= nil and edgeHolds() then edgeOffset(var5) else nil
            local var8 = if arg1.replaced then 0 else var7

            if arg1.viewportChanged then
                local keptDistanceFromEnd = arg1.keptDistanceFromEnd
                if var6 and var5 ~= nil and edgeHolds() then
                    var8 = edgeOffset(var5)
                elseif keptDistanceFromEnd ~= nil and not holdsItemTarget() then
                    var8 = viewport.getContentLength() - viewport.getLength() - keptDistanceFromEnd
                end
            end
            if var8 ~= nil then
                callback(var8)
            end
            if var6 and (arg1.replaced or arg1.viewportChanged or arg1.scrollMoved) then
                observe()
            end
        end or nil,
        getAnchoredItem = function()
            local var5 = var3
            local bool4

            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                if var5 == nil then
                    bool4 = false
                else
                    bool4 = var5.kind == "itemTarget"
                end
            elseif var5 == nil then
                bool4 = true
            elseif var5.kind == "viewport" then
                bool4 = not tbl1.shouldPreserveUserPosition()
            else
                bool4 = false
            end

            if bool4 then
                local indexHint = if FFlagViewRecyclerReact084 then var5.indexHint elseif FFlagViewRecyclerReact08 then var5.indexHint else nil

                if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                    if indexHint == nil then
                        return nil
                    end

                    return (table.freeze({ index = indexHint, alignment = var5.alignment }))
                else
                    return nil
                end
            end

            local var6 = if FFlagViewRecyclerReact084 then var4 else nil

            if if FFlagViewRecyclerReact084 then viewport.getContentLength() <= viewport.getLength() else FFlagViewRecyclerReact08 then
                if FFlagViewRecyclerReact084 then
                    local contentAlignment = viewport.getContentAlignment()
                    if contentAlignment == ScrollAlignment.Start then
                        var6 = ScrollAlignment.Start
                    elseif contentAlignment == ScrollAlignment.End then
                        var6 = ScrollAlignment.End
                    end
                else
                    var6 = var4

                    if viewport.getContentLength() <= viewport.getLength() then
                        local contentAlignment = viewport.getContentAlignment()
                        if contentAlignment == ScrollAlignment.Start then
                            var6 = ScrollAlignment.Start
                        elseif contentAlignment == ScrollAlignment.End then
                            var6 = ScrollAlignment.End
                        end
                    end
                    if var6 ~= nil then
                        local var7 = tbl1.getItemSequence().getItemCount()
                        if var7 == 0 then
                            return nil
                        end
                        return table.freeze({ index = if var6 == ScrollAlignment.Start then 1 else var7, alignment = var6 })
                    end

                    if var5 == nil or not var2.preserveScrollPositionOnChange then
                        return nil
                    end
                end
            end

            if FFlagViewRecyclerReact084 then
                if var6 ~= nil then
                    local var7 = tbl1.getItemSequence().getItemCount()
                    if var7 == 0 then
                        return nil
                    end
                    return table.freeze({ index = if var6 == ScrollAlignment.Start then 1 else var7, alignment = var6 })
                end

                if var5 == nil or not var2.preserveScrollPositionOnChange then
                    return nil
                end
            end
            local indexHint = var5.indexHint

            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                if indexHint == nil then
                    return nil
                end

                return (table.freeze({ index = indexHint, alignment = ScrollAlignment.Start }))
            else
                if indexHint == nil then
                    return nil
                end
                return table.freeze(
                    {
                        index = indexHint,
                        alignment = if var5.kind == "itemTarget" then var5.alignment else ScrollAlignment.Start
                    }
                )
            end
        end,
        dataSourceReplaced = FFlagViewRecyclerReact084 and function()
            var3 = nil
            var4 = nil
            bool2 = false
            bool3 = true
        end or FFlagViewRecyclerReact08 and function()
            var3 = nil
            var4 = nil
            bool2 = false
            bool3 = true
        end or nil,
        reset = function()
            var3 = nil
        end,
        allowsPolicyOffset = if FFlagViewRecyclerReact084 then nil else not FFlagViewRecyclerReact08 and function(): boolean
            return var3 == nil or var3.kind == "viewport"
        end or nil
    }
end

return createScrollAnchor
