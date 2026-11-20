-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local ParseContentIds = require(scriptParentParentParent.util.ParseContentIds)
local _Types = require(scriptParentParentParent.util.Types)

local getFFlagUGCValidateVersionedContentIds = require(scriptParentParentParent.flags.getFFlagUGCValidateVersionedContentIds)

local module = {}

function module.getData(arg1)
    local rootInstance = arg1.rootInstance
    local data = ({})

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, instance in descendants do
        local var1 = Constants.CONTENT_ID_FIELDS[instance.ClassName]
        if not var1 then
            continue
        end

        for _, fieldName in var1 do
            local var2 = instance[fieldName]
            if var2 == "" then
                continue
            end

            local var3 = nil
            local var4

            if getFFlagUGCValidateVersionedContentIds() then
                var4, var3 = ParseContentIds.tryParseContentId(var2)
            else
                var4 = ParseContentIds.tryGetAssetIdFromContentId(var2)
            end
            if var4 == nil then
                continue
            end

            if data[var4] == nil then
                data[var4] = {}
            end
            table.insert(data[var4], { fieldName = fieldName, instance = instance, version = var3 })
        end

        local var2 = Constants.CONTENT_FIELDS_WITHOUT_CONTENTID[instance.ClassName]
        if not var2 then
            continue
        end

        for _, fieldName in var2 do
            local var3 = instance[fieldName]
            if var3.SourceType ~= Enum.ContentSourceType.Uri then
                continue
            end

            local var4 = nil
            local var5

            if getFFlagUGCValidateVersionedContentIds() then
                var5, var4 = ParseContentIds.tryParseContentId(var3.Uri)
            else
                var5 = ParseContentIds.tryGetAssetIdFromContentId(var3.Uri)
            end
            if var5 == nil then
                continue
            end

            if data[var5] == nil then
                data[var5] = {}
            end
            table.insert(data[var5], { fieldName = fieldName, instance = instance, version = var4 })
        end
    end

    return data
end

return module
