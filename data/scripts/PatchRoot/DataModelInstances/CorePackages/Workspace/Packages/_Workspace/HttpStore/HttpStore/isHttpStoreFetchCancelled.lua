-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local HttpResponseStatus = require(scriptParentParent.InternalHttpStore).HttpResponseStatus

local function isHttpStoreFetchCancelled(arg1): boolean
    if arg1.status ~= HttpResponseStatus.Failed then
        return false
    end
    if arg1.cancelled == true then
        return true
    end
    local response = arg1.response
    return not not (response and response.HttpError == Enum.HttpError.Aborted)
end

return isHttpStoreFetchCancelled
