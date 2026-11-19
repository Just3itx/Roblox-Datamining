-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local OpenPublishAvatarAssetPrompt = require(scriptParentParent.Actions.OpenPublishAvatarAssetPrompt)
local PromptType = require(scriptParentParent.PromptType)

return function(arg1, str1: string, arg2)
    return function(arg3)
        arg3:dispatch(OpenPublishAvatarAssetPrompt(PromptType.PublishAvatarAsset, arg1, str1, arg2))
    end
end
