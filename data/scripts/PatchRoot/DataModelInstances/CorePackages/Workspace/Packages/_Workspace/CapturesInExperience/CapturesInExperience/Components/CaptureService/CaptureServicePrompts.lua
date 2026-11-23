-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local Constants = require(scriptParentParentParent.Constants)
local PromptConnections = require(scriptParentParentParent.Components.CaptureService.PromptConnections)
local PromptType = require(scriptParentParentParent.Enums.PromptType)
local SaveCapturesPrompt = require(scriptParentParentParent.Components.CaptureService.SaveCapturesPrompt)
local ShareCapturePrompt = require(scriptParentParentParent.Components.CaptureService.ShareCapturePrompt)

local CapturePermissionsPromptV2 = require(scriptParentParentParent.Components.CaptureService.CapturePermissionsPromptV2)

local _Types = require(scriptParentParentParent.Types)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local tbl1 = {
    [PromptType.SaveCaptures] = SaveCapturesPrompt,
    [PromptType.ShareCapture] = ShareCapturePrompt
}

if game:GetEngineFeature("CaptureServiceGalleryPermissionPrompt") then
    tbl1[PromptType.CapturePermissions] = CapturePermissionsPromptV2
end

return function(_)
    local var1 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Prompts[1]
    end)

    local promptData = var1 and var1.PromptData
    local promptId = var1 and var1.PromptId
    local promptType = var1 and var1.PromptType

    local element = nil
    if promptType then
        local var2 = tbl1[promptType]
        if var2 then
            element = React.createElement(var2, { promptData = promptData, promptId = promptId })
        else
            error(`Unexpected prompt type: {promptType}!`)
        end
    end

    return React.createElement(
        React.Fragment,
        {},
        {
            PromptConnections = React.createElement(PromptConnections),
            Prompt = element
        }
    )
end
