-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

module.ButtonName = { LuaChatInputBar = "luaChatInputBar", LuaGameDetails = "luaGameDetails" }

module.EventName = {
    InviteSent = "inputShareGameInviteSent",
    EntryPoint = "inputShareGameEntryPoint"
}

module.DiagCounters = {
    EntryPoint = {
        [module.ButtonName.LuaChatInputBar] = game:DefineFastString("LuaShareGameLuaChatInputBarEntryCounter", "LuaShareGameLuaChatInputBarEntryCounter"),
        [module.ButtonName.LuaGameDetails] = game:DefineFastString("LuaShareGameLuaGameDetailsEntryCounter", "LuaShareGameLuaGameDetailsEntryCounter")
    },
    InviteSent = {
        [module.ButtonName.LuaChatInputBar] = game:DefineFastString("LuaShareGameLuaChatInputBarInviteCounter", "LuaShareGameLuaChatInputBarInviteCounter"),
        [module.ButtonName.LuaGameDetails] = game:DefineFastString("LuaShareGameLuaGameDetailsInviteCounter", "LuaShareGameLuaGameDetailsInviteCounter")
    }
}

function module.new(_eventStreamImpl, _diagImpl, _buttonName)
    assert(_eventStreamImpl, "EventStream implementation not found.")
    assert(_diagImpl, "Diag implementation not found.")
    assert(_buttonName, "ButtonName not found.")

    return (setmetatable({ _eventStreamImpl = _eventStreamImpl, _diagImpl = _diagImpl, _buttonName = _buttonName }, module))
end

function module.onActivatedInviteSent(arg1, arg2, arg3, senderId, arg4, arg5)
    local btn = arg1:_getButtonName()

    local inviteSent = module.EventName.InviteSent
    local participants = table.concat(arg5, ",")
    local tbl1 = {
        btn = btn,
        placeId = tostring(arg2),
        gameId = tostring(arg3),
        senderId = senderId,
        conversationId = tostring(arg4),
        participants = participants
    }
    arg1:_getEventStream():setRBXEventStream("touch", inviteSent, tbl1)

    local var2 = module.DiagCounters.InviteSent[arg1:_getButtonName()]
    if var2 then
        arg1:_getDiag():reportCounter(var2, 1)
    end
end

function module.inputShareGameEntryPoint(arg1, arg2, arg3)
    local btn = arg1:_getButtonName()

    local entryPoint = module.EventName.EntryPoint
    local tbl1 = {
        btn = btn,
        placeId = arg2 and tostring(arg2),
        gameId = arg3 and tostring(arg3)
    }

    arg1:_getEventStream():setRBXEventStream("touch", entryPoint, tbl1)

    local var2 = module.DiagCounters.EntryPoint[arg1:_getButtonName()]
    if var2 then
        arg1:_getDiag():reportCounter(var2, 1)
    end
end

function module:_getEventStream()
    return self._eventStreamImpl
end

function module:_getDiag()
    return self._diagImpl
end

function module:_getButtonName()
    return self._buttonName
end

return module
