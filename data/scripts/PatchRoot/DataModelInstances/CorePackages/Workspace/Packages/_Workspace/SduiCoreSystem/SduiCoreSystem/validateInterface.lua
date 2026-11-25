-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent
local t = require(SduiCoreSystemParent.t)

local function validateInterface(tbl1, tbl2, bool1: boolean?)
    if bool1 == nil then
        bool1 = true
    end

    return (if bool1 then t.interface(tbl2) else t.strictInterface(tbl2))(tbl1)
end

return validateInterface
