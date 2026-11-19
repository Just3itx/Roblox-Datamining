-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T00:10:36Z
-- Luau bytecode version: 9 | Luau type version: 3
local FFlagEnableArgus = require(script.Parent.FFlagEnableArgus)
local FFlagArgoEnableMoments = require(script.Parent.FFlagArgoEnableMoments)
local bool1 = game:DefineFastFlag("SubTabAddMomentsFlagGating", false)

return game:DefineFastFlag("LuaAppIaHomeSubTab", false) or bool1 and FFlagEnableArgus and FFlagArgoEnableMoments
