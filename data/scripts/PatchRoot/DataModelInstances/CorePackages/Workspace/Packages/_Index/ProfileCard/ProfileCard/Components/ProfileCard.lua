-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileCardParent = script:FindFirstAncestor("ProfileCard").Parent

local BuilderIcons = require(ProfileCardParent.BuilderIcons)
local Foundation = require(ProfileCardParent.Foundation)
local Localization = require(ProfileCardParent.Localization)
local React = require(ProfileCardParent.React)
local FlyoutAccountSwitcherIXP = require(ProfileCardParent.SharedExperimentDefinition).FlyoutAccountSwitcherIXP
local SharedFlags = require(ProfileCardParent.SharedFlags)
local UIBlox = require(ProfileCardParent.UIBlox)
local UniversalAppPolicy = require(ProfileCardParent.UniversalAppPolicy)
local getStandardSizeAvatarHeadShotRbxthumb = require(ProfileCardParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb

local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local LoadableImage = UIBlox.App.Loading.LoadableImage
local FoundationText = Foundation.Text
local View = Foundation.View
local useAppPolicy = UniversalAppPolicy.useAppPolicy
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local FFlagEnableFlyoutUncheckedBadge = SharedFlags.FFlagEnableFlyoutUncheckedBadge
local FFlagEnableDrawerFocusNav = SharedFlags.FFlagEnableDrawerFocusNav
local FFlagHidePremiumIconography = SharedFlags.FFlagHidePremiumIconography
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck

return React.memo(function(tbl1) -- name: ProfileCard
    local var1 = useTokens()
    local var2 = if FFlagEnableFlyoutUncheckedBadge then useLocalization({ Unchecked = "CommonUI.Features.Label.Unchecked" }) else nil

    local var3 = if FFlagEnableFlyoutUncheckedBadge then useAppPolicy(function(arg1)
        return arg1.getShowUncheckedBadge()
    end) else nil

    local localUserModel = tbl1.localUserModel
    local image = React.useMemo(function()
        if localUserModel and localUserModel.id then
            return getStandardSizeAvatarHeadShotRbxthumb(localUserModel.id, tbl1.useProfileFrameThumbnail == true)
        end
        return nil
    end, { localUserModel, tbl1.useProfileFrameThumbnail })
    local var5 = React.useMemo(function()
        return localUserModel and localUserModel.membership == Enum.MembershipType.Premium
    end, { localUserModel })

    local var6 = if tbl1.isCompact then var1.Size.Size_1000 else var1.Size.Size_1600
    local name = localUserModel and localUserModel.name or ""
    local displayName = localUserModel and localUserModel.displayName or ""
    local bool1 = if FFlagEnableBlackbirdCheck then tbl1.isRobloxSubscriber == true else false
    local var7 = not FFlagHidePremiumIconography and var5 and not bool1
    local onProfileActivated = tbl1.onProfileActivated
    local var8 = React.useCallback(function()
        if onProfileActivated then
            onProfileActivated()
        end
    end, { onProfileActivated })

    local var9 = not (tbl1.onSwitchAccountActivated == nil) and FlyoutAccountSwitcherIXP.isProfileHandleEnabled()
    local var10 = not (tbl1.onSwitchAccountActivated == nil) and FlyoutAccountSwitcherIXP.isProfileIconButtonEnabled()
    local element = React.createElement(LoadableImage, {
        Size = UDim2.fromOffset(var6, var6),
        BackgroundColor3 = var1.Color.Common.Shimmer.Color3,
        BackgroundTransparency = var1.Color.Common.Shimmer.Transparency,
        Image = image,
        useShimmerAnimationWhileLoading = true,
        cornerRadius = UDim.new(0.5, 0),
        shouldHandleReloads = true,
        LayoutOrder = 1
    })

    local createElement = React.createElement
    local var11 = View
    local tbl2 = {
        tag = {
            ["size-full-0 auto-y"] = true,
            ["row align-y-center gap-small"] = FFlagEnableFlyoutUncheckedBadge or var10,
            ["padding-y-medium"] = tbl1.isCompact == true
        },
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = { ProfileCardButton = 0, UncheckedBadge = 0, SwitchAccountChevron = 0 }
    local createElement2 = React.createElement
    local str1 = "TextButton"
    local tbl4 = {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        Active = not var9 and onProfileActivated ~= nil,
        Selectable = not var9 and onProfileActivated ~= nil,
        AutomaticSize = if FFlagEnableFlyoutUncheckedBadge then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY,
        LayoutOrder = if FFlagEnableFlyoutUncheckedBadge then 1 elseif var10 then 1 else nil
    }
    local activated = React.Event.Activated

    if var9 then
        var8 = nil
    end

    tbl4[activated] = var8
    local tag = React.Tag
    tbl4[tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil
    local tbl5 = {
        UIPadding = if FFlagEnableDrawerFocusNav then React.createElement("UIPadding", { PaddingRight = UDim.new(0, var1.Padding.Small) }) else nil,
        UIFlexItem = if FFlagEnableFlyoutUncheckedBadge then React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }) else nil,
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var1.Gap.Medium)
        }),
        UserAvatar = 0,
        UserInfoContainer = 0
    }
    if var9 then
        element = React.createElement(View, {
            tag = "auto-xy radius-circle",
            LayoutOrder = 1,
            onActivated = onProfileActivated,
            testId = "profile-card-avatar",
            selection = { Selectable = false }
        }, { Image = element })
    end

    tbl5.UserAvatar = element

    local createElement3 = React.createElement
    local var12 = View
    local tbl6 = {
        tag = {
            col = true,
            ["gap-xsmall"] = tbl1.isCompact == true,
            ["fill auto-y"] = FFlagEnableFlyoutUncheckedBadge,
            ["position-center-left anchor-center-left auto-xy"] = not FFlagEnableFlyoutUncheckedBadge
        },
        LayoutOrder = 2
    }

    local tbl7 = {
        UsernameContainer = React.createElement(View, {
            tag = {
                ["row gap-xsmall"] = true,
                ["size-full-0 auto-y"] = FFlagEnableFlyoutUncheckedBadge and not var9,
                ["shrink auto-xy"] = FFlagEnableFlyoutUncheckedBadge and var9,
                ["position-center-left anchor-center-left auto-xy"] = not FFlagEnableFlyoutUncheckedBadge
            },
            LayoutOrder = 1,
            onActivated = if var9 then onProfileActivated else nil,
            testId = "profile-card-display-name"
        }, {
            DisplayNameText = React.createElement(FoundationText, {
                tag = {
                    ["text-title-medium text-align-x-left content-emphasis"] = true,
                    ["auto-xy"] = not var9,
                    ["size-0-500 auto-x"] = var9,
                    ["shrink text-truncate-split"] = FFlagEnableFlyoutUncheckedBadge
                },
                Text = displayName,
                LayoutOrder = 1
            }),
            PremiumIcon = if var7 then React.createElement(Icon, {
                style = var1.Color.Content.Emphasis,
                name = BuilderIcons.Icon.Premium,
                size = IconSize.Small,
                LayoutOrder = 2,
                testId = "profile-card-premium-icon"
            }) else nil,
            SubscriberBadge = if bool1 then React.createElement(Icon, {
                style = var1.Color.Content.Emphasis,
                name = IconName.RobloxPlus,
                size = IconSize.Small,
                LayoutOrder = 3,
                testId = "profile-card-subscriber-icon"
            }) else nil
        }),
        UserName = if var9 then nil else React.createElement(FoundationText, {
            tag = {
                ["text-body-medium text-align-x-left content-default"] = true,
                ["size-full-0 auto-y text-truncate-split"] = FFlagEnableFlyoutUncheckedBadge,
                ["auto-xy"] = not FFlagEnableFlyoutUncheckedBadge
            },
            Text = "@" .. name,
            LayoutOrder = 2
        }),
        HandleRow = 0
    }
    local element2

    if var9 then
        element2 = React.createElement(View, {
            tag = "row align-y-center shrink gap-xsmall auto-xy",
            LayoutOrder = 2,
            onActivated = tbl1.onSwitchAccountActivated,
            testId = "profile-card-switch-account-handle"
        }, {
            UserName = React.createElement(FoundationText, {
                tag = "shrink size-0-500 auto-x text-body-medium text-align-x-left text-truncate-split content-default",
                Text = "@" .. name,
                LayoutOrder = 1
            }),
            SwitchAccountChevron = if tbl1.onSwitchAccountActivated then React.createElement(Icon, {
                tag = "auto-xy content-emphasis padding-medium",
                name = BuilderIcons.Icon.ChevronLargeDown,
                size = IconSize.Small,
                LayoutOrder = 2,
                testId = "profile-card-switch-account-chevron",
                ref = tbl1.switchAccountAnchorRef
            }) else nil
        })
    else
        element2 = nil
    end

    tbl7.HandleRow = element2
    tbl5.UserInfoContainer = createElement3(var12, tbl6, tbl7)
    tbl3.ProfileCardButton = createElement2(str1, tbl4, tbl5)

    tbl3.UncheckedBadge = if FFlagEnableFlyoutUncheckedBadge and var3 then React.createElement(Badge, { text = var2.Unchecked, variant = BadgeVariant.Neutral, LayoutOrder = 2 }) else nil
    local element3

    if var10 then
        element3 = React.createElement(View, {
            tag = "auto-xy padding-small radius-circle",
            LayoutOrder = 3,
            onActivated = tbl1.onSwitchAccountActivated,
            testId = "profile-card-switch-account-chevron",
            ref = tbl1.switchAccountAnchorRef
        }, {
            Icon = React.createElement(
                Icon,
                {
                    tag = "auto-xy content-emphasis",
                    name = BuilderIcons.Icon.ChevronLargeDown,
                    size = IconSize.Large
                }
            )
        })
    else
        element3 = nil
    end

    tbl3.SwitchAccountChevron = element3
    return createElement(var11, tbl2, tbl3)
end)
