-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParentParent = script.Parent.Parent
local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local t = require(scriptParentParent.t)
local Cryo = require(scriptParentParent.Cryo)
local default = require(scriptParentParent.LoggingProtocol).default

local _GameProtocolTypes = require(script.Parent.GameProtocolTypes)

local GetFFlagMoveLuaExpLaunchBegin = require(script.Parent.Flags.GetFFlagMoveLuaExpLaunchBegin)

local var1 = t.strictInterface({
    placeId = t.optional(t.number),
    userId = t.optional(t.number),
    accessCode = t.optional(t.string),
    gameInstanceId = t.optional(t.string),
    linkCode = t.optional(t.string),
    referralPage = t.optional(t.string),
    launchData = t.optional(t.string),
    eventId = t.optional(t.string),
    referredByPlayerId = t.optional(t.number),
    joinAttemptOrigin = t.optional(t.string),
    joinAttemptId = t.string
})

local module = {
    GAME_LAUNCH_DESCRIPTOR = {
        mid = MessageBus.getMessageId("Game", "launch"),
        validateParams = t.intersection(var1, function(arg1) -- name: checkRequiredParams
            return arg1.placeId or arg1.userId
        end)
    }
}

module.__index = module

function module.new()
    return (setmetatable({ subscriber = MessageBus.Subscriber.new() }, module))
end

function module.launchGame(tbl1, arg1, joinAttemptOrigin: string?, callback: ((...any) -> (...any))?)
    if type(arg1.placeId) == "string" then
        arg1.placeId = tonumber(arg1.placeId)
    end
    if type(arg1.userId) == "string" then
        arg1.userId = tonumber(arg1.userId)
    end

    local joinAttemptId = if arg1.joinAttemptId ~= nil then arg1.joinAttemptId else HttpService:GenerateGUID(false)
    local join = Cryo.Dictionary.join
    local tbl2 = { joinAttemptId = joinAttemptId, joinAttemptOrigin = 0 }
    if joinAttemptOrigin == nil then
        joinAttemptOrigin = arg1.joinAttemptOrigin
    end

    tbl2.joinAttemptOrigin = joinAttemptOrigin
    local var3 = join(arg1, tbl2)

    if callback then
        callback(joinAttemptId)
    end

    if GetFFlagMoveLuaExpLaunchBegin() then
        default:logEvent("experience_launch_begin")
    end

    MessageBus.publish(tbl1.GAME_LAUNCH_DESCRIPTOR, var3)
end

module.default = module.new()

return module
