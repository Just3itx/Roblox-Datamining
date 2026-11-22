-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)

local UserInputService = game:GetService("UserInputService")

local useEffect = React.useEffect
local useState = React.useState

local function useIsMultiTouchActive(bool1: boolean)
    local var1, var2 = useState(false)

    useEffect(function()
        if not bool1 then
            var2(false)
            return nil
        end

        local tbl1 = ({})
        local function refreshFromActiveTouches() -- Luacid: Inlined by compiler; 2 call sites recovered
            local num1 = 0
            for _ in tbl1 do
                num1 += 1
            end
            var2(num1 >= 2)
        end

        local connection = UserInputService.TouchStarted:Connect(function(touch: InputObject)
            tbl1[touch] = true
            refreshFromActiveTouches()
        end)

        local connection2 = UserInputService.TouchEnded:Connect(function(touch: InputObject)
            tbl1[touch] = nil
            refreshFromActiveTouches()
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { bool1 })

    return var1
end

return useIsMultiTouchActive
