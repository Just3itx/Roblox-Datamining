-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent
local EmoteUtility = require(AvatarExperienceProfilePictureEditorParent.Thumbnailing).EmoteUtility

local function applyCloseupPreviewPose(arg1, str1: string?)
    local var1 = if str1 then tonumber(str1) else nil
    local var2 = EmoteUtility.LoadKeyframesForPose(arg1, var1, nil, true, true)

    if not var2 then
        EmoteUtility.SetPlayerCharacterNeutralPose(arg1)
        local humanoid = arg1:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.RigType == Enum.HumanoidRigType.R6 then
            EmoteUtility.AdjustArmOnR6ForTool(arg1)
        end
    else
        EmoteUtility.ApplyKeyframesForPose(arg1, var2)
    end

    local RunService = game:GetService("RunService")
    RunService.PreAnimation:Wait()
    RunService.PostSimulation:Wait()
end

return applyCloseupPreviewPose
