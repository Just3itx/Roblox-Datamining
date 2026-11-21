-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:19:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
return require(scriptParentParent.dependencies).Rodux.makeActionCreator(script.Name, function<T>(tbl1): T
    assert(
        type(tbl1) == "table",
        string.format("SetIsPhoneVerified action expects params to be a table, was %s", type(tbl1))
    )
    return tbl1
end)
