-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local React = require(AccountUpgradeParent.React)

local function useTextFieldValue(str1: string?, callback: (...any) -> (...any))
    local value, var2 = React.useState(str1 or "")
    local valueRef = React.useRef(value)

    return {
        value = value,
        valueRef = valueRef,
        onChanged = React.useCallback(function(current: string)
            valueRef.current = current
            var2(current)
            callback(current)
        end, { callback })
    }
end

return useTextFieldValue
