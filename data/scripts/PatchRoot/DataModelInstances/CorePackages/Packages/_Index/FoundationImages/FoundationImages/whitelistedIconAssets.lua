-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local Flags = require(scriptParent.Flags)

local tbl1 = ({})

for _, value in string.split(Flags.FoundationImagesWhitelistedIconAssets, ",") do
    tbl1[value] = true
end

return tbl1
