-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:00:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)
local _StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local usePlugin = require(Foundation.Providers.Plugin.usePlugin)
local useWidgetsContext = require(Foundation.Providers.StudioWidgets.useWidgetsContext)

local PanelsContext = require(script.Parent.PanelsContext)
local PopoverManager = require(script.Parent.Managers.PopoverManager)

local _Types = require(script.Parent.Types)

local function PanelsProvider(tbl1)
    local var1 = usePlugin()
    if var1 == nil then
        error("PanelsProvider must be used within a plugin context")
    end

    local var2 = if Flags.FoundationPopoverPluginAnchorRefresh then useWidgetsContext() else nil

    local var3 = React.useMemo(function()
        return PopoverManager.new(var1, tbl1.uriScope)
    end, { var1, tbl1.uriScope })

    React.useEffect(function()
        local var4 = task.spawn(function()
            var3:prewarmPoolAsync(2)
        end)

        return function()
            if var4 then
                task.cancel(var4)
            end

            var3:destroy()
        end
    end, { var3 })

    local registerPopoverAsync = React.useCallback(function(targetWidgetUri, arg1, func1: (...any) -> (...any), num1: number?, str1: string?, bool1: boolean?)
        if Flags.FoundationPopoverPluginAnchorRefresh then
            var2.refreshAsync(targetWidgetUri)
        end
        local var4 = var3
        local tbl2 = {
            targetWidgetUri = targetWidgetUri,
            targetAnchorPoint = arg1.targetAnchorPoint,
            subjectAnchorPoint = arg1.subjectAnchorPoint,
            offset = arg1.offset
        }

        if not Flags.FoundationPopoverPluginFocusable then
            bool1 = nil
        end

        local var5 = var4:openAtAsync(tbl2, func1, num1, str1, bool1)

        return var5, function()
            var5.close()
        end
    end, { var3, var2 })

    local value = React.useMemo(function()
        return { registerPopoverAsync = registerPopoverAsync }
    end, { registerPopoverAsync })

    return React.createElement(PanelsContext.Provider, { value = value }, tbl1.children)
end

return PanelsProvider
