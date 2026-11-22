-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local React = require(scriptParentParentParentParent.React)
local useTokens = require(scriptParentParentParentParent.Foundation).Hooks.useTokens

local function useInitialButtonDisableDelay(bool1: boolean?, num1: number?)
    local var1 = useTokens()

    local var2 = num1 or var1.Time.Time_300
    local var3, var4 = React.useState(true)

    React.useEffect(function()
        local bool2 = false

        task.delay(var2, function()
            if not bool2 then
                var4(false)
            end
        end)

        return function()
            bool2 = true
        end
    end, { var2 })

    return bool1 or var3
end

return useInitialButtonDisableDelay
