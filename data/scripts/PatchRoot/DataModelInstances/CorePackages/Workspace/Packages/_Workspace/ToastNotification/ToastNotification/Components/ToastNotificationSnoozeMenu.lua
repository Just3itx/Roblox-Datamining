-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local dependencies = require(scriptParentParent.dependencies)
local NotificationTypeEnum = require(scriptParentParent.type).NotificationTypeEnum
local ShowNotificationSnoozeMenuSignal = require(scriptParentParent.Signals).ShowNotificationSnoozeMenuSignal
local DismissNotificationSnoozeMenuSignal = require(scriptParentParent.Signals).DismissNotificationSnoozeMenuSignal
local NotificationSnoozeMenuVisibleSignal = require(scriptParentParent.Signals).NotificationSnoozeMenuVisibleSignal
local default = require(scriptParentParent.ToastNotificationSnoozeManager).default

local Foundation = require(scriptParentParentParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local Cryo = dependencies.Cryo
local Localization = dependencies.Localization
local React = dependencies.React
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox

local useLocalization = Localization.Hooks.useLocalization

local Colors = UIBlox.App.Style.Colors
local Interactable = UIBlox.Core.Control.Interactable
local useCursor = UIBlox.App.SelectionCursor.useCursor
local useStyle = UIBlox.Core.Style.useStyle

local FocusNavigationUtils = require(scriptParentParentParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FocusRoot = FocusNavigationUtils.FocusRoot
local InputHandlers = require(scriptParentParentParent.InputHandlers)
local _ReactFocusNavigation = require(scriptParentParentParent.ReactFocusNavigation)

local FFlagEnableAppChatSnoozeMenuFocus = require(scriptParentParentParent.SharedFlags).FFlagEnableAppChatSnoozeMenuFocus

local GetFFlagAppChatInExpToastSnoozeMenuDismissFix = require(scriptParentParentParent.SharedFlags).GetFFlagAppChatInExpToastSnoozeMenuDismissFix
local bool1 = game:DefineFastFlag("SnoozeMenuTextXAlignment", false)

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local UniversalAppPolicy = require(scriptParentParentParent.UniversalAppPolicy)

local tbl2 = {
    [NotificationTypeEnum.ChatNewMessage] = if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "CommonUI.Features.Label.Chat" else "Feature.Squads.Label.Party"
}

local tbl3 = {
    { textKey = "fifteenMinutes", durationMinutes = 15 },
    { textKey = "fourHours", durationMinutes = 240 },
    { textKey = "oneDay", durationMinutes = 1440 },
    { textKey = "untilITurnItBackOn", durationMinutes = -1 }
}

return function()
    local var1 = useStyle()
    local var2 = useTokens()
    local var3 = useLocalization(
        (Cryo.Dictionary.union(tbl2, {
            fifteenMinutes = "Feature.Notifications.Action.SnoozeFifteenMinutes",
            fourHours = "Feature.Notifications.Action.SnoozeFourHours",
            oneDay = "Feature.Notifications.Action.SnoozeOneDay",
            oneHour = "Feature.Notifications.Action.SnoozeOneHour",
            untilITurnItBackOn = "Feature.Notifications.Action.UntilITurnItBackOn",
            snoozeFeedback = "Feature.Notifications.Heading.SnoozeFeedback"
        }))
    )

    local visible, var5 = React.useState(false)
    local var6, var7 = React.useState({})

    local var8 = React.useCallback(function()
        var5(false)
    end, { var5 })

    React.useEffect(function()
        local connection = ShowNotificationSnoozeMenuSignal:connect(function(tbl4)
            var7(tbl4)
            var5(true)
        end)

        local connection2 = if GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then DismissNotificationSnoozeMenuSignal:connect(function()
            var8()
        end) else nil

        return function()
            connection:disconnect()
            if GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then
                connection2:disconnect()
            end
        end
    end, { var5 })

    local var9

    if FFlagEnableAppChatSnoozeMenuFocus then
        var9 = React.useMemo(function()
            local result = {}
            result[FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    var8()
                    arg1:cancel()
                end)
            }
            return result
        end, { var8 })

        React.useEffect(function()
            NotificationSnoozeMenuVisibleSignal:fire({ visible = visible })
        end, { visible })
    else
        var9 = nil
    end

    local selectionImageObject = if FFlagEnableAppChatSnoozeMenuFocus then useCursor() else nil

    local var11 = React.useMemo(function()
        local result = {}

        for layoutOrder, value in ipairs(tbl3) do
            local createElement = React.createElement
            local str1 = "TextButton"
            local tbl4 = {
                Size = UDim2.new(1, 0, 0, if FFlagEnableAppChatSnoozeMenuFocus then var2.Size.Size_1400 else 56),
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(var2.Typography.TitleLarge.Font),
                LayoutOrder = layoutOrder,
                SelectionImageObject = selectionImageObject,
                Text = var3[value.textKey],
                TextSize = var1.Font.Header2.RelativeSize * var1.Font.BaseSize,
                TextColor3 = Colors.White,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            }

            tbl4[React.Event.Activated] = function()
                if var6.notificationType then
                    local notificationType = var6.notificationType
                    if type(var6.notificationType) == "table" then
                        notificationType = var6.notificationType[1]
                    end

                    default:snoozeNotification({
                        context = var6.context,
                        notificationType = var6.notificationType,
                        durationMinutes = value.durationMinutes,
                        modalMessage = var3.snoozeFeedback:gsub("{title}", var3[notificationType] or ""):gsub("{duration}", var3[value.textKey])
                    })
                end
                var5(false)
            end
            local tbl5 = {
                UIPadding = if FFlagEnableAppChatSnoozeMenuFocus then React.createElement(
                    "UIPadding",
                    {
                        PaddingLeft = UDim.new(0, var2.Padding.XXLarge),
                        PaddingRight = UDim.new(0, var2.Padding.XXLarge)
                    }
                ) else nil,
                Border = React.createElement("Frame", {
                    Size = if FFlagEnableAppChatSnoozeMenuFocus then UDim2.new(1, var2.Padding.XXLarge, 0, 1) else UDim2.new(1, 0, 0, 1),
                    BackgroundTransparency = 0.8,
                    BackgroundColor3 = Colors.White,
                    LayoutOrder = layoutOrder
                })
            }
            table.insert(result, createElement(str1, tbl4, tbl5))

            local _ = layoutOrder + 1
        end

        return result
    end, { var6, var2.Typography.TitleLarge.Font })

    if not visible then
        return nil
    end

    local createElement = React.createElement
    local var12 = Interactable
    local tbl4 = {
        Size = UDim2.fromScale(1, 1),
        AutoButtonColor = false,
        BackgroundColor3 = Colors.Black,
        BackgroundTransparency = 0.6,
        onStateChanged = function() end,
        [React.Event.Activated] = var8
    }
    local tbl5 = { SnoozeMenu = 0 }
    local createElement2 = React.createElement
    local var13 = if FFlagEnableAppChatSnoozeMenuFocus then FocusRoot else Interactable
    local var14 = FFlagEnableAppChatSnoozeMenuFocus
        and {
            eventHandlers = var9,
            eventMap = eventMap,
            frameProps = {
                AnchorPoint = Vector2.new(0.5, 0.5),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
                BackgroundTransparency = var1.Theme.BackgroundDefault.Transparency,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.new(1, -var2.Padding.Small * 2, 0, 0)
            },
            isAutoFocusRoot = true,
            isIsolated = true,
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
        }
        or {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, -16, 0, 0),
            AutoButtonColor = false,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
            BackgroundTransparency = var1.Theme.BackgroundDefault.Transparency,
            onStateChanged = function() end
        }
    local tbl6 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Tokens.Radius.Large) }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = if FFlagEnableAppChatSnoozeMenuFocus then nil else React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 24) }),
        UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(400, math.huge) }),
        TitleContainer = 0,
        SnoozeOptions = 0
    }
    local createElement3 = React.createElement
    local str1 = "Frame"
    local tbl7 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl8 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = React.createElement("UIPadding", {
            PaddingBottom = UDim.new(0, if FFlagEnableAppChatSnoozeMenuFocus then var2.Padding.XLarge else 20),
            PaddingRight = UDim.new(0, if FFlagEnableAppChatSnoozeMenuFocus then var2.Padding.XXLarge else 24),
            PaddingTop = UDim.new(0, if FFlagEnableAppChatSnoozeMenuFocus then var2.Padding.XLarge else 20),
            PaddingLeft = if FFlagEnableAppChatSnoozeMenuFocus then UDim.new(0, var2.Padding.XXLarge) else nil
        }),
        Title = React.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var2.Typography.BodyLarge.Font),
            LayoutOrder = 1,
            Text = var6.title or "",
            TextSize = var1.Font.Body.RelativeSize * var1.Font.BaseSize,
            TextColor3 = Colors.White,
            TextWrapped = true,
            TextXAlignment = if bool1 then Enum.TextXAlignment.Left else nil
        }),
        Description = 0
    }
    local element

    if var6 and var6.description and var6.description ~= "" then
        element = React.createElement("TextLabel", {
            AutomaticSize = Enum.AutomaticSize.XY,
            BackgroundTransparency = 1,
            FontFace = normalizeFontFace(var2.Typography.BodySmall.Font),
            LayoutOrder = 2,
            Text = var6.description or "",
            TextSize = var1.Font.CaptionBody.RelativeSize * var1.Font.BaseSize,
            TextColor3 = var1.Theme.TextDefault.Color
        })
    else
        element = nil
    end

    tbl8.Description = element
    tbl6.TitleContainer = createElement3(str1, tbl7, tbl8)

    tbl6.SnoozeOptions = React.createElement(
        "Frame",
        {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 0)
        },
        {
            UIListLayout = React.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            SnoozeOptions = Roact.createFragment(var11)
        }
    )
    tbl5.SnoozeMenu = createElement2(var13, var14, tbl6)
    return (createElement(var12, tbl4, tbl5))
end
