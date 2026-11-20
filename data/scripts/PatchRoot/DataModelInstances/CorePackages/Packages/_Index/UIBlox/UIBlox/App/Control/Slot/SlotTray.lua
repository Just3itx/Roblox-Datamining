-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParent.Core

local React = require(scriptParentParentParentParentParent.React)
local t = require(scriptParentParentParentParentParent.t)
local Otter = require(scriptParentParentParentParentParent.Otter)
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local RoactGamepad = require(scriptParentParentParentParentParent.RoactGamepad)
local Focusable = RoactGamepad.Focusable

local TileSlot = require(script.Parent.TileSlot)
local useStyle = require(Core.Style.useStyle)
local CursorKind = require(scriptParentParentParent.SelectionImage.CursorKind)
local useSelectionCursor = require(scriptParentParentParent.SelectionImage.useSelectionCursor)

local tbl1 = { dampingRatio = 1, frequency = 10 }

local var1 = t.strictInterface({
    displayText = t.optional(t.string),
    thumbnail = t.optional(t.string),
    isDisabled = t.optional(t.boolean),
    isLoading = t.optional(t.boolean)
})

local var2 = t.strictInterface({
    slots = t.array(var1),
    defaultSelectedSlotIndex = t.optional(t.integer),
    onChange = t.callback,
    width = t.optional(t.integer),
    darken = t.optional(t.boolean),
    onInputBegan = t.optional(t.callback),
    onInputEnded = t.optional(t.callback),
    scrollingFrameRef = t.optional(t.table),
    onFocusChanged = t.optional(t.callback),
    inputBindings = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

local function useScrollingFrameMotor(arg1, num1: number?)
    local var3 = React.useRef(nil)
    if var3.current == nil then
        var3.current = Otter.createSingleMotor(num1 or 0)
    end
    local current = var3.current
    React.useEffect(function()
        current:onStep(function(x: number?)
            if arg1.current ~= nil then
                arg1.current.CanvasPosition = Vector2.new(x, 0)
            end
        end)

        return function()
            current:destroy()
        end
    end, {})

    return current
end

local function SlotTray(tbl2)
    local var3 = tbl2.isRoactGamepadEnabled == nil or tbl2.isRoactGamepadEnabled
    local var4 = React.useRef({})
    local var5 = if var3 then RoactGamepad.useRefCache() else var4.current
    local var6 = React.useRef(nil)
    if tbl2.scrollingFrameRef then
        var6 = tbl2.scrollingFrameRef
    end

    local width = tbl2.width or 360

    local var7 = useScrollingFrameMotor(var6, 0)

    local var8, var9 = React.useState(tbl2.defaultSelectedSlotIndex or 1)

    React.useEffect(function()
        local current = var6.current

        if var8 == 0 or not current then
            return
        end

        local current2 = var5[var8] and var5[var8].current
        if not current2 then
            return
        end

        local canvasPositionX = current.CanvasPosition.X
        local absolutePositionX = current.AbsolutePosition.X
        local var10 = absolutePositionX + width

        local absolutePositionX2 = current2.AbsolutePosition.X
        local var11 = absolutePositionX2 + 48 + 24 - var10
        local var12 = absolutePositionX2 - 24 - absolutePositionX

        local var13 = canvasPositionX + var11
        local var14 = canvasPositionX + var12

        if canvasPositionX < var13 then
            var7:setGoal(Otter.spring(var13, tbl1))
        elseif var14 < canvasPositionX then
            var7:setGoal(Otter.spring(var14, tbl1))
        end
    end, {
        var8,
        width,
        var5,
        var6,
        var7
    })
    local onActivated = React.useCallback(function(arg1)
        var9(arg1)
        tbl2.onChange(arg1)
    end, { tbl2.onChange })

    local xOffset = #tbl2.slots * 48 + (#tbl2.slots - 1) * 12 + 48

    local var11 = useStyle()
    local selectionImageObject = useSelectionCursor(CursorKind.RoundedSlot)

    assert(var2(tbl2))
    local theme = var11.Theme

    local var13 = Cryo.List.map(tbl2.slots, function(arg1, arg2)
        if not var3 then
            var5[arg2] = var5[arg2] or React.createRef()
        end

        local createElement = React.createElement
        local var13 = if var3 then Focusable.Frame else "Frame"

        local tbl3 = {
            key = "Slot" .. tostring(arg2),
            LayoutOrder = arg2,
            Size = UDim2.fromOffset(48, 48),
            BackgroundTransparency = 1,
            BorderSizePixel = 2,
            ref = var5[arg2],
            NextSelectionRight = if arg2 < #tbl2.slots then var5[arg2 + 1] or nil else nil,
            NextSelectionLeft = if arg2 > 1 then var5[arg2 - 1] or nil else nil,
            onFocusGained = var3 and function()
                onActivated(arg2)
            end or nil,
            SelectionImageObject = selectionImageObject
        }

        return createElement(var13, tbl3, {
            Slot = React.createElement(TileSlot, {
                isSelected = var8 == arg2,
                displayText = arg1.displayText,
                thumbnail = arg1.thumbnail,
                isLoading = arg1.isLoading,
                isDisabled = arg1.isDisabled,
                index = arg2,
                onActivated = onActivated
            })
        })
    end)

    table.insert(
        var13,
        (React.createElement("UIListLayout", {
            key = "Layout",
            VerticalAlignment = Enum.VerticalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        }))
    )
    local createElement = React.createElement
    local var14 = if var3 then Focusable.ScrollingFrame else "ScrollingFrame"
    local tbl3 = {
        Size = UDim2.fromOffset(width, 72),
        CanvasSize = UDim2.new(0, xOffset, 0, 72),
        BackgroundTransparency = 1,
        ScrollBarImageColor3 = theme.PlaceHolder.Color,
        ScrollBarImageTransparency = theme.PlaceHolder.Transparency,
        ScrollBarThickness = 0,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ElasticBehavior = Enum.ElasticBehavior.Always,
        ScrollingDirection = Enum.ScrollingDirection.X,
        ref = var6,
        [React.Event.InputBegan] = tbl2.onInputBegan,
        [React.Event.InputEnded] = tbl2.onInputEnded,
        onFocusChanged = if var3 then tbl2.onFocusChanged else nil,
        inputBindings = if var3 then tbl2.inputBindings else nil,
        NextSelectionDown = tbl2.NextSelectionDown,
        NextSelectionUp = tbl2.NextSelectionUp,
        NextSelectionLeft = tbl2.NextSelectionLeft,
        NextSelectionRight = tbl2.NextSelectionRight,
        defaultChild = if var3 then var5[1] else nil,
        restorePreviousChildFocus = if var3 then true else nil
    }
    local tbl4 = {
        SlotContainer = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = if tbl2.darken then theme.Overlay.Color else theme.PlaceHolder.Color,
            BackgroundTransparency = if tbl2.darken then theme.Overlay.Transparency else theme.PlaceHolder.Transparency
        }, var13)
    }
    return createElement(var14, tbl3, tbl4)
end

return SlotTray
