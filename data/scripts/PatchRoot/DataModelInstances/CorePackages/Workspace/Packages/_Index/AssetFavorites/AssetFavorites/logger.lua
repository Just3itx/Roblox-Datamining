-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetFavorites = script:FindFirstAncestor("AssetFavorites")

local var1 = require(AssetFavorites.Parent.Lumberyak).Logger.new(nil, "AssetFavorites")

local success, result = pcall(function()
    return {
        level = game:DefineFastString("DebugLuaLogLevel", ""),
        pattern = game:DefineFastString("DebugLuaLogPattern", "")
    }
end)

result = not success and { level = "debug", pattern = "" } or result

var1:setContext({ prefix = "[{loggerName} - {level}] - " })
var1:addSink({
    maxLevel = var1.Levels.fromString(result.level),
    log = function(_, arg1, _)
        if arg1:match(result.pattern) then
            print(arg1)
        end
    end
})

return var1
