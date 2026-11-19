-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:41:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local function assertEqual(left, right, str1: string?)
    if left ~= right then
        require(scriptParent.Error).new("AssertError", str1 or `Left "{left}" does not equal right "{right}"`):throw(
            { left = left, right = right }
        )
    end
end

return assertEqual
