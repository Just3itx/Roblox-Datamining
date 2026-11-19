-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local pageLogger = require(script.Parent.pageLogger)
local component = require(script.Parent.component)

return {
    init = function(arg1)
        pageLogger:setParent(arg1)
    end,
    doSomething = function()
        pageLogger:info("calling {root} {foo}")
        return component()
    end
}
