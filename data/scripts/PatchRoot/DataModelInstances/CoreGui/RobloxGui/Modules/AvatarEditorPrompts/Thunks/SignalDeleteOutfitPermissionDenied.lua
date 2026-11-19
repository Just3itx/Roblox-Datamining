-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")

local scriptParentParent = script.Parent.Parent
local CloseOpenPrompt = require(scriptParentParent.Actions.CloseOpenPrompt)

return function(arg1)
    AvatarEditorService:SignalDeleteOutfitPermissionDenied()

    arg1:dispatch(CloseOpenPrompt())
end
