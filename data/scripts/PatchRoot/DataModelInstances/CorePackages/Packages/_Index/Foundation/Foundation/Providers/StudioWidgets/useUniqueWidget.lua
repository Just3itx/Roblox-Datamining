-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:00:50Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local usePlugin = require(Foundation.Providers.Plugin.usePlugin)
local useWidgetRef = require(script.Parent.useWidgetRef)
local useWidgetsContext = require(script.Parent.useWidgetsContext)

local function useUniqueWidget(tbl1)
    local var1 = usePlugin()
    if var1 == nil then
        error("useUniqueWidget must be used within a Plugin context")
    end

    local var2 = useWidgetsContext()
    local var3 = React.useMemo(function()
        return StudioUri.wrap(var1:GetUri())
    end, { var1 })

    local var4 = React.useRef(nil)
    if var4.current == nil then
        if tbl1 and tbl1.id then
            var4.current = tbl1.id
        else
            var4.current = var2.nextId()
        end
    end

    local uri = React.useMemo(function()
        return StudioUri.join(var3, { Category = "Actions", ItemId = var4.current })
    end, { var3, var4.current })

    return {
        ref = useWidgetRef(uri, tbl1 and tbl1.forwardRef),
        uri = uri
    }
end

return useUniqueWidget
