-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local MomentUnavailableItem = require(script.MomentUnavailableItem)

return {{
    kind = "unavailableMoment",
    getKey = function(arg1)
        return "__unavailable_moment__:" .. arg1.targetId
    end,
    getAttribution = function(_)
        return nil
    end,
    render = function(arg1, _: number)
        return React.createElement(MomentUnavailableItem, { isModerated = arg1.isModerated })
    end
}}
