-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.Types)

local getCaptureObject = require(scriptParentParent.Utils.getCaptureObject)

local function findCaptureIndex(tbl1, arg1, filePath: string?)
    local localId = arg1.LocalId

    for value, value2 in tbl1 do
        if filePath and typeof(value2) == "table" and value2.filePath == filePath then
            return value
        end

        local captureObject = getCaptureObject(value2)
        if localId and captureObject and captureObject.LocalId == localId then
            return value
        end
    end

    return nil
end

return findCaptureIndex
