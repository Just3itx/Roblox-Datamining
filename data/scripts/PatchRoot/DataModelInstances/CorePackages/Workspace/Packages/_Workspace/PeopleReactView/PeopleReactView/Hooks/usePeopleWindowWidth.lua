-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local React = require(PeopleReactViewParent.React)

local function usePeopleWindowWidth()
    local var1, var2 = React.useState(0)
    local var3 = React.useRef(nil)

    return var1, (React.useCallback(function(arg1)
        if var3.current then
            var3.current()
            var3.current = nil
        end
        if not arg1 then
            return
        end

        local connection = nil
        local function track()
            if connection then
                connection:Disconnect()
            end
            local var4 = arg1:FindFirstAncestorWhichIsA("ScrollingFrame") or arg1
            var2(var4.AbsoluteSize.X)
            connection = var4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var2(var4.AbsoluteSize.X)
            end)
        end

        track()

        local connection2 = arg1.AncestryChanged:Connect(track)

        function var3.current()
            connection2:Disconnect()
            if connection then
                connection:Disconnect()
            end
        end
    end, {}))
end

return usePeopleWindowWidth
