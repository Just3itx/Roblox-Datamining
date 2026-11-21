-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local ViewRecycler = require(ChatUIPrimitivesParent.ViewRecycler)

return React.memo(function(tbl1) -- name: MessageListView
    return React.createElement(ViewRecycler.VirtualList, tbl1.listProps)
end)
