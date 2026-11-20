-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local Foundation = require(AppPageShellParent.Foundation)
local React = require(AppPageShellParent.React)
local Responsive = require(AppPageShellParent.Responsive)
local Signals = require(AppPageShellParent.Signals)

local View = Foundation.View
local useDeviceInsets = Responsive.useDeviceInsets

local PageConstants = require(AppPageShell.PageConstants)
local PageContext = require(AppPageShell.PageContext)
local PageStickyHeader = require(AppPageShell.PageStickyHeader)
local _PageTypes = require(AppPageShell.PageTypes)
local PageWholeContent = require(AppPageShell.PageWholeContent)
local PullToRefreshSpinner = require(AppPageShell.PullToRefreshSpinner)
local createFeedContextAdapter = require(AppPageShell.createFeedContextAdapter)
local createPageScrollStore = require(AppPageShell.createPageScrollStore)
local resolveCompositionTags = require(AppPageShell.resolveCompositionTags)
local computeStickyOffset = require(AppPageShell.computeStickyOffset)

local SharedFlags = require(AppPageShellParent.SharedFlags)
local FFlagSduiFeedScrollBarFixes = SharedFlags.FFlagSduiFeedScrollBarFixes
local FFlagAppPageShellScrollTelemetry = SharedFlags.FFlagAppPageShellScrollTelemetry

local PageContentMode = PageConstants.PageContentMode

local var1 = table.freeze({ contentMode = PageContentMode.Scroll, content = table.freeze({}) })

local function buildTag(str1: string, str2: string?): string -- Luacid: unused: defined but never referenced
    if str2 then
        return `{str1} {str2}`
    end

    return str1
end

return React.memo(React.forwardRef(function(tbl1, ref) -- name: Page
    local var2 = tbl1.contentConfig or var1
    local contentMode = var2.contentMode
    local onScrollToEnd = tbl1.onScrollToEnd
    local onScrollToEndThreshold = tbl1.onScrollToEndThreshold
    local composition = tbl1.composition
    local chrome = tbl1.chrome
    local stickyHeaderSlot = tbl1.stickyHeaderSlot

    local offset = if chrome then chrome.height else 0
    local chromeHeight = if chrome then chrome.scrollAwayHeight or chrome.height else 0
    local liveHeightBinding = if chrome then chrome.liveHeightBinding else nil
    local var4 = nil
    if FFlagSduiFeedScrollBarFixes then
        local top = useDeviceInsets().top
        var4 = React.useMemo(function()
            if liveHeightBinding == nil or offset <= 0 then
                return nil
            end
            return liveHeightBinding:map(function(num1: number): number
                return math.clamp(-computeStickyOffset(num1, chromeHeight, top), 0, offset)
            end)
        end, {
            liveHeightBinding,
            offset,
            chromeHeight,
            top
        })
    end

    local var5 = React.useRef(onScrollToEnd)
    var5.current = onScrollToEnd

    local scrollPerformanceIntervalName = tbl1.scrollPerformanceIntervalName

    local scrollStore = React.useMemo(function()
        return createPageScrollStore(if FFlagAppPageShellScrollTelemetry then scrollPerformanceIntervalName else nil)
    end, {})

    local scrollingFrameRef = React.useRef(nil)

    local var8 = React.useMemo(function()
        return createFeedContextAdapter(scrollStore, scrollingFrameRef)
    end, { scrollStore, scrollingFrameRef })

    React.useEffect(function()
        return function()
            var8.destroy()
        end
    end, { var8 })

    React.useEffect(function()
        scrollStore.setEndReachedThreshold(onScrollToEndThreshold)
    end, { scrollStore, onScrollToEndThreshold })

    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            if scrollStore.getIsEndReached(arg1) and var5.current ~= nil then
                var5.current()
            end
        end)
    end, { scrollStore })

    local padding = React.useMemo(function()
        if offset <= 0 then
            return nil
        elseif FFlagSduiFeedScrollBarFixes and var4 ~= nil then
            return table.freeze({
                top = var4:map(function(num1: number): UDim
                    return UDim.new(0, offset - num1)
                end)
            })
        end
        return table.freeze({ top = UDim.new(0, offset) })
    end, { offset, var4 })

    local value = React.useMemo(function()
        return {
            scrollViewPositionChangedSignal = var8.scrollViewPositionChangedSignal,
            verticalScrollingFrameRef = var8.verticalScrollingFrameRef,
            scrollStore = scrollStore,
            contentMode = contentMode
        }
    end, { scrollStore, var8, contentMode })

    local var11 = React.useMemo(function()
        return resolveCompositionTags(composition)
    end, { composition })

    local content = var2.content
    local element = React.createElement(PageWholeContent, {
        scrollStore = scrollStore,
        scrollingFrameRef = scrollingFrameRef,
        slots = content.contentSlot,
        contentTopPadding = tbl1.contentTopPadding,
        contentBottomPadding = tbl1.contentBottomPadding,
        chromeDisplacement = if FFlagSduiFeedScrollBarFixes then var4 else nil,
        tag = var11.body,
        containerTag = if FFlagSduiFeedScrollBarFixes then nil else "fill size-full-0",
        size = if FFlagSduiFeedScrollBarFixes then UDim2.new(1, 0, 0, 0) else nil,
        flexMode = if FFlagSduiFeedScrollBarFixes then Enum.UIFlexMode.Fill else nil,
        layoutOrder = 3,
        zIndex = 1
    })

    local onRefresh = tbl1.onRefresh
    local refresh = if onRefresh == nil then nil else React.createElement(
        PullToRefreshSpinner,
        {
            onRefresh = onRefresh,
            scrollingFrameRef = scrollingFrameRef,
            appEventName = tbl1.appEventName,
            LayoutOrder = 2
        }
    )
    local bool1 = not (stickyHeaderSlot == nil) and next(stickyHeaderSlot) ~= nil
    local createElement = React.createElement
    local provider = PageContext.Provider
    local tbl2 = { value = value }
    local tbl3 = { ChromeInset = 0 }

    local createElement2 = React.createElement
    local var12 = View
    local tbl4 = { tag = "col size-full", padding = padding }
    local tbl5 = { Root = 0 }
    local createElement3 = React.createElement
    local var13 = View
    local tbl6 = { tag = 0, ref = 0 }
    local root = var11.root
    tbl6.tag = if root then `col size-full {root}` else "col size-full"
    tbl6.ref = ref
    local tbl7 = { Sticky = 0, Refresh = 0, Content = 0 }
    local var14

    if bool1 then
        local createElement4 = React.createElement
        local var15 = PageStickyHeader
        local tbl8 = {
            slots = stickyHeaderSlot,
            chromeHeight = chromeHeight,
            liveChromeHeightBinding = if FFlagSduiFeedScrollBarFixes then nil else liveHeightBinding,
            backgroundStyle = tbl1.stickyBackgroundStyle,
            tag = 0,
            topPadding = 0
        }
        local header = var11.header
        tbl8.tag = if header then `col size-full-0 auto-y {header}` else "col size-full-0 auto-y"
        tbl8.topPadding = tbl1.stickyTopPadding
        var14 = createElement4(var15, tbl8)
    else
        var14 = nil
    end

    tbl7.Sticky = var14

    tbl7.Refresh = refresh

    tbl7.Content = element
    tbl5.Root = createElement3(var13, tbl6, tbl7)
    tbl3.ChromeInset = createElement2(var12, tbl4, tbl5)
    return createElement(provider, tbl2, tbl3)
end))
