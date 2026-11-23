-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local UserTile = require(UserListParent.UserTile).UserTile
local Foundation = require(UserListParent.Foundation)
local _Types = require(UserList.Common.Types)
local Enums = require(UserList.Common.Enums)
local Constants = require(UserList.Common.Constants)
local TextKeys = require(UserList.Common.TextKeys)
local useLocalization = require(UserListParent.Localization).Hooks.useLocalization

local FFlagFriendsPageViewBtnEnabled = require(UserListParent.SharedFlags).FFlagFriendsPageViewBtnEnabled
local FFlagEnableBlackbirdCheck = require(UserListParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagUserListCtaIntegrationEnabled = require(UserListParent.SharedFlags).FFlagUserListCtaIntegrationEnabled
local FFlagUserListSurfaceExtensions = require(UserListParent.SharedFlags).FFlagUserListSurfaceExtensions
local FFlagUserListInviteCta = require(UserListParent.SharedFlags).FFlagUserListInviteCta

local View = Foundation.View
local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local StatusIndicator = Foundation.StatusIndicator
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local useTokens = Foundation.Hooks.useTokens
local FillBehavior = Foundation.Enums.FillBehavior

local tbl1 = {
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
    SelectionBehaviorUp = Enum.SelectionBehavior.Escape,
    SelectionBehaviorDown = Enum.SelectionBehavior.Escape
}

return React.memo(function(tbl2) -- name: BaseRow
    local var1 = useTokens()
    local var2 = FFlagUserListSurfaceExtensions and tbl2.disableRowActivation == true

    local var3 = useLocalization({
        Accept = TextKeys.Accept,
        Add = TextKeys.Add,
        Chat = TextKeys.Chat,
        Join = TextKeys.Join,
        Pending = TextKeys.Pending,
        [Enums.ButtonTypes.Invite] = if FFlagUserListInviteCta then TextKeys.Invite else nil,
        [Enums.ButtonTypes.Invited] = if FFlagUserListInviteCta then TextKeys.Invited else nil,
        [Enums.ButtonTypes.View] = if FFlagFriendsPageViewBtnEnabled or FFlagUserListCtaIntegrationEnabled then TextKeys.View else nil
    })

    local createElement = React.createElement
    local var4 = View
    local tbl3 = {
        LayoutOrder = tbl2.layoutOrder,
        tag = {
            ["size-full-0 auto-y align-y-center"] = true,
            ["row gap-medium padding-top-medium padding-bottom-medium padding-right-xsmall flex-x-between"] = tbl2.layoutMode == Enums.RowLayoutMode.Wide,
            ["col gap-small padding-medium bg-surface-100 radius-medium"] = tbl2.layoutMode == Enums.RowLayoutMode.Compact
        }
    }
    local tbl4 = { UserTileContainer = 0, TrailingSection = 0 }
    local createElement2 = React.createElement
    local var5 = View
    local tbl5 = {
        tag = {
            fill = tbl2.layoutMode == Enums.RowLayoutMode.Wide,
            ["size-full-0 auto-y"] = tbl2.layoutMode == Enums.RowLayoutMode.Compact
        },
        Size = if tbl2.layoutMode == Enums.RowLayoutMode.Wide then UDim2.new(0, 0, 0, Constants.USER_ROW_HEIGHT) else nil,
        LayoutOrder = 1
    }

    local tbl6 = {
        UserTile = React.createElement(UserTile, {
            userId = tbl2.userId or "",
            avatarThumbnailUrl = tbl2.avatarThumbnailUrl,
            userPresenceType = tbl2.userPresenceType or Foundation.Enums.UserPresence.None,
            title = tbl2.title,
            subtitle = tbl2.subtitle,
            layoutMode = tbl2.layoutMode,
            onActivated = if var2 then nil else tbl2.onActivated,
            selectable = not var2 and (tbl2.selectable == nil or tbl2.selectable),
            isTitleLoading = tbl2.isTitleLoading,
            isSubtitleLoading = tbl2.isSubtitleLoading,
            contextualInfo = tbl2.contextualInfo and tbl2.contextualInfo.text,
            isContextualInfoLoading = tbl2.isContextualInfoLoading,
            avatarSize = if tbl2.layoutMode == Enums.RowLayoutMode.Compact then UDim2.new(0, var1.Size.Size_1400, 0, var1.Size.Size_1400) else nil,
            trustedConnectionIndicatorEnabled = tbl2.trustedConnectionIndicatorEnabled,
            isRobloxSubscriber = if FFlagEnableBlackbirdCheck then tbl2.isRobloxSubscriber else nil
        })
    }
    tbl4.UserTileContainer = createElement2(var5, tbl5, tbl6)

    local createElement3 = React.createElement
    local var6 = View
    local tbl7 = {
        tag = {
            ["gap-xsmall"] = true,
            ["row align-y-center auto-xy"] = tbl2.layoutMode == Enums.RowLayoutMode.Wide,
            ["col size-full-0 auto-y align-x-center"] = tbl2.layoutMode == Enums.RowLayoutMode.Compact
        },
        LayoutOrder = 2,
        selectionGroup = if var2 and tbl2.layoutMode == Enums.RowLayoutMode.Wide then tbl1 else nil
    }

    local tbl8 = {
        StatusIndicatorContainer = if tbl2.shouldShowNewIndicator then React.createElement(
            View,
            { LayoutOrder = 1, tag = "auto-xy padding-right-small" },
            {
                StatusIndicator = React.createElement(StatusIndicator, { variant = StatusIndicatorVariant.Emphasis })
            }
        ) else nil,
        PrimaryActionCta = 0,
        SecondaryActionCta = 0,
        TrailingContentWrapper = 0
    }
    local element

    if tbl2.primaryCta and tbl2.primaryCta.onActivated then
        if tbl2.layoutMode == Enums.RowLayoutMode.Wide then
            local createElement4 = React.createElement
            local var7 = View
            local tbl9 = {
                LayoutOrder = 2,
                tag = "auto-xy",
                sizeConstraint = {
                    MinSize = if tbl2.primaryCta.minWidth then Vector2.new(tbl2.primaryCta.minWidth, 0) else nil,
                    MaxSize = if tbl2.primaryCta.maxWidth then Vector2.new(tbl2.primaryCta.maxWidth, math.huge) else nil
                }
            }

            local tbl10 = {
                Button = React.createElement(Button, {
                    text = var3[tbl2.primaryCta.type],
                    size = InputSize.Small,
                    variant = if FFlagFriendsPageViewBtnEnabled or FFlagUserListCtaIntegrationEnabled then tbl2.primaryCta.variant or ButtonVariant.SoftEmphasis else ButtonVariant.SoftEmphasis,
                    onActivated = tbl2.primaryCta.onActivated,
                    isDisabled = tbl2.primaryCta.isDisabled,
                    isLoading = tbl2.primaryCta.isLoading,
                    fillBehavior = FillBehavior.Fill
                })
            }
            element = createElement4(var7, tbl9, tbl10)
        else
            element = React.createElement(Button, {
                text = var3[tbl2.primaryCta.type],
                size = InputSize.Small,
                variant = if FFlagFriendsPageViewBtnEnabled or FFlagUserListCtaIntegrationEnabled then tbl2.primaryCta.variant or ButtonVariant.SoftEmphasis else ButtonVariant.SoftEmphasis,
                onActivated = tbl2.primaryCta.onActivated,
                isDisabled = tbl2.primaryCta.isDisabled,
                isLoading = tbl2.primaryCta.isLoading,
                LayoutOrder = 2,
                width = if tbl2.layoutMode == Enums.RowLayoutMode.Compact then UDim.new(1, 0) else nil
            })
        end
    elseif FFlagUserListCtaIntegrationEnabled and tbl2.ctaLoading and tbl2.layoutMode == Enums.RowLayoutMode.Wide then
        element = React.createElement(
            Skeleton,
            {
                LayoutOrder = 2,
                Size = UDim2.fromOffset(tbl2.ctaLoading.minWidth or 0, var1.Size.Size_800),
                radius = Radius.Medium
            }
        )
    else
        element = nil
    end

    tbl8.PrimaryActionCta = element
    local element2

    if tbl2.layoutMode == Enums.RowLayoutMode.Wide
        and tbl2.secondaryCta
        and tbl2.secondaryCta.icon
        and tbl2.secondaryCta.onActivated
    then
        element2 = React.createElement(IconButton, {
            icon = tbl2.secondaryCta.icon,
            size = IconSize.Small,
            variant = ButtonVariant.Utility,
            onActivated = tbl2.secondaryCta.onActivated,
            isDisabled = tbl2.secondaryCta.isDisabled,
            isLoading = tbl2.secondaryCta.isLoading,
            LayoutOrder = 3
        })
    else
        element2 = nil
    end

    tbl8.SecondaryActionCta = element2

    tbl8.TrailingContentWrapper = if tbl2.layoutMode == Enums.RowLayoutMode.Wide and tbl2.trailingContent then React.createElement(View, { tag = "auto-xy", LayoutOrder = 4 }, { Content = tbl2.trailingContent }) else nil
    tbl4.TrailingSection = createElement3(var6, tbl7, tbl8)
    return createElement(var4, tbl3, tbl4)
end)
