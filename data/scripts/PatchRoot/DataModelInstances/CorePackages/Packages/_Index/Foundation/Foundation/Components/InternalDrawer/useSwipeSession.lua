-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local React = require(FoundationParent.React)

local gestureInput = require(script.Parent.gestureInput)

local function useSwipeSession(current, func1: (...any) -> (...any), tbl1, bool1: boolean)
    local var1 = React.useRef(current)
    var1.current = current
    local var2 = React.useState(function()
        return func1(var1)
    end)

    React.useEffect(function()
        if not bool1 then
            return
        end

        local var3 = gestureInput.connectPointer({
            onBegan = function(arg1)
                return tbl1.onInputBegan(var2, arg1)
            end,
            onChanged = function(arg1)
                tbl1.onInputChanged(var2, arg1)
            end,
            onEnded = function(arg1)
                return tbl1.onInputEnded(var2, arg1)
            end
        })

        return function()
            var3()
            tbl1.reset(var2)
        end
    end, { bool1 })
end

return useSwipeSession
