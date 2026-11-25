-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

local function useViewportSize()
    local currentCamera = workspace.CurrentCamera
    local vector2 = if currentCamera then currentCamera.ViewportSize else Vector2.new(1280, 720)
    local var1, var2 = React.useState(vector2)

    React.useEffect(function()
        local currentCamera2 = workspace.CurrentCamera
        if not currentCamera2 then
            return function() end
        end
        var2(currentCamera2.ViewportSize)
        local connection = currentCamera2:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            var2(currentCamera2.ViewportSize)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    return var1
end

return useViewportSize
