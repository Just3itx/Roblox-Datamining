-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local GameFiltersParent = GameFilters.Parent
local AppCommonLib = require(GameFiltersParent.AppCommonLib)
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local PeekView = require(GameFiltersParent.PeekView)
local PeekView2 = PeekView.PeekView
local PeekViewState = PeekView.PeekViewState
local React = require(GameFiltersParent.React)
local Signal = AppCommonLib.Signal

local useNavigation = require(GameFiltersParent.Navigation).useNavigation
local useNavigationProps = require(GameFiltersParent.RobloxAppNavigation).useNavigationProps

local FilterClickButtonName = require(GameFilters.Analytics.FilterClickButtonName)
local FilterMenuActionBar = require(GameFilters.Components.Menu.FilterMenuActionBar)
local FilterMenuHeader = require(GameFilters.Components.Menu.FilterMenuHeader)
local FilterMenuOptions = require(GameFilters.Components.Menu.FilterMenuOptions)
local useTopBarHeightSelector = require(GameFilters.Components.Menu.useTopBarHeightSelector)
local getOptionContextTag = require(GameFilters.Analytics.getOptionContextTag)

local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag

local function FilterMenuPeekView()
    local var1 = useNavigationProps(function(_, arg1)
        return {
            filter = arg1.filter,
            onFilterApplied = arg1.onFilterApplied,
            onFilterMenuClosed = arg1.onFilterMenuClosed,
            sendFilterClick = arg1.sendFilterClick
        }
    end)

    local filter = var1.filter

    local var2, var3 = React.useState(filter.selectedOptionId)

    local var4 = React.useRef(false)

    local var5 = useNavigation()

    local useCallback = React.useCallback

    local function func1(arg1, _)
        if arg1 ~= PeekViewState.Closed and arg1 ~= PeekViewState.Hidden then
            return
        end

        var5.goBack()
        var1.onFilterMenuClosed()

        if not var4.current then
            var1.sendFilterClick(
                FilterClickButtonName.ClosePeekView,
                filter.selectedOptionId,
                var2,
                if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(filter, filter.selectedOptionId) else nil,
                if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(filter, var2) else nil,
                true
            )
        end
    end

    local selectedOptionId = if FFlagLuaAppChartsFilterOptionTextTag then nil else filter.selectedOptionId
    local onFilterMenuClosed = var1.onFilterMenuClosed
    local sendFilterClick = var1.sendFilterClick
    local var6 = if FFlagLuaAppChartsFilterOptionTextTag then filter else nil
    local viewStateChanged = useCallback(func1, { selectedOptionId, var2, var5, onFilterMenuClosed, sendFilterClick, var6 })

    local var8 = useTopBarHeightSelector()

    local var9, var10 = React.useBinding(Vector2.new(0, 0))
    local var11, onHeightChanged = React.useBinding(0)
    local var13 = nil
    local var14 = nil
    local var15 = nil
    local var16 = nil
    local var17 = nil
    if FFlagLuaAppChartsFilterOptionTextTag then
        local var18
        var15, var18 = React.useBinding(0)
        var16 = var18
        var17 = React.useCallback(function(arg1)
            var16(arg1.AbsoluteCanvasSize.Y)
        end, {})
    else
        var13, var14 = React.useBinding(Vector2.new(0, 0))
    end

    local var18 = if FFlagLuaAppChartsFilterOptionTextTag then nil else var9:map(function(vector2: Vector2)
        return vector2.X
    end)

    local joinBindings = React.joinBindings

    if FFlagLuaAppChartsFilterOptionTextTag then
        var13 = var15
    end

    local tbl1 = { var9, var11, var13 }

    local var19 = joinBindings(tbl1):map(function(tbl2): UDim2
        local y = tbl2[1].Y
        local yOffset = math.min(tbl2[2] + (if FFlagLuaAppChartsFilterOptionTextTag then tbl2[3] else tbl2[3].Y), y - 84 - 25 - var8)

        return UDim2.new(1, 0, 0, yOffset)
    end)

    local var20 = var11:map(function(num1: number): UDim2
        return UDim2.new(1, 0, 1, -num1)
    end)

    local contentFrameRef = React.useRef(nil)

    local var22 = React.useCallback(function(arg1)
        local current = contentFrameRef.current

        if current then
            local absoluteSizeY = arg1.AbsoluteSize.Y
            current.AutomaticSize = Enum.AutomaticSize.None
            current.Size = UDim2.new(1, 0, 0, absoluteSizeY)
        end
    end, {})

    local var23 = React.useRef(Signal.new())

    local onCloseButtonActivated = React.useCallback(function()
        var23.current:fire()
    end, {})

    local onSelectedOptionChanged = React.useCallback(function(str1: string)
        var3(str1)
    end, {})

    local applyEnabled = var2 ~= filter.selectedOptionId

    local useCallback2 = React.useCallback

    local function func2()
        var1.onFilterApplied(filter.filterType, var2)
        var4.current = true
        onCloseButtonActivated()
        var1.sendFilterClick(
            FilterClickButtonName.Apply,
            var2,
            filter.selectedOptionId,
            if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(filter, var2) else nil,
            if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(filter, filter.selectedOptionId) else nil,
            true
        )
    end

    local filterType = if FFlagLuaAppChartsFilterOptionTextTag then nil else filter.filterType
    local selectedOptionId2 = if FFlagLuaAppChartsFilterOptionTextTag then nil else filter.selectedOptionId
    local onFilterApplied = var1.onFilterApplied

    local sendFilterClick2 = var1.sendFilterClick
    local var26 = if FFlagLuaAppChartsFilterOptionTextTag then filter else nil
    local onApply = useCallback2(
        func2,
        {
            filterType,
            selectedOptionId2,
            var2,
            onFilterApplied,
            onCloseButtonActivated,
            sendFilterClick2,
            var26
        }
    )

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = false
    }

    tbl2[React.Change.AbsoluteSize] = function(arg1)
        var10(arg1.AbsoluteSize)
    end
    local tbl3 = { PeekView = 0 }
    local createElement2 = React.createElement
    local var28 = PeekView2
    local tbl4 = {
        briefViewContentHeight = UDim.new(0, 0),
        contentFrameRef = contentFrameRef,
        closeSignal = var23.current,
        hasScrim = true,
        mountAsFullView = true,
        returnToFullView = true,
        showDraggerInClosedState = false,
        thumbstickScrollEnabled = true,
        viewStateChanged = viewStateChanged,
        bottomDockedContainerHeight = 84,
        bottomDockedContainerContent = React.createElement(
            FilterMenuActionBar,
            {
                Size = UDim2.new(1, 0, 0, 84),
                applyEnabled = applyEnabled,
                onApply = onApply
            }
        )
    }
    local tbl5 = { Content = 0 }
    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl6 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = var19,
        [React.Change.AbsoluteSize] = var22
    }
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Header = React.createElement(FilterMenuHeader, {
            LayoutOrder = 1,
            title = filter.filterDisplayName,
            onCloseButtonActivated = onCloseButtonActivated,
            onHeightChanged = onHeightChanged
        }),
        Options = 0
    }
    local createElement4 = React.createElement
    local var29 = FilterMenuOptions
    local tbl8 = {
        LayoutOrder = 2,
        Size = var20,
        containerMaxWidthBinding = 0,
        options = 0,
        selectedOptionId = 0,
        onSelectedOptionChanged = 0,
        onCanvasSizeChanged = 0
    }

    if FFlagLuaAppChartsFilterOptionTextTag then
        var18 = nil
    end

    tbl8.containerMaxWidthBinding = var18

    tbl8.options = filter.filterOptions
    tbl8.selectedOptionId = var2
    tbl8.onSelectedOptionChanged = onSelectedOptionChanged
    if FFlagLuaAppChartsFilterOptionTextTag then
        var14 = var17
    end

    tbl8.onCanvasSizeChanged = var14
    tbl7.Options = createElement4(var29, tbl8)
    tbl5.Content = createElement3(str2, tbl6, tbl7)
    tbl3.PeekView = createElement2(var28, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return FilterMenuPeekView
