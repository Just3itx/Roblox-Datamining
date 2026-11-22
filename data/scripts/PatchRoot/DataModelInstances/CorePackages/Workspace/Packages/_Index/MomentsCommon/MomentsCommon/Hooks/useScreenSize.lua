-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)

return function()
    local var1, var2 = React.useState(function(): Vector2
        local currentCamera = workspace.CurrentCamera
        if currentCamera then
            return currentCamera.ViewportSize
        end

        return Vector2.new(math.huge, math.huge)
    end)
    local var3, var4 = React.useState(workspace.CurrentCamera)

    React.useEffect(function()
        local currentCamera = workspace.CurrentCamera
        if currentCamera then
            var2(currentCamera.ViewportSize)
        end

        local connection = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
            var4(workspace.CurrentCamera)
        end)

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
