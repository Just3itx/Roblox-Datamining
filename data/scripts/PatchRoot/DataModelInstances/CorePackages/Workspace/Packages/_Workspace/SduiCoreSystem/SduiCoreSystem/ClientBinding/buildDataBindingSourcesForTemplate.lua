-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)

local tryGetPathFromData = require(SduiCoreSystem.ClientBinding.tryGetPathFromData)
local splitDottedPath = require(SduiCoreSystem.ClientBinding.splitDottedPath)
local _SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local ProtoVariableMapper = require(SduiCoreSystem.ClientBinding.ProtoVariableMapper)
local defaultHydrationIdPaths = require(SduiCoreSystem.ClientBinding.defaultHydrationIdPaths)

local function buildDataBindingSourcesForTemplate(tbl1, tbl2)
    local dataBindingSourcesForTemplate = ({})

    for _, value in tbl2 do
        local contentType = ProtoVariableMapper.mapHydrationContentTypeToLua(value.content_type)
        if not contentType then
            error(`Unsupported contentType {value.content_type}`)
        end

        local type = value.id_binding and value.id_binding.kind and value.id_binding.kind.type
        local value2 = value.id_binding and value.id_binding.kind and value.id_binding.kind.value
        local var2 = nil

        if type == "literal" and value2 then
            var2 = value2
        elseif type == "input_path" and value2 then
            local var3 = splitDottedPath(value2)
            local var4, var5 = tryGetPathFromData(tbl1, var3)
            if var4 and var5 ~= nil then
                var2 = var5
            else
                error(`Unable to resolve path from inputPath: {value2} in data`)
            end
        else
            local defaultHydrationIdPath = defaultHydrationIdPaths[contentType]
            if defaultHydrationIdPath then
                local var3, var4 = tryGetPathFromData(tbl1, defaultHydrationIdPath)
                if var3 and var4 ~= nil then
                    var2 = var4
                else
                    local str1 = table.concat(defaultHydrationIdPath, ",")
                    error(`Unable to resolve default path: {str1} in data for contentType {contentType}`)
                end
            else
                error(`Unable to find default for unknown contentType: {contentType}`)
            end
        end

        local var3 = if value.alias and value.alias ~= "" then value.alias else contentType
        dataBindingSourcesForTemplate[var3] = {
            contentType = contentType,
            id = var2,
            fetchIfMissing = value.client_fetch
        }
    end

    return dataBindingSourcesForTemplate
end

return buildDataBindingSourcesForTemplate
