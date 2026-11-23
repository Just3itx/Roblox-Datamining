-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)
local UserTile = require(AppChatParent.UserTile).UserTile
local LayoutMode = require(AppChatParent.UserTile).LayoutMode
local Skeleton = Foundation.Skeleton

local useTokens = Foundation.Hooks.useTokens
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local useFoundationPresence = require(AppChat.Hooks.useFoundationPresence)

local FFlagAppChatContextCardNameLoadingShimmer = require(AppChat.Flags.FFlagAppChatContextCardNameLoadingShimmer)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)

local SharedFlags = require(AppChatParent.SharedFlags)
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagAppChatDiscloseUpdateSecondVersion = SharedFlags.FFlagAppChatDiscloseUpdateSecondVersion

return React.memo(React.forwardRef(function(tbl1, ref)
    local var1 = useTokens()
    local size = var1.Size
    local var2 = useFoundationPresence(tbl1.userId)
    local var3 = useLocalization({
        firstConversationWithThisUserHeadingText = if FFlagAppChatDiscloseUpdateSecondVersion then "Feature.Chat.Heading.FirstConversationWithThisUser" else "Feature.Chat.Heading.SafeChattingWithThisUser",
        firstConversationWithHeadingText = FFlagAppChatDiscloseUpdateSecondVersion
            and {
                "Feature.Chat.Heading.FirstConversationWith",
                displayName = tbl1.displayName
            }
            or {
                "Feature.Chat.Heading.SafeChattingWithUsername",
                displayName = tbl1.displayName
            },
        firstInteractionWithThisPersonHeadingText = "Feature.Chat.Heading.FirstInteractionWithThisPerson",
        firstInteractionWithHeadingText = {
            "Feature.Chat.Heading.FirstInteractionWith",
            displayName = tbl1.displayName
        },
        osaContextCardDescriptionText = if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "Feature.Chat.Description.InlineContextCardDescription" else "Feature.Chat.Description.OSAContextCardDescription",
        user = "Feature.Chat.Label.User"
    })
    local var4 = if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then var3.firstConversationWithHeadingText else var3.firstInteractionWithHeadingText
    local var5 = if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then var3.firstConversationWithThisUserHeadingText else var3.firstInteractionWithThisPersonHeadingText

    if not FFlagAppChatContextCardNameLoadingShimmer then
        if not (tbl1.displayName and tbl1.username and tbl1.avatarThumbnail or tbl1.hasError) then
            return React.createElement(
                Foundation.View,
                {
                    tag = "size-full-0 auto-y",
                    sizeConstraint = {
                        MaxSize = Vector2.new(700, 500)
                    }
                },
                { React.createElement(Foundation.Skeleton, { Size = UDim2.new(1, 0, 0, 270), radius = Foundation.Enums.Radius.Large }) }
            )
        end

        local createElement = React.createElement
        local view = Foundation.View
        local tbl2 = {
            tag = "col align-x-center size-full-0 auto-y padding-xxlarge radius-large bg-shift-100 gap-xlarge",
            sizeConstraint = {
                MaxSize = Vector2.new(700, 500)
            }
        }
        local tbl3 = { AvatarContainer = 0, TextContainer = 0 }
        local var6

        if tbl1.hasError then
            var6 = nil
        else
            local createElement2 = React.createElement
            local view2 = Foundation.View
            local tbl4 = {
                tag = "col auto-xy bg-action-subtle align-x-center gap-medium radius-large padding-small",
                LayoutOrder = 1,
                onActivated = tbl1.onAvatarActivated
            }
            local tbl5 = {
                AvatarCircle = React.createElement(Foundation.View, {
                    tag = "size-1200-1200",
                    LayoutOrder = 1
                }, { React.createElement(UserTile, {
                        userId = tostring(tbl1.userId),
                        layoutMode = LayoutMode.compact,
                        userPresenceType = var2.presence,
                        dontTruncateTitle = true,
                        onActivated = tbl1.onAvatarActivated,
                        isRobloxSubscriber = if FFlagEnableBlackbirdCheck then tbl1.isRobloxSubscriber else nil,
                        selectable = not FFlagAppChatConsoleFocusFixes and nil
                    }) }),
                AvatarTextContainer = 0
            }

            local createElement3 = React.createElement
            local view3 = Foundation.View
            local tbl6 = { tag = "col auto-xy align-x-center", LayoutOrder = 2 }

            local tbl7 = { DisplayName = 0, Username = 0 }
            local element

            if FFlagEnableBlackbirdCheck and tbl1.isRobloxSubscriber then
                element = React.createElement(Foundation.View, {
                    tag = "row auto-xy align-y-center gap-xsmall",
                    LayoutOrder = 1
                }, {
                    Name = React.createElement(Foundation.Text, {
                        tag = "auto-xy",
                        LayoutOrder = 1,
                        Text = tbl1.displayName,
                        fontStyle = var1.Typography.TitleMedium,
                        textStyle = var1.Color.Content.Emphasis
                    }),
                    Badge = React.createElement(Foundation.Icon, {
                        LayoutOrder = 2,
                        name = Foundation.Enums.IconName.RobloxPlus,
                        size = Foundation.Enums.IconSize.Small,
                        style = var1.Color.Content.Emphasis
                    })
                })
            else
                element = React.createElement(Foundation.Text, {
                    tag = "auto-xy",
                    LayoutOrder = 1,
                    Text = tbl1.displayName,
                    fontStyle = var1.Typography.TitleMedium,
                    textStyle = var1.Color.Content.Emphasis
                })
            end

            tbl7.DisplayName = element

            tbl7.Username = React.createElement(Foundation.Text, {
                tag = "auto-xy",
                LayoutOrder = 2,
                Text = tbl1.username,
                fontStyle = var1.Typography.BodySmall,
                textStyle = var1.Color.Content.Muted
            })
            tbl5.AvatarTextContainer = createElement3(view3, tbl6, tbl7)
            var6 = createElement2(view2, tbl4, tbl5)
        end

        tbl3.AvatarContainer = var6

        local createElement2 = React.createElement
        local view2 = Foundation.View
        local tbl4 = { tag = "col align-x-center auto-xy", LayoutOrder = 2, ref = ref }
        local tbl5 = { HeadingText = 0, DescriptionText = 0 }
        local createElement3 = React.createElement
        local foundationText = Foundation.Text
        local tbl6 = {
            tag = "auto-xy text-wrap",
            LayoutOrder = 1,
            Text = 0,
            fontStyle = 0,
            textStyle = 0
        }

        if tbl1.hasError then
            var4 = var5
        end

        tbl6.Text = var4
        tbl6.fontStyle = var1.Typography.TitleLarge
        tbl6.textStyle = var1.Color.Content.Emphasis
        tbl5.HeadingText = createElement3(foundationText, tbl6)

        tbl5.DescriptionText = React.createElement(Foundation.Text, {
            tag = "auto-xy text-wrap",
            LayoutOrder = 2,
            Text = var3.osaContextCardDescriptionText,
            fontStyle = var1.Typography.BodyLarge,
            textStyle = var1.Color.Content.Default
        })
        tbl3.TextContainer = createElement2(view2, tbl4, tbl5)
        return createElement(view, tbl2, tbl3)
    end

    local bool1 = not (tbl1.displayName or tbl1.hasError)
    local bool2 = not (tbl1.username or tbl1.hasError)
    local bool3 = not (tbl1.avatarThumbnail or tbl1.hasError)

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "col align-x-center size-full-0 auto-y padding-xxlarge radius-large bg-shift-100 gap-xlarge",
        sizeConstraint = {
            MaxSize = Vector2.new(700, 500)
        }
    }
    local tbl3 = { AvatarContainer = 0, TextContainer = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = "col auto-xy bg-action-subtle align-x-center gap-medium radius-large padding-small",
        LayoutOrder = 1,
        onActivated = if bool1 or bool2 or bool3 then nil else tbl1.onAvatarActivated
    }
    local tbl5 = { AvatarCircle = 0, AvatarTextContainer = 0 }
    local element

    if bool3 then
        element = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(0, size.Size_1200, 0, size.Size_1200),
                radius = Foundation.Enums.Radius.Circle,
                LayoutOrder = 1
            }
        )
    else
        element = React.createElement(Foundation.View, { tag = "size-1200-1200", LayoutOrder = 1 }, { React.createElement(
                UserTile,
                {
                    userId = tostring(tbl1.userId),
                    layoutMode = LayoutMode.compact,
                    userPresenceType = var2.presence,
                    dontTruncateTitle = true,
                    onActivated = tbl1.onAvatarActivated,
                    isRobloxSubscriber = if FFlagEnableBlackbirdCheck then tbl1.isRobloxSubscriber else nil,
                    selectable = not FFlagAppChatConsoleFocusFixes and nil
                }
            ) })
    end

    tbl5.AvatarCircle = element

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = { tag = "col auto-xy align-x-center gap-xxsmall", LayoutOrder = 2 }

    local tbl7 = { DisplayName = 0, Username = 0 }
    local element2

    if bool1 then
        element2 = React.createElement(Skeleton, {
            Size = UDim2.new(0, size.Size_2500, 0, var1.Typography.TitleMedium.FontSize),
            radius = Foundation.Enums.Radius.Large,
            LayoutOrder = 1
        })
    elseif FFlagEnableBlackbirdCheck and tbl1.isRobloxSubscriber and not tbl1.hasError then
        element2 = React.createElement(Foundation.View, {
            tag = "row auto-xy align-y-center gap-xsmall",
            LayoutOrder = 1
        }, {
            Name = React.createElement(Foundation.Text, {
                tag = "auto-xy",
                LayoutOrder = 1,
                Text = tbl1.displayName,
                fontStyle = var1.Typography.TitleMedium,
                textStyle = var1.Color.Content.Emphasis
            }),
            Badge = React.createElement(Foundation.Icon, {
                LayoutOrder = 2,
                name = Foundation.Enums.IconName.RobloxPlus,
                size = Foundation.Enums.IconSize.Small,
                style = var1.Color.Content.Emphasis
            })
        })
    else
        element2 = React.createElement(Foundation.Text, {
            tag = "auto-xy",
            LayoutOrder = 1,
            Text = if tbl1.hasError then var3.user else tbl1.displayName,
            fontStyle = var1.Typography.TitleMedium,
            textStyle = var1.Color.Content.Emphasis
        })
    end

    tbl7.DisplayName = element2
    local element3

    if bool2 then
        element3 = React.createElement(Skeleton, {
            Size = UDim2.new(0, size.Size_2000, 0, var1.Typography.BodySmall.FontSize),
            radius = Foundation.Enums.Radius.Large,
            LayoutOrder = 2
        })
    else
        element3 = React.createElement(Foundation.Text, {
            tag = "auto-xy",
            LayoutOrder = 2,
            Text = if tbl1.hasError then var3.user else tbl1.username,
            fontStyle = var1.Typography.BodySmall,
            textStyle = var1.Color.Content.Muted
        })
    end

    tbl7.Username = element3
    tbl5.AvatarTextContainer = createElement3(view3, tbl6, tbl7)
    tbl3.AvatarContainer = createElement2(view2, tbl4, tbl5)

    local createElement4 = React.createElement
    local view4 = Foundation.View
    local tbl8 = { tag = "col align-x-center auto-xy", LayoutOrder = 2, ref = ref }
    local tbl9 = { HeadingText = 0, DescriptionText = 0 }
    local element4

    if bool1 then
        element4 = React.createElement(Skeleton, {
            Size = UDim2.new(0, size.Size_3000, 0, var1.Typography.TitleLarge.FontSize + var1.Gap.XXSmall),
            radius = Foundation.Enums.Radius.Large,
            LayoutOrder = 1
        })
    else
        local createElement5 = React.createElement
        local foundationText = Foundation.Text
        local tbl10 = {
            tag = "auto-xy text-wrap",
            LayoutOrder = 1,
            Text = 0,
            fontStyle = 0,
            textStyle = 0
        }

        if tbl1.hasError then
            var4 = var5
        end

        tbl10.Text = var4
        tbl10.fontStyle = var1.Typography.TitleLarge
        tbl10.textStyle = var1.Color.Content.Emphasis
        element4 = createElement5(foundationText, tbl10)
    end

    tbl9.HeadingText = element4

    tbl9.DescriptionText = React.createElement(Foundation.Text, {
        tag = "auto-xy text-wrap",
        LayoutOrder = 2,
        Text = var3.osaContextCardDescriptionText,
        fontStyle = var1.Typography.BodyLarge,
        textStyle = var1.Color.Content.Default
    })
    tbl3.TextContainer = createElement4(view4, tbl8, tbl9)
    return createElement(view, tbl2, tbl3)
end))
