-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local event = require(script.Parent.event)

local Actions = script:FindFirstAncestor("ExpChat").Actions
return event((require(Actions.VoiceParticipantAdded)))
