-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent
local React = require(GameJoinCardParent.React)

local JoinCardBannerVideoView = require(script.Parent.JoinCardBannerVideoView)
local useJoinCardBannerVideoViewModel = require(script.Parent.useJoinCardBannerVideoViewModel)

local function JoinCardBannerVideoContainer(arg1)
    local var1 = useJoinCardBannerVideoViewModel(arg1)
    return React.createElement(JoinCardBannerVideoView, var1)
end

return JoinCardBannerVideoContainer
