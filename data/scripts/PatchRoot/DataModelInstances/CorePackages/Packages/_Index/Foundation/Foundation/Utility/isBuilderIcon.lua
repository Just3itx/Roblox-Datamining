-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

return require(FoundationParent.Dash).memoize(function(str1: string?): boolean -- name: isBuilderIcon
    return not (str1 == nil or str1 == "") and str1:find("[^%l%d%-]") == nil
end)
