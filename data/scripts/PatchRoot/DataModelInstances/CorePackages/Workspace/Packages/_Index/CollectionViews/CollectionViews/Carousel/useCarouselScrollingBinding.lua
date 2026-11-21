-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local CollectionViewsParent = script:FindFirstAncestor("CollectionViews").Parent
local React = require(CollectionViewsParent.React)

local function useCarouselScrollingBinding(tbl1, bool1: boolean)
    local var1, var2 = React.useBinding(false)

    React.useEffect(function()
        local current = tbl1.current
        if not (bool1 and current) then
            return nil
        end

        assert(current, "scrollingFrame must exist")
        local num1 = 0
        local connection = nil

        local connection2 = current:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            num1 = os.clock() + 0.01
            if connection then
                return
            end

            var2(true)
            connection = RunService.Heartbeat:Connect(function()
                if not (os.clock() >= num1) then
                    return
                end

                var2(false)
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
            end)
        end)

        return function()
            connection2:Disconnect()
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl1 })

    return var1
end

return useCarouselScrollingBinding
