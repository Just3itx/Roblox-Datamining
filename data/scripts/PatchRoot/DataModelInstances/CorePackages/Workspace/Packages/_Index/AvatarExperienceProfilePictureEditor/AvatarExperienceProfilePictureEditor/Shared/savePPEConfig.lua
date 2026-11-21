-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Parent.Constants)

local function buildApplyConfig(tbl1)
    local var1 = if tbl1.emoteAssetId then tonumber(tbl1.emoteAssetId) or 0 else 0
    local tbl2 = {
        ThumbnailCustomizations = {
            {
                ThumbnailType = Enum.AvatarThumbnailCustomizationType.Closeup.Value,
                EmoteAssetId = var1,
                Camera = {
                    FieldOfViewDeg = tbl1.fieldOfViewDeg,
                    YRotDeg = tbl1.cameraYRotDeg,
                    DistanceScale = tbl1.cameraDistanceScale
                }
            },
            {
                ThumbnailType = Enum.AvatarThumbnailCustomizationType.FullBody.Value,
                EmoteAssetId = var1,
                Camera = {
                    FieldOfViewDeg = tbl1.fieldOfViewDeg,
                    YRotDeg = tbl1.cameraYRotDeg,
                    DistanceScale = Constants.FullBodyDistanceScale
                }
            }
        }
    }

    if tbl1.profileFrameAssetId ~= nil then
        tbl2.FrameAssetId = tbl1.profileFrameAssetId
    end

    return tbl2
end

local function applyProfileConfiguration(arg1, applyConfig): boolean
    local var1 = arg1:NoPromptApplyProfileConfiguration(applyConfig)
    while not var1 do
        arg1.PromptApplyProfileConfigurationCompleted:Wait()
        var1 = arg1:NoPromptApplyProfileConfiguration(applyConfig)
    end

    return arg1.PromptApplyProfileConfigurationCompleted:Wait() == Enum.AvatarPromptResult.Success
end

return {
    saveCloseupAndFullBody = function(arg1)
        local var1 = arg1.avatarEditorService or game:GetService("AvatarEditorService")
        local applyConfig = buildApplyConfig(arg1)
        return if applyProfileConfiguration(var1, applyConfig) then { ok = true } else {
            ok = false
        }
    end
}
