-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local t = require(GamePlayButtonParent.t)
local mutedError = require(GamePlayButtonParent.Loggers).mutedError

local var1 = t.strictInterface({ placeId = t.string, playButtonState = t.string, universeId = t.string })

return function(arg1, arg2)
    local var2, var3 = var1(arg2)
    if not var2 then
        mutedError(var3)
    end

    arg1.EventStream:setRBXEventStream("GamePlayButton", "shareLinkGameJoin", arg2)

    arg1.Diag:reportCounter("shareLinkGameJoin", 1)
end
