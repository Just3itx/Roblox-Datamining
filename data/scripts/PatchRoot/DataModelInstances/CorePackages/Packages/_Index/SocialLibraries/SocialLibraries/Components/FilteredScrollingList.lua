-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

local SortedList = require(script.Parent.SortedList)
local CallbackInputBoxWithIcon = require(script.Parent.CallbackInputBoxWithIcon)

local var1 = Roact.Component:extend("FilteredScrollingList")
var1.defaultProps = {
    searchBoxCornerRadius = 0,
    searchBoxHeight = 48,
    searchBoxTopPadding = 0,
    searchBoxLeftPadding = 0,
    searchBoxRightPadding = 0,
    searchBoxBottomPadding = 0,
    searchBackgroundTransparency = 0,
    searchBackgroundColor3 = Color3.new(1, 0, 1),
    searchBoxBorderThickness = 0,
    searchIconCellWidth = 60,
    searchIconSize = 24,
    searchIconColor3 = Color3.new(1, 0, 1),
    searchIconTransparency = 0,
    searchIconImage = "rbxasset://textures/ui/LuaChat/icons/ic-search.png",
    searchInputTextFont = nil,
    searchInputTextColor3 = nil,
    searchInputTextSize = nil,
    searchInputTextTransparency = nil,
    searchPlaceholderTextTransparency = nil,
    searchPlaceholderTextColor3 = nil,
    searchPlaceholderText = nil,
    searchClearIconColor3 = nil,
    searchClearIcon = "rbxasset://textures/ui/LuaChat/icons/ic-close-white.png",
    searchDividerColor3 = Color3.new(1, 0, 1),
    searchDividerTransparency = 0,
    searchDividerHeight = 1,
    scrollBarImageTransparency = 0,
    scrollBarImageColor3 = Color3.new(1, 0, 1),
    entries = {},
    renderEntry = nil,
    entryHeight = 54,
    scrollTouchedBottomCallback = nil,
    filterPredicate = function(_, _): boolean
        return true
    end,
    sortComparator = function(_, _): boolean
        return true
    end
}

function var1.shouldUpdate(arg1, props, state)
    if state ~= arg1.state then
        return true
    end

    if props == arg1.props then
        return false
    end

    for k, prop in pairs(props) do
        if k == "extraProps" and not arg1.props.extraProps then
            return true
        end

        if arg1.props[k] ~= prop then
            return true
        end
    end

    for k, prop in pairs(arg1.props) do
        if k == "extraProps" then
            if not props.extraProps then
                return true
            end

            for k2, value in pairs(prop) do
                if props.extraProps[k2] ~= value then
                    return true
                end
            end
        elseif props[k] ~= prop then
            return true
        end
    end

    return false
end

function var1.init(arg1)
    arg1:setState({})
end

function var1.render(arg1)
    local filterPredicate = arg1.props.filterPredicate
    local filterText = arg1.state.filterText

    local entries = {}
    local num1 = 0
    for _, value in pairs(arg1.props.entries) do
        if filterPredicate(filterText, value) then
            num1 += 1
            table.insert(entries, value)
        end
    end

    local tbl2 = {
        sortedList = Roact.createElement(SortedList, {
            entries = entries,
            renderEntry = arg1.props.renderEntry,
            entryHeight = arg1.props.entryHeight,
            sortComparator = arg1.props.sortComparator
        })
    }

    local createElement = Roact.createElement
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl4 = {
        layout = Roact.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        dividerTop = Roact.createElement("Frame", {
            BackgroundColor3 = arg1.props.searchDividerColor3,
            BackgroundTransparency = arg1.props.searchDividerTransparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, arg1.props.searchDividerHeight),
            LayoutOrder = 1
        }),
        callbackBoxContainer = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(
                1,
                -arg1.props.searchBoxBorderThickness * 2,
                0,
                arg1.props.searchBoxHeight + arg1.props.searchBoxTopPadding + arg1.props.searchBoxBottomPadding
            ),
            LayoutOrder = 2
        }, {
            UIPadding = Roact.createElement("UIPadding", {
                PaddingBottom = UDim.new(0, arg1.props.searchBoxBottomPadding),
                PaddingLeft = UDim.new(0, arg1.props.searchBoxLeftPadding),
                PaddingRight = UDim.new(0, arg1.props.searchBoxRightPadding),
                PaddingTop = UDim.new(0, arg1.props.searchBoxTopPadding)
            }),
            callbackBox = Roact.createElement(CallbackInputBoxWithIcon, {
                backgroundTransparency = arg1.props.searchBackgroundTransparency,
                backgroundColor3 = arg1.props.searchBackgroundColor3,
                borderColor = arg1.props.searchBoxBorderColor,
                borderTransparency = arg1.props.searchBoxBorderTransparency,
                borderThickness = arg1.props.searchBoxBorderThickness,
                cornerRadius = arg1.props.searchBoxCornerRadius,
                iconCellWidth = arg1.props.searchIconCellWidth,
                iconSize = arg1.props.searchIconSize,
                iconColor3 = arg1.props.searchIconColor3,
                iconTransparency = arg1.props.searchIconTransparency,
                iconImage = arg1.props.searchIconImage,
                inputTextFont = arg1.props.searchInputTextFont,
                inputTextColor3 = arg1.props.searchInputTextColor3,
                inputTextSize = arg1.props.searchInputTextSize,
                inputTextTransparency = arg1.props.searchInputTextTransparency,
                placeholderTextTransparency = arg1.props.searchPlaceholderTextTransparency,
                placeholderTextColor3 = arg1.props.searchPlaceholderTextColor3,
                placeholderText = arg1.props.searchPlaceholderText,
                clearIconColor3 = arg1.props.searchClearIconColor3,
                clearIcon = arg1.props.searchClearIcon,
                textChangedCallback = function(filterText2)
                    arg1:setState({ filterText = filterText2 })
                end
            })
        }),
        dividerBottom = Roact.createElement("Frame", {
            BackgroundColor3 = arg1.props.searchDividerColor3,
            BackgroundTransparency = arg1.props.searchDividerTransparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, arg1.props.searchDividerHeight),
            LayoutOrder = 3
        }),
        entryList = 0
    }

    local createElement2 = Roact.createElement
    local tbl5 = {
        Size = UDim2.new(
            1,
            0,
            1,
            -arg1.props.searchBoxHeight - arg1.props.searchBoxTopPadding - arg1.props.searchBoxBottomPadding - arg1.props.searchDividerHeight * 2
        ),
        CanvasSize = UDim2.new(0, 0, 0, num1 * arg1.props.entryHeight),
        BackgroundTransparency = 1,
        ScrollBarThickness = 5,
        ElasticBehavior = Enum.ElasticBehavior.Always,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollBarImageTransparency = arg1.props.scrollBarImageTransparency,
        ScrollBarImageColor3 = arg1.props.scrollBarImageColor3,
        BottomImage = "rbxasset://textures/ui/LuaChat/9-slice/scroll-bar.png",
        MidImage = "rbxasset://textures/ui/LuaChat/9-slice/scroll-bar.png",
        TopImage = "rbxasset://textures/ui/LuaChat/9-slice/scroll-bar.png",
        LayoutOrder = 4
    }
    tbl5[Roact.Change.CanvasPosition] = function(arg2)
        local offset = arg2.CanvasSize.Y.Offset

        if not arg1.isTouchingBottom and offset <= arg2.CanvasPosition.Y + arg2.AbsoluteSize.Y then
            arg1.isTouchingBottom = true

            if arg1.props.scrollTouchedBottomCallback then
                arg1.props.scrollTouchedBottomCallback()
            end
        elseif arg2.CanvasPosition.Y + arg2.AbsoluteSize.Y < offset then
            arg1.isTouchingBottom = false
        end
    end

    tbl4.entryList = createElement2("ScrollingFrame", tbl5, tbl2)
    return createElement("Frame", tbl3, tbl4)
end

return var1
