-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)

local VoiceEnabledChanged = require(RobloxGui.Modules.VoiceChat.Actions.VoiceEnabledChanged)
local BubbleChatEnabledChanged = require(script.Parent.Parent.Actions.BubbleChatEnabledChanged)

local createReducer = Rodux.createReducer

local tbl1 = {}

tbl1[BubbleChatEnabledChanged.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { bubbleChatEnabled = arg2.enabled })
end

tbl1[VoiceEnabledChanged.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { voiceEnabled = arg2.enabled })
end

return (createReducer({ bubbleChatEnabled = false, voiceEnabled = false }, tbl1))
