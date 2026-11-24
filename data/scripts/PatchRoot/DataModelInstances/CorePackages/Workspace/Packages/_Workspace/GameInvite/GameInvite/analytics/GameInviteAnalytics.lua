-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent

local Cryo = require(GameInviteParent.Cryo)

game:DefineFastFlag("GameInviteModalIncludeLinkIdInShareButton", false)

local module = {}
module.__index = module

module.ButtonName = {
    SettingsHub = "settingsHub",
    ModalPrompt = "modalPrompt",
    GameDetailsMoreMenu = "uaGameDetailsMoreMenu",
    GameDetailsPlayWithFriendsMenu = "uaGameDetailsPlayWithFriendsMenu"
}

module.EventName = {
    InviteSent = "inputShareGameInviteSent",
    EntryPoint = "inputShareGameEntryPoint",
    LinkGenerated = "linkGenerated",
    ShareButtonClick = "buttonClick",
    InviteSearchFocused = "inviteSearchFocused",
    GameInviteModal = "gameInviteModal"
}

module.ActionType = {
    ModalOpen = "modalOpen",
    InviteTriggered = "inviteTriggered",
    ModalClose = "modalClose",
    InviteFailure = "inviteFailure"
}

module.DiagCounters = {
    EntryPoint = {
        [module.ButtonName.SettingsHub] = settings():GetFVariable("LuaShareGameSettingsHubEntryCounter"),
        [module.ButtonName.ModalPrompt] = settings():GetFVariable("LuaShareGameModalPromptEntryCounter")
    },
    InviteSent = {
        [module.ButtonName.SettingsHub] = settings():GetFVariable("LuaShareGameSettingsHubInviteCounter"),
        [module.ButtonName.ModalPrompt] = settings():GetFVariable("LuaShareGameModalPromptInviteCounter")
    }
}

function module.new()
    local tbl1 = { _eventStreamImpl = nil, _diagImpl = nil, _buttonName = nil }

    setmetatable(tbl1, module)

    return tbl1
end

function module:withEventStream(_eventStreamImpl)
    self._eventStreamImpl = _eventStreamImpl
    return self
end

function module:withDiag(_diagImpl)
    self._diagImpl = _diagImpl
    return self
end

function module:withButtonName(_buttonName)
    self._buttonName = _buttonName
    return self
end

function module.onActivatedInviteSent(arg1, _, arg2, arg3, arg4, arg5)
    local btn = arg1:_getButtonName()

    local str1 = if arg1:_getIsUniversalApp() then "inApp" else "inGame"

    local inviteSent = module.EventName.InviteSent
    local participants = table.concat(arg3, ",")
    local var2, var3

    if arg1:_getIsUniversalApp() then
        var2 = tostring(arg4)
        var3 = tostring(arg5)
    else
        var2 = tostring(game.PlaceId)
        var3 = tostring(game.GameId)
    end
    local tbl1 = {
        btn = btn,
        placeId = var2,
        gameId = var3,
        conversationId = tostring(arg2),
        participants = participants
    }
    arg1:_getEventStream():setRBXEventStream(str1, inviteSent, tbl1)

    local var4 = module.DiagCounters.InviteSent[arg1:_getButtonName()]
    if var4 then
        arg1:_getDiag():reportCounter(var4, 1)
    end
end

function module.inputShareGameEntryPoint(arg1, arg2, arg3)
    local btn = arg1:_getButtonName()

    local str1 = if arg1:_getIsUniversalApp() then "inApp" else "inGame"

    local entryPoint = module.EventName.EntryPoint
    local var2, var3

    if arg1:_getIsUniversalApp() then
        var2 = tostring(arg2)
        var3 = tostring(arg3)
    else
        var2 = tostring(game.PlaceId)
        var3 = tostring(game.GameId)
    end
    arg1:_getEventStream():setRBXEventStream(str1, entryPoint, { btn = btn, placeId = var2, gameId = var3 })

    local var4 = module.DiagCounters.EntryPoint[arg1:_getButtonName()]
    if var4 then
        arg1:_getDiag():reportCounter(var4, 1)
    end
end

function module.linkGenerated(tbl1, tbl2)
    local linkGenerated2 = module.EventName.LinkGenerated

    local tbl3 = {
        linkType = tbl2.linkType,
        linkId = tbl2.linkId,
        page = "inGameMenu",
        subpage = "inviteFriendsPage"
    }

    tbl1:_getEventStream():setRBXEventStream("shareLinks", linkGenerated2, tbl3)
end

function module.onShareButtonClick(tbl1, linkId: number?)
    local shareButtonClick = module.EventName.ShareButtonClick

    local tbl2 = {
        btn = "shareServerInviteLink",
        page = "inGameMenu",
        subpage = "inviteFriendsPage",
        linkId = 0,
        isShortUrlEnabled = true
    }

    if not game:GetFastFlag("GameInviteModalIncludeLinkIdInShareButton") then
        linkId = nil
    end

    tbl2.linkId = linkId

    tbl1:_getEventStream():setRBXEventStream("shareLinks", shareButtonClick, tbl2)
end

function module.onSearchFocused(arg1)
    local inviteSearchFocused = module.EventName.InviteSearchFocused

    local tbl1 = {
        btn = arg1:_getButtonName(),
        page = "inGameMenu",
        subpage = "inviteFriendsPage"
    }
    local str1

    if arg1:_getIsUniversalApp() then
        tbl1.page = "inAppGameDetails"
        str1 = "inApp"
    else
        str1 = "inGame"
    end
    arg1:_getEventStream():setRBXEventStream(str1, inviteSearchFocused, tbl1)
end

function module.sendEvent(arg1, arg2, arg3, arg4)
    local var1 = Cryo.Dictionary.join(
        arg3.Args,
        {
            placeId = if arg1:_getIsUniversalApp() and arg4 and arg4.place_id then arg4.place_id else game.PlaceId
        }
    )

    if arg4 then
        var1 = Cryo.Dictionary.join(var1, arg4)
    end
    arg1:_getEventStream():setRBXEventStream(arg2, arg3.Type, var1)
end

function module.sendGameInviteModalEvent(arg1, arg2, arg3)
    local tbl1 = {
        place_id = if arg1:_getIsUniversalApp() and arg3 and arg3.place_id then arg3.place_id else game.PlaceId
    }

    if arg3 then
        tbl1 = Cryo.Dictionary.join(tbl1, arg3)
    end
    arg1:_getEventStream():setRBXEventStream(arg2, module.EventName.GameInviteModal, tbl1)
end

function module:_getEventStream()
    assert(self._eventStreamImpl, "EventStream implementation not found. Did you forget to construct withEventStream?")
    return self._eventStreamImpl
end

function module:_getDiag()
    assert(self._diagImpl, "Diag implementation not found. Did you forget to construct withDiag?")
    return self._diagImpl
end

function module:_getButtonName()
    assert(self._buttonName, "ButtonName not found. Did you forget to construct withButtonName?")
    return self._buttonName
end

function module:_getIsUniversalApp(): boolean
    assert(self._buttonName, "ButtonName not found. Did you forget to construct withButtonName?")
    return self._buttonName == module.ButtonName.GameDetailsMoreMenu
        or self._buttonName == module.ButtonName.GameDetailsPlayWithFriendsMenu
end

return module
