-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)

local function useRefImpression(tbl1, callback: (...any) -> (...any))
    local var1 = React.useRef(false)

    local var2 = React.useCallback(function(arg1, arg2)
        if arg1.AbsolutePosition.Y <= arg2.AbsoluteSize.Y then
            var1.current = true
            callback()
        end
    end, { callback })

    React.useEffect(function()
        if var1.current then
            return
        end

        local current = tbl1.current
        local connection = nil

        if current then
            local screenGui = current:FindFirstAncestorWhichIsA("ScreenGui")

            if screenGui then
                var2(current, screenGui)

                connection = current:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                    if var1.current then
                        return
                    end

                    var2(current, screenGui)
                end)
            end
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end)
end

return useRefImpression
