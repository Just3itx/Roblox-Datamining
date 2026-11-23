-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local UserProfiles = require(TrustedContactsParent.UserProfiles)
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization

local _GraphQLServer = require(TrustedContactsParent.GraphQLServer)

local ApolloProfileInsights = require(TrustedContactsParent.ApolloProfileInsights)
local useProfileInsightsByUserIds = ApolloProfileInsights.Hooks.useProfileInsightsByUserIds
local getProfileInsightsByUserIdFromData = ApolloProfileInsights.Selectors.getProfileInsightsByUserIdFromData
local isCustomNil = require(TrustedContacts.Utils.isCustomNil)

local Signals = require(TrustedContactsParent.Signals)
local SignalsReact = require(TrustedContactsParent.SignalsReact)

local Foundation = require(TrustedContactsParent.Foundation)
local Skeleton = Foundation.Skeleton

local View = Foundation.View

local UserTile = require(TrustedContactsParent.UserTile).UserTile
local LayoutMode = require(TrustedContactsParent.UserTile).LayoutMode

local SocialMetadataIconsAndTextsSection = require(script.Parent.SocialMetadataIconsAndTextsSection)
local useSignalProfileInsightsByUserId = require(TrustedContactsParent.ProfileInsights).useSignalProfileInsightsByUserId
local AmpUpsell = require(TrustedContactsParent.AmpUpsell)
local AmpApiProvider = AmpUpsell.AmpApiProvider
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum
local FFlagProfilePlatformAddTC = require(TrustedContactsParent.SharedFlags).FFlagProfilePlatformAddTC
local FStringParentLinkAmpNameSpace = require(TrustedContactsParent.SharedFlags).FStringParentLinkAmpNameSpace

local GetFFlagEnableProfileInsightsApolloMigration = require(TrustedContactsParent.SharedFlags).GetFFlagEnableProfileInsightsApolloMigration
local FFlagTFClassmatesProfileInsight = require(TrustedContactsParent.SharedFlags).FFlagTFClassmatesProfileInsight

local var1 = UserProfiles.Stores.UserProfileStore.get()

return function(tbl1)
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var2 = var1 and var1.fetchNamesByUserIds({ tostring(tbl1.userId) })(arg1)

            local var3 = var2 and var2.data and var2.data[1]
            local names = var3 and var3.names
            return {
                combinedName = if names then names.getCombinedName(arg1) else "",
                username = if names then names.getUsername() else ""
            }
        end)
    end, { tbl1.userId })

    local var3 = SignalsReact.useSignalState(var2)
    local username = var3.username
    local combinedName = var3.combinedName

    local tbl2 = {}
    local loading

    if GetFFlagEnableProfileInsightsApolloMigration() then
        local var4
        var4, loading = useSignalProfileInsightsByUserId({ userId = tbl1.userId, rankingStrategy = "tc_info_boost", forceFetch = true })
        tbl2 = var4
    else
        local var4 = useProfileInsightsByUserIds(
            {
                userIds = { tbl1.userId },
                rankingStrategy = "tc_info_boost",
                fetchPolicy = "network-only"
            }
        )

        if var4 and var4.data and not var4.loading then
            tbl2 = getProfileInsightsByUserIdFromData(var4.data, tbl1.userId)
        end

        loading = var4.loading
    end

    local userAgeVerifiedBracket = if isCustomNil(tbl2.userAgeVerifiedBracket) then nil else tbl2.userAgeVerifiedBracket
    local var4 = useLocalization(
        {
            userAgeVerifiedBracket = userAgeVerifiedBracket,
            yourLinkedParent = "Feature.Friends.Label.YourLinkedParent"
        }
    )

    local var5, var6 = React.useState(false)
    local var7 = var5
    local var8 = var6

    React.useEffect(function()
        local tbl3 = {
            name = "otherUser",
            type = "UserId",
            value = tbl1.userId
        }
        local var9 = AmpApiProvider.upsellFeatureAccess("IsLinkedChildOf", {}, FStringParentLinkAmpNameSpace, { tbl3 })

        var8(var9.access == AccessResponseEnum.Granted)
    end, { tbl1.userId })

    local var9 = React.useMemo(function()
        if var4.userAgeVerifiedBracket then
            return ` \226\128\162 {var4.userAgeVerifiedBracket}`
        end
        return nil
    end, { var4.userAgeVerifiedBracket })

    local avatarWithNames = React.useMemo(function()
        local var10 = Foundation.Hooks.useTokens()
        local createElement = React.createElement
        local var11 = View
        local tbl3 = { tag = "size-0-1200 auto-x row align-y-center", LayoutOrder = 1 }
        local tbl4 = {
            UserTile = React.createElement(UserTile, {
                userId = tbl1.userId,
                userPresenceType = Foundation.Enums.UserPresence.None,
                layoutMode = LayoutMode.wide,
                title = if var7 then var4.yourLinkedParent else combinedName,
                subtitle = if username == "" then nil else `@{username}{var9 or ""}`,
                titleStyle = var10.Typography.TitleMedium,
                subtitleStyle = var10.Typography.BodyMedium,
                onActivated = nil
            })
        }
        return createElement(var11, tbl3, tbl4)
    end, {
        tbl1.userId,
        combinedName,
        var7,
        var8,
        var4.yourLinkedParent,
        username,
        var9
    })

    local profileInsightIconItems = React.useMemo(function()
        return {
            mutualFriends = if isCustomNil(tbl2.mutualFriends) then nil else tbl2.mutualFriends,
            friendshipAgeUnixSeconds = if isCustomNil(tbl2.friendshipAgeUnixSeconds) then nil else tbl2.friendshipAgeUnixSeconds,
            friendRequestOriginSource = if isCustomNil(tbl2.friendRequestOriginSource) then nil else tbl2.friendRequestOriginSource,
            accountCreationDateUnixSeconds = if isCustomNil(tbl2.accountCreationDateUnixSeconds) then nil else tbl2.accountCreationDateUnixSeconds,
            localizedCountryName = if isCustomNil(tbl2.localizedCountryName) then nil else tbl2.localizedCountryName,
            isClassmate = if FFlagTFClassmatesProfileInsight and tbl2.isClassmate == true then true else nil
        }
    end, { tbl2 })

    return React.createElement(View, {
        tag = {
            ["col size-full-0 auto-y align-x-left radius-medium bg-shift-100"] = true,
            ["gap-medium padding-medium"] = tbl1.isVerticallyConstrained,
            ["gap-large padding-large"] = not tbl1.isVerticallyConstrained
        },
        LayoutOrder = 2
    }, {
        AvatarWithNames = avatarWithNames,
        SocialMetadataIconAndTextList = if loading then React.createElement(
            Skeleton,
            {
                Size = UDim2.new(1, 0, 0, 50),
                LayoutOrder = if FFlagProfilePlatformAddTC then tbl1.layoutOrder else 2
            }
        ) else React.createElement(SocialMetadataIconsAndTextsSection, {
            profileInsightIconItems = profileInsightIconItems,
            isVerticallyConstrained = tbl1.isVerticallyConstrained,
            layoutOrder = if FFlagProfilePlatformAddTC then tbl1.layoutOrder else 2
        })
    })
end
