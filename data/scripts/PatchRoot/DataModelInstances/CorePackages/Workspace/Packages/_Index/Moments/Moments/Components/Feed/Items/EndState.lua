-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local MomentsEndStateItem = require(script.MomentsEndStateItem)

return {{
    kind = "endState",
    getKey = function(_): string
        return "__feed_end_state__"
    end,
    getAttribution = function(_)
        return nil
    end,
    render = function(_, _: number)
        return React.createElement(MomentsEndStateItem)
    end
}}
