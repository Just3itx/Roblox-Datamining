-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = game:GetService("CaptureService")

local PromptDismissed = require(scriptParentParent.Actions.PromptDismissed)

return function(promptId: number, wasAccepted: boolean)
    return function(arg1)
        arg1:dispatch(PromptDismissed(promptId))

        if game:GetEngineFeature("CaptureServiceGalleryPermissionPrompt") then
            CaptureService:OnCapturePermissionsPromptFinished(promptId, wasAccepted)
        end
    end
end
