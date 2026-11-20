-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Cryo = require(scriptParentParent.Cryo)
local Roact = require(scriptParentParent.Roact)
local isRoact17 = require(scriptParent.isRoact17)

local Rect = require(scriptParent.Rect)

local Axis = {
    Horizontal = {},
    Vertical = {},
    Both = {}
}

local var1 = Roact.PureComponent:extend("FitFrameOnAxis")

var1.defaultProps = {
    axis = Axis.Vertical,
    minimumSize = UDim2.new(UDim.new(0, 0), UDim.new(0, 0)),
    margin = Rect.square(0),
    FillDirection = Enum.FillDirection.Vertical,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    ImageSet = {},
    VerticalAlignment = Enum.VerticalAlignment.Top,
    contentPadding = UDim.new(0, 0),
    textProps = nil
}

function var1.init(arg1)
    arg1.layoutRef = Roact.createRef()
    if isRoact17() then
        arg1.frameRef = arg1.props.forwardedRef or Roact.createRef()
    else
        arg1.frameRef = arg1.props[Roact.Ref] or Roact.createRef()
    end

    function arg1.onResize()
        local current = arg1.layoutRef.current
        local current2 = arg1.frameRef.current
        if not (current2 and current) then
            return
        end

        current2.Size = arg1:__getSize(current)
    end
end

function var1.render(arg1)
    assert(arg1.props.Size == nil, "Size is not a valid property of FitFrameOnAxis. Did you mean `minimumSize`?")
    local prop = arg1.props[Roact.Children] or {}
    local var2 = arg1:__getFilteredProps()

    local str1 = if arg1.props.onActivated then "ImageButton" else "ImageLabel"

    local join = Cryo.Dictionary.join
    local tbl2 = {
        ["$layout"] = Roact.createElement("UIListLayout", {
            FillDirection = arg1.props.FillDirection,
            HorizontalAlignment = arg1.props.HorizontalAlignment,
            Padding = arg1.props.contentPadding,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = arg1.props.VerticalAlignment,
            [Roact.Change.AbsoluteContentSize] = arg1.onResize,
            [Roact.Ref] = arg1.layoutRef
        }),
        ["$margin"] = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, arg1.props.margin.left),
            PaddingRight = UDim.new(0, arg1.props.margin.right),
            PaddingTop = UDim.new(0, arg1.props.margin.top),
            PaddingBottom = UDim.new(0, arg1.props.margin.bottom)
        })
    }
    local var3 = join(prop, tbl2)

    if not arg1.props.textProps then
        return Roact.createElement(str1, var2, var3)
    end

    return Roact.createElement(str1, var2, {
        TextLabel = Roact.createElement(
            "TextLabel",
            Cryo.Dictionary.join(arg1.props.textProps, { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
        ),
        ChildFrame = Roact.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) }, var3)
    })
end

function var1.didMount(arg1)
    arg1.onResize()
end

function var1.didUpdate(arg1)
    arg1.onResize()
end

function var1.__getFilteredProps(arg1)
    local var2 = Cryo.Dictionary.join(
        arg1.props.ImageSet,
        {
            [Roact.Ref] = arg1.frameRef,
            [Roact.Event.Activated] = arg1.props.onActivated
        }
    )
    for k, _ in pairs(var1.defaultProps) do
        var2[k] = Cryo.None
    end

    var2.textProps = Cryo.None

    return Cryo.Dictionary.join(
        arg1.props,
        var2,
        {
            onActivated = Cryo.None,
            forwardedRef = Cryo.None,
            [Roact.Children] = Cryo.None
        }
    )
end

function var1.__getSize(arg1, arg2)
    if arg1.props.axis == Axis.Both then
        return arg1:__getBothAxisSize(arg2)
    end

    local var2 = arg1:__getAxisUDim(arg2.AbsoluteContentSize)
    local var3 = arg1:__getOtherUDim()

    if arg1.props.axis == Axis.Vertical then
        return UDim2.new(var3, var2)
    end

    if arg1.props.axis == Axis.Horizontal then
        return UDim2.new(var2, var3)
    end
end

function var1.__getBothAxisSize(arg1, arg2): UDim2
    local minimumSize = arg1.props.minimumSize
    local absoluteContentSize = arg2.AbsoluteContentSize

    local uDim = UDim.new(minimumSize.X.Scale, absoluteContentSize.X + arg1:__getHorizontalMargin())
    local uDim2 = UDim.new(minimumSize.Y.Scale, absoluteContentSize.Y + arg1:__getVerticalMargin())

    return UDim2.new(uDim, uDim2)
end

function var1.__getAxisUDim(arg1, arg2)
    local minimumSize = arg1.props.minimumSize

    local var2 = nil
    local var3 = nil
    if arg1.props.axis == Axis.Vertical then
        var2 = minimumSize.Y
        var3 = arg2.Y + arg1:__getVerticalMargin()
    elseif arg1.props.axis == Axis.Horizontal then
        var2 = minimumSize.X
        var3 = arg2.X + arg1:__getHorizontalMargin()
    end

    return UDim.new(var2.Scale, math.max(var3, var2.Offset))
end

function var1.__getVerticalMargin(arg1)
    return arg1.props.margin.top + arg1.props.margin.bottom
end

function var1.__getHorizontalMargin(arg1)
    return arg1.props.margin.left + arg1.props.margin.right
end

function var1.__getOtherUDim(arg1)
    local minimumSize = arg1.props.minimumSize

    if arg1.props.axis == Axis.Vertical then
        return minimumSize.X
    end

    if arg1.props.axis == Axis.Horizontal then
        return minimumSize.Y
    end
end

local var2 = if isRoact17() then Roact.forwardRef(function(arg1, forwardedRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardedRef = forwardedRef }))
end) else var1

var2.Axis = Axis

return var2
