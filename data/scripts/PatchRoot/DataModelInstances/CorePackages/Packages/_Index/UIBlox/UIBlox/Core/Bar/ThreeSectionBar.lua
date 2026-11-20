-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent

local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Roact = require(scriptParentParentParentParent.Roact)
local FitFrame = require(scriptParentParentParentParent.FitFrame)
local bindingValidator = require(scriptParentParent.Utility.bindingValidator)

local var1 = Roact.PureComponent:extend("ThreeSectionBar")
var1.validateProps = t.strictInterface({
    BackgroundColor3 = t.optional(t.Color3),
    BackgroundTransparency = t.optional(t.union(t.number, bindingValidator(t.number))),
    barHeight = t.optional(t.number),
    contentPaddingLeft = t.optional(t.UDim),
    contentPaddingRight = t.optional(t.UDim),
    estimatedCenterWidth = t.optional(t.number),
    marginLeft = t.optional(t.number),
    marginRight = t.optional(t.number),
    onWidthChange = t.optional(t.callback),
    renderCenter = t.optional(t.callback),
    renderLeft = t.optional(t.callback),
    renderRight = t.optional(t.callback),
    automaticHeight = t.optional(t.boolean),
    sectionSpacing = t.optional(t.number)
})

var1.defaultProps = {
    barHeight = 32,
    BackgroundTransparency = 0,
    marginLeft = 0,
    marginRight = 0,
    contentPaddingLeft = UDim.new(0, 0),
    contentPaddingRight = UDim.new(0, 0),
    renderLeft = nil,
    renderRight = nil,
    renderCenter = nil,
    onWidthChange = function()
        return nil
    end,
    estimatedCenterWidth = math.huge,
    automaticHeight = false,
    sectionSpacing = 8
}

function var1.init(arg1)
    local leftWidth, updateLeftWidth = Roact.createBinding(0)
    arg1.leftWidth = leftWidth
    arg1.updateLeftWidth = updateLeftWidth
    local rightWidth, updateRightWidth = Roact.createBinding(0)
    arg1.rightWidth = rightWidth
    arg1.updateRightWidth = updateRightWidth
    local fullWidth, updateFullWidth = Roact.createBinding(0)
    arg1.fullWidth = fullWidth
    arg1.updateFullWidth = updateFullWidth

    function arg1.computeCenteredSize(arg2): UDim2
        local var8 = arg2[1]
        local var9 = arg2[2]
        local var10 = arg2[3]

        local x = math.max(var8, var9)

        local magnitude = (Vector2.new(var10 / 2, 0) - Vector2.new(x, 0)).magnitude

        if not (arg1.props.renderLeft and arg1.props.renderRight) then
            return UDim2.new(1, -x, 1, 0)
        end

        return UDim2.new(0, magnitude * 2, 1, 0)
    end

    function arg1.computeBumpedPosition(arg2): UDim2
        local var8 = arg2[1]
        local var9 = arg2[2]
        local var10 = (arg2[3] - var8 - var9) / 2

        return UDim2.new(0, var8 + var10, 0.5, 0)
    end

    function arg1.computeBumpedSize(arg2): UDim2
        local var8 = arg2[1]
        local var9 = arg2[2]

        return UDim2.new(1, -var8 - var9, 1, 0)
    end
end

function var1.didUpdate(arg1)
    if not arg1.props.renderLeft then
        arg1.updateLeftWidth(0)
    end
    if not arg1.props.renderRight then
        arg1.updateRightWidth(0)
    end
end

function var1.render(arg1)
    local vector2 = Vector2.new(0.5, 0.5)
    local uDim2 = if not arg1.props.renderLeft and arg1.props.renderRight then UDim2.fromScale(0, 0.5) elseif arg1.props.renderLeft and not arg1.props.renderRight then UDim2.fromScale(1, 0.5) else UDim2.fromScale(0.5, 0.5)
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, arg1.props.barHeight),
        BackgroundColor3 = arg1.props.BackgroundColor3,
        BackgroundTransparency = arg1.props.BackgroundTransparency,
        BorderSizePixel = 0,
        AutomaticSize = if arg1.props.automaticHeight then Enum.AutomaticSize.Y else nil
    }
    tbl1[Roact.Change.AbsoluteSize] = function(arg2)
        arg1.props.onWidthChange(arg2.AbsoluteSize.X)
        arg1.updateFullWidth(arg2.AbsoluteSize.X)
    end
    local tbl2 = { leftFrame = 0, centerFrame = 0, rightFrame = 0 }
    local renderLeft = arg1.props.renderLeft

    if renderLeft then
        local createElement2 = Roact.createElement
        local fitFrameHorizontal = FitFrame.FitFrameHorizontal
        local tbl3 = {
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.fromScale(0, 0),
            BackgroundTransparency = 1,
            minimumSize = UDim.new(0, 200),
            height = UDim.new(1, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            contentPadding = arg1.props.contentPaddingLeft,
            margin = {
                top = 0,
                left = arg1.props.marginLeft,
                right = arg1.props.sectionSpacing,
                bottom = 0
            }
        }
        tbl3[Roact.Change.AbsoluteSize] = function(arg2)
            arg1.updateLeftWidth(arg2.AbsoluteSize.X)
        end
        local tbl4 = {
            leftContent = arg1.props.renderLeft(
                Cryo.Dictionary.join(arg1.props, {
                    [Roact.Children] = {
                        sizeConstraint = Roact.createElement("UISizeConstraint", {
                            MaxSize = Roact.joinBindings({ arg1.leftWidth, arg1.rightWidth, arg1.fullWidth }):map(function(arg2): Vector2
                                local _ = arg2[1]
                                local var2 = arg2[2]
                                local x = math.max(0, arg2[3] - var2 - arg1.props.marginLeft)

                                return Vector2.new(x, math.huge)
                            end)
                        })
                    }
                })
            )
        }

        renderLeft = createElement2(fitFrameHorizontal, tbl3, tbl4)
    end

    tbl2.leftFrame = renderLeft

    tbl2.centerFrame = arg1.props.renderCenter
        and Roact.createElement("Frame", {
            AnchorPoint = vector2,
            BackgroundTransparency = 1,
            Position = Roact.joinBindings({ arg1.leftWidth, arg1.rightWidth, arg1.fullWidth }):map(function(arg2)
                if math.abs(arg1.computeCenteredSize(arg2).X.Offset) <= arg1.props.estimatedCenterWidth then
                    return arg1.computeBumpedPosition(arg2)
                end
                return uDim2
            end),
            Size = Roact.joinBindings({ arg1.leftWidth, arg1.rightWidth, arg1.fullWidth }):map(function(arg2)
                local var2 = arg1.computeCenteredSize(arg2)

                if math.abs(var2.X.Offset) <= arg1.props.estimatedCenterWidth then
                    return arg1.computeBumpedSize(arg2)
                end
                return var2
            end)
        }, {
            UIPadding = Roact.createElement("UIPadding", {
                PaddingLeft = arg1.props.renderLeft and UDim.new(0, 0) or UDim.new(0, arg1.props.marginLeft),
                PaddingRight = arg1.props.renderRight and UDim.new(0, 0) or UDim.new(0, arg1.props.marginRight)
            }),
            ["$layout"] = Roact.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            centerContent = arg1.props.renderCenter(arg1.props)
        })

    local renderRight = arg1.props.renderRight

    if renderRight then
        local createElement2 = Roact.createElement
        local fitFrameHorizontal = FitFrame.FitFrameHorizontal
        local tbl3 = {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1,
            minimumSize = UDim.new(0, 200),
            height = UDim.new(1, 0),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            contentPadding = arg1.props.contentPaddingRight,
            margin = {
                top = 0,
                left = arg1.props.sectionSpacing,
                right = arg1.props.marginRight,
                bottom = 0
            }
        }
        tbl3[Roact.Change.AbsoluteSize] = function(arg2)
            arg1.updateRightWidth(arg2.AbsoluteSize.X)
        end

        renderRight = createElement2(fitFrameHorizontal, tbl3, { rightContent = arg1.props.renderRight(arg1.props) })
    end

    tbl2.rightFrame = renderRight
    return createElement(str1, tbl1, tbl2)
end

return var1
