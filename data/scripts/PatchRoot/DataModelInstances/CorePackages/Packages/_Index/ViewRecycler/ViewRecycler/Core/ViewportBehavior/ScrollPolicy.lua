-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local AutoScroll = require(script.Parent.AutoScroll)
local AutoScrollTarget = require(ViewRecycler.Core.Enums.AutoScrollTarget)
local PaginationEdges = require(script.Parent.PaginationEdges)
local ReachedThreshold = require(script.Parent.ReachedThreshold)
local ScrollAlignment = require(ViewRecycler.Core.Enums.ScrollAlignment)
local _Types = require(ViewRecycler.Core.Types)
local InitialScrollPosition = require(script.Parent.InitialScrollPosition)

local function validate(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    AutoScroll.validate(tbl1.autoScrollOnChange)
    if tbl1.autoScrollThreshold ~= nil then
        ReachedThreshold.validate(tbl1.autoScrollThreshold, "Virtualizer: autoScrollThreshold")
    end
    if tbl1.startReachedThreshold ~= nil then
        ReachedThreshold.validate(tbl1.startReachedThreshold, "Virtualizer: startReachedThreshold")
    end
end

local function createScrollPolicy(tbl1)
    validate(tbl1)
    local tbl2 = tbl1
    local var1 = InitialScrollPosition()
    local var2 = AutoScroll.create()
    local var3 = PaginationEdges.create()

    local function settleInitialEnd(num1: number?, itemCount: number): number? -- Luacid: Inlined by compiler; 3 call sites recovered
        if num1 ~= nil and itemCount > 0 and tbl2.initialScrollAlignment == ScrollAlignment.End then
            var2.settleAt(AutoScrollTarget.End)
        end
        return num1
    end

    local function followThreshold(viewportLength: number) -- Luacid: Inlined by compiler; 1 call site recovered
        return ReachedThreshold.resolve(tbl2.autoScrollThreshold, viewportLength, 1)
    end

    return {
        configure = function(arg1)
            validate(arg1)
            tbl2 = arg1
        end,
        contentLengthChanged = function(arg1)
            return var2.getSettleOffset(arg1.contentLength, arg1.viewportLength)
        end,
        dataChanged = function(arg1, arg2)
            local var4 = var1.onDataSourceChange(arg1.itemCount, tbl2.initialScrollAlignment, arg1.getScrollOffsetForItem)

            local var5 = var2.onDataSourceChanged(AutoScroll.resolveTarget(tbl2.autoScrollOnChange, arg2, followThreshold(arg2.viewportLength)))

            if var5 ~= false then
                return AutoScroll.getTargetOffset(var5, arg1.scrollState.contentLength, arg1.scrollState.viewportLength)
            end

            return settleInitialEnd(var4, arg1.itemCount)
        end,
        dataReplaced = function(arg1): number?
            return settleInitialEnd(
                var1.onDataSourceReplaced(arg1.itemCount, tbl2.initialScrollAlignment, arg1.getScrollOffsetForItem),
                arg1.itemCount
            )
        end,
        viewportChanged = function(arg1)
            local scrollState = arg1.scrollState
            if arg1.itemCount ~= 0 and not (scrollState.contentLength > 0) then
                return nil
            end

            local var4 = var1.onViewportChanged(arg1.itemCount, tbl2.initialScrollAlignment, arg1.getScrollOffsetForItem)
            settleInitialEnd(var4, arg1.itemCount)

            if var4 ~= nil then
                return var4
            end

            return var2.getSettleOffset(scrollState.contentLength, scrollState.viewportLength)
        end,
        observe = function(arg1)
            var2.onScrollOffsetChanged(arg1, followThreshold(arg1.viewportLength), AutoScroll.followedEdge(tbl2.autoScrollOnChange))
        end,
        pin = var2.pin,
        checkEdges = function(arg1, arg2, rearmAfterStructureChange)
            if not (tbl2.startReachedEnabled or tbl2.endReachedEnabled) then
                return false, false
            end
            local viewportLength = arg1.viewportLength
            if viewportLength <= 0 or arg2 > 0 and arg1.contentLength == 0 then
                return false, false
            end
            local var4 = var3.check({
                scrollOffset = arg1.scrollOffset,
                viewportLength = viewportLength,
                contentLength = arg1.contentLength,
                startThreshold = ReachedThreshold.resolve(tbl2.startReachedThreshold, viewportLength, 0),
                atEnd = arg1.atEnd,
                canReachStart = tbl2.startReachedEnabled,
                canReachEnd = tbl2.endReachedEnabled,
                rearmAfterStructureChange = rearmAfterStructureChange
            })
            return var4.startReached, var4.endReached
        end,
        reachesEdges = function()
            return tbl2.startReachedEnabled or tbl2.endReachedEnabled
        end
    }
end

return createScrollPolicy
