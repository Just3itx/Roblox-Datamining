-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)
local isCallable = require(scriptParentParentParent.Utility.isCallable)
local UIBloxConfig = require(scriptParentParentParent.UIBloxConfig)

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)

local isPositiveVector2 = require(scriptParentParentParent.Utility.isPositiveVector2)

local var1 = Roact.PureComponent:extend("GridView")

var1.validateProps = t.strictInterface({
    renderItem = isCallable,
    itemSize = isPositiveVector2,
    itemPadding = t.Vector2,
    items = t.table,
    maxHeight = t.numberMin(0),
    windowHeight = t.optional(t.numberMin(0)),
    LayoutOrder = t.optional(t.integer),
    onWidthChanged = t.optional(isCallable),
    onNumItemsPerRowChanged = t.optional(isCallable),
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

function var1.itemsAreVisible(arg1)
    local isInDataModel = arg1.state.isInDataModel
    return isInDataModel and arg1.state.containerWidth ~= 0 and arg1.props.itemSize.X ~= 0
end

var1.defaultProps = {
    maxHeight = math.huge,
    restorePreviousChildFocus = true,
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    arg1.currentItemsPerRow = -1
    arg1.frameRef = Roact.createRef()
    arg1.isMounted = false

    arg1.state = { containerWidth = 0, containerYPosition = 0, isInDataModel = false }

    arg1.focusableRefs = arg1.props.isRoactGamepadEnabled and RoactGamepad.createRefCache() or {}

    function arg1.onAncestryChanged(arg2)
        if not arg2:IsDescendantOf(game) then
            return
        end

        arg1:setState(function(arg3): {containerWidth: any, isInDataModel: boolean}?
            return if arg3.isInDataModel and arg3.containerWidth == arg2.AbsoluteSize.X then nil else {
                isInDataModel = true,
                containerWidth = arg2.AbsoluteSize.X
            }
        end)
    end
end

function var1.render(arg1)
    local items = arg1.props.items
    local itemsLen = #items

    local itemSize = arg1.props.itemSize
    local itemPadding = arg1.props.itemPadding
    local maxHeight = arg1.props.maxHeight
    local containerWidth = arg1.state.containerWidth
    local containerYPosition = arg1.state.containerYPosition
    local defaultChildIndex = arg1.props.defaultChildIndex
    local onNumItemsPerRowChanged = arg1.props.onNumItemsPerRowChanged
    local num1 = 1
    local num2 = itemsLen
    local tbl1 = {}
    local xOffset = 0
    local yOffset = 0

    local num3 = math.max(1, itemSize.X + itemPadding.X)
    local num4 = math.max(1, itemSize.Y + itemPadding.Y)
    local num5 = math.floor((containerWidth + itemPadding.X) / num3)
    local num6 = math.floor((maxHeight + itemPadding.Y) / num4)

    local currentItemsPerRow = arg1.currentItemsPerRow

    if num5 ~= currentItemsPerRow then
        arg1.currentItemsPerRow = num5
        if onNumItemsPerRowChanged then
            onNumItemsPerRowChanged(num5)
        end
    end

    local num7 = math.min(num6, math.ceil(itemsLen / num5))
    local yOffset2 = num7 * itemSize.Y + math.max(num7 - 1, 0) * itemPadding.Y

    if arg1.props.windowHeight ~= nil then
        local num8 = math.floor((arg1.props.windowHeight + itemPadding.Y) / (itemSize.Y + itemPadding.Y)) + 2

        local num9 = math.floor((containerYPosition + itemPadding.Y) / (itemSize.Y + itemPadding.Y))

        local num10 = math.min(num7, num9 + num8) + 1

        num1 = math.max(1, num9 * num5 + 1)
        num2 = math.min(itemsLen, num10 * num5)

        yOffset = num9 * itemSize.Y + num9 * itemPadding.Y
    end

    local function getItemIndexRef(num8: number, arg2) -- Luacid: Inlined by compiler; 4 call sites recovered
        local bool1 = num8 > 0 and arg2 > 0 and arg2 <= num5
        local var2 = 1 + ((num8 - 1) * num5 + (arg2 - 1))

        return num1 <= var2 and var2 <= num2 and bool1 and arg1.focusableRefs[var2] or nil
    end

    local function renderItem(arg2)
        local row = math.floor((arg2 - 1) / num5) + 1
        local column = 1 + (arg2 - 1) % num5

        local var3 = arg1:itemsAreVisible()

        if not arg1.props.isRoactGamepadEnabled then
            arg1.focusableRefs[arg2] = arg1.focusableRefs[arg2] or Roact.createRef()
        end

        return Roact.createElement(if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, xOffset, 0, yOffset),
            Size = UDim2.new(0, itemSize.X, 0, itemSize.Y),
            NextSelectionLeft = getItemIndexRef(row, column - 1),
            NextSelectionRight = getItemIndexRef(row, column + 1),
            NextSelectionUp = getItemIndexRef(row - 1, column),
            NextSelectionDown = getItemIndexRef(row + 1, column),
            [Roact.Ref] = arg1.focusableRefs[arg2],
            onFocusGained = if arg1.props.isRoactGamepadEnabled then arg1.props.onFocusGained else nil
        }, {
            Content = var3
                and arg1.props.renderItem(
                    items[arg2],
                    arg2,
                    UIBloxConfig.passRowAndColumnDataToItemInGridView and {
                        row = row,
                        column = column
                    } or nil
                )
        })
    end

    if yOffset2 < maxHeight then
        local bool1 = false
        local var2 = defaultChildIndex and defaultChildIndex <= itemsLen

        for i = num1, num2 do
            if i == defaultChildIndex then
                bool1 = true
            end

            tbl1[tostring(i)] = renderItem(i)

            local itemSizeX = itemSize.X
            xOffset = math.floor(xOffset + itemSizeX + itemPadding.X)

            local itemSizeX2 = itemSize.X

            if containerWidth < xOffset + itemSizeX2 and i < num2 then
                xOffset = 0
                local itemPaddingY = itemPadding.Y
                yOffset = yOffset + itemPaddingY + itemSize.Y
            end
        end

        if var2 and not bool1 then
            xOffset = (defaultChildIndex - 1) % num5 * (itemSize.X + itemPadding.X)
            yOffset = math.floor((defaultChildIndex - 1) / num5) * (itemPadding.Y + itemSize.Y)
            tbl1[tostring(defaultChildIndex)] = renderItem(defaultChildIndex)
        end
    end

    local createElement = Roact.createElement
    local var2 = if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame"

    local tbl2 = {
        BackgroundTransparency = nil,
        BackgroundTransparency = nil,
        BackgroundTransparency = nil,
        BackgroundTransparency = nil,
        BackgroundTransparency = nil,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.LayoutOrder,
        Size = UDim2.new(1, 0, 0, yOffset2),
        [Roact.Change.AbsolutePosition] = if arg1.props.windowHeight == nil then nil else function(arg2)
            if arg1.isMounted then
                arg1:setState({ containerYPosition = -math.min(0, arg2.AbsolutePosition.Y) })
            end
        end or nil
    }

    tbl2[Roact.Change.AbsoluteSize] = function(arg2)
        if not arg1.isMounted then
            return
        end

        if arg1.state.isInDataModel then
            arg1:setState({ containerWidth = arg2.AbsoluteSize.X })
        end

        if arg1.props.onWidthChanged ~= nil then
            arg1.props.onWidthChanged(arg2.AbsoluteSize.X)
        end
    end

    tbl2[Roact.Event.AncestryChanged] = arg1.onAncestryChanged
    tbl2[Roact.Ref] = arg1.props.frameRef or arg1.frameRef
    tbl2.NextSelectionLeft = arg1.props.NextSelectionLeft
    tbl2.NextSelectionRight = arg1.props.NextSelectionRight
    tbl2.NextSelectionUp = arg1.props.NextSelectionUp
    tbl2.NextSelectionDown = arg1.props.NextSelectionDown
    tbl2.defaultChild = if arg1.props.isRoactGamepadEnabled and defaultChildIndex then arg1.focusableRefs[defaultChildIndex] else nil

    tbl2.restorePreviousChildFocus = if arg1.props.isRoactGamepadEnabled then arg1.props.restorePreviousChildFocus else nil
    return createElement(var2, tbl2, tbl1)
end

function var1.didMount(arg1)
    arg1.isMounted = true

    local frameRef = arg1.props.frameRef or arg1.frameRef

    if not frameRef:getValue() or frameRef:getValue().AbsoluteSize.X == 0 then
        return
    end

    if frameRef:getValue():IsDescendantOf(game) then
        arg1:setState(function(_)
            if frameRef:getValue() then
                return {
                    isInDataModel = true,
                    containerWidth = frameRef:getValue().AbsoluteSize.X
                }
            end

            return nil
        end)
    end

    if arg1.props.onWidthChanged == nil then
        return
    end

    delay(0, function()
        if frameRef:getValue() then
            arg1.props.onWidthChanged(frameRef:getValue().AbsoluteSize.X)
        end
    end)
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

return Roact.forwardRef(function(arg1, frameRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)
