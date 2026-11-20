-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)

local getFFlagUGCValidateVersionedContentIds = require(scriptParentParent.flags.getFFlagUGCValidateVersionedContentIds)

local module = {}

local function getRbxAssetId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (string.match(arg1, "^rbxassetid://(%d+)$"))
end

local function getAssetUrlId(arg1)
    arg1 = string.match(arg1, "^https?://www%.(.+)") or string.match(arg1, "^https?://(.+)")
    if not arg1 then
        return nil
    end
    arg1 = string.match(arg1, "^sitetest%d%.robloxlabs(.+)") or string.match(arg1, "^roblox(.+)")
    if not arg1 then
        return nil
    end

    return (string.match(arg1, "^%.com//?asset/%?id=(%d+)$"))
end

local function getAssetDeliveryAssetUrlId(arg1)
    arg1 = string.match(arg1, "^https?://assetdelivery%.(.+)")
    if not arg1 then
        return nil
    end
    arg1 = string.match(arg1, "^sitetest%d%.robloxlabs(.+)") or string.match(arg1, "^roblox(.+)")
    if not arg1 then
        return nil
    end
    return (string.match(arg1, "^%.com/v1/asset/%?id=(%d+)$"))
end

local function splitVersionPin(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1, var2, var3 = string.match(str1, "^(.*)&(%a+)=(%d+)$")
    if var1 == nil or string.lower(var2) ~= "version" or #var3 > 10 then
        return str1, nil
    end

    local var4 = tonumber(var3)
    if var4 == nil or var4 < 1 then
        return str1, nil
    end
    return var1, var4
end

local function tryParseVersionedContentId(str1: string)
    local var1, var2 = splitVersionPin(str1)
    local var3 = string.match(var1, "^%d+$")
    if var3 ~= nil and var2 ~= nil then
        return nil, nil
    end

    local var4 = var3 or getRbxAssetId(var1) or getAssetUrlId(var1) or getAssetDeliveryAssetUrlId(var1)
    if var4 == nil then
        return nil, nil
    end
    return string.gsub(var4, "^0+(%d)", "%1"), var2
end

local function tryGetAssetIdFromContentIdInternal(arg1)
    if getFFlagUGCValidateVersionedContentIds() then
        return (tryParseVersionedContentId(arg1))
    end

    local var1 = tonumber(arg1)
    if var1 ~= nil then
        return var1
    end

    local rbxAssetId = getRbxAssetId(arg1)

    if rbxAssetId ~= nil then
        return rbxAssetId
    end

    local assetUrlId = getAssetUrlId(arg1)
    if assetUrlId ~= nil then
        return assetUrlId
    end

    local assetDeliveryAssetUrlId = getAssetDeliveryAssetUrlId(arg1)
    return if assetDeliveryAssetUrlId == nil then nil else assetDeliveryAssetUrlId
end

local function hasInExpCreatedEditableInstance(instance, fieldName, arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not arg1 then
        return false
    end

    if not arg1.allowEditableInstances then
        return false
    end

    local var1 = arg1.editableImages[instance]
    if var1 and var1[fieldName] and var1[fieldName].instance then
        return true
    end

    local var2 = arg1.editableMeshes[instance]
    return not not (var2 and var2[fieldName] and var2[fieldName].instance)
end

local function parseContentId(tbl1: {any}, arg1, tbl2: {any}, instance, fieldName, arg2, arg3)
    local var1 = instance[fieldName]

    if var1 == "" then
        if hasInExpCreatedEditableInstance(instance, fieldName, arg3) then
            if tbl2 then
                table.insert(tbl2, { fieldName = fieldName, instance = instance })
            end
        elseif arg2 then
            return false, { string.format("%s.%s cannot be empty", instance:GetFullName(), fieldName) }
        end

        return true
    end

    local id = tryGetAssetIdFromContentIdInternal(var1)
    if id == nil then
        return false, { string.format(
                "Could not parse ContentId %s in %s.%s. Please make sure you are using a valid URL with a valid ID.",
                var1,
                instance:GetFullName(),
                fieldName
            ) }
    end

    if arg1[id] == nil then
        arg1[id] = { fieldName = fieldName, instance = instance }

        table.insert(tbl1, id)
    end

    if tbl2 then
        table.insert(tbl2, { fieldName = fieldName, instance = instance, id = id })
    end

    return true
end

local function parseWithErrorCheckInternal(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    arg5 = arg5 or Constants.CONTENT_ID_FIELDS
    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    local descendants = arg4:GetDescendants()
    table.insert(descendants, arg4)

    for _, descendant in pairs(descendants) do
        local var1 = arg5[descendant.ClassName]
        if not var1 then
            continue
        end

        local var2 = arg6 and arg6[descendant.ClassName]
        for _, value in ipairs(var1) do
            local var3 = var2 and var2[value]
            failureReasonsAccumulator:updateReasons(parseContentId(arg1, arg2, arg3, descendant, value, var3, arg7))
        end
    end

    return failureReasonsAccumulator:getFinalResults()
end

function module.tryGetAssetIdFromContentId(str1: string)
    return (tryGetAssetIdFromContentIdInternal(str1))
end

function module.tryParseContentId(str1: string)
    if getFFlagUGCValidateVersionedContentIds() then
        return tryParseVersionedContentId(str1)
    end
    return tryGetAssetIdFromContentIdInternal(str1), nil
end

function module.getReferenceKey(str1: string, version: number?): string
    if version == nil then
        return str1
    end
    return string.format("%s&version=%d", str1, version)
end

function module.toAssetUri(str1: string, version: number?)
    return "rbxassetid://" .. module.getReferenceKey(str1, version)
end

function module.getDistinctReferences(arg1)
    local distinctReferences = {}
    local tbl1 = ({})
    for assetId, value2 in arg1 do
        for _, entry in value2 do
            local key = module.getReferenceKey(assetId, entry.version)
            if tbl1[key] then
                continue
            end

            tbl1[key] = true
            table.insert(
                distinctReferences,
                {
                    key = key,
                    uri = module.toAssetUri(assetId, entry.version),
                    assetId = assetId,
                    entry = entry
                }
            )
        end
    end

    return distinctReferences
end

function module.parseWithErrorCheck(arg1, arg2, arg3, arg4, arg5, arg6)
    return parseWithErrorCheckInternal(arg1, arg2, nil, arg3, arg4, arg5, arg6)
end

function module.parse(arg1, arg2, arg3)
    local result = {}
    assert((parseWithErrorCheckInternal({}, {}, result, arg1, arg2, nil, arg3)))
    return result
end

return module
