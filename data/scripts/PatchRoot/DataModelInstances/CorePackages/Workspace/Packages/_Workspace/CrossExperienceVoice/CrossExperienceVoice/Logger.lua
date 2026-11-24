-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")

local var1 = require(CrossExperienceVoice.dependencies).Lumberyak.Logger.new(nil, "CrossExperienceVoice")

var1:addSink({
    maxLevel = var1.Levels.Info,
    log = function(_, arg1, _)
        print(arg1)
    end
})

return var1
