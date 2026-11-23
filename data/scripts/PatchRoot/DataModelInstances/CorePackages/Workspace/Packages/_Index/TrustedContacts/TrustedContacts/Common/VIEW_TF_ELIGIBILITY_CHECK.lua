-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

return {
    featureName = require(TrustedContactsParent.SharedFlags).FStringCanAccessTrustedContactsAmpFeature,
    nameSpace = require(TrustedContactsParent.SharedFlags).FStringCanAccessTrustedContactsAmpNameSpace
}
