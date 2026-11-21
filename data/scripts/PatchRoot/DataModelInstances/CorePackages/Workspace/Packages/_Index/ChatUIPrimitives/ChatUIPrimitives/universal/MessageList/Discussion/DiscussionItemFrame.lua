-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local Sizing = require(script.Parent.Parent.Parent.Sizing)

local function DiscussionItemFrame(tbl1)
    local frameTag = Sizing.useSizing().discussion.frameTag
    return React.createElement(Foundation.View, { tag = frameTag }, tbl1.children)
end

return DiscussionItemFrame
