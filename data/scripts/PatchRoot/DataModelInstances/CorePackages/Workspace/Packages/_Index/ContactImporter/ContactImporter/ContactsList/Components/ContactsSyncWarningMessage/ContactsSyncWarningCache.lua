-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent

return (require(ContactImporterParent.SocialCommon).Utils.ImpressionCacheImpl({
    appStorageKey = "ContactsSyncWarningImpressionsCount",
    isKeyAvailableInEngine = game:GetEngineFeature("RegisterContactsSyncWarningImpressionsCountKey"),
    dismissedValue = -1
}))
