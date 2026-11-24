-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local CaptureService = game:GetService("CaptureService")

local PromptDismissed = require(scriptParentParent.Actions.PromptDismissed)

return function(promptId: number, tbl1)
    return function(arg1)
        arg1:dispatch(PromptDismissed(promptId))

        CaptureService:OnSavePromptFinished(promptId, tbl1)
    end
end
