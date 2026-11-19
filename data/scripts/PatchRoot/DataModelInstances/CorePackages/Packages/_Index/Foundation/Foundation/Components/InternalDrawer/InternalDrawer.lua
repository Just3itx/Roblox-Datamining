-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local ScrollBarVisibility = require(Foundation.Enums.ScrollBarVisibility)
local withDefaults = require(Foundation.Utility.withDefaults)

local InternalDrawerOverlay = require(script.Parent.InternalDrawerOverlay)
local _Types = require(script.Parent.Types)

local tbl1 = {
    outerBleed = 0,
    scrolls = true,
    scrollBarVisibility = ScrollBarVisibility.None,
    testId = "--foundation-internal-drawer"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: InternalDrawer
    local var1 = withDefaults(arg1, tbl1)
    local var2, var3 = React.useState(var1.isOpen)
    if var1.isOpen and not var2 then
        var3(true)
    end

    local onCloseComplete = var1.onCloseComplete
    local onExited = React.useCallback(function()
        var3(false)
        if onCloseComplete then
            onCloseComplete()
        end
    end, { onCloseComplete })

    if not var2 then
        return nil
    end

    var1.ref = ref
    var1.onExited = onExited

    return React.createElement(InternalDrawerOverlay, var1)
end))
