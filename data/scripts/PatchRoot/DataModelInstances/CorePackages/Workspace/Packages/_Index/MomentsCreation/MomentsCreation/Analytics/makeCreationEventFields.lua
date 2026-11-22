-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local EventNames = MomentsCommon.Analytics.EventNames
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local GetFFlagEnableMomentTextGeneration = MomentsCommon.Flags.GetFFlagEnableMomentTextGeneration

local CreationFlowSteps = FunnelEventNames.CreationFlowSteps

local tbl1 = {
    [EventNames.MomentsEditingFlowContinueToEditButtonPressed] = CreationFlowSteps.GalleryItemSelectedContinuePressed,
    [EventNames.MomentsEditingFlowContinueToDescriptionButtonPressed] = CreationFlowSteps.EditingScreenContinuePressed,
    [EventNames.MomentsEditingFlowPublished] = CreationFlowSteps.Published,
    [EventNames.EditingFlowGalleryPageAppear] = CreationFlowSteps.CreateIntent,
    [EventNames.EditingFlowEditPageAppear] = CreationFlowSteps.GalleryItemSelectedContinuePressed,
    [EventNames.EditingFlowPreviewPageAppear] = CreationFlowSteps.EditingScreenContinuePressed,
    [EventNames.MomentsEditingFlowExited] = CreationFlowSteps.CreateIntent
}

local tbl2 = {
    Gallery = CreationFlowSteps.GalleryItemSelectedContinuePressed,
    Preview = CreationFlowSteps.EditingScreenContinuePressed,
    Description = CreationFlowSteps.EditingScreenContinuePressed
}

local function enumName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "EnumItem" then
        return arg1.Name
    elseif arg1 == nil then
        return nil
    end
    return tostring(arg1)
end

local function classifyGeneratedTextOutcome(str1: string?, str2: string?): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == nil then
        return "none"
    end

    if str2 == str1 then
        return "verbatim"
    end

    if str2 == nil or str2 == "" then
        return "discarded"
    end

    return "edited"
end

return {
    makeStepField = function(str1: string)
        local step = tbl1[str1]
        return if step == nil then {} else { step = step }
    end,
    makeStepFieldFromState = function(str1: string?)
        local step = if str1 == nil then nil else tbl2[str1]
        return if step == nil then {} else { step = step }
    end,
    makeToolField = function(tbl3)
        return if tbl3 == nil or tbl3.kind == nil then {} else {
            tool = tbl3.kind
        }
    end,
    makeToolFieldFromKind = function(tool: string?): {[any]: any} | {tool: string}
        return if tool == nil then {} else { tool = tool }
    end,
    makeCreationBaseFields = function(creationSessionId: string?): {[any]: any} | {creationSessionId: string}
        return if creationSessionId == nil then {} else { creationSessionId = creationSessionId }
    end,
    makeVoiceEventFields = function(tbl3)
        local tbl4 = { tool = "voice" }

        local creationSessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
        local tbl5, var1, var2

        if creationSessionId == nil then
            tbl5 = {}
            var1 = nil
            var2 = nil
        else
            tbl5 = { creationSessionId = creationSessionId }
            var1 = nil
            var2 = nil
        end

        for value, value2 in tbl5, var1, var2 do
            tbl4[value] = value2
        end
        if tbl3 ~= nil then
            for value, value2 in tbl3 do
                tbl4[value] = value2
            end
        end
        return tbl4
    end,
    makeTextOverlayEventFields = function(tbl3)
        local tbl4 = { tool = "text" }

        local creationSessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
        local tbl5, var1, var2

        if creationSessionId == nil then
            tbl5 = {}
            var1 = nil
            var2 = nil
        else
            tbl5 = { creationSessionId = creationSessionId }
            var1 = nil
            var2 = nil
        end

        for value, value2 in tbl5, var1, var2 do
            tbl4[value] = value2
        end
        if tbl3 ~= nil then
            for value, value2 in tbl3 do
                tbl4[value] = value2
            end
        end
        return tbl4
    end,
    makeTextOverlayPublishSummaryFields = function(arg1)
        if arg1 == nil then
            return {}
        end
        local tbl3 = {}
        local textOverlayStyle = arg1.textOverlayStyle
        if textOverlayStyle ~= nil then
            if textOverlayStyle.font ~= nil then
                tbl3.font = textOverlayStyle.font.Name
            end
            if textOverlayStyle.fontSize ~= nil then
                tbl3.fontSize = tostring(textOverlayStyle.fontSize)
            end
            if textOverlayStyle.fontColor ~= nil then
                tbl3.color = "#" .. textOverlayStyle.fontColor:ToHex()
            end
            if textOverlayStyle.textXAlignment ~= nil then
                tbl3.alignment = textOverlayStyle.textXAlignment.Name
            end
        end
        if arg1.rotation ~= nil then
            tbl3.rotation = tostring(arg1.rotation)
        end
        if typeof(arg1.position) == "UDim2" then
            tbl3.positionX = tostring(arg1.position.X.Scale)
            tbl3.positionY = tostring(arg1.position.Y.Scale)
        end
        if arg1.scale ~= nil then
            tbl3.scale = tostring(arg1.scale)
        end
        return if next(tbl3) == nil then {} else tbl3
    end,
    makeVoicePublishSummaryFields = function(arg1, num1: number?, num2: number?)
        if arg1 == nil then
            return {}
        end
        local voicePublishSummaryFields = {}
        if arg1.voiceId ~= nil then
            voicePublishSummaryFields.ttsVoiceId = tostring(arg1.voiceId)
        end
        if arg1.text ~= nil then
            voicePublishSummaryFields.ttsCharCount = tostring(utf8.len(arg1.text) or #arg1.text)
        end
        if num2 ~= nil and num2 > 0 then
            voicePublishSummaryFields.ttsDuration = tostring(num2)
        end
        local startTime = arg1.startTime or 0
        voicePublishSummaryFields.ttsStartTimeSeconds = tostring(startTime)
        if num1 ~= nil then
            voicePublishSummaryFields.ttsVideoDurationSeconds = tostring(num1)
            voicePublishSummaryFields.ttsStartTimeFraction = tostring(if num1 > 0 then startTime / num1 else 0)
        end
        return voicePublishSummaryFields
    end,
    makeCaptureDescriptorFields = function(arg1)
        local tbl3 = {
            sourcePlaceId = tostring(arg1.SourcePlaceId),
            localId = tostring(arg1.LocalId),
            captureType = enumName(arg1.CaptureType)
        }
        tbl3.universeId = tostring(arg1.SourceUniverseId)
        return tbl3
    end,
    makeGeneratedTextOutcomeFields = function(str1: string?, str2: string?, str3: string?, str4: string?)
        if not GetFFlagEnableMomentTextGeneration() then
            return {}
        end

        return {
            generatedDescriptionOutcome = classifyGeneratedTextOutcome(str1, str2),
            generatedSummaryOutcome = classifyGeneratedTextOutcome(str3, str4)
        }
    end,
    classifyGeneratedTextOutcome = classifyGeneratedTextOutcome,
    enumName = enumName
}
