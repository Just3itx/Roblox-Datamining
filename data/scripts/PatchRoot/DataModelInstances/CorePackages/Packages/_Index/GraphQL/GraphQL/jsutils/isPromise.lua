-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Promise = require(scriptParentParentParent.Promise)

return {
    isPromise = function(arg1)
        return Promise.is(arg1)
    end
}
