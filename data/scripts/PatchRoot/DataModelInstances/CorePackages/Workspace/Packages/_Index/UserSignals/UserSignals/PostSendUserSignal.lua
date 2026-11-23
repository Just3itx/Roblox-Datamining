-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local SessionService = game:GetService("SessionService")

local UserSignals = script:FindFirstAncestor("UserSignals")
local UserSignalsParent = UserSignals.Parent

local SessionType = require(UserSignalsParent.RobloxAppSessionization).SessionType

local Http = require(UserSignalsParent.Http)
local _RobloxAppEnums = require(UserSignalsParent.RobloxAppEnums)

local Url = Http.Url
local _UserSignalTypes = require(UserSignals.UserSignalTypes)

local FFlagLuaAppAddSessionIdToUserSignals = require(UserSignalsParent.SharedFlags).FFlagLuaAppAddSessionIdToUserSignals

return function(arg1, signalValue, signalEntity, signalValueType, signalType)
    local metadata = if FFlagLuaAppAddSessionIdToUserSignals then SessionService:GetMetadata(
        SessionType.StructuralIdentifier.HomePageSessionInfo,
        SessionType.Metadata.HomePageSessionInfo.OmniSessionId
    ) else nil
    local timestampMs = tostring(DateTime.now().UnixTimestampMillis)
    local str2 = string.format("%suser-signal-http-gateway/v1/user-signal/ingest", Url.APIS_URL)
    local httpService = HttpService
    local input = { userSignalEvents = 0 }

    local tbl1 = {
        signalValue = signalValue,
        timestampMs = timestampMs,
        signalValueType = signalValueType,
        signalEntity = signalEntity,
        signalType = signalType,
        omniSessionId = 0
    }

    if not FFlagLuaAppAddSessionIdToUserSignals then
        metadata = nil
    end

    tbl1.omniSessionId = metadata
    input.userSignalEvents = { tbl1 }
    return arg1(str2, "POST", { postBody = httpService:JSONEncode(input) })
end
