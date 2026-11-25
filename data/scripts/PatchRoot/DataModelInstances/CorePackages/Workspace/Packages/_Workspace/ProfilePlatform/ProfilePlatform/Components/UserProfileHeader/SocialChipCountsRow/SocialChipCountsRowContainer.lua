-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local _Types = require(ProfilePlatform.Common.Types)
local Foundation = require(ProfilePlatformParent.Foundation)
local ApolloProfileInsights = require(ProfilePlatformParent.ApolloProfileInsights)

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useAreWebViewsSupported = require(ProfilePlatform.Hooks.useAreWebViewsSupported)
local ChipGroup = require(ProfilePlatform.Components.ChipGroup).ChipGroup

local useLocalUserId = RobloxAppHooks.useLocalUserId
local useProfileInsightsByUserIds = ApolloProfileInsights.Hooks.useProfileInsightsByUserIds
local getProfileInsightsByUserIdFromData = ApolloProfileInsights.Selectors.getProfileInsightsByUserIdFromData
local useSignalProfileInsightsByUserId = require(ProfilePlatformParent.ProfileInsights).useSignalProfileInsightsByUserId

local GetFFlagEnableProfileInsightsApolloMigration = require(ProfilePlatformParent.SharedFlags).GetFFlagEnableProfileInsightsApolloMigration

local scriptParent = script.Parent
local useSocialCountsData = require(scriptParent.hooks.useSocialCountsData)
local useSocialCountsActions = require(scriptParent.hooks.useSocialCountsActions)
local useSchoolChip = require(scriptParent.hooks.useSchoolChip)
local useDynamicSizeMargin = require(ProfilePlatform.Hooks.useDynamicSizeMargin)

local ChipSize = Foundation.Enums.ChipSize

local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local FFlagAddIEMProfilePage = SharedFlags.FFlagAddIEMProfilePage
local FFlagEnableSocialTabsPage = SharedFlags.FFlagEnableSocialTabsPage
local FFlagProfilePlatformEnableSchoolChip = SharedFlags.FFlagProfilePlatformEnableSchoolChip
local FFlagProfilePlatformGracefulVisibility = require(ProfilePlatform.Flags.FFlagProfilePlatformGracefulVisibility)
local FFlagSocialTabsPageIxpEnabled = require(ProfilePlatform.Flags.FFlagSocialTabsPageIxpEnabled)

local function SocialCountsChipRowContainer(tbl1)
    local var1 = useProfileWrapperContext()
    local var2 = useProfileAnalyticsContext()
    local var3 = useAreWebViewsSupported()
    local var4 = useLocalUserId()
    local offset, var5 = useDynamicSizeMargin()

    local profileId = var1.profileId
    local source = if FFlagAddIEMProfilePage then var1.sourceInfo.source else nil
    local bool1 = profileId == tostring(var4)

    local profileInsightsByUserIdFromData = nil

    if GetFFlagEnableProfileInsightsApolloMigration() then
        profileInsightsByUserIdFromData = useSignalProfileInsightsByUserId({ userId = profileId, rankingStrategy = "tc_info_boost" })
    else
        local var6 = useProfileInsightsByUserIds({ userIds = { profileId } })

        if var6 and var6.data and not var6.loading then
            profileInsightsByUserIdFromData = getProfileInsightsByUserIdFromData(var6.data, profileId)
        end
    end

    local var6 = not (profileInsightsByUserIdFromData and profileInsightsByUserIdFromData.mutualFriends) and {}
        or profileInsightsByUserIdFromData.mutualFriends

    local tbl2 = {}
    for _, value in ipairs(var6) do
        table.insert(tbl2, value.id)
    end

    local var7 = useSocialCountsData(profileId, bool1, var3, tbl2)

    local var8 = useSocialCountsActions
    local title = if FFlagEnableSocialTabsPage then tbl1.title else nil

    if not FFlagSocialTabsPageIxpEnabled then
        var3 = nil
    end

    local var9 = var8(profileId, bool1, var2, tbl2, title, var3)

    local var10 = if FFlagProfilePlatformEnableSchoolChip then useSchoolChip(var2) else nil

    local chips = React.useMemo(function()
        local result = {}

        local var11 = FFlagAddIEMProfilePage and source == Enums.Sources.InExperienceProfile
        if FFlagProfilePlatformEnableSchoolChip and var10 and not var11 then
            table.insert(result, var10)
        end

        for _, value in ipairs(var7) do
            if value.fieldName == "mutualFriendsCount" and tonumber(value.count) == 0 then
                continue
            end

            local var12 = FFlagProfilePlatformGracefulVisibility

            if var12 then
                if value.fieldName == "friendsCount" then
                    var12 = value.isDisabled
                else
                    var12 = false
                end
            end

            table.insert(result, {
                count = value.count,
                text = value.text,
                layoutOrder = value.layoutOrder,
                onActivated = if var12 or FFlagAddIEMProfilePage and source == Enums.Sources.InExperienceProfile then nil else var9[value.fieldName],
                isDisabled = value.isDisabled,
                size = ChipSize.Medium,
                leading = value.leading
            })
        end

        return result
    end, {
        var7,
        var9,
        var10,
        source
    })
    return React.createElement("Frame", {
        LayoutOrder = tbl1.layoutOrder,
        Size = tbl1.size,
        BackgroundTransparency = 1,
        [React.Change.AbsoluteSize] = var5,
        AutomaticSize = Enum.AutomaticSize.Y
    }, {
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, offset), PaddingRight = UDim.new(0, offset) }),
        ChipGroup = React.createElement(ChipGroup, {
            chips = chips,
            automaticSize = Enum.AutomaticSize.Y,
            scrollingEnabledOverride = true,
            size = UDim2.new(1, 0, 0, 32),
            layoutOrder = tbl1.layoutOrder
        })
    })
end

return SocialCountsChipRowContainer
