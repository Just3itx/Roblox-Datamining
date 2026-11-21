-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local CFrameUtility = require(AvatarExperienceProfilePictureEditorParent.Thumbnailing).CFrameUtility
local CameraUtility = require(AvatarExperienceProfilePictureEditorParent.Thumbnailing).CameraUtility
local CharacterUtility = require(AvatarExperienceProfilePictureEditorParent.Thumbnailing).CharacterUtility

local Constants = require(script.Parent.Parent.Constants)
local computeCutoutFieldOfViewDeg = require(script.Parent.computeCutoutFieldOfViewDeg)
local computeFocusAngleAboveCenterRad = require(script.Parent.computeFocusAngleAboveCenterRad)

local function frameCloseupPreviewCamera(tbl1)
    local character = tbl1.character
    local head = character:FindFirstChild("Head")
    if not (head and head:IsA("BasePart")) then
        return nil
    end

    local layout = tbl1.layout
    local cameraFieldOfViewDeg = tbl1.fieldOfViewDeg or Constants.CameraFieldOfViewDeg
    local var2 = tbl1.fieldOfViewForDistanceScaleDeg
        or computeCutoutFieldOfViewDeg({
            viewportHeightPix = layout.viewportHeight,
            cutoutTopOffsetPix = layout.cutoutTopOffset,
            cutoutDiameterPix = layout.cutoutDiameter,
            cameraFieldOfViewDeg = cameraFieldOfViewDeg
        })

    local var3 = computeFocusAngleAboveCenterRad({
        viewportHeightPix = layout.viewportHeight,
        cutoutTopOffsetPix = layout.cutoutTopOffset,
        cutoutDiameterPix = layout.cutoutDiameter,
        cameraFieldOfViewDeg = cameraFieldOfViewDeg
    })

    local targetCFrame = CFrameUtility.CalculateTargetCFrame(head.CFrame)
    local var4, var5 = CharacterUtility.CalculateHeadExtents(character, targetCFrame)

    local var6 = CameraUtility.CalculateBaseDistanceToCamera(math.rad(var2), var4, var5, CameraUtility.DefaultHeadMarginScale) * tbl1.distanceScale

    local var7 = targetCFrame + Vector3.new(0, (var4.Y + var5.Y) / 2, 0)
    local position = (var7 * CFrame.Angles(0, math.rad(tbl1.yRotDeg), 0) * CFrame.new(0, 0, -var6)).Position

    return CFrame.lookAt(position, var7.Position) * CFrame.fromEulerAnglesXYZ(-var3, 0, 0)
end

return frameCloseupPreviewCamera
