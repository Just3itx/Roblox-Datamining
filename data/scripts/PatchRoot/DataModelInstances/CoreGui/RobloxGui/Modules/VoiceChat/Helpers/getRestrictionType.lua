-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local _createVoiceRestrictionController = require(CorePackages.Workspace.Packages.VoiceChat.createVoiceRestrictionController)
local Constants = require(script.Parent.Parent.Constants)

local function getRestrictionType(arg1): string
    if not arg1 then
        return "Nudge"
    end

    if arg1.bannedUntil then
        if arg1.banReason == Constants.BAN_REASON.NUDGE_V3 then
            return "NudgeBan"
        end

        return "TemporaryBan"
    end

    return "PermanentBan"
end

return getRestrictionType
