-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent
local CurrentCamera = workspace.CurrentCamera
local constants = require(StreamNotifications.constants)

local React = require(StreamNotificationsParent.React)
local ReactRoblox = require(StreamNotificationsParent.ReactRoblox)
local useStyle = require(StreamNotificationsParent.UIBlox).Core.Style.useStyle
local FocusNavigationUtils = require(StreamNotificationsParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local _ReactFocusNavigation = require(StreamNotificationsParent.ReactFocusNavigation)
local InputHandlers = require(StreamNotificationsParent.InputHandlers)

local components = StreamNotifications.components
local StreamNotificationsHeader = require(components.StreamNotificationsHeader)
local StreamNotificationsContent = require(components.StreamNotificationsContent)

local EventStream = require(StreamNotifications.analytics.analyticsService).EventStream
local NotificationHelper = require(StreamNotificationsParent.NotificationsCommon).NotificationHelper
local analyticsConstants = require(StreamNotifications.analytics.analyticsConstants)

local FFlagLuaAppSupportDeviceSafeInsets = require(StreamNotificationsParent.SharedFlags).FFlagLuaAppSupportDeviceSafeInsets

local StreamNotificationDropdownExperimentation = require(StreamNotifications.StreamNotificationDropdownExperimentation)

local function calculateDropdownHeight(num1: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return math.min(constants.Dropdown.MaxHeight, math.max(num1 - constants.Dropdown.VerticalMargin, constants.Dropdown.MinHeight))
end

return function(tbl1)
    local var1 = useStyle()
    local dropdownEnabled = StreamNotificationDropdownExperimentation.getDropdownEnabled()

    local dropdownHeight, var2 = React.useState(if dropdownEnabled then calculateDropdownHeight(CurrentCamera.ViewportSize.Y) else 0)

    local isSmallScreen, var4 = React.useState(CurrentCamera.ViewportSize.X < constants.Modal.WidthLimit)

    React.useEffect(function()
        if dropdownEnabled then
            var2((calculateDropdownHeight(CurrentCamera.ViewportSize.Y)))
        end
        local connection = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            if dropdownEnabled then
                var2((calculateDropdownHeight(CurrentCamera.ViewportSize.Y)))
            end
            if CurrentCamera.ViewportSize.X < constants.Modal.WidthLimit then
                var4(true)
                return
            end
            var4(false)
        end)

        return function()
            connection:Disconnect()
        end
    end, { dropdownEnabled })

    local var5, var6 = React.useState(true)
    local showOverlay = React.useCallback(function(arg1)
        var6(arg1)
    end)

    local var8, setDisplayScreenGuiEnabled = React.useState(true)

    local ref = React.useRef(nil)
    local handler = React.useMemo(function()
        return InputHandlers.onRelease(function(arg1)
            tbl1.displayStream(false)
            NotificationHelper.fireEvent(
                EventStream,
                analyticsConstants.Context.click,
                analyticsConstants.EventNames.closeContent,
                {
                    closeMethod = analyticsConstants.CloseMethod.focusNavigationBack
                }
            )
            arg1:cancel()
        end)
    end, { tbl1.displayStream })

    if dropdownEnabled then
        return React.createElement("Frame", {
            Size = UDim2.new(0, constants.Dropdown.Width, 0, dropdownHeight),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClipsDescendants = true
        }, {
            UIPadding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, constants.Dropdown.PaddingTop),
                PaddingBottom = UDim.new(0, constants.Dropdown.PaddingBottom),
                PaddingLeft = UDim.new(0, constants.Dropdown.HorizontalPadding),
                PaddingRight = UDim.new(0, constants.Dropdown.HorizontalPadding - constants.Dropdown.ScrollBarThickness)
            }),
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, constants.Dropdown.HeaderBodyGap)
            }),
            Header = React.createElement(StreamNotificationsHeader, { isSmallScreen = false, displayStream = tbl1.displayStream }),
            StreamNotificationsContent = React.createElement(StreamNotificationsContent, {
                showOverlay = function() end,
                isSmallScreen = false,
                displayStream = tbl1.displayStream,
                setDisplayScreenGuiEnabled = function() end,
                dropdownHeight = dropdownHeight
            })
        })
    end

    local tbl2 = { TextButtonOverlayBackground = 0 }
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl3 = {
        ref = ref,
        Selectable = false,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = if var5 then var1.Theme.Overlay.Transparency else 1,
        BackgroundColor3 = var1.Theme.Overlay.Color,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Text = ""
    }

    tbl3[React.Event.Activated] = function()
        tbl1.displayStream(false)
        NotificationHelper.fireEvent(
            EventStream,
            analyticsConstants.Context.click,
            analyticsConstants.EventNames.closeContent,
            {
                closeMethod = analyticsConstants.CloseMethod.backgroundOverlay
            }
        )
    end
    local tbl4 = { StreamNotificationsFrame = 0 }
    local createElement2 = React.createElement
    local str2 = "TextButton"
    local tbl5 = {
        Size = if isSmallScreen then UDim2.new(1, 0, 1, 0) else UDim2.new(0, constants.Modal.Width, 0, constants.Modal.Height),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
        BackgroundTransparency = var1.Theme.BackgroundDefault.Transparency,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Text = "",
        Selectable = false
    }

    local tbl6 = {
        UICorner = React.createElement(
            "UICorner",
            {
                CornerRadius = if isSmallScreen then UDim.new(0, 0) else UDim.new(0, constants.Modal.CornerRadius)
            }
        ),
        Header = React.createElement(StreamNotificationsHeader, { isSmallScreen = isSmallScreen, displayStream = tbl1.displayStream }),
        StreamNotificationsContent = React.createElement(StreamNotificationsContent, {
            showOverlay = showOverlay,
            isSmallScreen = isSmallScreen,
            displayStream = tbl1.displayStream,
            setDisplayScreenGuiEnabled = setDisplayScreenGuiEnabled
        })
    }
    tbl4.StreamNotificationsFrame = createElement2(str2, tbl5, tbl6)
    tbl2.TextButtonOverlayBackground = createElement(str1, tbl3, tbl4)

    local createPortal = ReactRoblox.createPortal
    local tbl7 = {
        ScreenGui = React.createElement("ScreenGui", {
            Enabled = var8,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 10,
            ScreenInsets = if FFlagLuaAppSupportDeviceSafeInsets then Enum.ScreenInsets.None else nil,
            IgnoreGuiInset = true
        }, { React.createElement(FocusNavigableSurfaceWrapper, {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
                isIsolated = true,
                frameProps = { ref = ref },
                customEventHandlers = {
                    [FocusNavigationEventNameEnum.NavigateBack] = { handler = handler }
                }
            }, tbl2) })
    }
    return createPortal(tbl7, CoreGui)
end
