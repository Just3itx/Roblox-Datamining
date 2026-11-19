-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local OpenPublishAssetPrompt = require(scriptParentParent.Actions.OpenPublishAssetPrompt)
local OpenPublishAvatarPrompt = require(scriptParentParent.Actions.OpenPublishAvatarPrompt)
local OpenPublishAvatarAssetPrompt = require(scriptParentParent.Actions.OpenPublishAvatarAssetPrompt)
local OpenPublishMakeupLookPrompt = require(scriptParentParent.Actions.OpenPublishMakeupLookPrompt)
local CloseOpenPrompt = require(scriptParentParent.Actions.CloseOpenPrompt)
local OpenResultModal = require(scriptParentParent.Actions.OpenResultModal)
local CloseResultModal = require(scriptParentParent.Actions.CloseResultModal)
local OpenValidationErrorModal = require(scriptParentParent.Actions.OpenValidationErrorModal)
local SetHumanoidModel = require(scriptParentParent.Actions.SetHumanoidModel)
local SetAccessoryInstance = require(scriptParentParent.Actions.SetAccessoryInstance)
local SetPriceInRobux = require(scriptParentParent.Actions.SetPriceInRobux)
local SetPromptVisibility = require(scriptParentParent.Actions.SetPromptVisibility)

local createReducer = Rodux.createReducer

local tbl1 = {}
tbl1[OpenPublishAssetPrompt.name] = function(arg1, arg2)
    if arg1.promptInfo.promptType == nil then
        return Cryo.Dictionary.join(arg1, { promptInfo = arg2.promptInfo })
    end

    return Cryo.Dictionary.join(arg1, { queue = Cryo.List.join(arg1.queue, { arg2.promptInfo }) })
end

tbl1[OpenPublishAvatarPrompt.name] = function(arg1, arg2)
    if arg1.promptInfo.promptType == nil then
        return Cryo.Dictionary.join(arg1, { promptInfo = arg2.promptInfo })
    end

    return Cryo.Dictionary.join(arg1, { queue = Cryo.List.join(arg1.queue, { arg2.promptInfo }) })
end

tbl1[OpenPublishAvatarAssetPrompt.name] = function(arg1, arg2)
    if arg1.promptInfo.promptType == nil then
        return Cryo.Dictionary.join(arg1, { promptInfo = arg2.promptInfo })
    end

    return Cryo.Dictionary.join(arg1, { queue = Cryo.List.join(arg1.queue, { arg2.promptInfo }) })
end

tbl1[OpenPublishMakeupLookPrompt.name] = function(arg1, arg2)
    if arg1.promptInfo.promptType == nil then
        return Cryo.Dictionary.join(arg1, { promptInfo = arg2.promptInfo })
    end

    return Cryo.Dictionary.join(arg1, { queue = Cryo.List.join(arg1.queue, { arg2.promptInfo }) })
end

tbl1[SetHumanoidModel.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(
        arg1,
        {
            promptInfo = Cryo.Dictionary.join(arg1.promptInfo, { humanoidModel = arg2.humanoidModel })
        }
    )
end

tbl1[SetAccessoryInstance.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(
        arg1,
        {
            promptInfo = Cryo.Dictionary.join(arg1.promptInfo, { accessoryInstance = arg2.accessoryInstance })
        }
    )
end

tbl1[SetPriceInRobux.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { promptInfo = Cryo.Dictionary.join(arg1.promptInfo, { priceInRobux = arg2.priceInRobux }) })
end

tbl1[CloseOpenPrompt.name] = function(arg1, _)
    if Cryo.isEmpty(arg1.queue) then
        return {
            promptInfo = {},
            queue = arg1.queue
        }
    end
    return Cryo.Dictionary.join(arg1, { promptInfo = arg1.queue[1], queue = Cryo.List.removeIndex(arg1.queue, 1) })
end

tbl1[OpenResultModal.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { resultModalType = arg2.resultType })
end

tbl1[CloseResultModal.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { resultModalType = Cryo.None })
end

tbl1[OpenValidationErrorModal.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { promptInfo = Cryo.Dictionary.join(arg1.promptInfo, { errorMessage = arg2.errorMessage }) })
end

tbl1[SetPromptVisibility.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(
        arg1,
        {
            promptInfo = Cryo.Dictionary.join(arg1.promptInfo, { promptVisible = arg2.promptVisible })
        }
    )
end

return (createReducer({ promptInfo = {}, queue = {} }, tbl1))
