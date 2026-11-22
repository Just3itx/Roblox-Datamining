-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Constants)
local Enums = require(script.Enums)
local Stores = require(script.Stores)

local CreationFlowScreen = require(script.Components.CreationFlowScreen)

local _CreationFlowState = require(script.Enums.CreationFlowState)
local CreationFlowLocalization = require(script.Enums.CreationFlowLocalization)
local _DialogType = require(script.Enums.DialogType)
local _DragHandle = require(script.Enums.DragHandle)
local makePostMetadata = require(script.Utils.makePostMetadata)

local publishMomentWithUpload = require(script.Upload.publishMomentWithUpload)
local isTextFiltered = require(script.Moderation.isTextFiltered)

local module = {
    Constants = Constants,
    Enums = Enums,
    CreationFlowLocalization = CreationFlowLocalization,
    Stores = Stores,
    CreationFlowScreen = CreationFlowScreen,
    publishMomentWithUpload = publishMomentWithUpload
}

function module.beginCreationFlow(str1: string)
    require(script.Analytics.beginCreationFlow)(str1)
end

function module.publishMomentWithTags(arg1, arg2, str1: string, str2: string?, num1: number?, bool1: boolean?, func1: ((...any) -> (...any))?)
    return require(script.Upload.publishMomentWithTags)(arg1, arg2, str1, str2, num1, bool1, func1)
end

function module.registerAnalyticsListener(func1: (...any) -> (...any))
    return require(script.Analytics.hostAnalyticsListener).register(func1)
end

function module.resetCreationFlow(arg1)
    return require(script.resetCreationFlow)(arg1)
end

module.isTextFiltered = isTextFiltered

module.makePostMetadata = makePostMetadata

module["jest.config"] = script["jest.config"]
return module
