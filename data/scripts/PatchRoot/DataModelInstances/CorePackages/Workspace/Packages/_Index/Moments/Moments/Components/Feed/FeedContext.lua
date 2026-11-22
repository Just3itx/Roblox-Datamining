-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local _Signals = require(MomentsParent.Signals)

local _FeedTypes = require(script.Parent.FeedTypes)

local FeedContext = React.createContext(nil)

return {
    FeedContext = FeedContext,
    useFeed = function()
        local var1 = React.useContext(FeedContext)
        if var1 == nil then
            error("useFeed must be used within a Feed")
        end
        return var1
    end,
    useFeedOptional = function()
        return React.useContext(FeedContext)
    end
}
