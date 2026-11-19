-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")
local dependencies = require(CrossExperience.dependencies)
local FFlagEnablePartyVoiceChangersInLua = dependencies.SharedFlags.FFlagEnablePartyVoiceChangersInLua

local t = dependencies.t

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.format(arg1)
    return (module.new({
        userId = arg1.userId,
        isLocalUser = arg1.isLocalUser,
        username = arg1.username,
        displayname = arg1.displayname,
        isMuted = arg1.isMuted,
        isMutedLocally = arg1.isMutedLocally,
        isVoiceChangerActive = if FFlagEnablePartyVoiceChangersInLua then arg1.isVoiceChangerActive else nil,
        isVoiceChangerHearMyselfActive = if FFlagEnablePartyVoiceChangersInLua then arg1.isVoiceChangerHearMyselfActive else nil,
        selectedVoicePack = if FFlagEnablePartyVoiceChangersInLua then arg1.selectedVoicePack else nil
    }))
end

local var1

if FFlagEnablePartyVoiceChangersInLua then
    var1 = t.strictInterface({
        userId = t.number,
        isLocalUser = t.boolean,
        username = t.string,
        displayname = t.string,
        isMuted = t.boolean,
        isMutedLocally = t.boolean,
        isVoiceChangerActive = t.boolean,
        isVoiceChangerHearMyselfActive = t.boolean,
        selectedVoicePack = t.string
    })
else
    var1 = t.strictInterface({
        userId = t.number,
        isLocalUser = t.boolean,
        username = t.string,
        displayname = t.string,
        isMuted = t.boolean,
        isMutedLocally = t.boolean
    })
end

module.isValid = var1

return module
