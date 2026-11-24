-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)

return function()
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3, var4 = React.useState(workspace.CurrentCamera)

    React.useEffect(function()
        local connection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
            var4(workspace.CurrentCamera)
        end)

        var4(workspace.CurrentCamera)

        return function()
            connection:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if not var3 then
            return
        end

        var2(var3.ViewportSize)
        local connection = var3:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            var2(var3.ViewportSize)
        end)

        return function()
            connection:Disconnect()
        end
    end, { var3 })

    return var1
end
