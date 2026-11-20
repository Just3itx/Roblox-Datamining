-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParent.Core

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local Otter = require(scriptParentParentParentParent.Otter)
local Images = require(scriptParentParentParent.App.ImageSet.Images)

local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)

local ControlState = require(Core.Control.Enum.ControlState)
local SegmentedControlTabName = require(script.Parent.SegmentedControlTabName)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local getContentStyle = require(Core.Button.getContentStyle)
local getIconSize = require(scriptParentParentParent.App.ImageSet.getIconSize)
local IconSize = require(scriptParentParentParent.App.ImageSet.Enum.IconSize)
local GetTextSize = require(scriptParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParent.Core.Text.GetFontFromFontStyle)

local iconSize = getIconSize(IconSize.Medium)
local tbl1 = { frequency = 10, dampingRatio = 1 }

local component_assetsCircle_17 = Images["component_assets/circle_17"]
local tbl2 = {
    [ControlState.Default] = "BackgroundUIDefault"
}
local tbl3 = {
    [ControlState.Default] = "Divider"
}
local tbl4 = {
    [ControlState.Default] = "UIEmphasis"
}

local iconStateColorMap = {
    [ControlState.Default] = "SecondaryDefault",
    [ControlState.Hover] = "SecondaryOnHover"
}

local var1 = Roact.Component:extend("SegmentedControl")

var1.validateProps = t.strictInterface({
    tabs = function(arg1)
        local var2, var3 = t.array(t.strictInterface({ tabName = t.string, isDisabled = t.optional(t.boolean), icon = t.optional(t.table) }))(arg1)

        if not var2 then
            return var2, var3
        end

        local var4, var5 = t.numberMin(2)(#arg1)
        if not var4 then
            return var4, var5
        end

        local var6, var7 = t.numberMax(4)(#arg1)
        if not var6 then
            return var6, var7
        end

        return true
    end,
    width = t.UDim,
    height = t.optional(t.number),
    maxWidth = t.optional(t.number),
    selectedTabIndex = t.number,
    onTabActivated = t.callback,
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    layoutOrder = t.optional(t.number)
})

var1.defaultProps = { height = 44 }

function var1.init(arg1)
    arg1.rootRef = Roact.createRef()
    arg1.tabRefs = RoactGamepad.createRefCache()

    local selectedBackgroundPositionX, setSelectedBackgroundPositionX = Roact.createBinding(0)
    arg1.selectedBackgroundPositionX = selectedBackgroundPositionX
    arg1.setSelectedBackgroundPositionX = setSelectedBackgroundPositionX
    arg1.selectedBackgroundMotor = Otter.createSingleMotor(4)
    arg1.selectedBackgroundMotor:onStep(function(arg2)
        arg1.setSelectedBackgroundPositionX(arg2)
    end)

    arg1:setState({ tabWidth = 0, computedMinFrameWidth = 0 })

    function arg1.onTabActivated(arg2)
        arg1.props.onTabActivated(arg2)
    end

    function arg1.setSize(arg2)
        local tabWidth = math.floor((math.max(arg2.AbsoluteSize.X, arg1.state.computedMinFrameWidth) - 8) / #arg1.props.tabs)
        arg1.selectedBackgroundMotor:setGoal(Otter.spring(4 + tabWidth * (arg1.props.selectedTabIndex - 1), tbl1))

        arg1:setState({ tabWidth = tabWidth })
    end
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local controlState = arg1.state.controlState
        local tabsLen = #arg1.props.tabs
        local var2 = if arg1.props.tabs[arg1.props.selectedTabIndex].isDisabled then ControlState.Disabled or controlState else controlState
        local contentStyle = getContentStyle(tbl2, controlState, arg2)
        local contentStyle2 = getContentStyle(tbl3, controlState, arg2)

        local contentStyle3 = getContentStyle(tbl4, var2, arg2)
        local tabWidth = arg1.state.tabWidth
        local var3 = if arg1.props.icon then iconSize else 0

        local height = arg1.props.height
        local yOffset = arg1.props.height - 12
        local yOffset2 = arg1.props.height - 16

        local var4 = arg2.Font.Header2.RelativeSize * arg2.Font.BaseSize
        if arg1.state.computedMinFrameWidth == 0 then
            local maxX = 0
            for i = 1, tabsLen do
                local tabName = arg1.props.tabs[i].tabName
                maxX = math.max(maxX, GetTextSize(tabName, var4, GetFontFromFontStyle(arg2.Font.Header2), Vector2.new(math.huge, math.huge)).X)
            end

            local num1 = maxX + 8
            local var5 = (var3 + 80) * tabsLen + 8
            local var6 = (var3 + num1) * tabsLen + 8
            local var7 = arg1
            local tbl6 = {
                computedMinFrameWidth = if arg1.props.maxWidth then math.min(var6, arg1.props.maxWidth) else math.max(var6, var5)
            }
            var7:setState(tbl6)
        end

        local tbl6 = {}
        for i = 1, tabsLen - 1 do
            if i == arg1.props.selectedTabIndex or i == arg1.props.selectedTabIndex - 1 then
                continue
            end

            table.insert(
                tbl6,
                i,
                Roact.createElement("Frame", {
                    Size = UDim2.fromOffset(1, yOffset2),
                    BackgroundTransparency = contentStyle2.Transparency,
                    BackgroundColor3 = contentStyle2.Color,
                    Position = UDim2.fromOffset(4 + tabWidth * i, (height - yOffset2) / 2)
                })
            )
        end

        return RoactGamepad.withFocusController(function(arg3)
            local function func1(layoutOrder) -- Luacid: Inlined by compiler; 3 call sites recovered
                if layoutOrder > 1 then
                    arg3.moveFocusTo(arg1.tabRefs[layoutOrder - 1])
                end
            end
            local function func2(layoutOrder) -- Luacid: Inlined by compiler; 3 call sites recovered
                if layoutOrder < tabsLen then
                    arg3.moveFocusTo(arg1.tabRefs[layoutOrder + 1])
                end
            end
            local function func3()
                arg3.moveFocusTo(arg1.rootRef)
            end

            local var5 = Cryo.List.map(arg1.props.tabs, function(arg4, layoutOrder)
                local createElement = Roact.createElement
                local frame = RoactGamepad.Focusable.Frame

                local tbl7 = {
                    key = arg4.tabName,
                    LayoutOrder = layoutOrder,
                    Size = UDim2.fromOffset(tabWidth, height),
                    BackgroundTransparency = 1,
                    [Roact.Ref] = arg1.tabRefs[layoutOrder],
                    NextSelectionLeft = if layoutOrder > 1 then arg1.tabRefs[layoutOrder - 1] or nil else nil,
                    NextSelectionRight = if layoutOrder < tabsLen then arg1.tabRefs[layoutOrder + 1] or nil else nil,
                    inputBindings = {
                        LeaveA = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, func3),
                        LeaveB = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonB, func3),
                        SelectNext1 = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonR1, function()
                            func2(layoutOrder)
                        end),
                        SelectPre1 = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonL1, function()
                            func1(layoutOrder)
                        end),
                        SelectNext2 = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonR2, function()
                            func2(layoutOrder)
                        end),
                        SelectPre2 = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonL2, function()
                            func1(layoutOrder)
                        end),
                        SelectNext3 = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonR3, function()
                            func2(layoutOrder)
                        end),
                        SelectPre3 = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonL3, function()
                            func1(layoutOrder)
                        end)
                    }
                }

                return createElement(frame, tbl7, {
                    Tab = Roact.createElement(SegmentedControlTabName, {
                        text = arg4.tabName,
                        onActivated = function()
                            arg1.onTabActivated(layoutOrder)
                        end,
                        Size = UDim2.fromScale(1, 1),
                        isDisabled = arg4.isDisabled,
                        isSelectedStyle = arg1.props.selectedTabIndex == layoutOrder,
                        icon = arg4.icon,
                        iconStateColorMap = iconStateColorMap
                    })
                })
            end)

            local createElement = Roact.createElement
            local tbl7 = {
                Size = UDim2.new(arg1.props.width.Scale, arg1.props.width.Offset, 0, height),
                BackgroundTransparency = 1,
                [Roact.Change.AbsoluteSize] = arg1.setSize,
                LayoutOrder = arg1.props.layoutOrder
            }
            local tbl8 = {
                SizeConstraint = Roact.createElement(
                    "UISizeConstraint",
                    {
                        MinSize = Vector2.new(arg1.state.computedMinFrameWidth, height),
                        MaxSize = Vector2.new(640, height)
                    }
                ),
                Background = Roact.createElement(ImageSetComponent.Label, {
                    Size = UDim2.new(1, 0, 0, yOffset),
                    Position = UDim2.fromOffset(0, (height - yOffset) / 2),
                    BackgroundTransparency = 1,
                    Image = component_assetsCircle_17,
                    ImageColor3 = contentStyle.Color,
                    ImageTransparency = contentStyle.Transparency,
                    LayoutOrder = 1,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(8, 8, 9, 9),
                    ZIndex = 1
                }),
                Dividers = 0,
                SelectedBackground = 0,
                TabContainer = 0
            }

            local createElement2 = Roact.createElement
            local frame = RoactGamepad.Focusable.Frame

            local tbl9 = {
                Size = UDim2.new(1, 0, 0, height),
                Position = UDim2.fromOffset(0, 0),
                BackgroundTransparency = 1,
                ZIndex = 2,
                NextSelectionLeft = arg1.props.NextSelectionLeft,
                NextSelectionRight = arg1.props.NextSelectionRight,
                NextSelectionUp = arg1.props.NextSelectionUp,
                NextSelectionDown = arg1.props.NextSelectionDown,
                [Roact.Ref] = arg1.rootRef,
                inputBindings = {
                    Enter = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, function()
                        arg3.moveFocusTo(arg1.tabRefs[arg1.props.selectedTabIndex])
                    end)
                }
            }

            tbl8.Dividers = createElement2(frame, tbl9, tbl6)

            tbl8.SelectedBackground = Roact.createElement(ImageSetComponent.Label, {
                Size = UDim2.fromOffset(tabWidth, yOffset2),
                Position = arg1.selectedBackgroundPositionX:map(function(xOffset: number): UDim2
                    return UDim2.fromOffset(xOffset, (height - yOffset2) / 2)
                end),
                BackgroundTransparency = 1,
                Image = component_assetsCircle_17,
                ImageColor3 = contentStyle3.Color,
                ImageTransparency = contentStyle3.Transparency,
                LayoutOrder = 2,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(8, 8, 9, 9),
                ZIndex = 4
            })

            tbl8.TabContainer = Roact.createElement(RoactGamepad.Focusable.Frame, {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(0, 0),
                ZIndex = 5,
                defaultChild = arg1.tabRefs[arg1.props.selectedTabIndex]
            }, {
                TabLayout = Roact.createElement("UIListLayout", {
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                Roact.createFragment(var5)
            })
            return createElement("Frame", tbl7, tbl8)
        end)
    end)
end

function var1.didUpdate(arg1, arg2)
    if arg2.selectedTabIndex ~= arg1.props.selectedTabIndex then
        arg1.selectedBackgroundMotor:setGoal(Otter.spring(4 + arg1.state.tabWidth * (arg1.props.selectedTabIndex - 1), tbl1))
    end
end

return var1
