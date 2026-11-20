-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local React = require(FoundationParent.React)

local PluginContext = require(script.Parent.PluginContext)

local function PluginProvider(tbl1)
    return React.createElement(PluginContext.Provider, { value = tbl1.plugin or React.None }, tbl1.children)
end

return PluginProvider
