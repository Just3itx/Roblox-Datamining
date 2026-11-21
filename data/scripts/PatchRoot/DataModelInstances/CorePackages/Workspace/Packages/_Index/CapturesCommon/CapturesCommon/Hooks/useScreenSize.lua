-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

return function()
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3, var4 = React.useState(workspace.CurrentCamera)

    React.useEffect(function()
        local connection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
            var4(workspace.CurrentCamera)
        end)

        if var3 then
            var2(var3.ViewportSize)
        end

        return function()
            connection:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if not var3 then
            return
        end

        local connection = var3:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            if var3 then
                var2(var3.ViewportSize)
            end
        end)

        return function()
            connection:Disconnect()
        end
    end, { var3 })

    return var1
end
