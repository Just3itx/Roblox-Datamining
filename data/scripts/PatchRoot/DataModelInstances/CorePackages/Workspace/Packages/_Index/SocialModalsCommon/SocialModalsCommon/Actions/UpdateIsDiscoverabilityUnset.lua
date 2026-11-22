-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialModalsCommonParent = script:FindFirstAncestor("SocialModalsCommon").Parent
return require(SocialModalsCommonParent.Rodux).makeActionCreator(script.Name, function<T>(tbl1): T
    assert(
        type(tbl1) == "table",
        string.format("UpdateIsDiscoverabilityUnset action expects params to be a table, was %s", type(tbl1))
    )
    return tbl1
end)
