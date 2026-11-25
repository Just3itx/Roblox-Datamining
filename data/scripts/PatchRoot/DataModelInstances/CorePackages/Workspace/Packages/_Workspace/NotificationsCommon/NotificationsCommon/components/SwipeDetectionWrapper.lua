-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)

return function(tbl1)
    local ref = React.createRef()
    local var1, var2 = React.useState(false)
    React.useEffect(function()
        if not (tbl1.swipeEnabled and tbl1.swipeCallback) then
            var2(false)

            return nil
        end

        local connection = UserInputService.TouchStarted:Connect(function(touch: InputObject)
            local current = ref and ref.current
            if not current then
                return
            end

            local var3 = Vector2.new(touch.Position.X, touch.Position.Y) - current.AbsolutePosition

            if var3.X >= 0 and var3.Y >= 0 and var3.X <= current.AbsoluteSize.X and var3.Y <= current.AbsoluteSize.Y then
                var2(true)
            end
        end)
        local connection2 = UserInputService.TouchEnded:Connect(function()
            var2(false)
        end)

        local connection3 = if var1 then UserInputService.TouchSwipe:Connect(function(swipeDirection: Enum.SwipeDirection)
            if var1 then
                tbl1.swipeCallback(swipeDirection)
            end
        end) else nil

        return function()
            connection:Disconnect()
            connection2:Disconnect()
            if connection3 then
                connection3:Disconnect()
            end
        end
    end, {
        tbl1.swipeEnabled,
        tbl1.swipeCallback,
        ref,
        var1
    })

    return React.createElement(
        "Frame",
        {
            Size = tbl1.Size,
            AutomaticSize = tbl1.AutomaticSize,
            BackgroundTransparency = 1,
            Active = true,
            ref = ref
        },
        tbl1.children
    )
end
