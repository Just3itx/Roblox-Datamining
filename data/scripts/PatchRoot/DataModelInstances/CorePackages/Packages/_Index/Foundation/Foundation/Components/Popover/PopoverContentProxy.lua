-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:40:37Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Content = require(script.Parent.Content)
local ContentPlugin = require(script.Parent.ContentPlugin)
local isPluginSecurity = require(Foundation.Utility.isPluginSecurity)
local usePlugin = require(Foundation.Providers.Plugin.usePlugin)

return React.forwardRef(function(arg1, ref) -- name: PopoverContentProxy
    local _, var1 = usePlugin()

    if ref then
        arg1 = table.clone(arg1)
        arg1.ref = ref
    end

    if isPluginSecurity() and var1 then
        return React.createElement(ContentPlugin, arg1)
    end
    return React.createElement(Content, arg1)
end)
