-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Promise = require(scriptParentParent.Parent.Promise)

game:DefineFastInt("UGCValidationCanPublishRequestPageSize", 50)
game:DefineFastInt("UGCValidationMaxAssetSizeAllowed", 500)

local Analytics = require(scriptParentParent.Analytics)

local APIUtil = require(scriptParentParent.util.APIUtil)
local _Types = require(scriptParentParent.util.Types)

local HttpService = game:GetService("HttpService")

local baseDomain = APIUtil.getBaseDomain()
local str1 = string.format("https://apis.%s", baseDomain)

local fastInt = game:GetFastInt("UGCValidationCanPublishRequestPageSize")
local fastInt2 = game:GetFastInt("UGCValidationMaxAssetSizeAllowed")
local Constants = require(scriptParentParent.Constants)

local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)

local getFStringUGCValidationReferenceMeshIdWhitelistForIEC = require(scriptParentParent.flags.getFStringUGCValidationReferenceMeshIdWhitelistForIEC)

local getFFlagUGCValidateRejectUnsupportedCreatorTypes = require(scriptParentParent.flags.getFFlagUGCValidateRejectUnsupportedCreatorTypes)

local function getWhitelistIds()
    local whitelistIds = ({})
    local fStringUgcValidationReferenceMeshIdWhitelistForIec = getFStringUGCValidationReferenceMeshIdWhitelistForIEC()
    if #fStringUgcValidationReferenceMeshIdWhitelistForIec == 0 then
        return whitelistIds
    end

    for value in string.gmatch(fStringUgcValidationReferenceMeshIdWhitelistForIec, "([^,%s]+)") do
        whitelistIds[value] = true
    end

    return whitelistIds
end

local function createCanPublishPromise(url: string, assetIds, restrictedEntities, token, universeId) -- Luacid: Inlined by compiler; 2 call sites recovered
    if #assetIds == 0 then
        return Promise.resolve()
    end
    return Promise.new(function(callback, callback2)
        local body = HttpService:JSONEncode({ assetIds = assetIds, restrictedEntities = restrictedEntities, universeId = universeId })

        HttpService:RequestInternal({
            Url = url,
            Method = "POST",
            Body = body,
            Headers = {
                [Constants.ExperienceAuthHeaderKey] = token,
                [Constants.ContentType] = Constants.ApplicationJson
            }
        }):Start(
            function(arg1, arg2)
                if arg1 and arg2.StatusCode == 200 then
                    local var1 = HttpService:JSONDecode(arg2.Body)
                    callback(var1)
                    return
                end
                callback2()
            end
        )
    end)
end

local function validateAssetCreator(arg1, arg2)
    local isServer = arg2.isServer
    local var1 = not arg2.restrictedUserIds and {} or arg2.restrictedUserIds
    local token = arg2.token
    local universeId = arg2.universeId

    if getFFlagUGCValidateRejectUnsupportedCreatorTypes() then
        for _, value in var1 do
            if value.creatorType == "Experience" then
                local id = value.id
                return false, { `Experience creators are not supported. CreatorType: Experience, CreatorId: {tostring(id)}.` }
            end

            if value.creatorType == "User" or value.creatorType == "Group" then
                continue
            end

            local str2 = tostring(value.creatorType)
            local id = value.id
            return false, { `Unsupported creator type. CreatorType: {str2}, CreatorId: {tostring(id)}.` }
        end
    else
        local tbl1 = {
            User = {},
            Group = {}
        }

        for _, value in ipairs(var1) do
            local var2 = tbl1[value.creatorType]
            local id = value.id
            var2[tonumber(id)] = true
        end
    end

    local str2 = str1 .. (if isServer then "packages-api/v1/rcc/canPublish" else "packages-api/v1/canPublish")
    local failureReasonsAccumulator = FailureReasonsAccumulator.new()
    local tbl1 = ({})
    local tbl2 = {}
    local num1 = 0

    for value, _ in arg1 do
        if not tbl1[value] then
            num1 += 1
            tbl1[value] = true
        end
    end
    if fastInt2 < num1 then
        Analytics.reportFailure(Analytics.ErrorType.validateAssetCreator_TooManyDependencies, nil, arg2)
        return false, { "Upload of model has too many children assets (Meshes, Textures, etc.) and cannot be processed as is. You need to rearrange the model." }
    end

    local tbl3 = {}

    for value, _ in tbl1 do
        table.insert(tbl3, value)

        if #tbl3 >= fastInt then
            table.insert(tbl2, (createCanPublishPromise(str2, tbl3, var1, token, universeId)))
            tbl3 = {}
        end
    end

    if #tbl3 > 0 then
        table.insert(tbl2, (createCanPublishPromise(str2, tbl3, var1, token, universeId)))
    end

    local var2, var3 = Promise.all(tbl2):await()

    if not var2 then
        Analytics.reportFailure(Analytics.ErrorType.validateAssetCreator_FailedToLoad, nil, arg2)
        return false, { "Failed to load detailed information for model assets. Make sure all model assets exist and try again." }
    end

    local bool1 = getFStringUGCValidationReferenceMeshIdWhitelistForIEC() ~= ""
    local tbl4 = not bool1 and {} or getWhitelistIds()

    for _, value in var3 do
        local result = value.result
        for k, value2 in pairs(result) do
            if bool1 then
                value2 = value2 or tbl4[k]
            end

            if not value2 then
                Analytics.reportFailure(Analytics.ErrorType.validateAssetCreator_DependencyNotOwnedByCreator, nil, arg2)
            end

            local var4 = arg1[k]
            failureReasonsAccumulator:updateReasons(value2, { string.format(
                    "%s.%s ( %s ) being used is not owned by the experience creator or player. You can only publish assets that you own.",
                    var4.instance:GetFullName(),
                    var4.fieldName,
                    k
                ) })
        end
    end

    return failureReasonsAccumulator:getFinalResults()
end

return validateAssetCreator
