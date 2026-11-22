-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local components = StreamNotifications.components
local StreamNotificationsParent = StreamNotifications.Parent
local React = require(StreamNotificationsParent.React)
local Foundation = require(StreamNotificationsParent.Foundation)
local constants = require(StreamNotifications.constants)
local ReactOtter = require(StreamNotificationsParent.ReactOtter)

local NotificationsCommon = require(StreamNotificationsParent.NotificationsCommon)
local StreamNotificationAnimationWrapper = require(components.StreamNotificationAnimationWrapper)
local useLocalization = require(StreamNotificationsParent.Localization).Hooks.useLocalization
local NotificationHelper = NotificationsCommon.NotificationHelper

local UIBlox = require(StreamNotificationsParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local iconsActionsTruncationExpand = Images["icons/actions/truncationExpand"]
local iconsActionsTruncationCollapse = Images["icons/actions/truncationCollapse"]

local uDim = UDim.new(0, 12)
local uDim2 = UDim.new(0, 24)

local yOffset = constants.DefaultPadding * 4
local uDim2_2 = UDim2.fromOffset(24, 24)

local EventStream = require(StreamNotifications.analytics.analyticsService).EventStream
local analyticsConstants = require(StreamNotifications.analytics.analyticsConstants)

local tbl1 = { stiffness = 207, damping = 24, mass = 1 }

return function(tbl2)
    local var1 = useStyle()
    local var2 = useTokens()
    local fontFace = normalizeFontFace(var2.Typography.TitleMedium.Font)
    local fontSize = var2.Typography.TitleMedium.FontSize

    local var4, var5 = React.useState(true)
    local var6, var7 = React.useState(74)
    local var8, var9 = React.useState(true)

    local var10, var11 = ReactOtter.useAnimatedBinding({ shadowHeight = 0, shadowWidth = 1 })

    local var12 = useLocalization({ moreText = constants.Text.ShowMoreKey, lessText = constants.Text.ShowLessKey })

    local onHeightChange = React.useCallback(function(num1: number, num2: number)
        if num1 == 1 and var4 then
            var7(num2)
        end
    end)

    local function func1(notifications)
        local result = {}
        for _, notification in notifications do
            if notification.id then
                table.insert(result, notification.id)
            end
        end
        return result
    end

    local function func2()
        var5(function(arg1): boolean
            NotificationHelper.fireEvent(
                EventStream,
                analyticsConstants.Context.click,
                if arg1 then analyticsConstants.EventNames.bundleOpened else analyticsConstants.EventNames.bundleClosed,
                {
                    bundleKey = tbl2.notifications[1].content.bundleKey or nil,
                    totalNotifications = #tbl2.notifications or nil,
                    notificationIds = func1(tbl2.notifications) or nil
                }
            )

            if arg1 then
                for bundlePosition, notification in tbl2.notifications do
                    NotificationHelper.fireEvent(
                        EventStream,
                        analyticsConstants.Context.seen,
                        analyticsConstants.EventNames.notificationViewed,
                        {
                            notificationId = notification.id or nil,
                            notificationType = notification.content.notificationType or nil,
                            bundlePosition = bundlePosition,
                            bundleKey = notification.content.bundleKey or nil,
                            clientEventsPayload = notification.content.clientEventsPayload or nil
                        }
                    )
                end
            end

            return not arg1
        end)
    end

    React.useEffect(function()
        var11({
            shadowHeight = ReactOtter.spring(if var4 then 0 else 1, tbl1),
            shadowWidth = ReactOtter.spring(if var4 then 1 else 0, tbl1)
        })
    end, { var4 })

    React.useEffect(function()
        var9(#tbl2.notifications > 1)
    end, { tbl2.notifications })

    return (React.useMemo(function()
        local tbl3 = {}
        for layoutOrder, notification in ipairs(tbl2.notifications) do
            local bool1 = false
            local var14 = if tbl2.impressionMetadataByNotificationId then tbl2.impressionMetadataByNotificationId[notification.id] else nil

            if var4 and var8 then
                bool1 = true
            end

            local id = notification.id
            tbl3[id] = React.createElement(StreamNotificationAnimationWrapper, {
                layoutOrder = layoutOrder,
                notification = notification,
                finishDismissNotification = tbl2.finishDismissNotification,
                handleActions = tbl2.handleActions,
                openMetaActions = tbl2.openMetaActions,
                onHeightChange = onHeightChange,
                collapsed = bool1,
                impressionsTag = tbl2.impressionsTag,
                impressionIndex = var14 and var14.impressionIndex or nil
            })
        end

        tbl3.UIPadding = React.createElement("UIPadding", { PaddingTop = if not var4 and var8 then UDim.new(0, 40) else UDim.new(0, 0) })

        tbl3.UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        })
        local element

        if var4 and var8 then
            element = React.createElement("Frame", {
                Size = var10:map(function(tbl4): UDim2
                    return UDim2.new(1, 0, 0, tbl4.shadowHeight * var6 + constants.DefaultPadding)
                end),
                LayoutOrder = #tbl2.notifications + 1,
                ZIndex = -(#tbl2.notifications + 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }, {
                React.createElement("Frame", {
                    Size = var10:map(function(tbl4): UDim2
                        return UDim2.new(1, -(constants.DefaultPadding * 4 * tbl4.shadowWidth), 0, var6 - constants.DefaultPadding)
                    end),
                    BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0)
                }, {
                    UICorner = React.createElement("UICorner", { CornerRadius = uDim })
                })
            })
        else
            element = nil
        end

        tbl3.Shadow1 = element
        local element2

        if var4 and var8 then
            element2 = React.createElement("Frame", {
                Size = var10:map(function(tbl4): UDim2
                    return UDim2.new(1, 0, 0, tbl4.shadowHeight * var6 + constants.DefaultPadding * 2)
                end),
                LayoutOrder = #tbl2.notifications + 2,
                BackgroundTransparency = 1,
                ZIndex = -(#tbl2.notifications + 2),
                BorderSizePixel = 0
            }, {
                React.createElement("Frame", {
                    Size = var10:map(function(tbl4): UDim2
                        return UDim2.new(1, -(constants.DefaultPadding * 6 * tbl4.shadowWidth), 0, var6 - constants.DefaultPadding)
                    end),
                    BackgroundColor3 = var1.Theme.BackgroundContrast.Color,
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0)
                }, {
                    UICorner = React.createElement("UICorner", { CornerRadius = uDim })
                })
            })
        else
            element2 = nil
        end

        tbl3.Shadow2 = element2

        local createElement = React.createElement
        local str1 = "Frame"
        local tbl4 = {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = tbl2.layoutOrder
        }
        local tbl5 = {
            UIPadding = React.createElement(
                "UIPadding",
                {
                    PaddingBottom = if var4 and var8 then UDim.new(0, constants.DefaultPadding) else UDim.new(0, 0)
                }
            ),
            ShowLessButton = 0,
            InvisibleExpandButton = 0,
            NumberMoreButton = 0,
            ListOfNotifications = 0
        }
        local element3

        if var4 or not var8 then
            element3 = nil
        else
            element3 = React.createElement("TextButton", {
                Size = UDim2.new(0, 160, 0, 40),
                Text = "",
                FontFace = fontFace,
                TextSize = fontSize,
                [React.Event.Activated] = func2,
                BackgroundTransparency = 1,
                BackgroundColor3 = var1.Theme.BackgroundMuted.Color,
                AutoButtonColor = false,
                LayoutOrder = 1,
                ZIndex = 4,
                Position = UDim2.new(1, 0, 0, 0),
                AnchorPoint = Vector2.new(1, 0),
                BorderSizePixel = 0
            }, {
                React.createElement("Frame", {
                    Size = UDim2.new(1, -constants.DefaultPadding, 1, -constants.DefaultPadding),
                    BackgroundTransparency = 0,
                    BackgroundColor3 = var1.Theme.BackgroundContrast.Color,
                    Position = UDim2.new(1, -constants.DefaultPadding, 0, 0),
                    AnchorPoint = Vector2.new(1, 0),
                    ZIndex = 10,
                    BorderSizePixel = 0
                }, {
                    UICorner = React.createElement("UICorner", { CornerRadius = uDim2 }),
                    ShowLessTextAndIconFrame = React.createElement("Frame", {
                        AutomaticSize = Enum.AutomaticSize.XY,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1
                    }, {
                        UIListLayout = React.createElement("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center
                        }),
                        ShowLessText = React.createElement(
                            "TextLabel",
                            {
                                Text = var12 and var12.lessText,
                                LayoutOrder = 1,
                                FontFace = fontFace,
                                TextSize = fontSize,
                                BackgroundTransparency = 1,
                                TextColor3 = var1.Theme.TextMuted.Color,
                                Size = UDim2.new(0, 0, 1, 0),
                                AutomaticSize = Enum.AutomaticSize.X
                            },
                            { React.createElement("UIPadding", { PaddingRight = UDim.new(0, constants.DefaultPadding) }) }
                        ),
                        CollapseIcon = React.createElement(ImageSetLabel, {
                            LayoutOrder = 2,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = uDim2_2,
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Image = iconsActionsTruncationCollapse,
                            ImageColor3 = var1.Theme.UIEmphasis.Color
                        })
                    })
                })
            })
        end

        tbl5.ShowLessButton = element3

        tbl5.InvisibleExpandButton = React.createElement("TextButton", {
            Size = UDim2.new(1, 0, 0, if var4 and var8 then var6 + constants.DefaultPadding * 2 else 0),
            BackgroundTransparency = 1,
            Text = "",
            [React.Event.Activated] = func2,
            ZIndex = 5,
            BorderSizePixel = 0,
            AutoButtonColor = false
        })
        local var14

        if var6 == 0 or not (var4 and #tbl2.notifications > 1) then
            var14 = nil
        else
            local createElement2 = React.createElement
            local str2 = "Frame"
            local tbl6 = {
                Size = UDim2.new(0, 125, 0, yOffset),
                AutomaticSize = Enum.AutomaticSize.X,
                Position = UDim2.new(0.5, 0, 1, 0),
                AnchorPoint = Vector2.new(0.5, 1),
                ZIndex = 10,
                BackgroundColor3 = var1.Theme.BackgroundContrast.Color,
                BackgroundTransparency = 0
            }
            local tbl7 = {
                UICorner = React.createElement("UICorner", { CornerRadius = uDim2 }),
                NumberedMoreTextAndIconFrame = 0
            }
            local createElement3 = React.createElement
            local str3 = "Frame"
            local tbl8 = {
                AutomaticSize = Enum.AutomaticSize.XY,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            }

            local tbl9 = {
                UIListLayout = React.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }),
                NumberMoreText = 0,
                ExpandIcon = 0
            }
            local createElement4 = React.createElement
            local str4 = "TextLabel"
            local tbl10 = {
                Text = var12 and var12.moreText and string.gsub(var12.moreText, "{notificationCount}", tostring(#tbl2.notifications - 1)),
                LayoutOrder = 1,
                FontFace = fontFace,
                TextSize = fontSize,
                BackgroundTransparency = 1,
                TextColor3 = var1.Theme.TextMuted.Color,
                Size = UDim2.new(0, 0, 1, 0),
                AutomaticSize = Enum.AutomaticSize.X
            }
            tbl9.NumberMoreText = createElement4(
                str4,
                tbl10,
                { React.createElement("UIPadding", { PaddingRight = UDim.new(0, constants.DefaultPadding) }) }
            )

            tbl9.ExpandIcon = React.createElement(ImageSetLabel, {
                LayoutOrder = 2,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = uDim2_2,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Image = iconsActionsTruncationExpand,
                ImageColor3 = var1.Theme.UIEmphasis.Color
            })
            tbl7.NumberedMoreTextAndIconFrame = createElement3(str3, tbl8, tbl9)
            var14 = createElement2(str2, tbl6, tbl7)
        end

        tbl5.NumberMoreButton = var14

        tbl5.ListOfNotifications = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ZIndex = 3,
            BorderSizePixel = 0
        }, tbl3)
        return createElement(str1, tbl4, tbl5)
    end, {
        tbl2.notifications,
        var4,
        var6,
        var8,
        tbl2.impressionsTag,
        tbl2.impressionMetadataByNotificationId,
        fontFace,
        fontSize
    }))
end
