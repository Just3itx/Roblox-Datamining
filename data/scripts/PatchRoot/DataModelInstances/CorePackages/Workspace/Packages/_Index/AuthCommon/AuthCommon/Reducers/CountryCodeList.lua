-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local SetCountryCodeList = require(AuthCommon.Actions.SetCountryCodeList)

return function(tbl1, arg1)
    tbl1 = tbl1 or {}
    assert(tbl1, "")

    if arg1.type == SetCountryCodeList.name then
        tbl1 = arg1.countryCodeList
    end

    return tbl1
end
