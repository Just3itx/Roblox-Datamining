-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppShortcutBar = script:FindFirstAncestor("AppShortcutBar")
local AppShortcutBarParent = AppShortcutBar.Parent

local React = require(AppShortcutBarParent.React)
local Foundation = require(AppShortcutBarParent.Foundation)
local FocusNavigationUtils = require(AppShortcutBarParent.FocusNavigationUtils)
local Responsive = require(AppShortcutBarParent.Responsive)
local Display = require(AppShortcutBarParent.Display)

local useTokens = Foundation.Hooks.useTokens
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusedTextBox = FocusNavigationUtils.useFocusedTextBox
local useSelector = require(AppShortcutBarParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(AppShortcutBarParent.SignalsReact).useSignalState
local LoginStatus = require(AppShortcutBarParent.RobloxAppEnums).LoginStatus
local bool1 = game:DefineFastFlag("DisallowStickyShortcutBarOnNotLoggedIn", false)

local SharedFlags = require(AppShortcutBarParent.SharedFlags)
local FFlagUseSignalsForAuthenticationStatus = SharedFlags.FFlagUseSignalsForAuthenticationStatus
local FFlagEnableStickyShortcutBarOnAllPlatforms = SharedFlags.FFlagEnableStickyShortcutBarOnAllPlatforms
local FFlagUnifyShortcutBarUnifiedIXPExposure = SharedFlags.FFlagUnifyShortcutBarUnifiedIXPExposure

local FFlagEnableStickyShortcutBarOnAllPlatformsIxpEnabled = require(AppShortcutBar.Flags).FFlagEnableStickyShortcutBarOnAllPlatformsIxpEnabled
local GetAuthenticationStatusStore = if FFlagUseSignalsForAuthenticationStatus then require(AppShortcutBarParent.AuthenticationStatus).GetAuthenticationStatusStore else nil

local function selectUserLoggedIn(arg1)
    return arg1.AuthenticationStatus and arg1.AuthenticationStatus.status == LoginStatus.LOGGED_IN
end

local useAppShortcutBarHeight = require(AppShortcutBar.Hooks).useAppShortcutBarHeight
local useIsStickyShortcutBarEnabled = require(AppShortcutBar.Hooks).useIsStickyShortcutBarEnabled
local GetShortcutBarStatusStore = require(AppShortcutBar.Stores.GetShortcutBarStatusStore)
local AppShortcut = require(AppShortcutBar.Components.AppShortcut).AppShortcut
local useStickyShortcutBarExposureLogging = require(AppShortcutBar.Hooks.useStickyShortcutBarExposureLogging)

function AppStickyShortcutBar(arg1)
    local shortcutBarStatusStore = GetShortcutBarStatusStore(false)
    local var1 = useTokens()
    local var2 = useAppShortcutBarHeight()
    local bool2 = Responsive.usePreferredInput() == Responsive.Input.Directional
    local var3 = useFocusedTextBox()
    local var4 = if FFlagEnableStickyShortcutBarOnAllPlatforms then useIsStickyShortcutBarEnabled(arg1.currentPage) else nil
    local var5 = if FFlagEnableStickyShortcutBarOnAllPlatforms then useSignalState(Display.GetDisplayStore().getDeviceSafePadding) else nil
    local tbl1

    if FFlagEnableStickyShortcutBarOnAllPlatforms then
        tbl1 = { left = 0, top = 0, right = 0, bottom = 0 }
        local left = var5.left
        tbl1.left = math.ceil(left)
        local top = var5.top
        tbl1.top = math.ceil(top)
        local right = var5.right
        tbl1.right = math.ceil(right)
        local bottom = var5.bottom
        tbl1.bottom = math.ceil(bottom)
    else
        tbl1 = var5
    end

    local bool3 = if bool1 then if FFlagUseSignalsForAuthenticationStatus then useSignalState(GetAuthenticationStatusStore(false).getStatus) == LoginStatus.LOGGED_IN else useSelector(selectUserLoggedIn) else nil
    local bool4 = not arg1.items

    if not bool4 then
        bool4 = true
        if #arg1.items ~= 0 then
            local bool5 = false

            if #arg1.items == 1 then
                bool4 = true
                bool5 = arg1.items[1].eventName == FocusNavigationEventNameEnum.NavigateBack
            end

            if not bool5 then
                bool4 = var3

                if not bool4 then
                    bool4 = bool1
                    bool4 = bool4 and not bool3
                end
            end
        end
    end

    if FFlagEnableStickyShortcutBarOnAllPlatforms then
        bool4 = not var4
    end

    React.useEffect(function()
        shortcutBarStatusStore.setShortcutBarVisible(not bool4)
    end, { bool4 })

    if FFlagEnableStickyShortcutBarOnAllPlatformsIxpEnabled and not FFlagUnifyShortcutBarUnifiedIXPExposure then
        useStickyShortcutBarExposureLogging(not bool4)
    end

    if FFlagEnableStickyShortcutBarOnAllPlatforms then
        local num1 = math.max(var2 - tbl1.bottom, 0)

        React.useEffect(function()
            shortcutBarStatusStore.setShortcutBarReservedHeight(if bool4 then 0 else num1)
        end, { bool4, num1, shortcutBarStatusStore.setShortcutBarReservedHeight })

        React.useEffect(function()
            return function()
                shortcutBarStatusStore.setShortcutBarReservedHeight(0)
            end
        end, { shortcutBarStatusStore.setShortcutBarReservedHeight })
    end

    if bool4 then
        return nil
    end

    local element = nil
    local tbl2 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, var1.Gap.Large)
        })
    }
    local var6 = if FFlagEnableStickyShortcutBarOnAllPlatforms then arg1.items or {} else arg1.items
    local num1 = if bool2 then math.min(#var6, 4) else #var6
    local num2 = 0
    for _, value in var6 do
        if num2 < num1 and value.eventName ~= FocusNavigationEventNameEnum.NavigateBack then
            num2 += 1
            local layoutOrder = if bool2 then num1 - num2 + 1 else num2
            tbl2["Item_" .. tostring(layoutOrder)] = React.createElement(AppShortcut, { layoutOrder = layoutOrder, item = value })
        end

        if value.eventName == FocusNavigationEventNameEnum.NavigateBack then
            element = React.createElement(AppShortcut, { item = value })
        end
    end

    local var7 = FFlagEnableStickyShortcutBarOnAllPlatforms and not arg1.isLeftNavVisible
    local uDim2 = if FFlagEnableStickyShortcutBarOnAllPlatforms then UDim2.new(1, tbl1.right + (if var7 then tbl1.left else 0), 0, var2) else UDim2.new(1, 0, 0, var2)
    local uDim2_2 = if FFlagEnableStickyShortcutBarOnAllPlatforms then UDim2.new(0, if var7 then -tbl1.left else 0, 1, tbl1.bottom) else UDim2.fromScale(0, 1)
    return React.createElement("ImageButton", {
        BackgroundColor3 = var1.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = var1.Color.Surface.Surface_0.Transparency,
        BorderSizePixel = 0,
        Size = uDim2,
        AnchorPoint = Vector2.new(0, 1),
        Position = uDim2_2,
        Selectable = false,
        AutoButtonColor = false
    }, {
        Divider = React.createElement("Frame", {
            BackgroundColor3 = var1.Color.Stroke.Default.Color3,
            BackgroundTransparency = var1.Color.Stroke.Default.Transparency,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 1)
        }),
        ShortcutsFrame = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.fromScale(0.5, 0)
        }, {
            UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(var1.Size.Size_3000 * 16, var2) }),
            Padding = React.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, var1.Size.Size_800),
                PaddingTop = UDim.new(0, var1.Padding.XSmall),
                PaddingRight = UDim.new(0, var1.Size.Size_800),
                PaddingBottom = UDim.new(0, var1.Padding.XSmall)
            }),
            BackShortcutFrame = React.createElement("Frame", {
                Size = UDim2.fromScale(0, 1),
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.fromScale(0, 0.5),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY
            }, { BackShortcut = element }),
            RightShortcutsFrame = React.createElement("Frame", {
                Size = UDim2.fromScale(0, 1),
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.fromScale(1, 0.5),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.X
            }, tbl2)
        })
    })
end

return AppStickyShortcutBar
