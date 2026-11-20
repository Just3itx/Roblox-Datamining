-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)
local useContext = React.useContext

local PluginContext = require(script.Parent.PluginContext)
local isPluginElevated = require(script.Parent.isPluginElevated)

local function usePlugin()
    local var1 = useContext(PluginContext)
    if var1 and var1 ~= React.None then
        return var1, isPluginElevated(var1)
    end
    return nil, false
end

return usePlugin
