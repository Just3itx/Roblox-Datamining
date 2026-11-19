-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local appLogger = require(script.Parent.appLogger)

local page = require(script.Parent.Parent.page.page)
appLogger:addSink(require(script.Parent.PrintSink).new(appLogger.Levels.Error))

return function()
    appLogger:info("calling {root}")
    page.init(appLogger)

    return page.doSomething()
end
