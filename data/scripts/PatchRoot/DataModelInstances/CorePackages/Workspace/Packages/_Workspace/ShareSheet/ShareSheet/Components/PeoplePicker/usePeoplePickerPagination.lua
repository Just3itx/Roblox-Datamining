-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)

local _Types = require(ShareSheet.Types)
local ShareSheetConstants = require(ShareSheet.ShareSheetConstants)

local var1 = ShareSheetConstants.FIntShareSheetPeoplePickerLoadMoreThresholdWindowHundredthsPercent / 10000

local function isViewportNearEnd(num1: number, num2: number, num3: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (num2 <= 0) and num1 + num2 >= num3 - num2 * var1
end

local function isViewportUnderfilled(viewportLength: number, contentLength: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return viewportLength > 0 and contentLength <= viewportLength
end

local function usePeoplePickerPagination(tbl1)
    local isPeoplePickerDisplayed = tbl1.isPeoplePickerDisplayed
    local listResult = tbl1.listResult
    local isFetchingNextPage = listResult.isFetchingNextPage
    local bool1 = listResult.nextPageToken ~= nil
    local isLoading = tbl1.isEligibilityLoading or isFetchingNextPage
    local nextPageToken = not isLoading
        and bool1
        and tbl1.conversationCount < ShareSheetConstants.FIntShareSheetPeoplePickerMaxConversations
        and listResult.nextPageToken
        or ""

    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local var5 = React.useCallback(function()
        if nextPageToken == "" or var3.current == nextPageToken then
            return
        end
        var3.current = nextPageToken
        tbl1.loadMore(nextPageToken)
    end, { nextPageToken, tbl1.loadMore })

    local var6 = React.useRef({ contentLength = nil, scrollOffset = 0, viewportLength = nil })

    local endReachedThreshold, var8 = React.useState(nil)
    local var9 = React.useCallback(function()
        local current = var4.current

        if current then
            return isViewportNearEnd(current.CanvasPosition.Y, current.AbsoluteWindowSize.Y, current.AbsoluteCanvasSize.Y)
        end

        local current2 = var6.current
        if current2.viewportLength == nil or current2.contentLength == nil then
            return false
        end
        return isViewportNearEnd(current2.scrollOffset, current2.viewportLength, current2.contentLength)
    end, {})
    local var10 = React.useCallback(function()
        local current = var6.current

        if isPeoplePickerDisplayed
            and current.viewportLength ~= nil
            and current.contentLength ~= nil
            and isViewportUnderfilled(current.viewportLength, current.contentLength)
        then
            var5()
        end
    end, { isPeoplePickerDisplayed, var5 })
    local onContentLengthChanged = React.useCallback(function(contentLength: number)
        var6.current.contentLength = contentLength
        var10()
    end, { var10 })
    local onScrollOffsetChanged = React.useCallback(function(scrollOffset: number)
        var6.current.scrollOffset = scrollOffset
        if not isPeoplePickerDisplayed then
            return
        end
        if not var9() then
            var3.current = nil
        end
    end, { isPeoplePickerDisplayed, var9 })
    local onViewportChanged = React.useCallback(function(vector2: Vector2)
        var6.current.viewportLength = vector2.Y
        var8(vector2.Y * var1)
        var10()
    end, { var10 })
    local scrollingFrameRef = React.useCallback(function(current)
        var4.current = current
    end, {})

    React.useEffect(function()
        if not isPeoplePickerDisplayed then
            var3.current = nil
            return
        end

        local bool2 = false
        task.defer(function()
            if not bool2 then
                var10()
            end
        end)
        return function()
            bool2 = true
        end
    end, { isPeoplePickerDisplayed, var10 })

    return {
        isLoading = isLoading,
        paginationProps = {
            endReachedThreshold = endReachedThreshold,
            scrollingFrameRef = scrollingFrameRef,
            onContentLengthChanged = onContentLengthChanged,
            onEndReached = if isPeoplePickerDisplayed then if nextPageToken == "" then nil else var5 else nil,
            onScrollOffsetChanged = onScrollOffsetChanged,
            onViewportChanged = onViewportChanged
        }
    }
end

return usePeoplePickerPagination
