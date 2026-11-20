-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local useScreen = require(Foundation.Providers.Overlay.useScreen)

local function useScreenHeight()
    local var1 = useScreen()
    local var2, var3 = React.useState(var1 and var1.AbsoluteSize.Y or 0)

    React.useLayoutEffect(function()
        local connection = nil

        if var1 then
            var3(var1.AbsoluteSize.Y)
            connection = var1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var3(var1.AbsoluteSize.Y)
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { var1 })

    return var2
end

return useScreenHeight
