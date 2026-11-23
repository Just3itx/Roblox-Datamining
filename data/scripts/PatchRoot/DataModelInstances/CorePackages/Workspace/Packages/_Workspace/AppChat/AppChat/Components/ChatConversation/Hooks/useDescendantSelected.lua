-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local function isSelectionWithin(arg1, bool1: boolean, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return bool1 or arg2 ~= nil and arg2:IsDescendantOf(arg1)
end

return {
    useDescendantSelected = function()
        local var1, var2 = React.useState(nil)
        local var3, var4 = React.useState(false)
        local var5 = React.useCallback(function(arg1)
            var2(arg1)
        end, {})

        React.useEffect(function()
            var4(false)
            if not var1 then
                return
            end

            local connection = var1.SelectionChanged:Connect(function(bool1: boolean, _, arg1)
                var4((isSelectionWithin(var1, bool1, arg1)))
            end)

            return function()
                connection:Disconnect()
            end
        end, { var1 })

        return var3, var5
    end
}
