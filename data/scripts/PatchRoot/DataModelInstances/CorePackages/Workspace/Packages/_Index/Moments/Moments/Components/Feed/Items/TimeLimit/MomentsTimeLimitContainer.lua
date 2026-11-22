-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local MomentsTimeLimitView = require(script.Parent.MomentsTimeLimitView)
local useMomentsTimeLimitViewModel = require(script.Parent.useMomentsTimeLimitViewModel)

local function MomentsTimeLimitContainer()
    local var1 = useMomentsTimeLimitViewModel()
    return React.createElement(MomentsTimeLimitView, var1)
end

return MomentsTimeLimitContainer
