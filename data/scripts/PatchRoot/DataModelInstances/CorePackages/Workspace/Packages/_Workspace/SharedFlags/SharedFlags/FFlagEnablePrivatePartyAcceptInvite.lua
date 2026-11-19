-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T13:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local GetFFlagIsSquadEnabled = require(script.Parent.GetFFlagIsSquadEnabled)

return game:GetEngineFeature("PrivatePartyJoin")
    and GetFFlagIsSquadEnabled()
    and game:DefineFastFlag("EnablePrivatePartyAcceptInvite", false)
