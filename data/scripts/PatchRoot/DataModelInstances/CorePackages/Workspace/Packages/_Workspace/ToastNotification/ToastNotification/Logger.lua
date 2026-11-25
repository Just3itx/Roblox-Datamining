-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local Lumberyak = require(scriptParent.dependencies).Lumberyak
local Logger = Lumberyak.Logger

local maxLevel = game:DefineFastString("ToastNotificationEventLoggingLevel", Lumberyak.Logger.Levels.Warning)

local logger = Logger.new(nil, "ToastNotification")

logger:setContext({ prefix = "[ToastNotification] - " })
logger:addSink({
    maxLevel = maxLevel,
    log = function(_, arg1, _)
        print(arg1)
    end
})

return logger
