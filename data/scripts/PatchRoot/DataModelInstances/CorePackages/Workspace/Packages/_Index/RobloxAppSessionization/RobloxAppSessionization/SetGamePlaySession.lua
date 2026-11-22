-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SessionType = require(script.Parent.SessionType)

return function(sessionService, arg1, arg2)
    assert(sessionService, "sessionManager can't be nil")

    sessionService:RemoveSessionsWithMetadataKey(SessionType.Metadata.GamePlay.GamePlaySession)
    sessionService:SetSession(SessionType.StructuralIdentifier.Level1, arg1, arg1)
    sessionService:SetMetadata(arg1, SessionType.Metadata.GamePlay.GamePlaySession, "True")
    if arg2 then
        sessionService:SetMetadata(arg1, SessionType.Metadata.GamePlay.DeleteOnGameLeave, "True")
    end
end
