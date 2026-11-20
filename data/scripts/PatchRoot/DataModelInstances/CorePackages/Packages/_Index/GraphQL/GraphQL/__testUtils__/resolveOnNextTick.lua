-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Promise = require(script.Parent.Parent.Parent.Promise)

return function()
    return Promise.defer(function(callback)
        callback(nil)
    end)
end
