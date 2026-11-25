-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin

local UserTile = require(ProfilePlatformParent.UserTile).UserTile
local LayoutMode = require(ProfilePlatformParent.UserTile).LayoutMode

local Enums = require(ProfilePlatform.Common.Enums)
local Constants = require(ProfilePlatform.Common.Constants)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)

local SocialChipCountsRowContainer = require(ProfilePlatform.Components.UserProfileHeader.SocialChipCountsRow).SocialChipCountsRowContainer
local CTARow = require(ProfilePlatform.Components.CTARow)

local SharedFlags = require(ProfilePlatformParent.SharedFlags)

local FFlagEnableFontStylisticAlternativesOnSocialScreens = SharedFlags.FFlagEnableFontStylisticAlternativesOnSocialScreens
local FFlagEnableSocialTabsPage = SharedFlags.FFlagEnableSocialTabsPage

local function MeTabUserProfileHeader(tbl1)
    local var1 = useTokens()
    local var2 = useProfileWrapperContext()
    local var3 = useProfileFormFactor()

    local profileId = var2.profileId
    local grow = var3.formFactor == Enums.ProfileFormFactor.Wide

    local var4 = useProfileJsonComponent(Enums.Components.UserProfileHeader) or {}
    local names = var4.names or {}
    local username = names.username or ""
    local bool2 = var4.counts ~= nil
    local subtitle = if username == "" then nil elseif FFlagEnableFontStylisticAlternativesOnSocialScreens then `<font features="zero, ss03">@{username}</font>` else "@" .. username
    local yOffset = if grow then 128 else Constants.AVATAR_HEADSHOT_HEIGHT
    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        tag = {
            grow = grow,
            ["size-full-0"] = not grow
        },
        Size = if grow then UDim2.fromOffset(0, yOffset) else UDim2.new(1, 0, 0, yOffset),
        LayoutOrder = 1
    }
    local tbl3 = {
        UserTile = React.createElement(UserTile, {
            userId = profileId,
            title = names.primaryName or "",
            subtitle = subtitle,
            isPremium = var4.isPremium,
            isVerified = var4.isVerified,
            isRobloxAdmin = var4.isRobloxAdmin,
            layoutMode = LayoutMode.wide,
            userPresenceType = nil,
            titleStyle = if grow then var1.Typography.HeadingLarge else var1.Typography.HeadingSmall,
            subtitleStyle = if grow then var1.Typography.BodyLarge else var1.Typography.BodyMedium
        })
    }
    local identity = createElement(var6, tbl2, tbl3)

    local actions = React.createElement(
        View,
        {
            tag = {
                ["grow auto-y"] = grow,
                ["size-full-0 auto-y"] = not grow
            },
            LayoutOrder = 2
        },
        {
            Actions = React.createElement(CTARow, { layoutOrder = 1 })
        }
    )

    local createElement2 = React.createElement
    local var7 = View
    local tbl4 = {
        tag = {
            ["col size-full-0 auto-y"] = true,
            ["gap-xxlarge"] = grow,
            ["gap-large"] = not grow
        },
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl5 = {
        HeaderBlock = React.createElement(
            HorizontalPageMargin,
            {
                size = UDim2.new(1, 0, 0, 0),
                backgroundTransparency = 1,
                useAutomaticSizing = true,
                layoutOrder = 1
            },
            {
                Row = React.createElement(View, {
                    tag = {
                        ["row align-y-center gap-medium size-full-0 auto-y"] = grow,
                        ["col gap-medium size-full-0 auto-y"] = not grow
                    }
                }, { Identity = identity, Actions = actions })
            }
        ),
        SocialCountsRow = if bool2 then React.createElement(SocialChipCountsRowContainer, {
            size = UDim2.fromScale(1, 0),
            layoutOrder = 2,
            title = if FFlagEnableSocialTabsPage then `@{username}` else nil
        }) else nil
    }
    return createElement2(var7, tbl4, tbl5)
end

return MeTabUserProfileHeader
