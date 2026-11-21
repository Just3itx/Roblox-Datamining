-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent

return require(ContactImporterParent.GenericChallenges).Middleware.ChallengeRequestWrapper(
    require(ContactImporterParent.DataHydration).Friends.httpRequest
)
