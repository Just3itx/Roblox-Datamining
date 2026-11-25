-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent
local tutils = require(SduiCoreSystemParent.tutils)

local function hasCycle(tbl1, tbl2)
    tbl2 = tbl2 == nil and {} or tbl2

    assert(tbl2, "seenNodes must exist")

    for _, value in tbl1 do
        if typeof(value) ~= "table" then
            continue
        end

        if tbl2[value] then
            return true
        end

        tbl2[value] = true
        if hasCycle(value, tbl2) then
            return true
        end
    end

    return false
end

return {
    hasCycle = hasCycle,
    stringifyValue = function(arg1)
        if typeof(arg1) == "table" then
            if hasCycle(arg1) then
                return "table-with-cycle"
            end
            return tutils.toString(arg1)
        end
        return tutils.toString(arg1)
    end
}
