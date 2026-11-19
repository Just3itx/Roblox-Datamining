-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Constants = require(Foundation.Constants)
local Dash = require(FoundationParent.Dash)
local Flags = require(Foundation.Utility.Flags)
local Image = require(Foundation.Components.Image)
local PopoverContext = require(script.Parent.Parent.PopoverContext)
local View = require(Foundation.Components.View)
local isPointInGuiObjectBounds = require(Foundation.Utility.isPointInGuiObjectBounds)
local useFloating = require(script.Parent.Parent.useFloating)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local usePointerPosition = require(Foundation.Utility.usePointerPosition)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local Radius = require(Foundation.Enums.Radius)
local React = require(FoundationParent.React)
local ReactRoblox = require(FoundationParent.ReactRoblox)
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local ElevationLayer = require(Foundation.Enums.ElevationLayer)
local _Types = require(Foundation.Components.Types)
local useElevation = require(Foundation.Providers.Elevation.useElevation)
local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope

local tbl1 = {
    side = PopoverSide.Bottom,
    align = PopoverAlign.Center,
    hasArrow = true,
    selection = Constants.MODAL.DISABLE_SELECTION,
    selectionGroup = Constants.MODAL.TRAP_FOCUS,
    radius = Radius.Medium
}

local tbl2 = {
    [Radius.Small] = "radius-small",
    [Radius.Medium] = "radius-medium",
    [Radius.Circle] = "radius-circle"
}

local SHADOW_IMAGE = Constants.SHADOW_IMAGE
local SHADOW_SIZE = Constants.SHADOW_SIZE

return React.forwardRef(function(tbl3, arg1) -- name: PopoverContent
    local var1 = withDefaults(tbl3, tbl1)
    local var2 = React.useContext(PopoverContext)
    local bool1 = typeof(var2.anchor) == "Instance"
    local hasArrow = if bool1 then var1.hasArrow else false
    local var3 = useOverlay()

    local var4 = useTokens()
    local owner = useElevation(ElevationLayer.Popover, { stackAboveOwner = true })

    local size200 = var4.Size.Size_200
    local var6 = size200 * math.sqrt(2) / 2
    local backgroundStyle = var1.backgroundStyle or var4.Color.Surface.Surface_100

    local var8, ref = React.useState(nil)
    local var10, var11 = React.useState(nil)
    local var12 = usePointerPosition(var10)

    React.useImperativeHandle(arg1, function()
        return var8
    end, { var8 })

    local var13, var14, var15, var16, maxSize, zero = useFloating(var2.isOpen, var2.anchor, var8, var3, var1.side, var1.align, if hasArrow then var6 else 0)

    local var18 = React.useRef(nil)

    local var5 = React.useCallback(function(arg2)
        if var18.current then
            var18.current:Disconnect()
        end
        var11(arg2)

        if arg2 == nil or not var1.onPressedOutside then
            return
        end

        var18.current = arg2:GetPropertyChangedSignal("GuiState"):Connect(function()
            if arg2.GuiState ~= Enum.GuiState.Press then
                return
            end

            if var2.anchor and bool1 then
                local anchor = var2.anchor
                local value = var12:getValue()
                if isPointInGuiObjectBounds(anchor, value) then
                    return
                end

                if anchor.GuiState ~= Enum.GuiState.Idle then
                    return
                end
            end

            var1.onPressedOutside()
        end)
    end, { var1.onPressedOutside, var2.anchor })

    React.useEffect(function()
        return function()
            if var18.current then
                var18.current:Disconnect()
            end
        end
    end, {})

    local var20 = if Flags.FoundationPopoverContentAnchorFix then React.joinBindings({ var13, zero, var15 }):map(function(tbl4): UDim2
        local var20 = tbl4[1]
        local var21 = tbl4[2]
        local var22 = tbl4[3]
        return UDim2.fromOffset(var20.X - var21.X * var22.X.Offset, var20.Y - var21.Y * var22.Y.Offset)
    end) else nil

    local var21

    if var2.isOpen then
        local createElement = React.createElement
        local var22 = View
        local tbl4 = {
            ZIndex = owner.zIndex,
            tag = "size-full",
            Visible = var14,
            testId = `{var2.testId}--container`
        }
        local tbl5 = {
            Backdrop = if var1.onPressedOutside and var2.isOpen then React.createElement(View, {
                ZIndex = 1,
                stateLayer = {
                    affordance = StateLayerAffordance.None
                },
                Size = UDim2.fromScale(2, 2),
                tag = "position-center-center anchor-center-center",
                ref = var5,
                testId = `{var2.testId}--backdrop`
            }) else nil,
            Shadow = 0,
            Arrow = 0,
            Content = 0
        }
        local element

        if Flags.FoundationPopoverOverlayShadow then
            element = React.createElement(View, {
                AnchorPoint = zero,
                Size = var15,
                Position = var13:map(function(vector2: Vector2): UDim2
                    return UDim2.fromOffset(vector2.X, vector2.Y)
                end),
                ZIndex = 2,
                tag = `shadow-overlay-300 {tbl2[var1.radius]}`,
                testId = `{var2.testId}--shadow`
            })
        else
            element = React.createElement(Image, {
                AnchorPoint = zero,
                Image = SHADOW_IMAGE,
                Size = var15:map(function(uDim2: UDim2)
                    return uDim2 + UDim2.fromOffset(SHADOW_SIZE, SHADOW_SIZE)
                end),
                Position = React.joinBindings({ var13, zero }):map(function(tbl6): UDim2
                    local num1 = if tbl6[2].X == 0 then -1 else 1
                    local num2 = if tbl6[2].Y == 0 then -1 else 1
                    return UDim2.fromOffset(tbl6[1].X + SHADOW_SIZE / 2 * num1, tbl6[1].Y + SHADOW_SIZE / 2 * num2 + 2)
                end),
                ZIndex = 2,
                slice = {
                    center = Rect.new(SHADOW_SIZE, SHADOW_SIZE, SHADOW_SIZE + 1, SHADOW_SIZE + 1)
                },
                imageStyle = var4.Color.Extended.Black.Black_20,
                testId = `{var2.testId}--shadow`
            })
        end

        tbl5.Shadow = element

        tbl5.Arrow = if hasArrow then React.createElement(View, {
            Size = UDim2.fromOffset(size200, size200),
            Position = var16:map(function(vector2: Vector2): UDim2
                return UDim2.fromOffset(vector2.X, vector2.Y)
            end),
            Rotation = 45,
            ZIndex = 3,
            backgroundStyle = backgroundStyle,
            tag = "anchor-center-center",
            testId = `{var2.testId}--arrow`
        }) else nil

        local createElement2 = React.createElement
        local var23 = View
        local tbl6 = {
            AnchorPoint = 0,
            Position = 0,
            selection = 0,
            selectionGroup = 0,
            sizeConstraint = 0,
            stateLayer = 0,
            ZIndex = 4,
            onActivated = 0,
            backgroundStyle = 0,
            tag = 0,
            ref = 0,
            testId = 0
        }

        if Flags.FoundationPopoverContentAnchorFix then
            zero = Vector2.zero
        end

        tbl6.AnchorPoint = zero
        if not Flags.FoundationPopoverContentAnchorFix then
            var20 = var13:map(function(vector2: Vector2): UDim2
                return UDim2.fromOffset(vector2.X, vector2.Y)
            end)
        end

        tbl6.Position = var20

        tbl6.selection = var1.selection
        tbl6.selectionGroup = var1.selectionGroup
        tbl6.sizeConstraint = { MaxSize = maxSize }

        tbl6.stateLayer = {
            affordance = StateLayerAffordance.None
        }

        tbl6.onActivated = if var1.onPressedOutside or var1.DO_NOT_USE_hasContentInputSink then Dash.noop else nil
        tbl6.backgroundStyle = backgroundStyle
        tbl6.tag = `auto-xy {tbl2[var1.radius]}`
        tbl6.ref = ref
        tbl6.testId = `{var2.testId}--content`
        tbl5.Content = createElement2(var23, tbl6, React.createElement(ElevationOwnerScope, { owner = owner }, var1.children))
        var21 = createElement(var22, tbl4, tbl5)
    else
        var21 = nil
    end

    if var3 == nil then
        return var21
    end

    return ReactRoblox.createPortal(var21, var3)
end)
