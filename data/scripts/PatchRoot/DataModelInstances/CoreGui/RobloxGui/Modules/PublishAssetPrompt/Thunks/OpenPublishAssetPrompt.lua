-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local OpenPublishAssetPrompt = require(scriptParentParent.Actions.OpenPublishAssetPrompt)
local PromptType = require(scriptParentParent.PromptType)

return function(arg1, arg2, str1: string, arg3)
    return function(arg4)
        if arg1:IsA("Accessory") then
            local model = Instance.new("Model")
            model.Parent = arg1.Parent
            arg1.Parent = model

            local primaryPart = arg1:FindFirstChildWhichIsA("BasePart", true)
            if primaryPart == nil then
                print("Error: accessory to be published does not contain a BasePart")
            else
                model.PrimaryPart = primaryPart
                arg1 = model
            end
        end

        arg4:dispatch(OpenPublishAssetPrompt(PromptType.PublishAssetSingleStep, arg1, arg2, str1, arg3))
    end
end
