-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSduiParent = script:FindFirstAncestor("GroupPeekSdui").Parent

local HttpRequest = require(GroupPeekSduiParent.HttpRequest)

return HttpRequest.config({
    requestFunction = function(str1: string, str2: string, arg1)
        return HttpRequest.requestFunctions.RequestInternal(str1, str2, arg1)
    end
})
