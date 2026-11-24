-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("LuaAppEnableDataModelStreamForConsoles", false)

local function getDataModelStreamAllowedHosts()
    local tbl1 = { "ws://localhost:5051", "ws://10.0.2.2:5051" }

    if game:GetFastFlag("LuaAppEnableDataModelStreamForConsoles") then
        table.insert(tbl1, "ws://10.110.101.185:5051")
    end

    return tbl1
end

return getDataModelStreamAllowedHosts
