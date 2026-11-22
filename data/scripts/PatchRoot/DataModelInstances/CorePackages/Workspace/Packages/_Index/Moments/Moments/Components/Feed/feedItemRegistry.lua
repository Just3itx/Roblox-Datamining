-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _FeedTypes = require(script.Parent.FeedTypes)

local Moment = require(script.Parent.Items.Moment)
local EndState = require(script.Parent.Items.EndState)
local CaughtUp = require(script.Parent.Items.CaughtUp)
local UnavailableMoment = require(script.Parent.Items.UnavailableMoment)
local FFlagMomentsRenderAvatarPostsInFeed = require(MomentsParent.SharedFlags).FFlagMomentsRenderAvatarPostsInFeed

local tbl1 = {}

local function register(tbl2) -- Luacid: Inlined by compiler; 5 call sites recovered
    for _, value in tbl2 do
        tbl1[value.kind] = value
    end
end

register(Moment)
register(EndState)
register(CaughtUp)
register(UnavailableMoment)

if FFlagMomentsRenderAvatarPostsInFeed then
    register((require(script.Parent.Items.AvatarMoment)))
end

return tbl1
