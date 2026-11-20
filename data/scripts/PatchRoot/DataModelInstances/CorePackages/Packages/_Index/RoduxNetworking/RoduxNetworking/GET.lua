-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local makeRequestApi = require(scriptParent.makeRequestApi)

return function(arg1)
    return makeRequestApi(arg1, "GET")
end
