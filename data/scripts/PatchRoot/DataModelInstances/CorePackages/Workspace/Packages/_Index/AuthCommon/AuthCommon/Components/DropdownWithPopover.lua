-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local FocusNavigationUtils = require(AuthCommonParent.FocusNavigationUtils)
local Foundation = require(AuthCommonParent.Foundation)
local InputHandlers = require(AuthCommonParent.InputHandlers)
local React = require(AuthCommonParent.React)
local useSelector = require(AuthCommonParent.RoactUtils).Hooks.RoactRodux.useSelector

local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useLastInputMode = FocusNavigationUtils.useLastInputMode
local Popover = Foundation.Popover
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility
local ScrollView = Foundation.ScrollView
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local SideModalDropdownButton = require(AuthCommon.Components.SideModalDropdownButton)
local ReactFocusNavigation = require(AuthCommonParent.ReactFocusNavigation)

local function selectScreenSize(arg1)
    return arg1.ScreenSize
end

return React.memo(function(tbl1) -- name: DropdownWithPopover
    local var1 = useTokens()
    local var2 = useSelector(selectScreenSize)
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState({})
    local var7, var8 = React.useState(Vector2.new(0, 0))
    local var9, var10 = React.useState(Vector2.new(0, 0))

    local ref = React.useRef(nil)
    local var11 = React.useRef(nil)

    local bool1 = useLastInputMode() == "Focus"
    local var13 = ReactFocusNavigation.useFocusGuiObject()

    React.useEffect(function()
        if tbl1.value == nil then
            var6({})

            return
        end

        for _, cellData in ipairs(tbl1.cellDatas) do
            if cellData.value == tbl1.value then
                var6(cellData)
                return
            end
        end
    end, { tbl1.value, tbl1.cellDatas })

    local var14 = React.useCallback(function()
        if var13 and bool1 then
            var13(ref.current)
        end
        var4(false)
    end, { ref.current, bool1, var13 })

    React.useEffect(function()
        if var13 and tbl1.focusOnMount then
            var13(ref.current)
        end
    end, { ref.current, var13, tbl1.focusOnMount })

    React.useEffect(function()
        if tbl1.onDropdownOpened then
            tbl1.onDropdownOpened(var3)
        end
    end, { var3, tbl1.onDropdownOpened })

    local var15 = React.useMemo(function()
        local result = {}
        for _, cellData in ipairs(tbl1.cellDatas) do
            local function onActivated()
                tbl1.onChange(cellData.value)
                var14()
            end

            local createElement = React.createElement
            local var15 = View
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
            local var16 = View

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
            tbl3.TextContainer = createElement2(var16, { tag = "size-full-0 auto-y" }, tbl4)
            table.insert(result, createElement(var15, tbl2, tbl3))
        end

        return result
    end, {
        tbl1.cellDatas,
        var5,
        tbl1.onChange,
        var14
    })

    local onActivated = React.useCallback(function()
        var4(not var3)
    end, { var3 })

    local createElement = React.createElement
    local var17 = View

    local tbl2 = {
        tag = "size-full-0 auto-y",
        ref = ref,
        onAbsoluteSizeChanged = function(arg1)
            var8(arg1.AbsoluteSize)
        end,
        LayoutOrder = tbl1.layoutOrder
    }

    local tbl3 = { Popover = 0 }
    local createElement2 = React.createElement
    local root = Popover.Root
    local tbl4 = { isOpen = var3 }
    local tbl5 = { Anchor = 0, Content = 0 }
    local createElement3 = React.createElement
    local anchor = Popover.Anchor
    local var18 = nil
    local createElement4 = React.createElement
    local var19 = View
    local tbl6 = {
        Size = UDim2.new(0, var7.X, 0, var7.Y)
    }
    local tbl7 = {
        DropdownButton = React.createElement(SideModalDropdownButton, {
            onActivated = onActivated,
            text = if var5.text and #var5.text > 0 then var5.text elseif tbl1.placeholder then tbl1.placeholder else "",
            isDropdownError = tbl1.errorState,
            backgroundColorToken = tbl1.backgroundColorToken,
            height = tbl1.dropdownHeight,
            fixSizeToParent = tbl1.fixSizeToParent
        })
    }
    tbl5.Anchor = createElement3(anchor, var18, createElement4(var19, tbl6, tbl7))

    local createElement5 = React.createElement
    local content = Popover.Content
    local tbl8 = {
        align = PopoverAlign.Center,
        side = PopoverSide.Bottom,
        hasArrow = false,
        selection = { Selectable = true }
    }

    local tbl9 = { DropdownPopup = 0 }
    local createElement6 = React.createElement
    local var20 = View
    local tbl10 = { tag = "auto-xy" }

    local tbl11 = { AppFocusRoot = 0 }
    local createElement7 = React.createElement
    local var21 = AppFocusRoot
    local tbl12 = {
        surfaceIdentifier = if var3 then FocusNavigableSurfaceIdentifierEnum.ModerationOverlay else FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = var3,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(var14)
            }
        }
    }
    local createElement8 = React.createElement
    local var22 = ScrollView
    local tbl13 = {
        Size = UDim2.new(0, math.min(var2.X, var9.X), 0, math.min(500, var2.Y - (tbl1.topOffset or 0), var9.Y)),
        scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            scrollBarVisibility = ScrollBarVisibility.Always
        },
        gradientHeight = 15
    }

    local tbl14 = {
        createElement8(var22, tbl13, {
            BaseMenu = React.createElement(View, {
                Size = UDim2.new(0, var7.X + var1.Stroke.Standard * 2, 0, 0),
                onAbsoluteSizeChanged = function(arg1)
                    var10(arg1.AbsoluteSize)
                end,
                tag = "auto-y col align-y-center gap-xsmall padding-xsmall",
                ref = var11
            }, var15)
        })
    }

    tbl11.AppFocusRoot = createElement7(var21, tbl12, tbl14)
    tbl9.DropdownPopup = createElement6(var20, tbl10, tbl11)
    tbl5.Content = createElement5(content, tbl8, tbl9)
    tbl3.Popover = createElement2(root, tbl4, tbl5)
    return createElement(var17, tbl2, tbl3)
end)
