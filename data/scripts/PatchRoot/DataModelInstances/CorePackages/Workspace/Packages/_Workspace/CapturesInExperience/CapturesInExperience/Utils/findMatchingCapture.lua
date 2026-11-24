-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.Types)

local function getLocalId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 and arg1.LocalId then arg1.LocalId else nil
end

local function findMatchingCapture(tbl1, arg1)
    local localId = getLocalId(arg1)

    if localId == nil then
        return nil
    end

    for _, value in tbl1 do
        if value.LocalId == localId then
            return value
        end

        if value.videoCapture and getLocalId(value.videoCapture) == localId then
            return value.videoCapture
        end
    end

    return nil
end

return findMatchingCapture
