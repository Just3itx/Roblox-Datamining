-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:00:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)
local _StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local usePlugin = require(Foundation.Providers.Plugin.usePlugin)

local WidgetManager = require(script.Parent.WidgetManager)
local WidgetsContext = require(script.Parent.WidgetsContext)

local _Types = require(script.Parent.Types)

local function WidgetsProvider(tbl1)
    local var1 = usePlugin()
    if var1 == nil then
        error("WidgetsProvider must be used within a Plugin context")
    end

    local var2 = React.useMemo(function()
        return WidgetManager.new(var1:GetPluginComponent("Widgets"))
    end, { var1 })

    React.useEffect(function()
        return function()
            var2:destroy()
        end
    end, { var2 })

    local register = React.useCallback(function(arg1, arg2)
        var2:register(arg1, arg2)
    end, { var2 })

    local deregister = React.useCallback(function(arg1, arg2)
        var2:deregister(arg1, arg2)
    end, { var2 })

    local var5 = if Flags.FoundationPopoverPluginAnchorRefresh then React.useCallback(function(arg1)
        return var2:refreshAsync(arg1)
    end, { var2 }) else nil

    local nextId = React.useCallback(function()
        return var2:nextId()
    end, { var2 })

    local value = React.useMemo(function()
        return {
            register = register,
            deregister = deregister,
            refreshAsync = if Flags.FoundationPopoverPluginAnchorRefresh then var5 else nil,
            nextId = nextId
        }
    end, {
        register,
        deregister,
        var5,
        nextId
    })
    return React.createElement(WidgetsContext.Provider, { value = value }, tbl1.children)
end

return WidgetsProvider
