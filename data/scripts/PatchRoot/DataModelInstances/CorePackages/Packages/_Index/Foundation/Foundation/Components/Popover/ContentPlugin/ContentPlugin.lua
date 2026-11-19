-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:36Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactRoblox = require(FoundationParent.ReactRoblox)

local ElevationLayer = require(Foundation.Enums.ElevationLayer)
local PluginPopoverParentContext = require(Foundation.Providers.StudioPanels.PluginPopoverParentContext)
local PopoverAlign = require(Foundation.Enums.PopoverAlign)
local PopoverArrow = require(script.Parent.Parent.PopoverArrow)
local _Content = require(script.Parent.Parent.Content)
local PopoverContext = require(script.Parent.Parent.PopoverContext)
local PopoverShadow = require(script.Parent.Parent.PopoverShadow)
local PopoverSide = require(Foundation.Enums.PopoverSide)
local getPanelPosition = require(script.Parent.getPanelPosition)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local usePanel = require(Foundation.Providers.StudioPanels.usePanel)
local usePanelsContext = require(Foundation.Providers.StudioPanels.usePanelsContext)
local useStyleSheet = require(Foundation.Providers.Style.StyleSheetContext).useStyleSheet
local Constants = require(Foundation.Constants)
local Flags = require(Foundation.Utility.Flags)
local Logger = require(Foundation.Utility.Logger)
local Radius = require(Foundation.Enums.Radius)
local _StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local View = require(Foundation.Components.View)
local elevation = require(Foundation.Providers.Elevation.elevation)
local positioning = require(script.Parent.Parent.positioning)
local useArrowPosition = require(script.Parent.useArrowPosition)
local useElevation = require(Foundation.Providers.Elevation.useElevation)
local _useFloating = require(Foundation.Components.Popover.useFloating)
local usePanelSizing = require(script.Parent.usePanelSizing)
local usePluginAnchor = require(script.Parent.usePluginAnchor)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local isPointInGuiObjectBounds = require(Foundation.Utility.isPointInGuiObjectBounds)

local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope

local _Types = require(Foundation.Providers.StudioPanels.Types)
local var1 = if Flags.FoundationPopoverPluginOverlayMeasurement and Flags.FoundationPluginShadowSize then Constants.PLUGIN_SHADOW_SIZE else Constants.SHADOW_SIZE
local tbl1 = {
    side = PopoverSide.Bottom,
    align = PopoverAlign.Center,
    hasArrow = true,
    radius = Radius.Medium
}

local tbl2 = {
    [Radius.Small] = "radius-small",
    [Radius.Medium] = "radius-medium",
    [Radius.Circle] = "radius-circle"
}

return React.forwardRef(function(arg1, arg2) -- name: PopoverContentPlugin
    local var2 = withDefaults(arg1, tbl1)

    local var3 = usePanelsContext()
    local var4 = if Flags.FoundationPopoverPluginOverlayMeasurement then React.useContext(PluginPopoverParentContext) else nil
    local parentPopoverId = if Flags.FoundationPopoverPluginOverlayMeasurement then var4.id else React.useContext(PluginPopoverParentContext)
    local var6 = React.useContext(PopoverContext)
    local styleSheet = useStyleSheet()
    local var8 = useTokens()

    local owner = useElevation(ElevationLayer.Popover, { stackAboveOwner = true })
    local relativeIndex = elevation.getRelativeIndex(owner)

    local var10, ref = React.useState(nil)
    React.useImperativeHandle(arg2, function()
        return var10
    end, { var10 })

    local var12 = if Flags.FoundationPopoverPluginOverlayMeasurement then useOverlay() else nil

    local var13 = if Flags.FoundationPopoverPluginOverlayMeasurement then React.useMemo(function(): Frame
        local popoverPluginContainer = Instance.new("Frame")
        popoverPluginContainer.Name = "PopoverPluginContainer"
        popoverPluginContainer.BackgroundTransparency = 1
        popoverPluginContainer.BorderSizePixel = 0
        popoverPluginContainer.ClipsDescendants = false
        popoverPluginContainer.Position = UDim2.fromOffset(-10000, -10000)
        return popoverPluginContainer
    end, {}) else nil

    if Flags.FoundationPopoverPluginOverlayMeasurement then
        React.useEffect(function()
            return function()
                var13:Destroy()
            end
        end, { var13 })
    end

    local var14 = nil
    local var15 = nil
    local var16 = nil
    local var17 = nil
    local var18 = nil
    local var19 = nil
    if Flags.FoundationPopoverPluginOverlayMeasurement then
        local var20
        var14, var20 = React.useBinding(UDim2.new())
        var15 = var20
        local var21
        var16, var21 = React.useBinding(UDim2.new())
        var17 = var21
        var18, var19 = React.useState(nil)
    end

    local size200 = var8.Size.Size_200
    local var20 = size200 * math.sqrt(2) / 2
    local backgroundStyle = var2.backgroundStyle or var8.Color.Surface.Surface_100
    local var22 = nil
    local var23 = nil
    local var24 = nil
    local var25 = nil
    if Flags.FoundationPopoverPluginOverlayMeasurement then
        if var2.side then
            var22 = var2.side
        else
            var22 = PopoverSide.Bottom
        end

        if var2.align then
            var23 = var2.align
        else
            var23 = PopoverAlign.Center
        end

        var24 = if type(var22) ~= "table" then 0 else var22.offset
        if type(var23) == "table" then
            var25 = var23.offset
        else
            var25 = 0
        end
    end

    local var26

    if Flags.FoundationPopoverPluginOverlayMeasurement then
        if type(var22) == "table" then
            var26 = var22.position
        else
            var26 = var22
        end

        if type(var23) == "table" then
            var23 = var23.position
        end
    else
        if type(var2.side) == "table" then
            var26 = var2.side.position
        else
            var26 = var2.side or PopoverSide.Bottom
        end

        if type(var2.align) == "table" then
            var23 = var2.align.position
        else
            var23 = var2.align or PopoverAlign.Center
        end
    end
    local num1 = 0
    if var23 == PopoverAlign.Center then
        num1 = 0.5
    elseif var23 == PopoverAlign.End then
        num1 = 1
    end

    local anchorUri = var6.anchorUri
    local var27 = usePluginAnchor(var6.anchor, anchorUri)
    local hasArrow = not var27.isVirtual and var2.hasArrow
    local ready = nil
    local var28 = nil
    local var29 = nil
    if Flags.FoundationPopoverPluginOverlayMeasurement then
        ready = var6.isOpen and var27.isReady and var4.ready
        var28 = ready and var12 ~= nil
        var29 = var28 and var18 == nil

        React.useEffect(function()
            if not ready then
                var19(nil)
            end
        end, { ready })
    end

    local var30 = if Flags.FoundationPopoverPluginOverlayMeasurement then React.useCallback(function(arg3)
        if not (Flags.FoundationPopoverRecomputeContentSize or var29) then
            return
        end
        local absoluteSize = arg3.AbsoluteSize
        if absoluteSize.X > 0 and absoluteSize.Y > 0 then
            var19(absoluteSize)
        end
    end, { if Flags.FoundationPopoverRecomputeContentSize then nil else var29 }) else nil

    local position = React.useMemo(function()
        return getPanelPosition(
            if Flags.FoundationPopoverPluginOverlayMeasurement then var22 else var2.side or PopoverSide.Bottom,
            var2.align or PopoverAlign.Start,
            nil,
            var1,
            if hasArrow then var20 else 0
        )
    end, {
        if Flags.FoundationPopoverPluginOverlayMeasurement then var22 else var2.side,
        var2.align,
        hasArrow,
        var20
    })

    local registerPanelAsync = React.useCallback(function(arg3, arg4, func1: (...any) -> (...any), num2: number?, str1: string?, bool1: boolean?)
        local registerPopoverAsync = var3.registerPopoverAsync

        if not Flags.FoundationPopoverPluginFocusable then
            bool1 = nil
        end

        return registerPopoverAsync(arg3, arg4, func1, num2, str1, bool1)
    end, { var3.registerPopoverAsync })

    local var33 = React.useRef(false)
    React.useEffect(function()
        if not (var2.onPressedOutside or var33.current) then
            var33.current = true
            Logger:warning(
                "PopoverContent rendered in a plugin context without onPressedOutside. In Studio, the QWidget popup will close on focus loss, but the parent's isOpen state will not update. Provide onPressedOutside to stay in sync."
            )
        end
    end, { var2.onPressedOutside })

    local onClose = React.useCallback(function()
        if not var2.onPressedOutside then
            return
        end
        if Flags.FoundationPopoverClickOutsideInGuiShadow
            and typeof(var6.anchor) == "Instance"
            and var6.anchor.GuiState ~= Enum.GuiState.Idle
        then
            return
        end

        var2.onPressedOutside()
    end, { var2.onPressedOutside, var6.anchor })

    local depth = if relativeIndex == nil then 0 else relativeIndex
    local var36 = usePanel({
        isOpen = if Flags.FoundationPopoverPluginOverlayMeasurement then ready else var6.isOpen and var27.isReady,
        onClose = onClose,
        anchorUri = var27.uri,
        registerPanelAsync = registerPanelAsync,
        position = position,
        depth = depth,
        parentPopoverId = parentPopoverId,
        isFocusable = if Flags.FoundationPopoverPluginFocusable then var2.isFocusable else nil
    })

    if not Flags.FoundationPopoverPluginOverlayMeasurement then
        var14, var16 = usePanelSizing(var2.side, var2.align, var10, if hasArrow then var20 else 0, var36)
    end

    React.useEffect(function()
        if not Flags.FoundationPopoverClickOutsideInGuiShadow then
            return
        end

        if not (var36 and var36.container and var2.onPressedOutside) then
            return
        end
        local connection = var36.container.InputBegan:Connect(function(input: InputObject)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not var10 then
                return
            end

            local vector2 = Vector2.new(input.Position.X, input.Position.Y)
            if not isPointInGuiObjectBounds(var10, vector2) then
                var2.onPressedOutside()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { var36, var10, var2.onPressedOutside })

    if Flags.FoundationPopoverPluginOverlayMeasurement then
        React.useLayoutEffect(function()
            if not var29 or var10 == nil then
                return
            end

            local absoluteSize = var10.AbsoluteSize
            if absoluteSize.X > 0 and absoluteSize.Y > 0 then
                var19(absoluteSize)
            end
        end, { var29, var10 })
    end

    local var37 = if Flags.FoundationPopoverPluginOverlayMeasurement then React.useMemo(function()
        if var18 then
            return positioning.calculatePopoverBounds(var26, var24, var25, if hasArrow then var20 else 0, var18) + Vector2.new(var1 * 2, var1 * 2)
        end

        return nil
    end, {
        var18,
        var26,
        var24,
        var25,
        hasArrow,
        var20
    }) else nil

    if Flags.FoundationPopoverPluginOverlayMeasurement then
        React.useLayoutEffect(function()
            if var18 == nil or var37 == nil then
                var17(UDim2.new())
                var15(UDim2.new())
                return
            end

            var17(UDim2.fromOffset(var18.X, var18.Y))
            var15(UDim2.fromOffset(var37.X, var37.Y))

            if var36 then
                var36.setSizeAsync(var37)
            end
        end, { var18, var37, var36 })

        React.useLayoutEffect(function()
            if not var28 then
                var13.Parent = nil
                return
            end

            if var36 and var37 then
                var13.AutomaticSize = Enum.AutomaticSize.None
                var13.Size = UDim2.fromOffset(var37.X, var37.Y)
                var13.Position = UDim2.new()
                var13.Parent = var36.container
            else
                var13.AutomaticSize = Enum.AutomaticSize.XY
                var13.Size = UDim2.new()
                var13.Position = UDim2.fromOffset(-10000, -10000)
                var13.Parent = var12
            end
        end, {
            var28,
            var12,
            var36,
            var37,
            var13
        })
    end

    local anchor = if var27.isVirtual or typeof(var6.anchor) ~= "Instance" then nil else var6.anchor
    local var5 = useArrowPosition(var16, var26, var2.radius, num1, var20, anchor)
    local bool1 = not Flags.FoundationPopoverPluginOverlayMeasurement or not (var36 == nil) and var37 ~= nil
    local var39 = if Flags.FoundationPopoverPluginOverlayMeasurement then var28 else var36 ~= nil
    local var40 = if Flags.FoundationPopoverPluginOverlayMeasurement then var13 elseif var36 then var36.container else nil

    local var41 = if Flags.FoundationPopoverPluginOverlayMeasurement then React.useMemo(function()
        return {
            id = if var36 then var36.popoverId else nil,
            ready = bool1
        }
    end, { var36, bool1 }) else nil

    local var42

    if var39 and var40 then
        local createPortal = ReactRoblox.createPortal
        local createElement = React.createElement
        local fragment = React.Fragment
        local var43 = nil
        local tbl3 = {
            StyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet }),
            Container = 0
        }

        local createElement2 = React.createElement
        local var44 = View
        local tbl4 = {
            AutomaticSize = if Flags.FoundationPopoverPluginOverlayMeasurement and var37 == nil then Enum.AutomaticSize.XY else nil,
            Size = 0,
            testId = 0
        }

        if Flags.FoundationPopoverPluginOverlayMeasurement and var37 == nil then
            var14 = nil
        end

        tbl4.Size = var14

        tbl4.testId = `{var6.testId}--container`
        local tbl5 = {
            Shadow = React.createElement(PopoverShadow, {
                contentSize = var16,
                position = UDim2.fromOffset(
                    var1 / 2,
                    var1 / 2 + (Flags.FoundationPopoverPluginOverlayMeasurement and Flags.FoundationPluginShadowSize and 0 or 2)
                ),
                radiusTag = tbl2[var2.radius],
                ZIndex = 1,
                testId = `{var6.testId}--shadow`
            }),
            Arrow = if hasArrow then React.createElement(PopoverArrow, {
                size = size200,
                position = var5,
                ZIndex = 2,
                backgroundStyle = backgroundStyle,
                testId = `{var6.testId}--arrow`
            }) else nil,
            Content = 0
        }

        local createElement3 = React.createElement
        local var45 = View
        local tbl6 = {
            tag = `auto-xy {tbl2[var2.radius]}`,
            Position = UDim2.fromOffset(var1, var1),
            ref = ref,
            onAbsoluteSizeChanged = 0,
            backgroundStyle = 0,
            ZIndex = 3,
            testId = 0
        }

        if not Flags.FoundationPopoverPluginOverlayMeasurement then
            var30 = nil
        end

        tbl6.onAbsoluteSizeChanged = var30

        tbl6.backgroundStyle = backgroundStyle

        tbl6.testId = `{var6.testId}--content`

        local createElement4 = React.createElement
        local provider = PluginPopoverParentContext.Provider
        local tbl7 = { value = 0 }
        if not Flags.FoundationPopoverPluginOverlayMeasurement then
            var41 = var36.popoverId
        end

        tbl7.value = var41
        tbl5.Content = createElement3(
            var45,
            tbl6,
            createElement4(provider, tbl7, { Nested = React.createElement(ElevationOwnerScope, { owner = owner }, var2.children) })
        )
        tbl3.Container = createElement2(var44, tbl4, tbl5)
        local element = createElement(fragment, var43, tbl3)

        if not Flags.FoundationPopoverPluginOverlayMeasurement then
            var40 = var36.container
        end

        var42 = createPortal(element, var40)
    else
        var42 = nil
    end

    return React.createElement(React.Fragment, nil, { Anchor = var27.element, Panel = var42 })
end)
