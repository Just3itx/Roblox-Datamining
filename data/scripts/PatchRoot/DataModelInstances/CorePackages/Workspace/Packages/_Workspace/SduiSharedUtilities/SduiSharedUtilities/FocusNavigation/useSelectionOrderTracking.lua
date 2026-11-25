-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local React = require(SduiSharedUtilitiesParent.React)

local function useSelectionOrderTracking(tbl1)
    React.useEffect(function()
        local current = tbl1.current
        if not current then
            return
        end

        local num1 = -1
        local connection = current.SelectionChanged:Connect(function(_: boolean, arg1, arg2)
            if arg2 == nil or arg1 == nil or not (arg2:IsDescendantOf(current) and arg1:IsDescendantOf(current)) then
                return
            end
            arg2.SelectionOrder = num1
            num1 -= 1
        end)

        return function()
            connection:Disconnect()
        end
    end, {})
end

return useSelectionOrderTracking
