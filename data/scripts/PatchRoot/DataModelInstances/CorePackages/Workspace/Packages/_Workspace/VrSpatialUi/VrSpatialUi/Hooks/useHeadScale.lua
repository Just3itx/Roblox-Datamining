-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrSpatialUi = script:FindFirstAncestor("VrSpatialUi")
local VrSpatialUiParent = VrSpatialUi.Parent
local React = require(VrSpatialUiParent.React)
local UIManager = require(VrSpatialUi.UIManager)
local InExperienceUIVRIXP = require(VrSpatialUiParent.SharedExperimentDefinition).InExperienceUIVRIXP

local function checkAndScalePart(vector2: Vector2, vector2_2: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local additionalCameraScaleIfNeeded = UIManager.getInstance():getAdditionalCameraScaleIfNeeded()
    if vector2 and vector2.current then
        local current = vector2.current
        current.Size = Vector3.new(
            vector2_2.X * additionalCameraScaleIfNeeded,
            vector2_2.Y * additionalCameraScaleIfNeeded,
            vector2.current.Size.Z
        )
    end
end

local function useHeadScale(vector2: Vector2, vector2_2: Vector2)
    local var1, var2 = React.useState(function()
        return UIManager.getInstance():getAdditionalCameraScaleIfNeeded()
    end)
    React.useEffect(function()
        if InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then
            checkAndScalePart(vector2, vector2_2)
        else
            var2(UIManager.getInstance():getAdditionalCameraScaleIfNeeded())
        end
        local connection = workspace.CurrentCamera:GetPropertyChangedSignal("HeadScale"):Connect(function()
            if InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() then
                checkAndScalePart(vector2, vector2_2)

                return
            end

            var2(UIManager.getInstance():getAdditionalCameraScaleIfNeeded())
        end)

        return function()
            connection:Disconnect()
        end
    end, InExperienceUIVRIXP:isSpatialUIScalingFixEnabled() and { vector2, vector2_2 } or {})
    return var1, var2
end

return useHeadScale
