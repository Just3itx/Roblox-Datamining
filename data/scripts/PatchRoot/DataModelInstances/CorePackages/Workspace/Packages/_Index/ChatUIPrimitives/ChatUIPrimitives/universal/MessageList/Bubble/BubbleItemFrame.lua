-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)

local Sizing = require(script.Parent.Parent.Parent.Sizing)

local function BubbleItemFrame(tbl1)
    local var1 = Sizing.useSizing()
    local tag = Foundation.Hooks.useDefaultTags(var1.row.tag, "col size-full-0 auto-y")
    return React.createElement(Foundation.View, { tag = tag }, tbl1.children)
end

return BubbleItemFrame
