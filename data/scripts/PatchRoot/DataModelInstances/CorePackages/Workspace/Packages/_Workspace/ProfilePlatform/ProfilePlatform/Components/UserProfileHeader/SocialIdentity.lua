-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local VerifiedBadges = require(ProfilePlatformParent.VerifiedBadges)

local UIBlox = require(ProfilePlatformParent.UIBlox)
local HorizontalPageMargin = UIBlox.App.Container.HorizontalPageMargin
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local Tooltip = UIBlox.App.Dialog.Tooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport
local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local useTokens = Foundation.Hooks.useTokens
local Enums = Foundation.Enums
local StateLayerAffordance = Enums.StateLayerAffordance
local IconSize2 = Enums.IconSize

local useDispatch = require(ProfilePlatformParent.RoactUtils).Hooks.RoactRodux.useDispatch

local Contexts = require(ProfilePlatformParent.SocialLuaAnalytics).Analytics.Enums.Contexts
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)

local default = require(ProfilePlatformParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default
local SetCurrentToastMessage = require(ProfilePlatformParent.ToastRodux).Actions.SetCurrentToastMessage

local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FFlagProfilePlatformEnableClickToCopyUsername = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableClickToCopyUsername)

local FFlagEnableFontStylisticAlternativesOnSocialScreens = require(ProfilePlatformParent.SharedFlags).FFlagEnableFontStylisticAlternativesOnSocialScreens
local GetFFlagLuaAppEnableOpenTypeSupport = require(ProfilePlatformParent.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport

local FFlagProfilePlatformEnableRobloxAdminBadge = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableRobloxAdminBadge)
local FFlagEnableBlackbirdCheck = require(ProfilePlatformParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagHidePremiumIconography = require(ProfilePlatformParent.SharedFlags).FFlagHidePremiumIconography
local FFlagAddPlatformNameToProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagAddPlatformNameToProfileHeader
local FFlagDisableCopyUsernameOnConsole = require(ProfilePlatformParent.SharedFlags).FFlagDisableCopyUsernameOnConsole
local Responsive = require(ProfilePlatformParent.Responsive)
local getBuilderIconForCurrentPlatform = Foundation.Utility.getBuilderIconForCurrentPlatform

local FFlagProfilePlatformTruncateLongCustomFriendNames = require(ProfilePlatform.Flags.FFlagProfilePlatformTruncateLongCustomFriendNames)
local iconsActionsEditCopy = if FFlagProfilePlatformEnableClickToCopyUsername then Images["icons/actions/edit/copy"] else nil

local function SocialIdentity(tbl1)
    local var1 = useTokens()
    local name = React.useMemo(function()
        if FFlagAddPlatformNameToProfileHeader then
            return (getBuilderIconForCurrentPlatform())
        end

        return nil
    end, {})

    local icon = if tbl1.isEdited then Images["icons/actions/edit/editOn_small"] else Images["icons/actions/edit/edit_small"]
    local var4 = if FFlagProfilePlatformEnableClickToCopyUsername then useDispatch() else nil
    local var5 = if FFlagProfilePlatformEnableClickToCopyUsername then useProfileAnalyticsContext() else nil
    local bool1 = if FFlagDisableCopyUsernameOnConsole then Responsive.usePreferredInput() == Responsive.Input.Directional else false
    local var6 = (tbl1.primaryName .. (if FFlagHidePremiumIconography or not tbl1.isPremium or FFlagEnableBlackbirdCheck and tbl1.isRobloxSubscriber == true then "" else VerifiedBadges.emoji.premium))
        .. (if tbl1.isVerified then VerifiedBadges.emoji.verified else "")

    local str1 = `@{tbl1.username}`

    local var7 = useLocalization({
        tooltipTitle = if tbl1.isLocalUser then nil else TextKeys.AliasTooltipHeader,
        tooltipBody = if tbl1.isLocalUser then TextKeys.DisplayNameTooltipBody else TextKeys.AliasTooltipBody,
        usernameCopied = if FFlagProfilePlatformEnableClickToCopyUsername then TextKeys.UsernameCopied else nil,
        trustedLabel = TextKeys.TrustedLabel
    })

    local var8 = if FFlagProfilePlatformEnableClickToCopyUsername then React.useCallback(function()
        default:setClipboardText({ context = Contexts.ProfileCard, text = tbl1.username })

        var5.fireAnalyticsEvent(EventNames.UsernameCopied)
        var4(
            SetCurrentToastMessage({ toastMessage = var7.usernameCopied, isLocalized = true, toastIcon = iconsActionsEditCopy })
        )
    end, { tbl1.username, var5, var7.usernameCopied }) else nil

    local str2 = if tbl1.isTrustedConnection then ` \226\128\162 {var7.trustedLabel}` else ""

    local onActivated = React.useCallback(function()
        if tbl1.openEditName then
            tbl1.openEditName()
        end

        tbl1.dismissTooltip()
    end)

    local createElement = React.createElement
    local var10 = HorizontalPageMargin
    local tbl2 = {
        size = tbl1.size,
        layoutOrder = tbl1.layoutOrder,
        useAutomaticSizing = true,
        backgroundTransparency = 1
    }

    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        PrimaryNameFrame = 0,
        Username = 0,
        PlatformName = 0
    }
    local var11

    if FFlagProfilePlatformTruncateLongCustomFriendNames then
        local createElement2 = React.createElement
        local var12 = View
        local tbl4 = { tag = "row align-y-center auto-y size-full-0", LayoutOrder = 1 }

        local tbl5 = { PrimaryNameFrameTouchable = 0 }
        local createElement3 = React.createElement
        local var13 = View
        local tbl6 = {
            tag = "row align-x-left align-y-center auto-xy gap-xxsmall",
            LayoutOrder = 1,
            onActivated = onActivated
        }
        local tbl7 = {
            EditNameButton = 0,
            PrimaryName = 0,
            AdminTiltIcon = 0,
            SubscriptionBadge = 0
        }
        local element

        if tbl1.openEditName then
            element = React.createElement(
                IconButton,
                {
                    icon = icon,
                    iconSize = IconSize.Small,
                    size = UDim2.fromOffset(26, 26),
                    layoutOrder = 1,
                    onActivated = onActivated
                },
                {
                    tooltip = if tbl1.isTooltipActive then React.createElement(Tooltip, {
                        triggerPosition = Vector2.new(16, 0),
                        triggerSize = Vector2.new(0, 0),
                        headerText = var7.tooltipTitle,
                        bodyText = var7.tooltipBody,
                        orientation = TooltipOrientation.Top,
                        forceClickTriggerPoint = true,
                        isDirectChild = true
                    }) else nil
                }
            )
        else
            element = nil
        end

        tbl7.EditNameButton = element

        tbl7.PrimaryName = React.createElement(FoundationText, {
            Text = var6,
            tag = "auto-xy text-align-x-left text-align-y-bottom content-emphasis text-truncate-end shrink",
            fontStyle = var1.Typography.HeadingSmall,
            LayoutOrder = 2
        })

        tbl7.AdminTiltIcon = if FFlagProfilePlatformEnableRobloxAdminBadge and tbl1.isRobloxAdmin then React.createElement(
            Foundation.Icon,
            {
                name = Foundation.Enums.IconName.Tilt,
                size = Foundation.Enums.IconSize.Large,
                LayoutOrder = 3
            }
        ) else nil

        tbl7.SubscriptionBadge = if FFlagEnableBlackbirdCheck and tbl1.isRobloxSubscriber == true then React.createElement(
            View,
            { tag = "auto-xy padding-top-xxsmall", LayoutOrder = 4 },
            {
                Icon = React.createElement(
                    Foundation.Icon,
                    {
                        name = Foundation.Enums.IconName.RobloxPlus,
                        size = Foundation.Enums.IconSize.Small
                    }
                )
            }
        ) else nil
        tbl5.PrimaryNameFrameTouchable = createElement3(var13, tbl6, tbl7)
        var11 = createElement2(var12, tbl4, tbl5)
    else
        local createElement2 = React.createElement
        local str3 = "Frame"
        local tbl4 = {
            Size = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        }
        local tbl5 = { PrimaryNameFrameTouchable = 0 }
        local createElement3 = React.createElement
        local str4 = "TextButton"
        local tbl6 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            Text = "",
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            [React.Event.Activated] = onActivated,
            Selectable = false
        }
        local tbl7 = {
            UIListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = if FFlagProfilePlatformEnableRobloxAdminBadge and tbl1.isRobloxAdmin then Enum.VerticalAlignment.Center else Enum.VerticalAlignment.Bottom,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            EditNameButton = 0,
            PrimaryName = 0,
            AdminTiltIcon = 0,
            SubscriptionBadge = 0
        }
        local element

        if tbl1.openEditName then
            element = React.createElement(
                IconButton,
                {
                    icon = icon,
                    iconSize = IconSize.Small,
                    size = UDim2.fromOffset(26, 26),
                    layoutOrder = 1,
                    onActivated = onActivated
                },
                {
                    tooltip = if tbl1.isTooltipActive then React.createElement(Tooltip, {
                        triggerPosition = Vector2.new(16, 0),
                        triggerSize = Vector2.new(0, 0),
                        headerText = var7.tooltipTitle,
                        bodyText = var7.tooltipBody,
                        orientation = TooltipOrientation.Top,
                        forceClickTriggerPoint = true,
                        isDirectChild = true
                    }) else nil
                }
            )
        else
            element = nil
        end

        tbl7.EditNameButton = element

        tbl7.PrimaryName = React.createElement(FoundationText, {
            Text = var6,
            tag = "auto-xy text-align-x-left text-align-y-bottom content-emphasis",
            fontStyle = var1.Typography.HeadingSmall,
            LayoutOrder = 2
        })
        local element2

        if FFlagProfilePlatformEnableRobloxAdminBadge and tbl1.isRobloxAdmin then
            element2 = React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    LayoutOrder = 3
                },
                {
                    UIPadding = React.createElement(
                        "UIPadding",
                        {
                            PaddingLeft = UDim.new(0, var1.Gap.XXSmall),
                            PaddingBottom = UDim.new(0, var1.Gap.XXSmall)
                        }
                    ),
                    Icon = React.createElement(Foundation.Icon, { name = Foundation.Enums.IconName.Tilt, size = Foundation.Enums.IconSize.Large })
                }
            )
        else
            element2 = nil
        end

        tbl7.AdminTiltIcon = element2
        local element3

        if FFlagEnableBlackbirdCheck and tbl1.isRobloxSubscriber == true then
            element3 = React.createElement(
                "Frame",
                {
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundTransparency = 1,
                    LayoutOrder = 4
                },
                {
                    UIPadding = React.createElement(
                        "UIPadding",
                        {
                            PaddingLeft = UDim.new(0, var1.Gap.XXSmall),
                            PaddingBottom = UDim.new(0, var1.Gap.XXSmall)
                        }
                    ),
                    Icon = React.createElement(
                        Foundation.Icon,
                        {
                            name = Foundation.Enums.IconName.RobloxPlus,
                            size = Foundation.Enums.IconSize.Small
                        }
                    )
                }
            )
        else
            element3 = nil
        end

        tbl7.SubscriptionBadge = element3
        tbl5.PrimaryNameFrameTouchable = createElement3(str4, tbl6, tbl7)
        var11 = createElement2(str3, tbl4, tbl5)
    end

    tbl3.PrimaryNameFrame = var11

    local createElement2 = React.createElement
    local var12 = FoundationText
    local tbl4 = {
        RichText = if FFlagEnableFontStylisticAlternativesOnSocialScreens then true else nil,
        Text = if FFlagEnableFontStylisticAlternativesOnSocialScreens then `<font features="zero, ss03">{str1}</font>` .. str2 else str1 .. str2,
        tag = "auto-xy text-align-x-left text-align-y-top",
        fontStyle = var1.Typography.CaptionMedium,
        OpenTypeFeatures = if FFlagEnableFontStylisticAlternativesOnSocialScreens or not GetFFlagLuaAppEnableOpenTypeSupport() then nil else OpenTypeSupport:getUserNameStylisticAlternative(),
        LayoutOrder = 2,
        onActivated = 0,
        stateLayer = 0
    }

    if bool1 then
        var8 = nil
    end

    tbl4.onActivated = var8
    tbl4.stateLayer = if bool1 then nil else FFlagProfilePlatformEnableClickToCopyUsername and {
        affordance = StateLayerAffordance.None
    } or nil
    tbl3.Username = createElement2(var12, tbl4)
    local element

    if FFlagAddPlatformNameToProfileHeader and tbl1.platformName then
        element = React.createElement(View, {
            tag = "row align-y-center gap-xsmall auto-xy",
            LayoutOrder = 3
        }, {
            PlatformIcon = if name then React.createElement(Icon, { name = name, size = IconSize2.XSmall, LayoutOrder = 1 }) else nil,
            PlatformNameLabel = React.createElement(FoundationText, {
                Text = tbl1.platformName,
                tag = "shrink auto-xy text-align-x-left text-align-y-top",
                fontStyle = var1.Typography.CaptionMedium,
                LayoutOrder = 2
            })
        })
    else
        element = nil
    end

    tbl3.PlatformName = element
    return createElement(var10, tbl2, tbl3)
end

return SocialIdentity
