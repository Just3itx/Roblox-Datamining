-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local FriendRequestOriginSource = require(TrustedContactsParent.ApolloProfileInsights).Enums.FriendRequestOriginSource

local LocalizationService = game:GetService("LocalizationService")

local React = require(TrustedContactsParent.React)

local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization

local Icon = require(TrustedContactsParent.BuilderIcons).Icon

local FFlagTFNonFriendsPermitted = require(TrustedContacts.Flags.FFlagTFNonFriendsPermitted)
local FFlagTFClassmatesProfileInsight = require(TrustedContactsParent.SharedFlags).FFlagTFClassmatesProfileInsight

local tbl1 = {
    mutualFriends = Icon.TwoPeople,
    friendshipAgeUnixSeconds = Icon.Calendar,
    qrCode = Icon.SquaresGridQr,
    search = Icon.MagnifyingGlass,
    contacts = Icon.SmartphonePortrait,
    accountCreationDateUnixSeconds = Icon.CircleI,
    localizedCountryName = Icon.GlobeDetailed,
    isClassmate = if FFlagTFClassmatesProfileInsight then Icon.PersonGraduate else nil,
    notAFriend = if FFlagTFNonFriendsPermitted then Icon.TriangleExclamation else nil,
    noMutualFriends = if FFlagTFNonFriendsPermitted then Icon.TriangleExclamation else nil
}

local function func1(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 ~= "friendRequestOriginSource" then
        return tbl1[arg1]
    end

    local var1 = nil
    if arg2 == FriendRequestOriginSource.QrCode then
        var1 = "qrCode"
    elseif arg2 == FriendRequestOriginSource.PhoneContactImporter then
        var1 = "contacts"
    elseif arg2 == FriendRequestOriginSource.PlayerSearch then
        var1 = "search"
    end

    return tbl1[var1]
end

local function func2(arg1, arg2, arg3)
    local var1 = nil

    if arg1 == "friendshipAgeUnixSeconds" then
        return arg3.connectedDuration
    end

    if arg1 == "friendRequestOriginSource" then
        if arg2 == FriendRequestOriginSource.QrCode then
            return arg3.fromQrCode
        end

        if arg2 == FriendRequestOriginSource.PhoneContactImporter then
            return arg3.fromContacts
        end

        if arg2 == FriendRequestOriginSource.PlayerSearch then
            return arg3.fromSearch
        end
    elseif arg1 == "mutualFriends" then
        if #arg2 > 1 then
            return arg3.mutualConnections
        end

        if #arg2 == 1 then
            return arg3.singularMutualConnection
        end
    else
        if arg1 == "localizedCountryName" then
            return arg2
        elseif arg1 == "accountCreationDateUnixSeconds" then
            return arg3.joinedInYear
        end

        if FFlagTFClassmatesProfileInsight and arg1 == "isClassmate" then
            if arg2 then
                return arg3.classmates
            end

            var1 = nil
        end
    end
    return var1
end

local function useProfileInsightsToIconsAndTexts(tbl2)
    local connectedDuration = React.useMemo(function()
        if not tbl2.friendshipAgeUnixSeconds then
            return nil
        end

        local var1 = DateTime.now().UnixTimestamp - tbl2.friendshipAgeUnixSeconds or 0
        local num = math.floor(var1 / 31536000)
        local num1 = math.floor(var1 / 2592000)
        local num2 = math.floor(var1 / 86400)

        if num > 1 then
            return { "Feature.Friends.Label.ConnectedNumYears", num = num }
        end

        if num == 1 then
            return "Feature.Friends.Label.ConnectedOneYear"
        end

        if num1 > 1 then
            return { "Feature.Friends.Label.ConnectedNumMonths", num = num1 }
        end

        if num1 == 1 then
            return "Feature.Friends.Label.ConnectedOneMonth"
        end

        if num2 > 1 then
            return { "Feature.Friends.Label.ConnectedNumDays", num = num2 }
        end

        if num2 == 1 then
            return "Feature.Friends.Label.ConnectedOneDay"
        end

        return "Feature.Friends.Label.NewFriend"
    end, { tbl2.friendshipAgeUnixSeconds })

    local year = DateTime.fromUnixTimestamp(tbl2.accountCreationDateUnixSeconds or 0):FormatLocalTime(
        "YYYY",
        LocalizationService.RobloxLocaleId
    )
    local var2 = useLocalization({
        singularMutualConnection = "Feature.Friends.Label.MutualFriendTitle",
        mutualConnections = {
            "Feature.Friends.Label.MutualFriendsTitle",
            numConnections = tbl2.mutualFriends and #tbl2.mutualFriends or 0
        },
        joinedInYear = { "Feature.Friends.Label.JoinedInYear", year = year },
        connectedDuration = connectedDuration,
        fromQrCode = "Feature.Friends.Description.FromQrCode",
        fromContacts = "Feature.Friends.Description.FromContacts",
        fromSearch = "Feature.PlayerSearchResults.Label.FromSearch",
        classmates = if FFlagTFClassmatesProfileInsight then "Feature.Schools.Label.Classmates" else nil,
        notAFriend = if FFlagTFNonFriendsPermitted then "Feature.Friends.Description.NotAFriend" else nil,
        noMutualFriends = if FFlagTFNonFriendsPermitted then "Feature.Friends.Description.NoMutualFriends" else nil
    })

    local tbl3 = {}
    return React.useMemo(function()
        for value, value2 in tbl2 do
            local icon = func1(value, value2)
            local text = func2(value, value2, var2)

            if icon and text then
                table.insert(tbl3, { icon = icon, text = text })
            end
        end

        if FFlagTFNonFriendsPermitted then
            if tbl2.friendshipAgeUnixSeconds == nil then
                table.insert(tbl3, { icon = tbl1.notAFriend, text = var2.notAFriend })
            end

            if tbl2.mutualFriends == nil or next(tbl2.mutualFriends) == nil then
                table.insert(tbl3, { icon = tbl1.noMutualFriends, text = var2.noMutualFriends })
            end
        end

        return tbl3
    end, { var2, tbl2 })
end

return useProfileInsightsToIconsAndTexts
