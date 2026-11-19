-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent

local PromptType = require(scriptParentParent.PromptType)

local CloseOpenPrompt = require(scriptParentParent.Actions.CloseOpenPrompt)
local OpenPrompt = require(scriptParentParent.Actions.OpenPrompt)
local CreateOutfitConfirmed = require(scriptParentParent.Actions.CreateOutfitConfirmed)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[CloseOpenPrompt.name] = function(arg1, _)
    if Cryo.isEmpty(arg1.queue) then
        return {
            queue = arg1.queue,
            infoQueue = arg1.infoQueue
        }
    end

    return Cryo.Dictionary.join(arg1.infoQueue[1], {
        promptType = arg1.queue[1],
        queue = Cryo.List.removeIndex(arg1.queue, 1),
        infoQueue = Cryo.List.removeIndex(arg1.infoQueue, 1)
    })
end

tbl1[OpenPrompt.name] = function(arg1, arg2)
    if arg1.promptType == nil then
        return Cryo.Dictionary.join(arg1, { promptType = arg2.promptType }, arg2.promptInfo)
    end

    return Cryo.Dictionary.join(arg1, {
        queue = Cryo.List.join(arg1.queue, { arg2.promptType }),
        infoQueue = Cryo.List.join(arg1.infoQueue, { arg2.promptInfo })
    })
end

tbl1[CreateOutfitConfirmed.name] = function(arg1, _)
    return Cryo.Dictionary.join(arg1, { promptType = PromptType.EnterOutfitName })
end

return (createReducer({
    promptType = nil,
    humanoidDescription = nil,
    rigType = nil,
    itemId = nil,
    itemType = nil,
    itemName = nil,
    isFavorited = nil,
    queue = {},
    infoQueue = {}
}, tbl1))
