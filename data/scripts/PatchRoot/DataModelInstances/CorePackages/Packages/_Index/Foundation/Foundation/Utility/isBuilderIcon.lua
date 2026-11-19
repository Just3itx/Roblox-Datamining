-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:20:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

return require(FoundationParent.Dash).memoize(function(str1: string?): boolean -- name: isBuilderIcon
    return not (str1 == nil or str1 == "") and str1:find("[^%l%d%-]") == nil
end)
