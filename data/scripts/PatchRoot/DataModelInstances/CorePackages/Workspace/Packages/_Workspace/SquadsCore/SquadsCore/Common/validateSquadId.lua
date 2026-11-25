-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent
local var1 = require(SquadsCoreParent.RegExp)("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")

local function validateSquadId(str1: string): boolean
    return not not (str1 and str1 ~= "" and var1:exec(str1))
end

return validateSquadId
