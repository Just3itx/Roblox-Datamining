-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
local Observable = require(script.Parent.Parent.Parent.utilities).Observable

function module.fromError(arg1)
    return Observable.new(function(arg2)
        arg2:error(arg1)
    end)
end

return module
