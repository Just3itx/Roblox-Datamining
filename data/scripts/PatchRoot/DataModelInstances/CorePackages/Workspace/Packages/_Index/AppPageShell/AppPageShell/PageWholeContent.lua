-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local Foundation = require(AppPageShellParent.Foundation)
local React = require(AppPageShellParent.React)
local useAnimateScrollViewToSelection = require(AppPageShellParent.AppBlox).useAnimateScrollViewToSelection
local useLastInputMode = require(AppPageShellParent.FocusNavigationUtils).useLastInputMode
local CollectionLayoutStoreProvider = require(AppPageShellParent.CollectionViews).CollectionLayoutStoreProvider

local _PageTypes = require(AppPageShell.PageTypes)
local _createPageScrollStore = require(AppPageShell.createPageScrollStore)

local ScrollView = Foundation.ScrollView
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local SharedFlags = require(AppPageShellParent.SharedFlags)
local FFlagSduiFeedScrollBarFixes = SharedFlags.FFlagSduiFeedScrollBarFixes
local FFlagSduiPageCanvasCollectionLayout = SharedFlags.FFlagSduiPageCanvasCollectionLayout
local isSubjectToDesktopPolicies = SharedFlags.isSubjectToDesktopPolicies

local selection = table.freeze({ Selectable = false })

return React.memo(function(tbl1) -- name: PageWholeContent
    local scrollStore = tbl1.scrollStore
    local slots = tbl1.slots
    local contentTopPadding = tbl1.contentTopPadding
    local contentBottomPadding = tbl1.contentBottomPadding
    local chromeDisplacement = if FFlagSduiFeedScrollBarFixes then tbl1.chromeDisplacement else nil
    local scrollingFrameRef = tbl1.scrollingFrameRef
    local var2, var3

    if FFlagSduiPageCanvasCollectionLayout then
        var2, var3 = React.useState(nil)
    else
        var2 = nil
        var3 = nil
    end

    useAnimateScrollViewToSelection(scrollingFrameRef, 0.4)
    local bool1 = useLastInputMode() ~= "Cursor"
    local var4 = nil
    local var5 = nil
    local var6 = nil
    if FFlagSduiFeedScrollBarFixes then
        var4 = useTokens()
        if isSubjectToDesktopPolicies() then
            var5 = 4
        else
            var5 = 0
        end
    else
        var6 = React.useMemo(function()
            return table.freeze({
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(1, 0, 0, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ScrollingEnabled = not bool1
            })
        end, { bool1 })
    end

    local var7 = nil
    local var8

    if FFlagSduiFeedScrollBarFixes then
        var8 = nil
    else
        var7 = React.useCallback(function(arg1)
            scrollStore.setViewportHeight(arg1.AbsoluteWindowSize.Y)
            scrollStore.setContentHeight(arg1.AbsoluteCanvasSize.Y)
        end, { scrollStore })

        var8 = React.useCallback(function(arg1)
            if var7 ~= nil then
                var7(arg1)
            end
            scrollStore.setCanvasPosition(arg1.CanvasPosition.Y)
        end, { scrollStore, var7 })
    end

    local var9 = React.useCallback(function(current)
        scrollStore.setScrollingFrame(current)
        scrollingFrameRef.current = current
    end, { scrollStore, scrollingFrameRef })

    local var10 = React.useMemo(function()
        if slots == nil then
            return nil
        end
        local result = {}
        for k, slot in slots do
            result[`Content{k}`] = slot
        end
        return result
    end, { slots })

    local var11 = if FFlagSduiFeedScrollBarFixes then React.useMemo(function()
        if chromeDisplacement == nil then
            return UDim2.new(1, 0, 0, contentTopPadding or 0)
        end
        return chromeDisplacement:map(function(num1: number): UDim2
            return UDim2.new(1, 0, 0, (contentTopPadding or 0) + num1)
        end)
    end, { chromeDisplacement, contentTopPadding }) else nil

    local tbl2 = { TopSpacer = 0, Content = 0, BottomSpacer = 0 }
    local var12

    if contentTopPadding and contentTopPadding > 0 or chromeDisplacement ~= nil then
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl3 = { Size = 0, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1 }
        if not FFlagSduiFeedScrollBarFixes then
            var11 = UDim2.new(1, 0, 0, contentTopPadding)
        end

        tbl3.Size = var11
        var12 = createElement(str1, tbl3)
    else
        var12 = nil
    end

    tbl2.TopSpacer = var12

    tbl2.Content = React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 2 }, var10)
    local bottomSpacer = if contentBottomPadding and contentBottomPadding > 0 then React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, contentBottomPadding),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 3
        }
    ) else nil
    tbl2.BottomSpacer = bottomSpacer

    if FFlagSduiPageCanvasCollectionLayout then
        tbl2 = React.createElement(CollectionLayoutStoreProvider, { container = var2 }, tbl2)
    end

    local tbl3 = { Canvas = 0 }

    local createElement = React.createElement
    local var13 = View
    local tbl4 = {
        tag = `col size-full-0 auto-y {tbl1.tag or ""}`,
        ref = 0
    }

    if not FFlagSduiPageCanvasCollectionLayout then
        var3 = nil
    end

    tbl4.ref = var3
    tbl3.Canvas = createElement(var13, tbl4, tbl2)

    if not FFlagSduiFeedScrollBarFixes then
        return React.createElement(ScrollView, {
            scrollingFrameRef = var9,
            selection = selection,
            scroll = var6,
            onCanvasPositionChanged = var8,
            onAbsoluteCanvasSizeChanged = var7,
            onAbsoluteWindowSizeChanged = var7,
            tag = tbl1.containerTag or "size-full",
            LayoutOrder = tbl1.layoutOrder,
            ZIndex = tbl1.zIndex,
            ClipsDescendants = false
        }, tbl3)
    end

    return React.createElement("ScrollingFrame", {
        Size = tbl1.size or UDim2.fromScale(1, 1),
        LayoutOrder = tbl1.layoutOrder,
        ZIndex = tbl1.zIndex,
        AutoLocalize = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(1, 0, 0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollingEnabled = not bool1,
        Selectable = false,
        ClipsDescendants = true,
        ScrollBarThickness = var5,
        ScrollBarImageColor3 = var4.Color.Shift.Shift_400.Color3,
        ScrollBarImageTransparency = 0,
        ElasticBehavior = Enum.ElasticBehavior.Always,
        [React.Change.CanvasPosition] = scrollStore.setCanvasPositionFromScrollingFrame,
        [React.Change.AbsoluteCanvasSize] = scrollStore.setExtentsFromScrollingFrame,
        [React.Change.AbsoluteWindowSize] = scrollStore.setExtentsFromScrollingFrame,
        ref = var9
    }, {
        FlexItem = if tbl1.flexMode == nil then nil else React.createElement("UIFlexItem", { FlexMode = tbl1.flexMode }),
        Canvas = tbl3.Canvas
    })
end)
