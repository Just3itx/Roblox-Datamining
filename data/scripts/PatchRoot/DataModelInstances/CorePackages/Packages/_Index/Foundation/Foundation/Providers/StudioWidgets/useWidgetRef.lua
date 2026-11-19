-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:00:51Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local useEffect = React.useEffect
local useRef = React.useRef

local StudioUri = require(Foundation.Utility.Plugin.StudioUri)

local useWidgetsContext = require(script.Parent.useWidgetsContext)

local function useWidgetRef(arg1, arg2)
    local var1 = useWidgetsContext()
    local var2 = useRef(nil)
    local var3 = arg2 or var2

    local var4 = StudioUri.toString(arg1)

    useEffect(function()
        local current = var3.current
        if not current then
            return
        end

        if not arg1 or typeof(current) ~= "Instance" then
            return nil
        end

        var1.register(arg1, current)
        return function()
            var1.deregister(arg1, current)
        end
    end, {
        var4,
        var3.current,
        arg1,
        var1.register,
        var1.deregister
    })
    return var3
end

return useWidgetRef
