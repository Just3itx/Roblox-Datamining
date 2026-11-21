-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)
local React = dependencies.React

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local t = dependencies.t
local withStyle = UIBlox.Style.withStyle
local withLocalization = dependencies.withLocalization
local UserProfiles = require(FriendsLandingParent.UserProfiles)
local userPresenceText = require(FriendsLanding.Friends.userPresenceText)
local userPresenceIcon = require(FriendsLanding.Friends.userPresenceIcon)
local getCorrectUserPresence = require(FriendsLanding.Friends.getCorrectUserPresence)

local memoize = dependencies.memoize
local createRelevancyInfo = require(script.Parent.createRelevancyInfo)

local SocialCommon = require(FriendsLandingParent.SocialCommon)
local ButtonTypes = require(FriendsLandingParent.UserList).Enums.ButtonTypes

local ButtonVariant = require(FriendsLandingParent.Foundation).Enums.ButtonVariant
local FriendTileWithTrustedIndicator = require(script.Parent.FriendTileWithTrustedIndicator)

local FFlagFriendsPageUserListEnabled = require(FriendsLandingParent.SharedFlags).FFlagFriendsPageUserListEnabled
local FFlagFriendsPageViewBtnEnabled = require(FriendsLandingParent.SharedFlags).FFlagFriendsPageViewBtnEnabled
local FFlagEnableBlackbirdCheck = require(FriendsLandingParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagFriendsPageUserListCtaEnabled = require(FriendsLanding.Flags.FFlagFriendsPageUserListCtaEnabled)

local var1 = Roact.PureComponent:extend("FriendTile")

var1.validateProps = t.strictInterface({
    user = t.table,
    index = t.number,
    openPlayerProfileHandle = t.callback,
    pageLoadingTimeReport = t.optional(t.callback),
    createRow = t.optional(t.callback),
    selected = t.optional(t.boolean),
    focusGuiObject = t.optional(t.callback),
    userProfile = t.optional(t.table),
    trustedConnection = t.optional(t.boolean),
    isRobloxSubscriber = t.optional(t.boolean),
    isLuobu = t.optional(t.boolean),
    buttons = t.optional(
        t.array(
            t.strictInterface({
                icon = t.optional(t.string),
                onActivated = t.optional(t.callback),
                isSecondary = t.optional(t.boolean),
                isDisabled = t.optional(t.boolean)
            })
        )
    )
})
var1.defaultProps = {
    user = { username = "" },
    openPlayerProfileHandle = function() end,
    isLuobu = false,
    index = 1,
    buttons = nil,
    trustedConnection = false
}

function var1.init(arg1)
    arg1.state = { isFirstRender = true }
    arg1.makeRelevancyInfo = memoize(createRelevancyInfo)
    arg1.playerTileRef = Roact.createRef()

    function arg1.checkAndSetSelected()
        if not arg1.props.selected or not arg1.props.focusGuiObject then
            return
        end

        local value = arg1.playerTileRef:getValue()
        if value then
            arg1.props.focusGuiObject(value)
        end
    end

    arg1.getPresenceType = FFlagFriendsPageUserListEnabled and function(arg2)
        local str1 = tostring(arg2 or "")
        return string.gsub(str1, "PresenceType%.", "") or SocialCommon.Enums.PresenceTypes.Offline
    end or nil

    function arg1.openProfilePeekViewHandle()
        return arg1.props.openPlayerProfileHandle(arg1.props.user.id, arg1.props.index, arg1.props.user)
    end
end

function var1.didMount(arg1)
    if arg1.props.pageLoadingTimeReport then
        arg1.props.pageLoadingTimeReport()
    end

    arg1.checkAndSetSelected()
end

function var1.render(arg1)
    local user = arg1.props.user
    local userPresence = getCorrectUserPresence(user)

    local presenceText = userPresenceText[userPresence]
    local var3 = userPresenceIcon[userPresence]

    if not arg1.playerTileRef:getValue() then
        arg1:setState({ isFirstRender = false })
    end

    return withStyle(function(arg2)
        return withLocalization({
            presenceText = presenceText,
            accountDeletedText = "Feature.Friends.Action.AccountDeleted",
            trustedText = "Feature.Friends.TrustedConnection.Label.Trusted"
        })(
            function(arg3)
                local presenceText = arg3.presenceText or nil
                local accountDeletedText = arg3.accountDeletedText

                if FFlagFriendsPageUserListEnabled then
                    local relevancyInfo = arg1.makeRelevancyInfo(
                        user,
                        presenceText,
                        var3,
                        nil,
                        arg2.Theme,
                        arg1.props.index,
                        arg1.props.isLuobu,
                        arg2.Font,
                        accountDeletedText,
                        true
                    )

                    return arg1.props.createRow({
                        onRowActivated = arg1.openProfilePeekViewHandle,
                        contextualInfo = relevancyInfo and {
                            text = relevancyInfo.text,
                            icon = relevancyInfo.icon
                        },
                        presence = arg1.getPresenceType(userPresence),
                        primaryCta = if FFlagFriendsPageUserListCtaEnabled then nil else FFlagFriendsPageViewBtnEnabled
                            and {
                                type = ButtonTypes.View,
                                onActivated = arg1.openProfilePeekViewHandle,
                                variant = ButtonVariant.Standard,
                                minWidth = 64,
                                maxWidth = 90
                            }
                            or nil
                    })
                end

                local combinedName, var4

                if arg1.props.userProfile then
                    combinedName = arg1.props.userProfile.names.combinedName
                    var4 = UserProfiles.Formatters.formatUsername(arg1.props.userProfile.names.username)
                    user.isDeleted = arg1.props.userProfile.isDeleted
                else
                    combinedName = nil
                    var4 = nil
                end
                local title = combinedName or user.displayName
                local subtitle = var4 or "@" .. user.username
                local relevancyInfo = if combinedName then arg1.makeRelevancyInfo(
                    user,
                    presenceText,
                    var3,
                    nil,
                    arg2.Theme,
                    arg1.props.index,
                    arg1.props.isLuobu,
                    arg2.Font,
                    accountDeletedText,
                    true
                ) else nil
                local isVerified = arg1.props.userProfile and arg1.props.userProfile.isVerified
                return React.createElement(FriendTileWithTrustedIndicator, {
                    user = user,
                    userPresence = userPresence,
                    title = title,
                    subtitle = subtitle,
                    relevancyInfo = relevancyInfo,
                    index = arg1.props.index,
                    openPlayerProfile = arg1.openProfilePeekViewHandle,
                    playerTileRef = arg1.playerTileRef,
                    buttons = arg1.props.buttons,
                    isTrustedConnection = arg1.props.trustedConnection,
                    isVerified = isVerified,
                    isRobloxSubscriber = if FFlagEnableBlackbirdCheck then arg1.props.isRobloxSubscriber else nil
                })
            end
        )
    end)
end

return var1
