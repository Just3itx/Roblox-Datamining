-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagEnableArgus = require(script.Parent.FFlagEnableArgus)
local FFlagArgoEnableMoments = require(script.Parent.FFlagArgoEnableMoments)
local FFlagEnableSubTabOverride = require(script.Parent.FFlagEnableSubTabOverride)
local FFlagLuaAppIaHomeSubTab = require(script.Parent.FFlagLuaAppIaHomeSubTab)
local bool1 = game:DefineFastFlag("SubTabAddMomentsFlagGating", false)

return FFlagLuaAppIaHomeSubTab or FFlagEnableSubTabOverride or bool1 and FFlagEnableArgus and FFlagArgoEnableMoments
