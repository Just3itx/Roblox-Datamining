-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local _ScreenRegion = require(script.Parent.ScreenRegion)
local _ScreenRegionKind = require(script.Parent.ScreenRegionKind)
local ScreenRegionContext = require(script.Parent.ScreenRegionProvider).ScreenRegionContext

local num1 = 0

local tbl1 = { isVisible = false, isDismissed = false }

local function useRegionEntry(arg1, arg2)
    local var1 = React.useContext(ScreenRegionContext)
    local var2 = React.useMemo(function(): number
        num1 += 1
        return num1
    end, {})
    local var3, var4 = React.useState(tbl1)

    React.useLayoutEffect(function()
        if var1 == nil or arg1 == nil then
            return nil
        end
        var1.register(arg1, var2, arg2.kind, var4)
        return function()
            var1.unregister(arg1, var2)
        end
    end, {
        var1,
        arg1,
        var2,
        arg2.kind
    })

    React.useLayoutEffect(function()
        if var1 == nil or arg1 == nil then
            return
        end

        var1.update(
            arg1,
            var2,
            {
                isOpen = arg2.isOpen,
                isMounted = arg2.isMounted,
                claimKey = arg2.claimKey,
                priority = arg2.priority
            }
        )
    end, {
        var1,
        arg1,
        var2,
        arg2.kind,
        arg2.isOpen,
        arg2.isMounted,
        arg2.claimKey,
        arg2.priority
    })

    return if var1 == nil or arg1 == nil then {
        isVisible = arg2.isOpen,
        isDismissed = false
    } else var3
end

return useRegionEntry
