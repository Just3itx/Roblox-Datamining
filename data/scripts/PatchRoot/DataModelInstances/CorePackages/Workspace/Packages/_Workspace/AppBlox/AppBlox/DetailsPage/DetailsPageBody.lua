-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local ContentPosition = require(script.Parent.ContentPosition)
local validateDetailsPageComponentList = require(script.Parent.validateDetailsPageComponentList)

local getPlatformConfig = require(script.Parent.getPlatformConfig)
local DetailsPageTitleContent = require(script.Parent.DetailsPageTitleContent)

local Roact = require(AppBloxParent.Roact)
local t = require(AppBloxParent.t)

local var1 = Roact.PureComponent:extend("DetailsPageBody")

var1.validateProps = t.strictInterface({
    titleText = t.optional(t.string),
    subTitleText = t.optional(t.string),
    renderInfoContent = t.optional(t.callback),
    componentList = t.optional(validateDetailsPageComponentList),
    dualPanelBreakpoint = t.optional(t.number),
    sideMargin = t.optional(t.number),
    bodyClipsDescendants = t.optional(t.boolean),
    maxContentWidth = t.optional(t.number),
    showPageDetails = t.optional(t.boolean),
    deviceType = t.optional(t.string),
    bottomPadding = t.optional(t.number)
})

var1.defaultProps = { bodyClipsDescendants = true, showPageDetails = false }

function var1.init(arg1)
    arg1.state = { containerWidth = nil }
    arg1.containerFrameRef = Roact.createRef()

    arg1.mounted = false

    function arg1.onContainerSizeChange(arg2)
        if not arg1.mounted then
            return
        end

        arg1:setState(function(arg3, _): {containerWidth: any}?
            return if arg3.containerWidth == arg2.AbsoluteSize.x then nil else {
                containerWidth = arg2.AbsoluteSize.x
            }
        end)
    end
end

function var1.renderSinglePanel(arg1)
    local tbl1 = {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 24)
        }),
        UISizeConstraint = if arg1.props.maxContentWidth then Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(arg1.props.maxContentWidth, math.huge) }) else nil
    }

    for k, value in pairs(arg1.props.componentList) do
        local var2 = k .. "Container"
        tbl1[var2] = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = value.portraitLayoutOrder,
            ZIndex = value.portraitZIndex
        }, {
            [k] = value.renderComponent()
        })
    end

    return {
        Panel = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0),
            Size = UDim2.fromScale(1, 0),
            ClipsDescendants = false,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1
        }, tbl1)
    }
end

function var1.renderDualPanel(arg1)
    local offset = if arg1.state.containerWidth < 1920 then 48 else 96

    local tbl1 = {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 24)
        })
    }

    local tbl2 = {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 24)
        })
    }

    for k, value in pairs(arg1.props.componentList) do
        local tbl3 = if value.landscapePosition == ContentPosition.Right then tbl2 else tbl1
        local var2 = k .. "Container"
        tbl3[var2] = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = value.landscapeLayoutOrder
        }, {
            [k] = value.renderComponent()
        })
    end

    local leftPanel = Roact.createElement("Frame", {
        Size = UDim2.new(0.5, -offset / 2, 0, 0),
        ClipsDescendants = true,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 1
    }, tbl1)

    local rightPanel = Roact.createElement("Frame", {
        Size = UDim2.new(0.5, -offset / 2, 0, 0),
        ClipsDescendants = false,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 2
    }, tbl2)

    return {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, offset)
        }),
        LeftPanel = leftPanel,
        RightPanel = rightPanel
    }
end

function var1.renderBodyContent(arg1)
    local dualPanelBreakpoint = arg1.props.dualPanelBreakpoint or 1280

    if arg1.state.containerWidth and arg1.props.componentList then
        if arg1.state.containerWidth < dualPanelBreakpoint then
            return arg1:renderSinglePanel()
        end
        return arg1:renderDualPanel()
    end

    return {}
end

function var1.render(arg1)
    local platformConfig = getPlatformConfig(arg1.props.deviceType)
    local sideMargin = if arg1.props.sideMargin then arg1.props.sideMargin else platformConfig.sideMargin
    return Roact.createElement("Frame", {
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = arg1.props.bodyClipsDescendants,
        AutomaticSize = Enum.AutomaticSize.Y,
        [Roact.Ref] = arg1.containerFrameRef,
        [Roact.Change.AbsoluteSize] = arg1.onContainerSizeChange
    }, {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        }),
        UIPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, sideMargin), PaddingRight = UDim.new(0, sideMargin) }),
        TitleInfo = arg1.props.showPageDetails
            and Roact.createElement(
                DetailsPageTitleContent,
                {
                    titleText = arg1.props.titleText,
                    subTitleText = arg1.props.subTitleText,
                    renderInfoContent = arg1.props.renderInfoContent,
                    verticalAlignment = Enum.VerticalAlignment.Top,
                    layoutOrder = 1
                }
                    or nil
            ),
        Padding = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, if arg1.props.showPageDetails then sideMargin else 24),
            BackgroundTransparency = 1,
            LayoutOrder = 2
        }),
        ContentFrame = Roact.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 3
            },
            arg1:renderBodyContent()
        ),
        BottomPadding = Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, arg1.props.bottomPadding or 3 * sideMargin),
                BackgroundTransparency = 1,
                LayoutOrder = 4
            }
        )
    })
end

function var1.didMount(arg1)
    arg1.mounted = true

    if arg1.containerFrameRef.current then
        arg1.onContainerSizeChange(arg1.containerFrameRef.current)
    end
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return var1
