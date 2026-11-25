-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new(tbl1)
    local module2 = {}

    local tbl2 = tbl1 or {}

    function module2.getLayerData(arg1)
        return tbl2[arg1]
    end

    function module2.logUserLayerExposure(arg1)
        return tbl2[arg1]
    end

    return module2
end

return module
