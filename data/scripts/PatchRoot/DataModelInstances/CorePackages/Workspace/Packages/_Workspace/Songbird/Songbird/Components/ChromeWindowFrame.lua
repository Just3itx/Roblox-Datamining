-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local Cryo = require(Songbird.Parent.Cryo)
local Foundation = require(Songbird.Parent.Foundation)
local React = require(Songbird.Parent.React)
local ReactUtils = require(Songbird.Parent.ReactUtils)
local Responsive = require(Songbird.Parent.Responsive)
local CollapsibleFrame = require(Songbird.Components.CollapsibleFrame)
local constants = require(Songbird.constants)

local getFFlagSongbirdPopoverSubmenu = require(Songbird.Flags.getFFlagSongbirdPopoverSubmenu)

local GetFFlagChromeMusicWindowTopbarReappearsOnGamepad = require(Songbird.Parent.SharedFlags).GetFFlagChromeMusicWindowTopbarReappearsOnGamepad

local createNextOrder = ReactUtils.createNextOrder
local usePrevious = ReactUtils.usePrevious
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState

local function useUnfocusKeybind(isFocused: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    useEffect(function()
        if not isFocused then
            return nil
        end

        ContextActionService:BindCoreAction("UnfocusMusicWindow", function(_: string, userInputState) -- name: unfocus
            if userInputState ~= Enum.UserInputState.End then
                return Enum.ContextActionResult.Pass
            end

            GuiService.SelectedCoreObject = nil

            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.ButtonB)

        return function()
            ContextActionService:UnbindCoreAction("UnfocusMusicWindow")
        end
    end, { isFocused })
end

local tbl1 = {
    autoCollapseSeconds = 3,
    isSubMenuOpen = false,
    isFocused = false,
    onToggleSubMenu = function() end
}

local function ChromeWindowFrame(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = Foundation.Hooks.useTokens()
    local ref = useRef(nil)
    local anchorRef = useRef(nil)

    local var5 = Responsive.useLastInput()
    local var6 = if GetFFlagChromeMusicWindowTopbarReappearsOnGamepad() then usePrevious(var5) else nil
    local bool1

    if getFFlagSongbirdPopoverSubmenu() or typeof(var1.overflowButtonRef) ~= "table" or not var1.overflowButtonRef.current then
        bool1 = true
    else
        local var7 = var1.overflowButtonRef.current.AbsolutePosition + Vector2.new(var2.Gap.Small + constants.SUBMENU_WIDTH, 0)
        local screenGui = var1.overflowButtonRef.current:FindFirstAncestorOfClass("ScreenGui")
        bool1 = var7.X < screenGui.AbsoluteSize.X
    end

    local nextOrder = createNextOrder()

    local var7 = useRef(nil)
    local var8, var9 = useState(true)

    local onActivated = useCallback(function()
        if var1.onClose then
            var1.onClose()
        end
    end, { var1.onClose })

    local onStateChanged = useCallback(function(default)
        var7.current = nil
        var9(true)

        if default == Foundation.Enums.ControlState.Default then
            var7.current = os.time()
        end
    end, {})

    useEffect(function()
        if var5 ~= Responsive.Input.Pointer then
            return
        end

        if not (var1.autoCollapseSeconds and var1.autoCollapseSeconds > 0) then
            return nil
        end

        local connection = RunService.Heartbeat:Connect(function()
            if var7.current and os.time() - var7.current >= var1.autoCollapseSeconds then
                var9(false)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { var1.autoCollapseSeconds, var5 })

    local var12, var13 = useState(Vector2.new(math.huge, math.huge))
    local onAbsoluteSizeChanged = useCallback(function(arg1)
        var13(arg1.AbsoluteSize)
    end, {})

    useEffect(function()
        local current = anchorRef.current

        if not current then
            return nil
        end

        local connection = current.SelectionChanged:Connect(function(_: boolean, _, arg1) -- name: onSelectionChanged
            if not current:IsAncestorOf(arg1) and var1.onUnfocus then
                var1.onUnfocus()
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { var1.onUnfocus })

    useEffect(function()
        if var1.isFocused then
            GuiService.SelectedCoreObject = ref.current
        end
    end, { var1.isFocused })

    useUnfocusKeybind(var1.isFocused)

    if GetFFlagChromeMusicWindowTopbarReappearsOnGamepad() then
        useEffect(function()
            if var6 and var5 ~= var6 and var5 ~= Responsive.Input.Pointer then
                var9(true)
            end
        end, { var5, var6 })
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        tag = "auto-xy",
        sizeConstraint = {
            MaxSize = if var1.maxSize then var1.maxSize else nil
        },
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        selectionGroup = {
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        },
        onStateChanged = onStateChanged,
        ref = if getFFlagSongbirdPopoverSubmenu() then anchorRef else nil
    }
    local tbl4 = { WindowFrame = 0, SubMenu = 0, OverflowMenu = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl5 = {
        tag = "size-full-0 auto-y bg-over-media-100 radius-medium col gap-xxsmall stroke-emphasis"
    }
    local tbl6 = {
        CollapsibleTitleBar = React.createElement(CollapsibleFrame, {
            isCollapsed = not var8,
            LayoutOrder = nextOrder()
        }, {
            TitleBar = React.createElement(Foundation.View, {
                tag = "size-full-0 auto-y row flex-between items-center"
            }, {
                Actions = React.createElement(
                    Foundation.View,
                    {
                        tag = "auto-xy row",
                        LayoutOrder = nextOrder(),
                        onAbsoluteSizeChanged = onAbsoluteSizeChanged
                    },
                    {
                        CloseButton = React.createElement(Foundation.IconButton, {
                            icon = Foundation.Enums.IconName.X,
                            layoutOrder = nextOrder(),
                            size = Foundation.Enums.IconSize.Medium,
                            onActivated = onActivated,
                            ref = ref
                        })
                    }
                ),
                CenterAlignedTitle = React.createElement(
                    Foundation.View,
                    {
                        tag = "size-full-0 shrink auto-y",
                        LayoutOrder = nextOrder()
                    },
                    {
                        Title = React.createElement(Foundation.Text, {
                            tag = "size-full-0 text-title-medium content-emphasis",
                            Text = var1.title,
                            fontStyle = var2.Typography.TitleMedium,
                            Position = UDim2.new(0, -var12.X / 2, 0, 0)
                        })
                    }
                )
            })
        }),
        Divider = if var8 then React.createElement(
            Foundation.View,
            {
                backgroundStyle = var2.Color.Stroke.Emphasis,
                Size = UDim2.new(1, 0, 0, 1),
                LayoutOrder = nextOrder()
            }
        ) else nil,
        Content = 0
    }

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl7 = {
        tag = "size-full-0 auto-y row flex-between items-center padding-left-small padding-y-small",
        LayoutOrder = nextOrder()
    }
    local tbl8 = {
        Body = React.createElement(
            Foundation.View,
            {
                tag = "size-full-0 auto-y shrink clip",
                LayoutOrder = nextOrder()
            },
            var1.children
        ),
        Actions = 0
    }
    local createElement4 = React.createElement
    local view4 = Foundation.View
    local tbl9 = {
        tag = "auto-xy row flex-between items-center",
        LayoutOrder = nextOrder()
    }
    local tbl10 = {
        CustomActions = if var1.actions then React.createElement(Foundation.View, { tag = "row auto-xy", LayoutOrder = nextOrder() }, var1.actions) else nil,
        OverflowButton = 0
    }
    local element

    if getFFlagSongbirdPopoverSubmenu() then
        if var1.menuItems and var5 ~= Responsive.Input.Directional then
            element = React.createElement(Foundation.IconButton, {
                icon = "icons/common/overflow",
                size = Foundation.Enums.IconSize.Medium,
                onActivated = var1.onToggleSubMenu,
                LayoutOrder = nextOrder()
            })
        else
            element = nil
        end
    elseif var1.submenu and var5 ~= Responsive.Input.Directional then
        element = React.createElement(Foundation.IconButton, {
            icon = "icons/common/overflow",
            size = Foundation.Enums.IconSize.Medium,
            onActivated = var1.onToggleSubMenu,
            LayoutOrder = nextOrder(),
            ref = var1.overflowButtonRef
        })
    else
        element = nil
    end

    tbl10.OverflowButton = element
    tbl8.Actions = createElement4(view4, tbl9, tbl10)
    tbl6.Content = createElement3(view3, tbl7, tbl8)
    tbl4.WindowFrame = createElement2(view2, tbl5, tbl6)
    local var15

    if getFFlagSongbirdPopoverSubmenu() or not (var1.submenu and var1.isSubMenuOpen) then
        var15 = nil
    else
        local createElement5 = React.createElement
        local view5 = Foundation.View
        local tbl11 = {
            tag = "auto-xy bg-over-media-200 radius-medium padding-small",
            Position = 0
        }
        local var16

        if bool1 then
            var16 = UDim2.fromScale(1, 0) + UDim2.fromOffset(var2.Gap.Small, 0)
        else
            var16 = UDim2.new(1, -constants.SUBMENU_WIDTH - constants.ICON_BUTTON_WIDTH / 2, 1, 0) + UDim2.fromOffset(var2.Gap.Small / 2, var2.Gap.Small)
        end

        tbl11.Position = var16
        var15 = createElement5(view5, tbl11, var1.submenu)
    end

    tbl4.SubMenu = var15
    local element2

    if getFFlagSongbirdPopoverSubmenu() and var1.menuItems then
        element2 = React.createElement(Foundation.Menu, {
            isOpen = var1.isSubMenuOpen,
            items = var1.menuItems,
            side = Foundation.Enums.PopoverSide.Right,
            align = Foundation.Enums.PopoverAlign.Center,
            anchorRef = anchorRef,
            onPressedOutside = var1.onToggleSubMenu
        })
    else
        element2 = nil
    end

    tbl4.OverflowMenu = element2
    return createElement(view, tbl3, tbl4)
end

return ChromeWindowFrame
