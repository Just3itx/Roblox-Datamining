-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
function debugPrint(_) end

debugPrint("Self View Analytics 10-19-2022__1")

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local module = ({})
module.__index = module

module.INFO = "info"
module.WARNING = "warning"
module.ERROR = "error"

local str1 = "SelfView"

function module.new(_impl)
    _impl = _impl or RbxAnalyticsService

    assert(_impl, "Analytics impl must not be nil.")

    return (setmetatable({ _impl = _impl }, module))
end

local function stub() end

function module.stubService()
    return {
        SetRBXEvent = stub,
        SetRBXEventStream = stub,
        SendEventDeferred = stub,
        ReportCounter = stub,
        ReportStats = stub,
        ReportInfluxSeries = stub,
        GetSessionId = stub
    }
end

function module:setImpl(_impl)
    self._impl = _impl
end

function module:_report(arg1, arg2, _, arg3)
    local str2 = if RunService:IsStudio() then "studio" else "client"

    self._impl:SendEventDeferred(str2, arg1, arg2, arg3)
end

function module:reportMicState(state)
    debugPrint(
        "Self View: Analytics:reportMicState, newState: "
            .. tostring(state) .. ",universeid: " .. tostring(game.GameId) .. ",pid: " .. tostring(game.PlaceId) .. ",uid: " .. tostring(Players.LocalPlayer.UserId) .. ",sessionid: " .. tostring(self._impl:GetSessionId())
    )
    local str2 = str1
    local str3 = tostring(state)
    local tbl1 = {
        state = state,
        universeid = tostring(game.GameId),
        pid = tostring(game.PlaceId),
        uid = tostring(Players.LocalPlayer.UserId),
        sessionid = tostring(self._impl:GetPlaySessionId())
    }
    self:_report(str2, "inExperienceMicState", str3, tbl1)
end

function module:reportCamState(state)
    debugPrint(
        "Self View: Analytics:reporCamState, newState: "
            .. tostring(state) .. ",universeid: " .. tostring(game.GameId) .. ",pid: " .. tostring(game.PlaceId) .. ",uid: " .. tostring(Players.LocalPlayer.UserId) .. ",sessionid: " .. tostring(self._impl:GetSessionId())
    )
    local str2 = str1
    local str3 = tostring(state)
    local tbl1 = {
        state = state,
        universeid = tostring(game.GameId),
        pid = tostring(game.PlaceId),
        uid = tostring(Players.LocalPlayer.UserId),
        sessionid = tostring(self._impl:GetPlaySessionId())
    }
    self:_report(str2, "inExperienceCamState", str3, tbl1)
end

function module:reportSelfViewEnabledInCoreGuiState(state)
    debugPrint(
        "Self View: Analytics:reportSelfViewEnabledInCoreGuiState, newState: " .. tostring(state) .. ",universeid: " .. tostring(game.GameId) .. ",pid: " .. tostring(game.PlaceId) .. ",sessionid: " .. tostring(self._impl:GetSessionId())
    )
    local str2 = tostring(state)
    local tbl1 = {
        state = state,
        universeid = tostring(game.GameId),
        pid = tostring(game.PlaceId),
        sessionid = tostring(self._impl:GetPlaySessionId())
    }
    self:_report("SelfView", "enabledinCoreGuiState", str2, tbl1)
end

function module:reportSelfViewSessionStarted(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    debugPrint(
        "Self View: Analytics:reportSelfViewSessionStarted,universeid: "
            .. tostring(game.GameId)
                .. ",pid: "
                    .. tostring(game.PlaceId)
                        .. ",sessionid: "
                            .. tostring(self._impl:GetSessionId())
                                .. ",x: "
                                    .. tostring(arg1)
                                        .. ",y: "
                                            .. tostring(arg2) .. ",width: " .. tostring(arg3) .. ",height: " .. tostring(arg4) .. ",x_relative: " .. tostring(arg5) .. ",y_relative: " .. tostring(arg6) .. ",width_relative: " .. tostring(arg7) .. ",height_relative: " .. tostring(arg8)
    )
    local tbl1 = {
        universeid = tostring(game.GameId),
        pid = tostring(game.PlaceId),
        sessionid = tostring(self._impl:GetPlaySessionId()),
        x = tostring(arg1),
        y = tostring(arg2),
        width = tostring(arg3),
        height = tostring(arg4),
        x_relative = tostring(arg5),
        y_relative = tostring(arg6),
        width_relative = tostring(arg7),
        height_relative = tostring(arg8)
    }
    self:_report("SelfView", "sessionStarted", "true", tbl1)

    RbxAnalyticsService:AddGlobalPointsField("feature/avatarChat/selfViewOn", 1)
end

function module:reportSelfViewSessionStopped()
    debugPrint(
        "Self View: Analytics:reportSelfViewSessionStopped,universeid: " .. tostring(game.GameId) .. ",pid: " .. tostring(game.PlaceId) .. ",sessionid: " .. tostring(self._impl:GetSessionId())
    )
    local tbl1 = {
        universeid = tostring(game.GameId),
        pid = tostring(game.PlaceId),
        sessionid = tostring(self._impl:GetPlaySessionId())
    }
    self:_report("SelfView", "sessionStopped", "true", tbl1)

    RbxAnalyticsService:AddGlobalPointsField("feature/avatarChat/selfViewOn", 0)
end

function module:reportUserAccountSettings(bool1: boolean, bool2: boolean)
    debugPrint(
        "Self View: Analytics:reportUserAccountSettings,universeid: "
            .. tostring(game.GameId) .. ",pid: " .. tostring(game.PlaceId) .. ",sessionid: " .. tostring(self._impl:GetSessionId()) .. ",userAccount_videoEnabled: " .. tostring(bool1) .. ",userAccount_audioEnabled: " .. tostring(bool2)
    )
    local tbl1 = {
        universeid = tostring(game.GameId),
        pid = tostring(game.PlaceId),
        sessionid = tostring(self._impl:GetPlaySessionId()),
        videoenabled = tostring(bool1),
        audioenabled = tostring(bool2)
    }
    self:_report("SelfView", "userAccountSettings", "true", tbl1)
end

function module:reportExperienceSettings(bool1: boolean, bool2: boolean, bool3: boolean)
    debugPrint(
        "Self View: Analytics:reportExperienceSettings,universeid: "
            .. tostring(game.GameId)
                .. ",pid: "
                    .. tostring(game.PlaceId)
                        .. ",sessionid: " .. tostring(self._impl:GetSessionId()) .. ",experienceSettings_placeEnabled: " .. tostring(bool1) .. ",experienceSettings_videoEnabled: " .. tostring(bool2) .. ",experienceSettings_audioEnabled: " .. tostring(bool3)
    )
    local tbl1 = {
        universeid = tostring(game.GameId),
        pid = tostring(game.PlaceId),
        sessionid = tostring(self._impl:GetPlaySessionId()),
        placeenabled = tostring(bool1),
        videoenabled = tostring(bool2),
        audioenabled = tostring(bool3)
    }
    self:_report("SelfView", "experienceSettings", "true", tbl1)
end

function module.setLastCtx(_, arg1)
    str1 = arg1
end

return module
