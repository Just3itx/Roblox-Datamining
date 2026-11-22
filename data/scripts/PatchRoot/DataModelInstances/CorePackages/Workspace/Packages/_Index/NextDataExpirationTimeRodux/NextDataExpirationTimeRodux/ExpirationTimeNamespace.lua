-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local NextDataExpirationTimeRoduxParent = script:FindFirstAncestor("NextDataExpirationTimeRodux").Parent

return {
    GameDetailPage = "GameDetailPage",
    GameDetailPlayability = "GameDetailPlayability",
    GameSortGroup = "GameSortGroup",
    SongDetailPage = if require(NextDataExpirationTimeRoduxParent.SharedFlags).FFlagEnableTopSongsSort then "SongDetailPage" else nil
}
