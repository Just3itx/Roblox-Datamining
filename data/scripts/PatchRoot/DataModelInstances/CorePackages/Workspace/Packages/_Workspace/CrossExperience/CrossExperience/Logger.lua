-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:21:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")

local Lumberyak = require(CrossExperience.dependencies).Lumberyak

local logger = Lumberyak.Logger.new(nil, "CrossExperience")

logger:addSink({
    maxLevel = game:DefineFastString("CrossExpEventLoggingLevel", Lumberyak.Logger.Levels.Error),
    log = function(_, arg1, _)
        print(arg1)
    end
})

return logger
