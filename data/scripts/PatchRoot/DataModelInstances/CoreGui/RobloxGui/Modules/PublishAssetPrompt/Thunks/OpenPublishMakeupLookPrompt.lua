-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local OpenPublishMakeupLookPrompt = require(scriptParentParent.Actions.OpenPublishMakeupLookPrompt)
local PromptType = require(scriptParentParent.PromptType)

return function(str1: string, arg1, arg2)
    return function(arg3)
        arg3:dispatch(OpenPublishMakeupLookPrompt(PromptType.PublishMakeupLook, str1, arg1, arg2))
    end
end
