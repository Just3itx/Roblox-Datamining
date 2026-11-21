-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local _Signals = require(ChatUIPrimitivesParent.Signals)

local Sizing = require(script.Parent.Parent.Sizing)
local _groupMessages = require(script.Parent.groupMessages)

local Context = React.createContext(nil)

return {
    Context = Context,
    Component = function(_) -- name: HeaderItem
        local header = React.useContext(Context)
        local var2 = Sizing.useSizing()
        local tag = Foundation.Hooks.useDefaultTags(var2.row.tag, "size-full-0 auto-y")
        return React.createElement(Foundation.View, { tag = tag, testId = "message-list-header" }, { Header = header })
    end
}
