-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent

local tbl1 = ({})

for value, value2 in (require(scriptParent.Images)) do
    tbl1[value2] = value
end

return tbl1
