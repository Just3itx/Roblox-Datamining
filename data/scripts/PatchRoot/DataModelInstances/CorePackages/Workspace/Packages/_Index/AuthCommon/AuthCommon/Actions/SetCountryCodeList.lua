-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
return require(AuthCommonParent.Rodux).makeActionCreator(script.Name, function(countryCodeList)
    return { countryCodeList = countryCodeList }
end)
