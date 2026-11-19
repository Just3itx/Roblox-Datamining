-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local OpenPublishAvatarPrompt = require(scriptParentParent.Actions.OpenPublishAvatarPrompt)
local PromptType = require(scriptParentParent.PromptType)

return function(str1: string, arg1)
    return function(arg2)
        arg2:dispatch(OpenPublishAvatarPrompt(PromptType.PublishAvatar, str1, arg1))
    end
end
