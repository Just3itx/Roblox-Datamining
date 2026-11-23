-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdGuiInteractivity = script:FindFirstAncestor("AdGuiInteractivity")

local guiPositionToScreenPosition = require(AdGuiInteractivity.guiPositionToScreenPosition)

return function(arg1, arg2)
    local currentCamera = game.Workspace.CurrentCamera
    if not currentCamera then
        return Vector2.zero
    end

    local layerCollector = arg1:FindFirstAncestorWhichIsA("LayerCollector")
    local var1 = currentCamera.ViewportSize / 2
    if not layerCollector then
        return var1
    end

    local vector2 = Vector2.new(arg2.Position.X, arg2.Position.Y)
    if vector2 == Vector2.zero then
        vector2 = arg1.AbsolutePosition + arg1.AbsoluteSize / 2
    end

    return guiPositionToScreenPosition(layerCollector, vector2, currentCamera) or var1
end
