-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local UIBlox = require(FlyoutSidePanelParent.UIBlox)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local BuilderIcons = require(FlyoutSidePanelParent.BuilderIcons)
local getStandardSizeAvatarHeadShotRbxthumb = require(FlyoutSidePanelParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local LoadableImage = UIBlox.App.Loading.LoadableImage
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local useRoactService = require(FlyoutSidePanelParent.RobloxAppHooks).useRoactService
local AppEventIngestService = require(FlyoutSidePanelParent.RoactServiceTags).AppEventIngestService
local useAppPolicy = require(FlyoutSidePanelParent.UniversalAppPolicy).useAppPolicy
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization

local ChevronSmallDownButton = require(script.Parent.ChevronSmallDownButton)

local getTestId = require(FlyoutSidePanelParent.RoactUtils).getTestId
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)

local FFlagLuaAppAddTestIdsForArrow = SharedFlags.FFlagLuaAppAddTestIdsForArrow
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagHidePremiumIconography = SharedFlags.FFlagHidePremiumIconography
local FFlagEnableFlyoutUncheckedBadge = SharedFlags.FFlagEnableFlyoutUncheckedBadge
local FFlagEnableDrawerFocusNav = SharedFlags.FFlagEnableDrawerFocusNav
local FFlagFlyoutSidePanelUseProfileFrameThumbnail = SharedFlags.FFlagFlyoutSidePanelUseProfileFrameThumbnail

local function FlyoutProfileCard(tbl1)
    local var1 = useTokens()
    local var2 = if FFlagEnableFlyoutUncheckedBadge then useLocalization({ Unchecked = "CommonUI.Features.Label.Unchecked" }) else nil

    local var3 = if FFlagEnableFlyoutUncheckedBadge then useAppPolicy(function(arg1)
        return arg1.getShowUncheckedBadge()
    end) else nil

    local var4 = useRoactService(AppEventIngestService)
    local localUserModel = tbl1.localUserModel
    local var5 = React.useCallback(function()
        tbl1.closeDrawer()
        if tbl1.onProfileActivated then
            tbl1.onProfileActivated()
            local id = localUserModel and localUserModel.id or ""
            FlyoutAnalytics.sendMoreLegacyAndFlyoutItemClickEvent(var4, "Profile", id)
        end
    end, {
        localUserModel,
        tbl1.onProfileActivated,
        tbl1.closeDrawer,
        var4
    })

    local onActivated = React.useCallback(function()
        tbl1.closeDrawer()
        if tbl1.onSwitchAccountActivated then
            tbl1.onSwitchAccountActivated()
        end
    end, { tbl1.onSwitchAccountActivated, tbl1.closeDrawer })

    local image = React.useMemo(function()
        if localUserModel and localUserModel.id then
            return getStandardSizeAvatarHeadShotRbxthumb(localUserModel.id, FFlagFlyoutSidePanelUseProfileFrameThumbnail)
        end

        return nil
    end, { localUserModel })
    local var8 = React.useMemo(function()
        return localUserModel and localUserModel.membership == Enum.MembershipType.Premium
    end, { localUserModel })
    local name = localUserModel and localUserModel.name or ""
    local displayName = localUserModel and localUserModel.displayName or ""
    local bool1 = if FFlagEnableBlackbirdCheck then tbl1.isRobloxSubscriber == true else false
    local var9 = not FFlagHidePremiumIconography and var8 and not bool1
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = {
            ["auto-y size-full-0"] = true,
            ["row align-y-center gap-small"] = FFlagEnableFlyoutUncheckedBadge
        },
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = { ProfileCardButton = 0, UncheckedBadge = 0, SwitchAccountButton = 0 }
    local createElement2 = React.createElement
    local str1 = "TextButton"
    local tbl4 = {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutomaticSize = if FFlagEnableFlyoutUncheckedBadge then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY,
        LayoutOrder = if FFlagEnableFlyoutUncheckedBadge then 1 else nil,
        [React.Event.Activated] = var5,
        [React.Tag] = if FFlagLuaAppAddTestIdsForArrow then getTestId("core-ui-flyout-profile-card") else nil
    }

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
        UserAvatar = React.createElement(LoadableImage, {
            Size = UDim2.new(0, var1.Size.Size_1600, 0, var1.Size.Size_1600),
            BackgroundColor3 = var1.Color.Common.Shimmer.Color3,
            BackgroundTransparency = var1.Color.Common.Shimmer.Transparency,
            Image = image,
            useShimmerAnimationWhileLoading = true,
            cornerRadius = UDim.new(0.5, 0),
            shouldHandleReloads = true,
            LayoutOrder = 1
        }),
        UserInfoContainer = 0
    }

    local createElement3 = React.createElement
    local view2 = Foundation.View
    local tbl6 = {
        tag = {
            col = true,
            ["fill auto-y"] = FFlagEnableFlyoutUncheckedBadge,
            ["position-center-left anchor-center-left auto-xy"] = not FFlagEnableFlyoutUncheckedBadge
        },
        LayoutOrder = 2
    }

    local tbl7 = {
        UsernameContainer = React.createElement(Foundation.View, {
            tag = {
                ["row gap-xsmall"] = true,
                ["size-full-0 auto-y"] = FFlagEnableFlyoutUncheckedBadge,
                ["position-center-left anchor-center-left auto-xy"] = not FFlagEnableFlyoutUncheckedBadge
            },
            LayoutOrder = 1
        }, {
            DisplayNameText = React.createElement(FoundationText, {
                tag = {
                    ["auto-xy text-title-medium content-emphasis text-align-x-left"] = true,
                    ["shrink text-truncate-split"] = FFlagEnableFlyoutUncheckedBadge
                },
                Text = displayName,
                LayoutOrder = 1
            }),
            PremiumIcon = if var9 then React.createElement(
                Icon,
                {
                    style = var1.Color.Content.Emphasis,
                    name = BuilderIcons.Icon.Premium,
                    size = IconSize.Small,
                    LayoutOrder = 2
                }
            ) else nil,
            SubscriberBadge = if bool1 then React.createElement(
                Icon,
                {
                    style = var1.Color.Content.Emphasis,
                    name = IconName.RobloxPlus,
                    size = IconSize.Small,
                    LayoutOrder = 3
                }
            ) else nil
        }),
        UserName = React.createElement(FoundationText, {
            tag = {
                ["text-body-medium content-default text-align-x-left"] = true,
                ["size-full-0 auto-y text-truncate-split"] = FFlagEnableFlyoutUncheckedBadge,
                ["auto-xy"] = not FFlagEnableFlyoutUncheckedBadge
            },
            Text = "@" .. name,
            LayoutOrder = 2
        })
    }
    tbl5.UserInfoContainer = createElement3(view2, tbl6, tbl7)
    tbl3.ProfileCardButton = createElement2(str1, tbl4, tbl5)

    tbl3.UncheckedBadge = if FFlagEnableFlyoutUncheckedBadge and var3 then React.createElement(Badge, { text = var2.Unchecked, variant = BadgeVariant.Neutral, LayoutOrder = 2 }) else nil

    tbl3.SwitchAccountButton = if tbl1.onSwitchAccountActivated then React.createElement(
        ChevronSmallDownButton,
        {
            onActivated = onActivated,
            layoutOrder = if FFlagEnableFlyoutUncheckedBadge then 3 else nil
        }
    ) else nil
    return createElement(view, tbl2, tbl3)
end

return FlyoutProfileCard
