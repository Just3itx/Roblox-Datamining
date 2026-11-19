-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")

local scriptParentParent = script.Parent.Parent
local OpenPrompt = require(scriptParentParent.Actions.OpenPrompt)

local GetOutfitName = require(scriptParentParent.Network.GetOutfitName)

local PromptType = require(scriptParentParent.PromptType)

return function(outfitId, humanoidDescription, rigType)
    return function(arg1)
        GetOutfitName(outfitId):andThen(function(outfitName)
            arg1:dispatch(
                OpenPrompt(
                    PromptType.UpdateOutfit,
                    {
                        outfitId = outfitId,
                        outfitName = outfitName,
                        humanoidDescription = humanoidDescription,
                        rigType = rigType
                    }
                )
            )
        end, function(_)
            AvatarEditorService:SignalUpdateOutfitFailed()
        end)
    end
end
