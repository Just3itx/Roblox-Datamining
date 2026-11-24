-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent

local React = require(GameInviteParent.React)
local _UserList = require(GameInviteParent.UserList)
local useLocalization = require(GameInviteParent.Localization).Hooks.useLocalization
local useGetPresenceByUserId = require(GameInviteParent.FriendsCommon).Hooks.useGetPresenceByUserId
local UserModel = require(GameInviteParent.UserLib).Models.UserModel

local GameInviteInviteButton = require(script.Parent.GameInviteInviteButton)
local friendMetadataLine = require(script.Parent.friendMetadataLine)
local FFlagGameInviteInExpLivePresence = require(GameInvite.Flags.FFlagGameInviteInExpLivePresence)

local tbl1 = { skipFetch = true }

local tbl2 = {
    [UserModel.PresenceType.ONLINE] = "Online",
    [UserModel.PresenceType.IN_GAME] = "InGame",
    [UserModel.PresenceType.IN_STUDIO] = "InStudio",
    [UserModel.PresenceType.OFFLINE] = "Offline"
}

local function GameInviteFriendRow(tbl3)
    local friend = tbl3.friend
    local id = friend.id
    local rowNumber = tbl3.rowNumber
    local var1 = useLocalization({
        inStudio = "Common.Presence.Label.RobloxStudio",
        online = if FFlagGameInviteInExpLivePresence then "Common.Presence.Label.Online" else nil
    })

    local contextText = friendMetadataLine.getContextText(friend, var1)
    local livePresenceType

    if FFlagGameInviteInExpLivePresence then
        livePresenceType = tbl2[friend.presence]
        local lastLocation = friend.lastLocation
        local var2 = useGetPresenceByUserId(id, tbl1)
        if var2 ~= nil then
            livePresenceType = friendMetadataLine.getLivePresenceType(var2)
            lastLocation = var2.lastLocation
        end
        contextText = friendMetadataLine.getContextTextForPresence(livePresenceType, lastLocation, var1)
    else
        livePresenceType = nil
    end

    local contextualInfo = React.useMemo(function(): {text: any}?
        return if contextText == nil then nil else { text = contextText }
    end, { contextText })
    local trailingContent = React.useMemo(function()
        return React.createElement(GameInviteInviteButton, { userId = id, rowNumber = rowNumber })
    end, { id, rowNumber })

    local createRow = tbl3.createRow
    local tbl4 = { contextualInfo = contextualInfo, presence = 0, trailingContent = 0 }
    if not FFlagGameInviteInExpLivePresence then
        livePresenceType = tbl2[friend.presence]
    end

    tbl4.presence = livePresenceType

    tbl4.trailingContent = trailingContent
    return createRow(tbl4)
end

return GameInviteFriendRow
