-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ReactionSize = require(script.Parent.Enums.ReactionSize)
local ReactionType = require(script.Parent.Enums.ReactionType)

local tbl1 = {
    [ReactionType.ThumbsUp] = "reactions/thumbsUp",
    [ReactionType.Heart] = "reactions/heart",
    [ReactionType.LaughJoy] = "reactions/laughJoy",
    [ReactionType.Wow] = "reactions/wow",
    [ReactionType.Cry] = "reactions/crying",
    [ReactionType.Fire] = "reactions/fire",
    [ReactionType.Skull] = "reactions/skull"
}

local tbl2 = {
    [ReactionType.ThumbsUp] = "rbxassetid://102151092753275",
    [ReactionType.Heart] = "rbxassetid://105415768176243",
    [ReactionType.LaughJoy] = "rbxassetid://121361760010558",
    [ReactionType.Wow] = "rbxassetid://76233345530268",
    [ReactionType.Cry] = "rbxassetid://97649651487628",
    [ReactionType.Fire] = "rbxassetid://120385289308805",
    [ReactionType.Skull] = "rbxassetid://122831007756738"
}
local bool1 = table.find({ 6010436773, 6010515967 }, game.GameId) ~= nil

local tbl3 = {
    ReactionSize = ReactionSize,
    PossibleReactions = {
        ReactionType.ThumbsUp,
        ReactionType.Heart,
        ReactionType.Fire,
        ReactionType.LaughJoy,
        ReactionType.Wow,
        ReactionType.Cry,
        ReactionType.Skull
    },
    ReactionIconMappings = 0,
    EaseInOut = 0,
    EaseInCubic = 0
}

if not bool1 then
    tbl2 = tbl1
end

tbl3.ReactionIconMappings = tbl2

tbl3.EaseInOut = {
    0.19,
    1,
    0.22,
    1
}
tbl3.EaseInCubic = {
    0.3,
    0,
    0.7,
    0
}

return tbl3
