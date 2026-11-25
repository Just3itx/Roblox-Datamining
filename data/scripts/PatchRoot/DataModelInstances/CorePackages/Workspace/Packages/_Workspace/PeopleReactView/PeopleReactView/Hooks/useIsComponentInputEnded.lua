-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local React = require(PeopleReactViewParent.React)

return function(tbl1)
    local var1, var2 = React.useState(false)

    React.useEffect(function()
        local connection = nil
        local connection2 = nil

        if tbl1.current then
            connection = tbl1.current.InputBegan:Connect(function()
                var2(false)
            end)
            connection2 = tbl1.current.InputEnded:Connect(function()
                var2(true)
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
        end
    end, {})

    return var1
end
