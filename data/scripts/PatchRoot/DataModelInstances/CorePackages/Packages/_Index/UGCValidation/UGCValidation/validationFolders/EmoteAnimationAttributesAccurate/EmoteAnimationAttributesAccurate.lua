-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local PublishService = game:GetService("PublishService")

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

game:DefineFastFlag("UGCValidateEmoteAttributes", false)

local module = {}

local EmoteIsUGCAttributeName = Constants.EmoteIsUGCAttributeName
local EmoteMaxPartTranslationAttributeName = Constants.EmoteMaxPartTranslationAttributeName

local function toFiniteNumber(arg1): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if typeof(arg1) == "number" and arg1 > -math.huge and arg1 < math.huge then arg1 else nil
end

module.categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION }
module.requiredData = {}
module.conditionalData = { ValidationEnums.SharedDataMember.curveAnimations }

function module.fflag(): boolean
    return game:GetFastFlag("UGCValidateEmoteAttributes") and game:GetEngineFeature("EngineTagEmoteMaxPartTranslation")
end
module.expectedFailures = {}
module.prereqTests = {}

function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        if curveAnimation:GetAttribute(EmoteIsUGCAttributeName) ~= true then
            arg1:fail(ErrorSourceStrings.Keys.EmoteAnimation_InvalidUGCAttribute)
            return
        end

        local var1 = toFiniteNumber((curveAnimation:GetAttribute(EmoteMaxPartTranslationAttributeName)))
        if var1 == nil then
            arg1:fail(ErrorSourceStrings.Keys.EmoteAnimation_InvalidMaxPartTranslationAttribute)
            return
        end

        local curveAnimationClone = curveAnimation:Clone()
        PublishService:TagEmoteAnimation(curveAnimationClone)
        local var2 = toFiniteNumber((curveAnimationClone:GetAttribute(EmoteMaxPartTranslationAttributeName)))
        curveAnimationClone:Destroy()

        if var2 == nil then
            arg1:fail(ErrorSourceStrings.Keys.EmoteAnimation_MaxPartTranslationCalcFailed)
            return
        end

        if not (math.abs(var1 - var2) > 0.00001) then
            continue
        end

        arg1:fail(
            ErrorSourceStrings.Keys.EmoteAnimation_MaxPartTranslationMismatch,
            {
                taggedTranslation = tostring(var1),
                calculatedTranslation = tostring(var2)
            }
        )
        return
    end
end

return module
