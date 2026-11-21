-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFilters = script:FindFirstAncestor("GameFilters")

local GameFiltersParent = GameFilters.Parent
local _DiscoveryTypes = require(GameFiltersParent.DiscoveryTypes)
local Foundation = require(GameFiltersParent.Foundation)
local React = require(GameFiltersParent.React)

local useDispatch = require(GameFiltersParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useTokens = Foundation.Hooks.useTokens

local FilterClickButtonName = require(GameFilters.Analytics.FilterClickButtonName)
local FilterMenuActionBar = require(GameFilters.Components.Menu.FilterMenuActionBar)
local FilterMenuHeader = require(GameFilters.Components.Menu.FilterMenuHeader)
local FilterMenuOptions = require(GameFilters.Components.Menu.FilterMenuOptions)
local getOptionContextTag = require(GameFilters.Analytics.getOptionContextTag)

local FFlagLuaAppChartsFilterOptionTextTag = require(GameFiltersParent.SharedFlags).FFlagLuaAppChartsFilterOptionTextTag

local var1 = if FFlagLuaAppChartsFilterOptionTextTag then nil else 10000

local function applyTokenScaling(num1: number, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 * arg1.Config.UI.Scale
end

local function FilterMenuDropdown(arg1)
    local var2 = useTokens()
    local var3 = useDispatch()
    local x = applyTokenScaling(260, var2)
    local yOffset = applyTokenScaling(84, var2)
    local selectedOptionId, onSelectedOptionChanged = React.useState(arg1.filter.selectedOptionId)

    local scrim = var2.Color.Common.Scrim
    local surface100 = var2.Color.Surface.Surface_100
    local border = var2.Color.ActionStandard.Border
    local var6, var7

    if arg1.openPosition then
        var6 = UDim2.fromOffset(arg1.openPosition.X, arg1.openPosition.Y)
        var7 = Vector2.new(0, 0)
    else
        var6 = UDim2.fromScale(0.5, 0.5)
        var7 = Vector2.new(0.5, 0.5)
    end

    local var8, var9 = React.useBinding(Vector2.new(0, 0))
    local var10, onHeightChanged = React.useBinding(0)
    local var12 = nil
    local var13 = nil
    local var14 = nil
    local var15 = nil
    local var16 = nil
    if FFlagLuaAppChartsFilterOptionTextTag then
        local var17
        var14, var17 = React.useBinding(0)
        var15 = var17
        var16 = React.useCallback(function(arg2)
            var15(arg2.AbsoluteCanvasSize.Y)
        end, {})
    else
        var12, var13 = React.useBinding(Vector2.new(var1, 0))
    end

    local maxSize = var8:map(function(vector2: Vector2): Vector2
        local x2, y

        if arg1.openPosition then
            x2 = math.max(vector2.X - arg1.openPosition.X - 24, x)
            y = math.max(vector2.Y - arg1.openPosition.Y - 24, 0)
        else
            x2 = vector2.X - 48
            y = vector2.Y - 48
        end

        return Vector2.new(x2, y)
    end)

    local var18 = if FFlagLuaAppChartsFilterOptionTextTag then nil else maxSize:map(function(vector2: Vector2)
        return vector2.X
    end)

    local joinBindings = React.joinBindings

    if FFlagLuaAppChartsFilterOptionTextTag then
        var12 = var14
    end

    local tbl1 = { var10, var12 }

    local var19 = joinBindings(tbl1):map(function(tbl2): UDim2
        local var19 = tbl2[1]
        if FFlagLuaAppChartsFilterOptionTextTag then
            local var20 = tbl2[2]

            return UDim2.fromOffset(0, var19 + var20 + yOffset)
        end
        local var20 = tbl2[2]

        return UDim2.fromOffset(var20.X, var19 + var20.Y + yOffset)
    end)

    local var20 = var10:map(function(num1: number): UDim2
        return UDim2.new(if FFlagLuaAppChartsFilterOptionTextTag then 0 else 1, 0, 1, -num1 - yOffset)
    end)

    local onCloseButtonActivated = React.useCallback(function()
        var3(arg1.closeCentralOverlayThunk())
        arg1.onFilterMenuClosed()
        arg1.sendFilterClick(
            FilterClickButtonName.CloseDropdown,
            arg1.filter.selectedOptionId,
            selectedOptionId,
            if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(arg1.filter, arg1.filter.selectedOptionId) else nil,
            if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(arg1.filter, selectedOptionId) else nil,
            true
        )
    end, {
        arg1.filter,
        selectedOptionId,
        arg1.closeCentralOverlayThunk,
        arg1.onFilterMenuClosed,
        arg1.sendFilterClick
    })

    local applyEnabled = selectedOptionId ~= arg1.filter.selectedOptionId

    local onApply = React.useCallback(function()
        arg1.onFilterApplied(arg1.filter.filterType, selectedOptionId)
        var3(arg1.closeCentralOverlayThunk())
        arg1.onFilterMenuClosed()
        arg1.sendFilterClick(
            FilterClickButtonName.Apply,
            selectedOptionId,
            arg1.filter.selectedOptionId,
            if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(arg1.filter, selectedOptionId) else nil,
            if FFlagLuaAppChartsFilterOptionTextTag then getOptionContextTag(arg1.filter, arg1.filter.selectedOptionId) else nil,
            true
        )
    end, {
        arg1.filter,
        selectedOptionId,
        arg1.onFilterApplied,
        arg1.closeCentralOverlayThunk,
        arg1.onFilterMenuClosed,
        arg1.sendFilterClick
    })

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        BackgroundColor3 = nil,
        BackgroundColor3 = nil,
        BackgroundColor3 = scrim.Color3,
        BackgroundTransparency = scrim.Transparency,
        Size = UDim2.fromScale(1, 1),
        ClipsDescendants = false,
        Text = "",
        AutoButtonColor = false,
        [React.Event.Activated] = onCloseButtonActivated
    }

    tbl2[React.Change.AbsoluteSize] = function(arg2)
        var9(arg2.AbsoluteSize)
    end
    tbl2.Selectable = false
    local tbl3 = { Dropdown = 0 }
    local createElement2 = React.createElement
    local str2 = "TextButton"
    local tbl4 = {
        BackgroundColor3 = surface100.Color3,
        BackgroundTransparency = surface100.Transparency,
        BorderColor3 = border.Color3,
        ClipsDescendants = true,
        Text = "",
        AutoButtonColor = false,
        Position = var6,
        AnchorPoint = var7,
        Size = var19,
        AutomaticSize = if FFlagLuaAppChartsFilterOptionTextTag then Enum.AutomaticSize.X else nil,
        Selectable = false
    }
    local tbl5 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var2.Radius.Medium) }),
        SizeConstraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(x, 0), MaxSize = maxSize }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalFlex = if FFlagLuaAppChartsFilterOptionTextTag then Enum.UIFlexAlignment.Fill else nil
        }),
        Header = React.createElement(FilterMenuHeader, {
            LayoutOrder = 1,
            title = arg1.filter.filterDisplayName,
            onCloseButtonActivated = onCloseButtonActivated,
            onHeightChanged = onHeightChanged
        }),
        Options = 0,
        ActionBar = 0
    }
    local createElement3 = React.createElement
    local var23 = FilterMenuOptions
    local tbl6 = {
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

    tbl6.containerMaxWidthBinding = var18

    tbl6.options = arg1.filter.filterOptions
    tbl6.selectedOptionId = selectedOptionId
    tbl6.onSelectedOptionChanged = onSelectedOptionChanged
    if FFlagLuaAppChartsFilterOptionTextTag then
        var13 = var16
    end

    tbl6.onCanvasSizeChanged = var13
    tbl5.Options = createElement3(var23, tbl6)

    tbl5.ActionBar = React.createElement(FilterMenuActionBar, {
        LayoutOrder = 3,
        Size = UDim2.new(if FFlagLuaAppChartsFilterOptionTextTag then 0 else 1, 0, 0, yOffset),
        applyEnabled = applyEnabled,
        onApply = onApply
    })
    tbl3.Dropdown = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return FilterMenuDropdown
