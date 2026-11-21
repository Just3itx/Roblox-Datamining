-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameVotesRodux = script:FindFirstAncestor("GameVotesRodux")
local GameVotesRoduxParent = GameVotesRodux.Parent
local Immutable = require(GameVotesRoduxParent.AppCommonLib).Immutable
local SetGameVotes = require(GameVotesRodux.GameVotes.SetGameVotes)

return function(tbl1, arg1)
    tbl1 = tbl1 or {}
    assert(tbl1, "")

    if arg1.type == SetGameVotes.name then
        local tbl2 = {
            upVotes = arg1.upVotes,
            downVotes = arg1.downVotes
        }

        tbl1 = Immutable.Set(tbl1, arg1.universeId, tbl2)
    end

    return tbl1
end
