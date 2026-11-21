-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local useDesignTokens = require(GameTileParent.Style).useDesignTokens
local Colors = require(GameTileParent.Style).Colors
local useLocalization = require(GameTileParent.Localization).Hooks.useLocalization
local Array = require(GameTileParent.LuauPolyfill).Array
local UIBlox = require(GameTileParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local useTextSizeOffset = UIBlox.Core.Style.useTextSizeOffset
local CoPlayFooter = UIBlox.App.Tile.ExperienceTileMetadata.CoPlayFooter
local UserProfiles = require(GameTileParent.UserProfiles)
local useUserProfilesFetch = UserProfiles.Hooks.useUserProfilesFetch
local DataHydration = require(GameTileParent.DataHydration)
local getAndFetchUserNamesByUserIds = DataHydration.UserProfile.getAndFetchUserNamesByUserIds
local useSignalState = require(GameTileParent.SignalsReact).useSignalState
local sortFriendsByPresenceAndRecencyFactory = require(GameTile.sortFriendsByPresenceAndRecencyFactory)

local FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix = require(GameTileParent.SharedFlags).FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix

local FFlagHomeFriendNamesUseUserProfileHydration = require(GameTileParent.SharedFlags).FFlagHomeFriendNamesUseUserProfileHydration

local function getUserIdsForFacePile(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local userIdsForFacePile = ({})
    for i = 1, #tbl1 do
        userIdsForFacePile[i] = tbl1[i].userId
    end

    return userIdsForFacePile
end

local function getDisplayName(tbl1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return Array.join(Array.map(tbl1, function(arg1)
        return arg1.displayName
    end), str1)
end

local function useFetchSortedDisplayNames(userIds)
    local result = {}
    if not FFlagHomeFriendNamesUseUserProfileHydration then
        local var1 = useUserProfilesFetch({
            userIds = userIds,
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds,
            skip = not userIds or #userIds == 0
        })
        if var1 and var1.data and userIds then
            for _, userId in userIds do
                table.insert(result, { userId = userId, displayName = UserProfiles.Selectors.getCombinedNameFromId(var1.data, userId) })
            end
        end

        table.sort(result, sortFriendsByPresenceAndRecencyFactory("displayName"))
        return result
    end

    local str1 = table.concat(userIds, ",")
    local var1 = React.useMemo(function()
        return getAndFetchUserNamesByUserIds(string.split(str1, ","))
    end, { str1 })
    local var2 = useSignalState(var1)
    if var2.status ~= DataHydration.DataStatus.NotReady then
        for _, userId in userIds do
            local var3 = var2.namesByUserId[userId]
            if var3 then
                table.insert(result, { userId = userId, displayName = var3.combinedName })
            end
        end
    end
    table.sort(result, sortFriendsByPresenceAndRecencyFactory("displayName"))
    return result
end

return {
    GridTileFriendFooter = function(tbl1)
        local fontStyle = if tbl1.useLargerFont then useStyle().Font.Body else useStyle().Font.CaptionHeader
        local size = useDesignTokens().Size
        local var2 = useTextSizeOffset()
        local var3 = useLocalization({ friendsSeparator = "Feature.GameDetails.Label.FriendsSeparator" })

        local size100 = size.Size_100
        if not tbl1.showOnlineBorder then
            size100 -= 3
        end

        if not FFlagLuaAppMigrateGameTileActiveFriendsHydrationFix then
            return React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, size.Size_500 + var2),
                BackgroundTransparency = 1
            }, {
                OnlineFriends = React.createElement(CoPlayFooter, {
                    users = getUserIdsForFacePile(tbl1.friends or {}),
                    labelText = getDisplayName(tbl1.friends or {}, var3.friendsSeparator),
                    showEmphasisBorder = tbl1.showOnlineBorder,
                    faceGroupCount = 2,
                    styleProps = {
                        faceWidth = size.Size_500,
                        faceHeight = size.Size_500,
                        faceGroupGap = -size.Size_150,
                        containerGap = size100,
                        badgeBorderWidth = 3,
                        badgeHeight = size.Size_500,
                        fontStyle = fontStyle,
                        badgeSpacingLeading = size.Size_100,
                        badgeSpacingTrailing = size.Size_100,
                        badgeBackgroundColor = {
                            Color = Colors.Smoke,
                            Transparency = 0
                        },
                        badgeContentColor = {
                            Color = Colors.White,
                            Transparency = 0
                        }
                    }
                })
            })
        end

        local tbl2 = useFetchSortedDisplayNames(tbl1.friendUserIds or {})
        return (React.createElement("TextButton", {
            Size = UDim2.new(1, 0, 0, size.Size_500 + var2),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            [React.Event.Activated] = tbl1.onFriendFooterActivated,
            Selectable = false
        }, {
            OnlineFriends = React.createElement(CoPlayFooter, {
                users = getUserIdsForFacePile(tbl2),
                labelText = getDisplayName(tbl2, var3.friendsSeparator),
                showEmphasisBorder = tbl1.showOnlineBorder,
                faceGroupCount = 2,
                styleProps = {
                    faceWidth = size.Size_500,
                    faceHeight = size.Size_500,
                    faceGroupGap = -size.Size_150,
                    containerGap = size100,
                    badgeBorderWidth = 3,
                    badgeHeight = size.Size_500,
                    fontStyle = fontStyle,
                    badgeSpacingLeading = size.Size_100,
                    badgeSpacingTrailing = size.Size_100,
                    badgeBackgroundColor = {
                        Color = Colors.Smoke,
                        Transparency = 0
                    },
                    badgeContentColor = {
                        Color = Colors.White,
                        Transparency = 0
                    }
                }
            })
        }))
    end,
    getUserIdsForFacePile = getUserIdsForFacePile,
    getDisplayName = getDisplayName
}
