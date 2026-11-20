-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)

local GridView = require(scriptParent.GridView)

local function validateWindowHeight(props)
    if props.windowHeight ~= nil and props.windowHeight > props.maxHeight then
        return false, ("windowHeight must be less than or equal to maxHeight\nmaxHeight: %f\nwindowHeight: %f"):format(
            props.maxHeight,
            props.windowHeight
        )
    end

    return true
end

local var1 = Roact.PureComponent:extend("DefaultMetricsGridView")

var1.validateProps = t.strictInterface({
    getItemHeight = t.callback,
    getItemMetrics = t.callback,
    windowHeight = t.optional(t.numberMin(0)),
    renderItem = t.callback,
    itemPadding = t.Vector2,
    items = t.table,
    maxHeight = t.numberMin(0),
    LayoutOrder = t.optional(t.integer),
    onNumItemsPerRowChanged = t.optional(t.callback),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    frameRef = t.optional(t.table),
    restorePreviousChildFocus = t.optional(t.boolean),
    onFocusGained = t.optional(t.callback),
    defaultChildIndex = t.optional(t.numberMin(1)),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    maxHeight = math.huge,
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    arg1.isMounted = false

    arg1.state = { containerWidth = 0 }

    arg1.initialSizeCheckerRef = Roact.createRef()
end

function var1.render(arg1)
    assert(validateWindowHeight(arg1.props))

    local itemMetrics = arg1.props.getItemMetrics(arg1.state.containerWidth, arg1.props.itemPadding.X)
    local itemHeight = arg1.props.getItemHeight(itemMetrics.itemWidth)

    local itemSize = Vector2.new(math.max(0, itemMetrics.itemWidth), math.max(0, itemHeight))

    local createElement = Roact.createElement
    local var3 = GridView
    local tbl1 = {
        renderItem = arg1.props.renderItem,
        windowHeight = arg1.props.windowHeight,
        maxHeight = arg1.props.maxHeight,
        itemSize = itemSize,
        itemPadding = arg1.props.itemPadding,
        items = arg1.props.items,
        LayoutOrder = arg1.props.LayoutOrder,
        onNumItemsPerRowChanged = arg1.props.onNumItemsPerRowChanged,
        NextSelectionLeft = arg1.props.NextSelectionLeft,
        NextSelectionRight = arg1.props.NextSelectionRight,
        NextSelectionUp = arg1.props.NextSelectionUp,
        NextSelectionDown = arg1.props.NextSelectionDown,
        [Roact.Ref] = arg1.props.frameRef,
        defaultChildIndex = if arg1.props.isRoactGamepadEnabled then arg1.props.defaultChildIndex else nil,
        restorePreviousChildFocus = if arg1.props.isRoactGamepadEnabled then arg1.props.restorePreviousChildFocus else nil,
        onFocusGained = if arg1.props.isRoactGamepadEnabled then arg1.props.onFocusGained else nil,
        isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled
    }
    function tbl1.onWidthChanged(containerWidth)
        if arg1.isMounted then
            arg1:setState({ containerWidth = containerWidth })
        end
    end

    return createElement(var3, tbl1)
end

function var1.didMount(arg1)
    arg1.isMounted = true
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

return Roact.forwardRef(function(arg1, frameRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)
