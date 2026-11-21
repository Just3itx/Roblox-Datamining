-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local Foundation = require(GameDetailParent.Foundation)
local React = require(GameDetailParent.React)
local RoactNavigation = require(GameDetailParent.RoactNavigation)
local SharedFlags = require(GameDetailParent.SharedFlags)

local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local shouldUseDeviceSafeInsets = SharedFlags.FFlagFixOverlayTopInsetForDeviceSafeInsets and require(GameDetailParent.Display).shouldUseDeviceSafeInsets

local function ExperienceDetailsBottomSheetTopBar(tbl1)
    local tokens = tbl1.tokens
    local navigation = tbl1.navigation

    local var1, var2 = React.useBinding(0)
    local var3, var4 = React.useBinding(false)

    local var5 = tokens.Padding.Small + tokens.Size.Size_100

    React.useEffect(function()
        local current = tbl1.sheetContentRef.current
        if not current then
            var2(0)
            return
        end

        local function updateTopBarState() -- Luacid: Inlined by compiler; 1 call site recovered
            local num1 = 1 - math.clamp(
                (math.ceil(current.AbsolutePosition.Y) + tbl1.deviceInsets.top - tbl1.topBarHeight - var5) / math.max(tbl1.fullH - tbl1.briefH, 1),
                0,
                1
            )
            var2(num1)
        end

        updateTopBarState()
        local connection = current:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateTopBarState)

        return function()
            connection:Disconnect()
        end
    end, {
        tbl1.overlayFrame,
        tbl1.deviceInsets.top,
        tbl1.topBarHeight,
        var5,
        tbl1.fullH,
        tbl1.briefH
    })

    React.useEffect(function()
        var4(navigation.isFocused())

        local var6 = navigation.addListener(RoactNavigation.Events.WillFocus, function()
            var4(true)
        end)

        local var7 = navigation.addListener(RoactNavigation.Events.WillBlur, function()
            var4(false)
        end)

        return function()
            var6.remove()
            var7.remove()
        end
    end, { navigation })

    local createElement = React.createElement
    local str1 = "ScreenGui"
    local tbl2 = {
        DisplayOrder = 1,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        ScreenInsets = if shouldUseDeviceSafeInsets then Enum.ScreenInsets.DeviceSafeInsets else Enum.ScreenInsets.None,
        ClipToDeviceSafeArea = false,
        Enabled = var3
    }
    local tbl3 = { TopBarCanvasGroup = 0 }
    local createElement2 = React.createElement
    local str2 = "CanvasGroup"

    local tbl4 = {
        Position = UDim2.new(0, 0, 0, if shouldUseDeviceSafeInsets then -tbl1.deviceInsets.top else 0),
        Size = UDim2.new(1, 0, 0, tbl1.topBarHeight),
        BackgroundColor3 = tokens.Color.Surface.Surface_0.Color3,
        Active = false,
        BackgroundTransparency = 0,
        GroupTransparency = if tbl1.shouldMountAsFullView then 0 else var1:map(function(arg1): number
            return 1 - arg1
        end),
        BorderColor3 = tokens.Color.Common.Shimmer.Color3,
        BorderSizePixel = 0,
        ZIndex = 2
    }

    local tbl5 = { TopBarOverlay = 0 }
    local createElement3 = React.createElement
    local view = Foundation.View
    local tbl6 = {
        tag = "row align-y-center size-full",
        padding = {
            top = UDim.new(0, tbl1.deviceInsets.top),
            left = UDim.new(0, tokens.Padding.Large)
        }
    }
    local tbl7 = {
        TopBarButton = React.createElement(IconButton, {
            icon = if tbl1.shouldMountAsFullView then IconName.ChevronLargeLeft else IconName.X,
            variant = ButtonVariant.Utility,
            size = ButtonSize.Medium,
            isCircular = true,
            onActivated = if tbl1.shouldMountAsFullView then tbl1.onBack else tbl1.onClose,
            testId = "--discovery-edp-iconbutton-bottomsheet-nav"
        })
    }
    tbl5.TopBarOverlay = createElement3(view, tbl6, tbl7)
    tbl3.TopBarCanvasGroup = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return ExperienceDetailsBottomSheetTopBar
