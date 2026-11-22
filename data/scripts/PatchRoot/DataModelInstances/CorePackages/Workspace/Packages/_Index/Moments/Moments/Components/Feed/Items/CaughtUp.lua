-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local CaughtUpItem = require(script.CaughtUpItem)

return {{
    kind = "caughtUp",
    getKey = function(_): string
        return "__feed_caught_up__"
    end,
    getAttribution = function(_)
        return nil
    end,
    render = function(_, _: number)
        return React.createElement(CaughtUpItem)
    end
}}
