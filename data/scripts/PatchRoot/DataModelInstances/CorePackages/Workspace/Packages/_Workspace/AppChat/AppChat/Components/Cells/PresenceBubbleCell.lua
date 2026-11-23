-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local UIBlox = require(AppChatParent.UIBlox)
local Foundation = require(AppChatParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset
local BaseCell = require(script.Parent.BaseCell)

local ConversationFacePile = require(AppChat.Components.Cells.ConversationFacePile)
local AvatarCircle = require(script.Parent.AvatarCircle)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagAppChatFixPlusBadgeAlignment = require(AppChat.Flags.FFlagAppChatFixPlusBadgeAlignment)
local FFlagAppChatTimestampInSubtitle = require(AppChat.Flags.FFlagAppChatTimestampInSubtitle)

local tbl1 = {
    BackgroundColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0,
    onPressedBackgroundColor3 = Color3.new(0, 0.2, 0.3),
    onPressedBackgroundTransparency = 1,
    testId = nil,
    avatarCircleCellWidth = 60,
    avatarCircleSize = 36,
    avatarCircleBackgroundColor3 = Color3.new(0.4, 0.4, 0.4),
    avatarCircleDividerColor3 = Color3.new(0.2, 0.2, 0.2),
    avatarCircleDividerTransparency = 0,
    avatarCirclePresenceImage = nil,
    subTitleText = nil,
    subTitleTextFont = Enum.Font.Gotham,
    subTitleTextTransparency = 0,
    subTitleTextColor3 = Color3.new(0.1, 0.1, 0.1),
    subTitleTextSize = 15,
    subTitlePadding = 2,
    subTitleIconColor3 = Color3.new(0.1, 0.1, 0.1),
    subTitleIconTransparency = 0,
    titleText = "titleText",
    titleFont = Enum.Font.Gotham,
    titleTextTransparency = 0,
    titleTextColor3 = Color3.new(0, 0, 0),
    titleTextSize = 20,
    secondaryTitleText = nil,
    secondaryTitleFont = Enum.Font.Gotham,
    secondaryTitleTextTransparency = 0,
    secondaryTitleTextColor3 = Color3.new(0.2, 0.2, 0.2),
    secondaryTitleTextSize = 16,
    showDivider = true,
    dividerTransparency = 0,
    dividerColor3 = Color3.fromRGB(227, 227, 227),
    thumbnails = {},
    conversationId = nil,
    childWidth = 0,
    onActivated = nil,
    onCircleActivated = nil,
    Size = UDim2.new(1, 0, 1, 0),
    isLoading = false,
    hideLeftAvatarPadding = false,
    paddingLeft = 0,
    paddingRight = 0
}

return React.memo(function(tbl2) -- name: PresenceBubbleCell
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useTextSizeOffset()
    local var3 = var1.subTitleTextSize + var2
    local yOffset = var1.titleTextSize + var2
    local yOffset2 = var1.subTitleTextSize + var2

    local var4 = nil
    local var5 = nil
    local var6, var7

    if FFlagAppChatTimestampInSubtitle then
        local var8, var9 = React.useBinding(math.huge)
        var4 = var9
        local var10, var11 = React.useBinding(0)
        var5 = var11
        var6 = React.joinBindings({ var8, var10 }):map(function(tbl3)
            return Vector2.new(math.max(0, tbl3[1] - tbl3[2]), math.huge)
        end)
        var7 = React.useMemo(function()
            if not var1.subTitleTimestamp then
                return nil
            end
            local subTitleText = var1.subTitleText
            if subTitleText and subTitleText ~= "" then
                return var1.subTitleTimestamp:map(function(str1: string): string
                    return if str1 == "" then "" else " · " .. str1
                end)
            end
            return var1.subTitleTimestamp
        end, { var1.subTitleTimestamp, var1.subTitleText })
    else
        var7 = nil
        var6 = nil
    end

    local bool1 = var1.conversationId ~= nil
    local tbl3 = {
        layout = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    }

    local xOffset = -(var1.paddingLeft + var1.paddingRight + var1.childWidth)
    local var8 = Cryo.Dictionary.join(tbl3, var1.children or {})
    local createElement = React.createElement
    local var9 = BaseCell
    local tbl4 = {
        Size = var1.Size,
        BackgroundTransparency = var1.BackgroundTransparency,
        BackgroundColor3 = var1.BackgroundColor3,
        dividerColor3 = var1.dividerColor3,
        dividerTransparency = var1.dividerTransparency,
        avatarCircleCellWidth = var1.avatarCircleCellWidth,
        onPressedBackgroundColor3 = var1.onPressedBackgroundColor3,
        onPressedBackgroundTransparency = var1.onPressedBackgroundTransparency,
        testId = if FFlagDebugAppChatEnableDomLocators then var1.testId else nil,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        LayoutOrder = var1.LayoutOrder,
        onActivated = var1.onActivated,
        showDivider = var1.showDivider
    }
    local tbl5 = { leftAlign = 0, rightAlign = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl6 = {
        Size = UDim2.new(1, xOffset, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl7 = {
        uiPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var1.paddingLeft) }),
        layout = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        circleHolder = 0,
        conversationInfo = 0
    }

    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl8 = {
        Size = UDim2.new(0, var1.avatarCircleCellWidth, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 0
    }

    local tbl9 = {
        layout = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = if var1.hideLeftAvatarPadding then Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Center
        }),
        circleSizeContainer = 0
    }
    local bool2 = false
    local element

    if not var1.isLoading then
        local createElement4 = React.createElement
        local str3 = "Frame"
        local tbl10 = {
            Size = UDim2.new(0, var1.avatarCircleSize, 0, var1.avatarCircleSize),
            BackgroundTransparency = 1
        }
        local tbl11 = {
            conversationFacePile = if bool1 then React.createElement(ConversationFacePile, {
                conversationId = var1.conversationId,
                participants = var1.participants,
                onActivated = var1.onCircleActivated or var1.onActivated,
                selectable = not (var1.onCircleActivated == nil) and nil
            }) else nil,
            avatarCircle = 0
        }
        local element3

        if bool1 then
            element3 = nil
        else
            element3 = React.createElement(AvatarCircle, {
                circleColor3 = var1.BackgroundColor3,
                circleTransparency = var1.BackgroundTransparency,
                circleInteriorBackgroundColor3 = var1.avatarCircleBackgroundColor3,
                circleDividerColor3 = var1.avatarCircleDividerColor3,
                circleDividerTransparency = var1.avatarCircleDividerTransparency,
                thumbnails = var1.thumbnails,
                presenceImage = var1.avatarCirclePresenceImage,
                presenceImageColor3 = var1.avatarCirclePresenceImageColor3,
                presenceImageTransparency = var1.avatarCirclePresenceImageTransparency,
                selectable = not (var1.onCircleActivated == nil) and nil,
                showNewPresenceImage = var1.showNewPresenceImage,
                onActivated = var1.onCircleActivated or var1.onActivated
            })
        end

        tbl11.avatarCircle = element3
        element = createElement4(str3, tbl10, tbl11)
        bool2 = element
    end
    if not bool2 then
        element = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(0, var1.avatarCircleSize, 0, var1.avatarCircleSize),
                radius = Radius.Circle
            }
        )
    end

    tbl9.circleSizeContainer = element
    tbl7.circleHolder = createElement3(str2, tbl8, tbl9)

    local createElement4 = React.createElement
    local str3 = "Frame"
    local tbl10 = {
        Size = UDim2.new(1, -var1.avatarCircleCellWidth, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl11 = {
        layout = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 2)
        }),
        titleContainer = 0,
        userPresenceLabelWithIcon = 0
    }
    local bool3 = false
    local element2

    if not var1.isLoading then
        local createElement5 = React.createElement
        local str4 = "Frame"
        local tbl12 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, yOffset),
            LayoutOrder = 1
        }
        local tbl13 = {
            layout = React.createElement("UIListLayout", {
                VerticalAlignment = if FFlagAppChatFixPlusBadgeAlignment then Enum.VerticalAlignment.Center else Enum.VerticalAlignment.Bottom,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            }),
            title = React.createElement(
                "TextLabel",
                {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.new(0, 0, 0, yOffset),
                    TextSize = var1.titleTextSize,
                    TextColor3 = var1.titleTextColor3,
                    TextTransparency = var1.titleTextTransparency,
                    FontFace = normalizeFontFace(var1.titleFont),
                    Text = var1.titleText or "",
                    TextTruncate = Enum.TextTruncate.SplitWord,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 1
                },
                {
                    flex = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink })
                }
            ),
            subscriptionBadge = 0,
            secondaryTitle = 0
        }
        local element3

        if FFlagAppChatFixPlusBadgeAlignment then
            if var1.isRobloxSubscriber then
                element3 = React.createElement(Foundation.Icon, {
                    name = Foundation.Enums.IconName.RobloxPlus,
                    size = Foundation.Enums.IconSize.Small,
                    style = {
                        Color3 = var1.titleTextColor3,
                        Transparency = var1.titleTextTransparency
                    },
                    LayoutOrder = 2
                })
            else
                element3 = nil
            end
        else
            element3 = React.createElement(
                Foundation.View,
                {
                    tag = "size-400-400",
                    LayoutOrder = 2,
                    Visible = var1.isRobloxSubscriber == true
                },
                {
                    Icon = React.createElement(Foundation.Icon, {
                        name = Foundation.Enums.IconName.RobloxPlus,
                        size = Foundation.Enums.IconSize.Small,
                        style = {
                            Color3 = var1.titleTextColor3,
                            Transparency = var1.titleTextTransparency
                        }
                    })
                }
            )
        end

        tbl13.subscriptionBadge = element3

        tbl13.secondaryTitle = React.createElement(
            "TextLabel",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, var1.secondaryTitleTextSize),
                TextSize = var1.secondaryTitleTextSize,
                TextColor3 = var1.secondaryTitleTextColor3,
                TextTransparency = var1.secondaryTitleTextTransparency,
                FontFace = normalizeFontFace(var1.secondaryTitleFont),
                Text = var1.secondaryTitleText or "",
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = if FFlagEnableBlackbirdCheck then 3 else 2
            },
            {
                flex = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
            }
        )
        element2 = createElement5(str4, tbl12, tbl13)
        bool3 = element2
    end
    if not bool3 then
        element2 = React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, yOffset), radius = Radius.Small, LayoutOrder = 1 })
    end

    tbl11.titleContainer = element2
    local var10

    if var1.subTitleText then
        local createElement5 = React.createElement
        local str4 = "Frame"

        local tbl12 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, var3),
            LayoutOrder = 2,
            [React.Change.AbsoluteSize] = FFlagAppChatTimestampInSubtitle and function(arg1)
                var4(arg1.AbsoluteSize.X)
            end or nil
        }

        local tbl13 = {
            layout = React.createElement("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, if FFlagAppChatTimestampInSubtitle and not var1.subTitleIcon then 0 else var1.subTitlePadding)
            }),
            subTitleIcon = if var1.subTitleIcon and not var1.isLoading then React.createElement(ImageSetLabel, {
                Size = UDim2.new(0, var3, 0, var3),
                BackgroundTransparency = 1,
                Image = var1.subTitleIcon,
                ImageColor3 = var1.subTitleIconColor3,
                ImageTransparency = var1.subTitleIconTransparency,
                LayoutOrder = 1
            }) else nil,
            userPresenceLabel = 0,
            timestampLabel = 0
        }
        local element3

        if var1.isLoading then
            element3 = React.createElement(Skeleton, { Size = UDim2.new(0.6, 0, 0, yOffset2), radius = Radius.Small, LayoutOrder = 2 })
        else
            element3 = React.createElement(
                "TextLabel",
                {
                    BackgroundTransparency = 1,
                    AutomaticSize = if FFlagAppChatTimestampInSubtitle then Enum.AutomaticSize.X else nil,
                    Size = if FFlagAppChatTimestampInSubtitle then UDim2.new(0, 0, 0, yOffset2) else UDim2.new(1, if var1.subTitleIcon then -var3 - var1.subTitlePadding else 0, 0, yOffset2),
                    TextSize = var1.subTitleTextSize + 1,
                    TextColor3 = var1.subTitleTextColor3,
                    TextTransparency = var1.subTitleTextTransparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Text = var1.subTitleText,
                    TextTruncate = if FFlagAppChatTimestampInSubtitle then Enum.TextTruncate.SplitWord else Enum.TextTruncate.AtEnd,
                    FontFace = normalizeFontFace(var1.subTitleTextFont),
                    LayoutOrder = 2
                },
                FFlagAppChatTimestampInSubtitle and {
                    sizeConstraint = React.createElement("UISizeConstraint", { MaxSize = var6 })
                }
                    or nil
            )
        end

        tbl13.userPresenceLabel = element3
        local var11

        if FFlagAppChatTimestampInSubtitle and var1.subTitleTimestamp and not var1.isLoading then
            local createElement6 = React.createElement
            local tbl14 = {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2.new(0, 0, 0, yOffset2),
                TextSize = var1.subTitleTextSize + 1,
                TextColor3 = var1.subTitleTextColor3,
                TextTransparency = var1.subTitleTextTransparency,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = var7,
                FontFace = normalizeFontFace(var1.subTitleTextFont),
                LayoutOrder = 3
            }

            tbl14[React.Change.AbsoluteSize] = function(arg1)
                var5(arg1.AbsoluteSize.X)
            end

            var11 = createElement6("TextLabel", tbl14)
        else
            var11 = nil
        end

        tbl13.timestampLabel = var11
        var10 = createElement5(str4, tbl12, tbl13)
    else
        var10 = nil
    end

    tbl11.userPresenceLabelWithIcon = var10
    tbl7.conversationInfo = createElement4(str3, tbl10, tbl11)
    tbl5.leftAlign = createElement2(str1, tbl6, tbl7)

    tbl5.rightAlign = React.createElement(
        "Frame",
        {
            Size = UDim2.new(0, var1.childWidth, 1, 0),
            Position = UDim2.new(1, -var1.childWidth, 0, 0),
            BackgroundTransparency = 1
        },
        Cryo.Dictionary.join({
            uiPadding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, var1.paddingRight) }),
            layout = React.createElement("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        }, var8)
    )
    return createElement(var9, tbl4, tbl5)
end)
