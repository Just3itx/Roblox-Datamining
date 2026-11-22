-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local function useVisibleContentHeight(arg1, arg2)
    local var1, var2 = React.useBinding(0)

    React.useEffect(function()
        local current = arg1.current
        if current == nil then
            return
        end

        local function update()
            local absolutePositionY = current.AbsolutePosition.Y
            local minY = absolutePositionY + current.AbsoluteWindowSize.Y
            if arg2 ~= nil then
                minY = math.min(minY, arg2.AbsolutePosition.Y)
            end
            var2(math.max(0, minY - absolutePositionY))
        end

        local absolutePositionY = current.AbsolutePosition.Y
        local minY = absolutePositionY + current.AbsoluteWindowSize.Y
        if arg2 ~= nil then
            minY = math.min(minY, arg2.AbsolutePosition.Y)
        end
        var2(math.max(0, minY - absolutePositionY))

        local tbl1 = { current:GetPropertyChangedSignal("AbsolutePosition"):Connect(update), current:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(update) }

        if arg2 ~= nil then
            local absolutePositionChanged = arg2:GetPropertyChangedSignal("AbsolutePosition")
            table.insert(tbl1, absolutePositionChanged:Connect(update))
        end
        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, { arg1, arg2 })

    return var1
end

return useVisibleContentHeight
