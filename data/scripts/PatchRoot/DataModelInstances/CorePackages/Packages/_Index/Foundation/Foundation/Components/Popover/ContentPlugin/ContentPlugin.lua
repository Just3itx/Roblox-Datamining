-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
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
local usePluginAnchor = require(script.Parent.usePluginAnchor)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local isPointInGuiObjectBounds = require(Foundation.Utility.isPointInGuiObjectBounds)

local ElevationOwnerScope = require(Foundation.Providers.Elevation.ElevationProvider).ElevationOwnerScope

local _Types = require(Foundation.Providers.StudioPanels.Types)
local var1 = if Flags.FoundationPluginShadowSize then Constants.PLUGIN_SHADOW_SIZE else Constants.SHADOW_SIZE
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
    local var4 = React.useContext(PluginPopoverParentContext)
    local id = var4.id

    local var5 = React.useContext(PopoverContext)
    local styleSheet = useStyleSheet()
    local var7 = useTokens()

    local owner = useElevation(ElevationLayer.Popover, { stackAboveOwner = true })
    local relativeIndex = elevation.getRelativeIndex(owner)

    local var9, ref = React.useState(nil)
    React.useImperativeHandle(arg2, function()
        return var9
    end, { var9 })

    local var11 = useOverlay()

    local var12 = React.useMemo(function(): Frame
        local popoverPluginContainer = Instance.new("Frame")
        popoverPluginContainer.Name = "PopoverPluginContainer"
        popoverPluginContainer.BackgroundTransparency = 1
        popoverPluginContainer.BorderSizePixel = 0
        popoverPluginContainer.ClipsDescendants = false
        popoverPluginContainer.Position = UDim2.fromOffset(-10000, -10000)
        return popoverPluginContainer
    end, {})
    React.useEffect(function()
        return function()
            var12:Destroy()
        end
    end, { var12 })

    local var13, var14 = React.useBinding(UDim2.new())
    local var15 = var14
    local contentSize, var17 = React.useBinding(UDim2.new())
    local var18 = var17
    local var19, var20 = React.useState(nil)
    local var21 = var19
    local var22 = var20

    local size200 = var7.Size.Size_200
    local var23 = size200 * math.sqrt(2) / 2
    local backgroundStyle = var2.backgroundStyle or var7.Color.Surface.Surface_100
    local var25 = if var2.side then var2.side else PopoverSide.Bottom
    local var26 = if var2.align then var2.align else PopoverAlign.Center
    local var27 = if type(var25) ~= "table" then 0 else var25.offset
    local var28 = if type(var26) ~= "table" then 0 else var26.offset
    local var29 = if type(var25) == "table" then var25.position else var25

    if type(var26) == "table" then
        var26 = var26.position
    end
    local num1 = 0
    if var26 == PopoverAlign.Center then
        num1 = 0.5
    elseif var26 == PopoverAlign.End then
        num1 = 1
    end

    local anchorUri = var5.anchorUri
    local var30 = usePluginAnchor(var5.anchor, anchorUri)
    local hasArrow = not var30.isVirtual and var2.hasArrow
    local ready = var5.isOpen and var30.isReady and var4.ready
    local var31 = ready and var11 ~= nil
    local var32 = var31 and var21 == nil

    React.useEffect(function()
        if not ready then
            var22(nil)
        end
    end, { ready })

    local onAbsoluteSizeChanged = React.useCallback(function(arg3)
        if not (Flags.FoundationPopoverRecomputeContentSize or var32) then
            return
        end
        local absoluteSize = arg3.AbsoluteSize
        if absoluteSize.X > 0 and absoluteSize.Y > 0 then
            var22(absoluteSize)
        end
    end, { if Flags.FoundationPopoverRecomputeContentSize then nil else var32 })

    local position = React.useMemo(function()
        return getPanelPosition(var25, var2.align or PopoverAlign.Start, nil, var1, if hasArrow then var23 else 0)
    end, {
        var25,
        var2.align,
        hasArrow,
        var23
    })

    local registerPanelAsync = React.useCallback(function(arg3, arg4, func1: (...any) -> (...any), num2: number?, str1: string?, bool1: boolean?, vector2: Vector2?)
        local registerPopoverAsync = var3.registerPopoverAsync

        if not Flags.FoundationPopoverPluginFocusable then
            bool1 = nil
        end

        if not Flags.FoundationPopoverPluginPoolReclaim then
            vector2 = nil
        end

        return registerPopoverAsync(arg3, arg4, func1, num2, str1, bool1, vector2)
    end, { var3.registerPopoverAsync })

    local var36 = React.useRef(false)
    React.useEffect(function()
        if not (var2.onPressedOutside or var36.current) then
            var36.current = true
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
            and typeof(var5.anchor) == "Instance"
            and var5.anchor.GuiState ~= Enum.GuiState.Idle
        then
            return
        end

        var2.onPressedOutside()
    end, { var2.onPressedOutside, var5.anchor })

    local depth = if relativeIndex == nil then 0 else relativeIndex
    local var39 = if Flags.FoundationPopoverPluginPoolReclaim and var21 then positioning.calculatePopoverBounds(var29, var27, var28, if hasArrow then var23 else 0, var21) + Vector2.new(var1 * 2, var1 * 2) else nil

    local var40 = usePanel({
        isOpen = if Flags.FoundationPopoverPluginPoolReclaim then ready and var39 ~= nil else ready,
        onClose = onClose,
        anchorUri = var30.uri,
        registerPanelAsync = registerPanelAsync,
        position = position,
        depth = depth,
        parentPopoverId = id,
        isFocusable = if Flags.FoundationPopoverPluginFocusable then var2.isFocusable else nil,
        initialSize = if Flags.FoundationPopoverPluginPoolReclaim then var39 else nil
    })

    React.useEffect(function()
        if not Flags.FoundationPopoverClickOutsideInGuiShadow then
            return
        end

        if not (var40 and var40.container and var2.onPressedOutside) then
            return
        end
        local connection = var40.container.InputBegan:Connect(function(input: InputObject)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not var9 then
                return
            end

            local vector2 = Vector2.new(input.Position.X, input.Position.Y)
            if not isPointInGuiObjectBounds(var9, vector2) then
                var2.onPressedOutside()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { var40, var9, var2.onPressedOutside })
    React.useLayoutEffect(function()
        if not var32 or var9 == nil then
            return
        end

        local absoluteSize = var9.AbsoluteSize
        if absoluteSize.X > 0 and absoluteSize.Y > 0 then
            var22(absoluteSize)
        end
    end, { var32, var9 })

    local var41 = if Flags.FoundationPopoverPluginPoolReclaim then nil else React.useMemo(function()
        if var21 then
            return positioning.calculatePopoverBounds(var29, var27, var28, if hasArrow then var23 else 0, var21) + Vector2.new(var1 * 2, var1 * 2)
        end

        return nil
    end, {
        var21,
        var29,
        var27,
        var28,
        hasArrow,
        var23
    })

    React.useLayoutEffect(function()
        local var42 = if Flags.FoundationPopoverPluginPoolReclaim then var39 else var41

        if var21 == nil or var42 == nil then
            var18(UDim2.new())
            var15(UDim2.new())
            return
        end

        var18(UDim2.fromOffset(var21.X, var21.Y))
        var15(UDim2.fromOffset(var42.X, var42.Y))

        if var40 then
            var40.setSizeAsync(var42)
        end
    end, { var21, if Flags.FoundationPopoverPluginPoolReclaim then var39 else var41, var40 })

    local useLayoutEffect = React.useLayoutEffect
    local function func1()
        if not var31 then
            var12.Parent = nil
            return
        end

        local var42 = if Flags.FoundationPopoverPluginPoolReclaim then var39 else var41

        if var40 and var42 then
            var12.AutomaticSize = Enum.AutomaticSize.None
            var12.Size = UDim2.fromOffset(var42.X, var42.Y)
            var12.Position = UDim2.new()
            var12.Parent = var40.container
            return
        end
        var12.AutomaticSize = Enum.AutomaticSize.XY
        var12.Size = UDim2.new()
        var12.Position = UDim2.fromOffset(-10000, -10000)
        var12.Parent = var11
    end

    local var42 = var31
    local var43 = if Flags.FoundationPopoverPluginPoolReclaim then var39 else var41
    useLayoutEffect(func1, { var42, var11, var40, var43, var12 })
    local anchor = if var30.isVirtual or typeof(var5.anchor) ~= "Instance" then nil else var5.anchor
    local var6 = useArrowPosition(contentSize, var29, var2.radius, num1, var23, anchor)
    local bool1 = not (var40 == nil) and (if Flags.FoundationPopoverPluginPoolReclaim then var39 else var41) ~= nil
    local var45 = var31

    local value = React.useMemo(function()
        return {
            id = if var40 then var40.popoverId else nil,
            ready = bool1
        }
    end, { var40, bool1 })

    local var47

    if var45 and var12 then
        local createPortal = ReactRoblox.createPortal
        local createElement = React.createElement
        local fragment = React.Fragment
        local var48 = nil
        local tbl3 = {
            StyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet }),
            Container = 0
        }

        local createElement2 = React.createElement
        local var49 = View
        local tbl4 = {
            AutomaticSize = if (if Flags.FoundationPopoverPluginPoolReclaim then var39 else var41) == nil then Enum.AutomaticSize.XY else nil,
            Size = 0,
            testId = 0
        }

        if (if Flags.FoundationPopoverPluginPoolReclaim then var39 else var41) == nil then
            var13 = nil
        end

        tbl4.Size = var13

        tbl4.testId = `{var5.testId}--container`
        tbl3.Container = createElement2(var49, tbl4, {
            Shadow = React.createElement(PopoverShadow, {
                contentSize = contentSize,
                position = UDim2.fromOffset(var1 / 2, var1 / 2 + (if Flags.FoundationPluginShadowSize then 0 else 2)),
                radiusTag = tbl2[var2.radius],
                ZIndex = 1,
                testId = `{var5.testId}--shadow`
            }),
            Arrow = if hasArrow then React.createElement(PopoverArrow, {
                size = size200,
                position = var6,
                ZIndex = 2,
                backgroundStyle = backgroundStyle,
                testId = `{var5.testId}--arrow`
            }) else nil,
            Content = React.createElement(
                View,
                {
                    tag = `auto-xy {tbl2[var2.radius]}`,
                    Position = UDim2.fromOffset(var1, var1),
                    ref = ref,
                    onAbsoluteSizeChanged = onAbsoluteSizeChanged,
                    backgroundStyle = backgroundStyle,
                    ZIndex = 3,
                    testId = `{var5.testId}--content`
                },
                React.createElement(
                    PluginPopoverParentContext.Provider,
                    { value = value },
                    {
                        Nested = React.createElement(ElevationOwnerScope, { owner = owner }, var2.children)
                    }
                )
            )
        })
        var47 = createPortal(createElement(fragment, var48, tbl3), var12)
    else
        var47 = nil
    end

    return React.createElement(React.Fragment, nil, { Anchor = var30.element, Panel = var47 })
end)
