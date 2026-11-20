-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Cryo = require(scriptParentParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParentParent.React)
local RoactGamepad = require(scriptParentParentParentParentParent.RoactGamepad)
local Focusable = RoactGamepad.Focusable
local FitFrame = require(scriptParentParentParentParentParent.FitFrame)
local FitFrameHorizontal = FitFrame.FitFrameHorizontal

local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local Images = require(scriptParentParentParent.ImageSet.Images)

local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local IconButton = require(scriptParentParentParentParent.App.Button.IconButton)
local useIsGamepad = require(scriptParentParentParentParent.Utility.useIsGamepad)
local ScrollingListWithArrowsAndGradient = require(scriptParentParent.HorizontalNav.ScrollingListWithArrowsAndGradient)
local Pillv2 = require(scriptParent.Pillv2)

local function PillGroup(tbl1)
    local var1 = tbl1.isRoactGamepadEnabled == nil or tbl1.isRoactGamepadEnabled
    local var2 = useIsGamepad() and var1

    local scrollingFrameRef = React.useRef(nil)

    local function scrollToStart() -- Luacid: Inlined by compiler; 1 call site recovered
        local current = scrollingFrameRef.current
        if current then
            current:ScrollToTop()
        end
    end

    local leftPadding = tbl1.leftPadding or 15
    local rightPadding = tbl1.rightPadding or 15

    local var4 = tbl1.selectedPills or {}

    local theme = useStyle().Theme

    local var5 = React.useCallback(function(arg1)
        if scrollingFrameRef.current then
            scrollingFrameRef.current.CanvasSize = UDim2.new(0, arg1.AbsoluteSize.X, 1, 0)
        end
    end)

    local var6 = React.useRef({})
    local var7 = var1 and RoactGamepad.useRefCache() or var6.current

    local onActivated = React.useCallback(function()
        if tbl1.onSelectionChanged then
            tbl1.onSelectionChanged({})
        end
    end)

    local var9 = React.useMemo(function()
        local tbl2 = {}
        for _, pill in tbl1.pills do
            if not Cryo.List.find(var4, pill) then
                table.insert(tbl2, pill)
            end
        end
        return Cryo.List.join(var4, tbl2)
    end, { tbl1.pills, var4 })

    local bool1 = #var4 > 1

    local tbl2 = {
        ClearButton = if bool1 then React.createElement(IconButton, {
            layoutOrder = 1,
            size = UDim2.fromOffset(24, 24),
            iconSize = IconSize.Medium,
            icon = Images["icons/actions/reject"],
            onActivated = onActivated,
            key = "0",
            buttonRef = var7[0],
            NextSelectionRight = var7[1]
        })
            or nil else nil
    }

    local isLoading = tbl1.isLoading

    for value, text in var9 do
        local function onActivated()
            local bool2 = Cryo.List.find(var4, text) ~= nil
            local var10 = if bool2 then Cryo.List.removeValue(var4, text) else Cryo.List.join(var4, { text })

            if not bool2 then
                scrollToStart()
            end

            if tbl1.onSelectionChanged then
                tbl1.onSelectionChanged(var10)
            end
        end

        local isSelected = value <= #var4

        if isSelected then
            isLoading = false
        end

        if not var1 then
            var7[value] = var7[value] or React.createRef()
        end

        local createElement = React.createElement
        local var10 = if var1 then Focusable[Pillv2] else Pillv2
        local tbl3 = {
            layoutOrder = value + 1,
            key = tostring(value),
            text = text,
            isSelected = isSelected,
            isLoading = tbl1.isLoading and not isSelected,
            onActivated = onActivated,
            ref = var7[value],
            NextSelectionLeft = if value > 1 or bool1 then var7[value - 1] else nil,
            NextSelectionRight = if value < #var9 then var7[value + 1] else nil
        }
        tbl2[value] = createElement(var10, tbl3)
    end

    if isLoading and var2 and var1 then
        tbl2[1] = React.createElement(Focusable[Pillv2], { layoutOrder = 2, key = "1", ref = var7[1], text = "" })
    end

    local function getScrollingListChildren()
        local tbl3 = {
            SubNavFrame = React.createElement(FitFrameHorizontal, {
                height = UDim.new(1, 0),
                contentPadding = UDim.new(0, 8),
                margin = FitFrame.Rect.quad(0, rightPadding, 0, leftPadding),
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                BackgroundTransparency = 1,
                [React.Change.AbsoluteSize] = var5
            }, tbl2)
        }
        return tbl3
    end

    local buttonRefs = ({})
    for i = 1, #var9 do
        buttonRefs[i] = var7[i]
    end

    return React.createElement(if var1 then Focusable.Frame else "Frame", {
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = theme.BackgroundDefault.Color,
        BackgroundTransparency = theme.BackgroundDefault.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        ref = tbl1.forwardRef,
        NextSelectionUp = tbl1.NextSelectionUp,
        NextSelectionDown = tbl1.NextSelectionDown,
        defaultChild = if var1 then var7[1] else nil
    }, {
        ScrollingList = React.createElement(ScrollingListWithArrowsAndGradient, {
            getScollingListContent = getScrollingListChildren,
            listHeight = 52,
            scrollingFrameRef = scrollingFrameRef,
            buttonRefs = buttonRefs,
            buttonPadding = 8,
            padOutsideEdges = false,
            hideGradient = true
        })
    })
end

return React.forwardRef(function(arg1, forwardRef)
    return React.createElement(PillGroup, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
