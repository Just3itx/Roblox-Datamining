-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfersParent = script:FindFirstAncestor("CurrencyTransfers").Parent

local React = require(CurrencyTransfersParent.React)

local function useAutoFocusTextBoxOnMount(callback: ((...any) -> (...any))?, num1: number?)
    local var1 = React.useRef(false)

    return React.useCallback(function(arg1)
        if callback then
            callback(arg1)
        end

        if not arg1 or var1.current then
            return
        end

        var1.current = true
        task.spawn(function()
            task.wait(num1 or 0.05)
            if arg1 and arg1.Parent then
                arg1:CaptureFocus()
            end
        end)
    end, { callback, num1 })
end

return useAutoFocusTextBoxOnMount
