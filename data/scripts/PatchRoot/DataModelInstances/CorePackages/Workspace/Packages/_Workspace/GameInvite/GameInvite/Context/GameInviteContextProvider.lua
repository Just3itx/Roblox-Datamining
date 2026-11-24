-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local FriendsMenu = require(scriptParentParentParent.FriendsMenu)
local React = require(scriptParentParentParent.React)
local GetFFlagEnableCommonFriendsMenu = require(scriptParentParentParent.SharedFlags).GetFFlagEnableCommonFriendsMenu

local FriendsListContextProvider = FriendsMenu.FriendsListContextProvider
local InviteFriendProvider = require(scriptParent.InviteFriendProvider)
local GameDetailsContextProvider = require(scriptParent.GameDetailsContextProvider)
local _gameInviteModalType = require(scriptParentParent.gameInviteModalType)

return function(tbl1)
    local trigger, inviteMessageId, launchData, promptMessage, isCoreScript, rootPlaceId, universeId

    if tbl1.options then
        trigger = tbl1.options.trigger
        inviteMessageId = tbl1.options.inviteMessageId
        launchData = tbl1.options.launchData
        promptMessage = tbl1.options.promptMessage
        isCoreScript = tbl1.isCoreScript or false
        rootPlaceId = tbl1.options.rootPlaceId
        universeId = tbl1.options.universeId
    else
        promptMessage = nil
        trigger = nil
        isCoreScript = nil
        inviteMessageId = nil
        launchData = nil
        rootPlaceId = nil
        universeId = nil
    end

    local createElement = React.createElement
    local var1 = GameDetailsContextProvider
    local tbl2 = {
        gameDetails = tbl1.gameDetails,
        serverType = tbl1.serverType,
        promptMessage = promptMessage,
        trigger = trigger,
        isCoreScript = isCoreScript
    }
    local element

    if GetFFlagEnableCommonFriendsMenu() then
        element = React.createElement(InviteFriendProvider, {
            trigger = trigger,
            inviteMessageId = inviteMessageId,
            launchData = launchData,
            promptMessage = promptMessage,
            isCoreScript = isCoreScript,
            rootPlaceId = rootPlaceId,
            universeId = universeId
        }, tbl1.children)
    else
        element = React.createElement(
            FriendsListContextProvider,
            {
                isLoadingCustomParams = tbl1.isLoadingCustomParams
            },
            React.createElement(InviteFriendProvider, {
                trigger = trigger,
                inviteMessageId = inviteMessageId,
                launchData = launchData,
                promptMessage = promptMessage,
                isCoreScript = isCoreScript,
                rootPlaceId = rootPlaceId,
                universeId = universeId
            }, tbl1.children)
        )
    end

    return createElement(var1, tbl2, { element })
end
