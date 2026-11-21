-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Responsive = require(AvatarExperienceProfilePictureEditorParent.Responsive)
local CameraMath = require(AvatarExperienceProfilePictureEditorParent.AvatarViewport).CameraMath

local yRotDegFromSliderValue = CameraMath.getYRotDegFromSliderValue(1)

local function useRotatableAvatarPreviewViewModel(tbl1)
    local var1 = Responsive.useLastInput()

    return {
        showCameraControlBar = not tbl1.isDisabled and var1 ~= Responsive.Input.Touch,
        onZoomIn = React.useCallback(function()
            tbl1.onDistanceScaleChanged(CameraMath.adjustDistanceScaleBySliderStep(tbl1.distanceScale, 1))
        end, { tbl1.distanceScale, tbl1.onDistanceScaleChanged }),
        onZoomOut = React.useCallback(function()
            tbl1.onDistanceScaleChanged(CameraMath.adjustDistanceScaleBySliderStep(tbl1.distanceScale, -1))
        end, { tbl1.distanceScale, tbl1.onDistanceScaleChanged }),
        onRotateLeft = React.useCallback(function()
            tbl1.onYRotDegChanged(CameraMath.clampYRotDeg(tbl1.committedYRotDeg + yRotDegFromSliderValue))
        end, { tbl1.committedYRotDeg, tbl1.onYRotDegChanged }),
        onRotateRight = React.useCallback(function()
            tbl1.onYRotDegChanged(CameraMath.clampYRotDeg(tbl1.committedYRotDeg - yRotDegFromSliderValue))
        end, { tbl1.committedYRotDeg, tbl1.onYRotDegChanged })
    }
end

return useRotatableAvatarPreviewViewModel
