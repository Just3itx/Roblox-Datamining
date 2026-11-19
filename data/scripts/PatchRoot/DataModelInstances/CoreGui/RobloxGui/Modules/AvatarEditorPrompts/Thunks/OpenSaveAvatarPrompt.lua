-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local OpenPrompt = require(scriptParentParent.Actions.OpenPrompt)

local PromptType = require(scriptParentParent.PromptType)

return function(humanoidDescription, rigType)
    return function(arg1)
        arg1:dispatch(OpenPrompt(PromptType.SaveAvatar, { humanoidDescription = humanoidDescription, rigType = rigType }))
    end
end
