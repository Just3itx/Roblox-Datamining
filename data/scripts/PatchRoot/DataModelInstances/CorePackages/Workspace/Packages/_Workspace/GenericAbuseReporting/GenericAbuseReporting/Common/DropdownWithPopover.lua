-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent
local CoreGui = game:GetService("CoreGui")

local FocusNavigationUtils = require(GenericAbuseReportingParent.FocusNavigationUtils)
local Foundation = require(GenericAbuseReportingParent.Foundation)
local InputHandlers = require(GenericAbuseReportingParent.InputHandlers)
local React = require(GenericAbuseReportingParent.React)
local ReactFocusNavigation = require(GenericAbuseReportingParent.ReactFocusNavigation)
local UIBlox = require(GenericAbuseReportingParent.UIBlox)

local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local OverlayProvider = Foundation.OverlayProvider
local Popover = Foundation.Popover
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local SideModalDropdownButton = require(GenericAbuseReporting.Common.SideModalDropdownButton)
local useScrollbarOffset = require(GenericAbuseReporting.Common.useScrollbarOffset)

return React.memo(function(tbl1) -- name: DropdownWithPopover
    local var1 = useLayerCollector()
    local var2 = useTokens()
    local absoluteSize = var1.absoluteSize
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState({})
    local var7, var8 = React.useState(Vector2.new(0, 0))
    local var9, var10 = React.useState(Vector2.new(0, 0))
    local var11, var12 = React.useState(Vector2.new(0, 0))
    local var13, var14 = React.useState(Vector2.new(0, 0))
    local var15 = useScrollbarOffset(var11, var13)

    local var16 = ReactFocusNavigation.useFocusGuiObject()
    local ref = React.useRef(nil)
    local var17 = React.useRef(nil)

    local vrCentralOverlay = CoreGui:FindFirstChild("VRCentralOverlay")
    local centralOverlaySurfaceGui = if vrCentralOverlay then vrCentralOverlay:FindFirstChild("CentralOverlay_SurfaceGui") else nil

    local onPressedOutside = React.useCallback(function()
        if not centralOverlaySurfaceGui then
            var16(ref.current)
        end
        var4(false)
    end, { ref.current, var16, centralOverlaySurfaceGui })

    local var20 = React.useMemo(function()
        local result = {}
        for _, cellData in ipairs(tbl1.cellDatas) do
            local function onActivated()
                tbl1.onChange(if cellData.value == nil then cellData.text else cellData.value)
                var6(cellData)
                onPressedOutside()
            end

            local createElement = React.createElement
            local var20 = View
            local tbl2 = {
                onActivated = onActivated,
                selection = { Selectable = true },
                tag = {
                    ["size-full-0"] = true,
                    ["auto-y"] = true,
                    ["padding-small"] = true,
                    ["radius-medium"] = true,
                    ["bg-shift-200"] = var5 == cellData
                }
            }
            local tbl3 = { TextContainer = 0 }
            local createElement2 = React.createElement
            local var21 = View

            local tbl4 = {
                Text = React.createElement(
                    FoundationText,
                    {
                        Text = cellData.text,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        tag = "auto-xy"
                    }
                )
            }
            tbl3.TextContainer = createElement2(var21, { tag = "size-full-0 auto-y" }, tbl4)
            table.insert(result, createElement(var20, tbl2, tbl3))
        end

        return result
    end, {
        tbl1.cellDatas,
        var5,
        tbl1.onChange,
        onPressedOutside
    })
    local onActivated = React.useCallback(function()
        var4(not var3)
    end, { var3 })

    local createElement = React.createElement
    local var22 = OverlayProvider
    local tbl2 = { gui = centralOverlaySurfaceGui }
    local tbl3 = { DropdownWithPopover = 0 }
    local createElement2 = React.createElement
    local var23 = View

    local tbl4 = {
        tag = "size-full-0 auto-y",
        ref = ref,
        onAbsoluteSizeChanged = function(arg1)
            var8(arg1.AbsoluteSize)
        end,
        LayoutOrder = tbl1.layoutOrder
    }

    local tbl5 = { Popover = 0 }
    local createElement3 = React.createElement
    local root = Popover.Root
    local tbl6 = { isOpen = var3 }
    local tbl7 = { Anchor = 0, Content = 0 }
    local createElement4 = React.createElement
    local anchor = Popover.Anchor
    local var24 = nil
    local createElement5 = React.createElement
    local var25 = View
    local tbl8 = {
        Size = UDim2.new(0, var7.X, 0, var7.Y)
    }
    local tbl9 = {
        DropdownButton = React.createElement(SideModalDropdownButton, {
            onActivated = onActivated,
            text = if var5.text and #var5.text > 0 then var5.text else tbl1.placeholder,
            isDropdownError = tbl1.errorState
        })
    }
    tbl7.Anchor = createElement4(anchor, var24, createElement5(var25, tbl8, tbl9))

    local createElement6 = React.createElement
    local content = Popover.Content
    local tbl10 = {
        align = PopoverAlign.Center,
        side = PopoverSide.Bottom,
        hasArrow = false,
        onPressedOutside = onPressedOutside,
        selection = { Selectable = true }
    }

    local tbl11 = { DropdownPopup = 0 }
    local createElement7 = React.createElement
    local var26 = View
    local tbl12 = { tag = "auto-xy" }

    local tbl13 = { AppFocusRoot = 0 }
    local createElement8 = React.createElement
    local var27 = AppFocusRoot
    local tbl14 = {
        surfaceIdentifier = if var3 then FocusNavigableSurfaceIdentifierEnum.ModerationOverlay else FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = var3,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(onPressedOutside)
            }
        }
    }
    local createElement9 = React.createElement
    local var28 = ScrollView
    local tbl15 = {
        Size = UDim2.new(0, math.min(absoluteSize.X, var9.X + var15), 0, math.min(absoluteSize.Y, var9.Y)),
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            scrollBarVisibility = ScrollBarVisibility.Always
        },
        onAbsoluteCanvasSizeChanged = 0,
        onAbsoluteWindowSizeChanged = 0,
        gradientHeight = 15
    }
    function tbl15.onAbsoluteCanvasSizeChanged(arg1)
        var12(arg1.AbsoluteCanvasSize)
    end
    function tbl15.onAbsoluteWindowSizeChanged(arg1)
        var14(arg1.AbsoluteWindowSize)
    end

    local tbl16 = {
        createElement9(var28, tbl15, {
            BaseMenu = React.createElement(View, {
                Size = UDim2.new(0, var7.X + var2.Stroke.Standard * 2, 0, 0),
                onAbsoluteSizeChanged = function(arg1)
                    var10(arg1.AbsoluteSize)
                end,
                tag = "auto-y col align-y-center gap-xsmall padding-xsmall",
                ref = var17
            }, var20)
        })
    }

    tbl13.AppFocusRoot = createElement8(var27, tbl14, tbl16)
    tbl11.DropdownPopup = createElement7(var26, tbl12, tbl13)
    tbl7.Content = createElement6(content, tbl10, tbl11)
    tbl5.Popover = createElement3(root, tbl6, tbl7)
    tbl3.DropdownWithPopover = createElement2(var23, tbl4, tbl5)
    return createElement(var22, tbl2, tbl3)
end)
