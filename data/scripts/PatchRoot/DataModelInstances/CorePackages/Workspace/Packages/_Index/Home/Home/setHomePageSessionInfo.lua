-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HomeParent = script:FindFirstAncestor("Home").Parent

local SessionType = require(HomeParent.RobloxAppSessionization).SessionType

local function setHomePageSessionInfo(arg1, str1: string?, str2: string?)
    if arg1 == nil then
        return
    end

    arg1:SetSession(
        SessionType.StructuralIdentifier.Level1,
        SessionType.StructuralIdentifier.HomePageSessionInfo,
        SessionType.StructuralIdentifier.HomePageSessionInfo
    )

    if str1 then
        arg1:SetMetadata(
            SessionType.StructuralIdentifier.HomePageSessionInfo,
            SessionType.Metadata.HomePageSessionInfo.RequestId,
            str1
        )
    end

    if str2 then
        arg1:SetMetadata(
            SessionType.StructuralIdentifier.HomePageSessionInfo,
            SessionType.Metadata.HomePageSessionInfo.OmniSessionId,
            str2
        )
    end
end

return setHomePageSessionInfo
