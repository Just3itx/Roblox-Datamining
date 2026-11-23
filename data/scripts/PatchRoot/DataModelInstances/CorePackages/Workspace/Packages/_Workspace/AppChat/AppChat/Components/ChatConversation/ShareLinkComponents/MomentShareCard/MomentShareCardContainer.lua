-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local MomentShareCardView = require(script.Parent.MomentShareCardView)
local useMomentShareCardViewModel = require(script.Parent.useMomentShareCardViewModel)

local function MomentShareCardContainer(arg1)
    local var1 = useMomentShareCardViewModel(arg1)
    return React.createElement(MomentShareCardView, var1)
end

return MomentShareCardContainer
