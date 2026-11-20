-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local ArrowNav = require(scriptParentParent.HorizontalNav.ArrowNav)
local NavigationDirection = require(scriptParentParent.HorizontalNav.NavigationDirection)
local Images = require(scriptParentParentParent.ImageSet.Images)

local iconsActionsCycleLeft = Images["icons/actions/cycleLeft"]
local iconsActionsCycleRight = Images["icons/actions/cycleRight"]

local var1 = Roact.PureComponent:extend("ArrowFrame")

var1.validateProps = t.strictInterface({
    ZIndex = t.optional(t.number),
    isVisibleLeft = t.optional(t.union(t.boolean, t.table)),
    isVisibleRight = t.optional(t.union(t.boolean, t.table)),
    onPressHoldInputBegan = t.optional(t.callback),
    onPressHoldInputEnded = t.optional(t.callback),
    defaultUseProps = t.optional(
        t.strictInterface({
            scrollingFrameRef = t.table,
            buttonRefs = t.optional(t.table),
            buttonWidth = t.optional(t.number),
            padOutsideEdges = t.optional(t.boolean),
            numButtons = t.optional(t.number),
            buttonPadding = t.number,
            updateCanvasPosition = t.callback
        })
    )
})
var1.defaultProps = { ZIndex = 1, isVisibleRight = true, isVisibleLeft = true }

function var1.init(arg1)
    arg1.state = { isHovered = false }

    function arg1.onMouseEnter()
        arg1:setState({ isHovered = true })
    end

    function arg1.onMouseLeave()
        arg1:setState({ isHovered = false })
    end
end

function var1.render(arg1)
    local isVisibleLeft = arg1.props.isVisibleLeft
    local isVisibleRight = arg1.props.isVisibleRight
    local defaultUseProps = arg1.props.defaultUseProps
    local onPressHoldInputBegan = arg1.props.onPressHoldInputBegan
    local onPressHoldInputEnded = arg1.props.onPressHoldInputEnded

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = arg1.props.ZIndex,
        [Roact.Event.MouseEnter] = arg1.onMouseEnter,
        [Roact.Event.MouseLeave] = arg1.onMouseLeave
    }, {
        ArrowLeft = Roact.createElement(ArrowNav, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, -6, 0.5, 0),
            Image = iconsActionsCycleLeft,
            Visible = arg1.state.isHovered and isVisibleLeft,
            navDirection = NavigationDirection.IsLeft,
            defaultUseProps = defaultUseProps,
            onPressHoldInputBegan = onPressHoldInputBegan,
            onPressHoldInputEnded = onPressHoldInputEnded
        }),
        ArrowRight = Roact.createElement(ArrowNav, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(1, -30, 0.5, 0),
            Image = iconsActionsCycleRight,
            Visible = arg1.state.isHovered and isVisibleRight,
            navDirection = NavigationDirection.IsRight,
            defaultUseProps = defaultUseProps,
            onPressHoldInputBegan = onPressHoldInputBegan,
            onPressHoldInputEnded = onPressHoldInputEnded
        })
    })
end

return var1
