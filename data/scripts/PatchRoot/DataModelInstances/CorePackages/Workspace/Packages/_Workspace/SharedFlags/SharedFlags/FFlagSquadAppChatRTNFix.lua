-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T02:31:12Z
-- Luau bytecode version: 9 | Luau type version: 3
local GetFFlagIsSquadEnabled = require(script.Parent.GetFFlagIsSquadEnabled)
if game:DefineFastFlag("SquadAppChatRTNFixWithSquadMainFlag", false) then
    return (GetFFlagIsSquadEnabled())
end

return (game:DefineFastFlag("SquadAppChatRTNFix", false))
