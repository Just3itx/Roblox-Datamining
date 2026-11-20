-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local React = require(MomentsCreationFlowParent.React)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useState = React.useState

local function useAutoDismissState(bool1: boolean?, num1: number?)
    local var1 = useRef(nil)
    local var2, var3 = useState(bool1 or true)

    local var4 = useCallback(function()
        if var1.current then
            task.cancel(var1.current)
        end

        var3(true)
        var1.current = task.delay(num1 or 5, function()
            var3(false)
        end)
    end, { num1, var2 })

    useEffect(function()
        var4()

        return function()
            if var1.current then
                task.cancel(var1.current)
                var1.current = nil
            end
        end
    end, { num1 })

    return var2, var4
end

return useAutoDismissState
