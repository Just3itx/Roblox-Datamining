-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Rodux = require(AppChatParent.Rodux)
local _SocialCommon = require(AppChatParent.SocialCommon)
local EnteredChatFromEntryPoint = require(AppChat.Actions.EnteredChatFromEntryPoint)

local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local trackChatLanding = require(AppChat.Telemetry.trackChatLanding)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[EnteredChatFromEntryPoint.name] = function(_, arg1)
    if FFlagAppChatPerfTracking then
        trackChatLanding(arg1.entryPoint)
    end
    return arg1.entryPoint
end

return createReducer("NotSet", tbl1)
