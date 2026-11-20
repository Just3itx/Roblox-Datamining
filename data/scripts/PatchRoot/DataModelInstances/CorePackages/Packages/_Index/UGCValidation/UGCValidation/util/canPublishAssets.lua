-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Promise = require(scriptParentParent.Parent.Promise)

game:DefineFastInt("UGCValidationCanPublishRequestPageSize", 50)
game:DefineFastInt("UGCValidationMaxAssetSizeAllowed", 500)

local APIUtil = require(scriptParentParent.util.APIUtil)
local Constants = require(scriptParentParent.Constants)

local getFStringUGCValidationReferenceMeshIdWhitelistForIEC = require(scriptParentParent.flags.getFStringUGCValidationReferenceMeshIdWhitelistForIEC)
local _Types = require(scriptParentParent.util.Types)

local HttpService = game:GetService("HttpService")

local baseDomain = APIUtil.getBaseDomain()
local str1 = string.format("https://apis.%s", baseDomain)

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

local function createCanPublishPromise(url: string, assetIds, restrictedEntities, str2: string?, universeId: number?)
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
                [Constants.ExperienceAuthHeaderKey] = str2,
                [Constants.ContentType] = Constants.ApplicationJson
            }
        }):Start(
            function(arg1, arg2)
                if arg1 and arg2.StatusCode == 200 then
                    callback(HttpService:JSONDecode(arg2.Body))
                    return
                end
                callback2()
            end
        )
    end)
end

local function canPublishAssets(arg1, restrictedEntities, str2: string?, universeId: number?, bool1: boolean)
    local fastInt = game:GetFastInt("UGCValidationCanPublishRequestPageSize")
    local fastInt2 = game:GetFastInt("UGCValidationMaxAssetSizeAllowed")

    local str3 = str1 .. (if bool1 then "packages-api/v1/rcc/canPublish" else "packages-api/v1/canPublish")
    local tbl1 = ({})
    local tbl2 = {}

    for value, _ in arg1 do
        if not tbl1[value] then
            tbl1[value] = true
            table.insert(tbl2, value)
        end
    end
    if fastInt2 < #tbl2 then
        return { status = "tooManyAssets" }
    end

    local tbl3 = {}
    local tbl4 = {}
    for _, value in tbl2 do
        table.insert(tbl4, value)
        if fastInt <= #tbl4 then
            table.insert(tbl3, createCanPublishPromise(str3, tbl4, restrictedEntities, str2, universeId))
            tbl4 = {}
        end
    end

    if #tbl4 > 0 then
        table.insert(tbl3, createCanPublishPromise(str3, tbl4, restrictedEntities, str2, universeId))
    end

    local var1, var2 = Promise.all(tbl3):await()
    if not var1 then
        return { status = "loadFailed" }
    end

    local bool2 = getFStringUGCValidationReferenceMeshIdWhitelistForIEC() ~= ""
    local tbl5 = not bool2 and {} or getWhitelistIds()

    local verdicts = {}
    for _, value in var2 do
        for assetId, value3 in value.result do
            local var3 = arg1[assetId]
            if not var3 then
                continue
            end

            if bool2 and not value3 and tbl5[assetId] then
                value3 = true
            end

            table.insert(verdicts, { assetId = assetId, allowed = value3, entry = var3[1] })
        end
    end

    return { status = "ok", verdicts = verdicts }
end

return canPublishAssets
