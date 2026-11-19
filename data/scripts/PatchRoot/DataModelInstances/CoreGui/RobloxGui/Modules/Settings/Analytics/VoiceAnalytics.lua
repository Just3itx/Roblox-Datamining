-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Resources.Constants)

local module = {}
module.__index = module

function module.new(_eventStreamImpl, _context)
    local tbl1 = {
        _eventStreamImpl = _eventStreamImpl,
        _target = "EventIngest",
        _context = _context or "SettingsHub"
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module.onToggleMuteAll(arg1, arg2)
    if arg2 then
        arg1:onMuteAll()
        return
    end
    arg1:onUnmuteAll()
end

function module.onToggleMuteSelf(arg1, arg2)
    if arg2 then
        arg1:onMuteSelf()
        return
    end
    arg1:onUnmuteSelf()
end

function module.onToggleMutePlayer(arg1, arg2, arg3)
    if arg3 then
        arg1:onMutePlayer(arg2)
        return
    end
    arg1:onUnmutePlayer(arg2)
end

function module:onMuteSelf()
    local muteSelf = Constants.VoiceAnalytics.MuteSelf
    self._eventStreamImpl:setRBXEventStream(self._target, self._context, muteSelf, {})
end

function module:onUnmuteSelf()
    local unmuteSelf = Constants.VoiceAnalytics.UnmuteSelf
    self._eventStreamImpl:setRBXEventStream(self._target, self._context, unmuteSelf, {})
end

function module:onMuteAll()
    local muteAll = Constants.VoiceAnalytics.MuteAll
    self._eventStreamImpl:setRBXEventStream(self._target, self._context, muteAll, {})
end

function module:onUnmuteAll()
    local unmuteAll = Constants.VoiceAnalytics.UnmuteAll
    self._eventStreamImpl:setRBXEventStream(self._target, self._context, unmuteAll, {})
end

function module:onMutePlayer(mutedUserId)
    local mutePlayer = Constants.VoiceAnalytics.MutePlayer
    self._eventStreamImpl:setRBXEventStream(self._target, self._context, mutePlayer, { mutedUserId = mutedUserId })
end

function module:onUnmutePlayer(mutedUserId)
    local unmutePlayer = Constants.VoiceAnalytics.UnmutePlayer
    self._eventStreamImpl:setRBXEventStream(self._target, self._context, unmutePlayer, { mutedUserId = mutedUserId })
end

return module
