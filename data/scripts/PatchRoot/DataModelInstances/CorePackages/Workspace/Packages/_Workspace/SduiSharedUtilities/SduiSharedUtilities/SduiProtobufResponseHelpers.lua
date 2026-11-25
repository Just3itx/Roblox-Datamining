-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local getProtoVariableMapper = require(SduiSharedUtilitiesParent.SduiCoreSystem).getProtoVariableMapper

local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local FFlagSduiHydrationDataCamelCasePropertyKeys = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiHydrationDataCamelCasePropertyKeys

local FFlagEnableHomepagePromptsForModalsAndBanners = require(SduiSharedUtilitiesParent.SharedFlags).FFlagEnableHomepagePromptsForModalsAndBanners
local FFlagPromptsHandlerEnabled = require(SduiSharedUtilitiesParent.SharedFlags).FFlagPromptsHandlerEnabled
local FFlagSduiSandboxContentInputData = require(SduiSharedUtilitiesParent.SharedFlags).FFlagSduiSandboxContentInputData

local function decodeProto(arg1, arg2)
    if typeof(arg2) == "string" then
        arg2 = buffer.fromstring(arg2)
    end
    return arg1.decode(arg2)
end

local function decodeProtobufJson(arg1, arg2)
    if typeof(arg2) == "buffer" then
        arg2 = buffer.tostring(arg2)
    end

    return arg1.jsonDecode(HttpService:JSONDecode(arg2))
end

local function parseSurfacing(surfacing)
    if not (surfacing and surfacing.kind) then
        return nil
    end
    local kind = surfacing.kind
    if kind.type == nil or kind.value == nil then
        return nil
    end
    local protoVariableMapper = getProtoVariableMapper()
    return {
        [protoVariableMapper.mapPropName(kind.type)] = protoVariableMapper.camelCaseKeys(kind.value)
    }
end
local unwrapSandboxStruct = nil

local function unwrapSandboxValue(arg1)
    if typeof(arg1) ~= "table" or typeof(arg1.kind) ~= "table" then
        return arg1
    end

    local kind = arg1.kind
    if kind.type == "null_value" then
        return nil
    elseif kind.type == "struct_value" then
        return unwrapSandboxStruct(kind.value)
    end

    if kind.type ~= "list_value" then
        return kind.value
    end

    local result = ({})
    local value = kind.value

    for value2, value3 in (typeof(value) ~= "table" or typeof(kind.value.values) ~= "table") and {} or kind.value.values do
        result[value2] = unwrapSandboxValue(value3)
    end
    return result
end

unwrapSandboxStruct = function(arg1)
    if typeof(arg1) ~= "table" or typeof(arg1.fields) ~= "table" then
        return arg1
    end

    local result = ({})
    for k, field in arg1.fields do
        result[k] = unwrapSandboxValue(field)
    end
    return result
end

return {
    decodeProto = decodeProto,
    decodeProtobufJson = decodeProtobufJson,
    makeProtoResponseDecoder = function(arg1)
        return function(arg2)
            return decodeProto(arg1, arg2)
        end
    end,
    makeProtobufJsonResponseDecoder = function(arg1)
        return function(arg2)
            return decodeProtobufJson(arg1, arg2)
        end
    end,
    parsePageEntriesFromResponse = function(arg1)
        local result = {}
        if arg1.page_entries then
            for _, value in arg1.page_entries do
                local robloxComponent = value.page_entry.roblox_component
                local value2 = value.input_data and value.input_data.kind and value.input_data.kind.value
                if FFlagSduiSandboxContentInputData then
                    local kind = value.input_data and value.input_data.kind
                    if kind and kind.type == "sandbox_content" then
                        value2 = unwrapSandboxStruct(kind.value)
                    end
                end
                local identifier = value.page_entry.identifier
                local title = value.page_entry.title
                local category = if FFlagEnableHomepagePromptsForModalsAndBanners or FFlagPromptsHandlerEnabled then value.page_entry.category else nil
                local surfacing = parseSurfacing(value.page_entry.surfacing)

                local tbl1 = {
                    robloxComponentType = robloxComponent,
                    identifier = 0,
                    componentInputData = 0,
                    title = 0,
                    category = 0,
                    surfacing = 0
                }

                if identifier == "" then
                    identifier = nil
                end

                tbl1.identifier = identifier
                tbl1.componentInputData = value2
                tbl1.title = title
                if category == nil or category == "" then
                    category = nil
                end

                tbl1.category = category
                tbl1.surfacing = surfacing
                table.insert(result, tbl1)
            end
        end

        return result
    end,
    parseHydrationDataFromResponse = function(tbl1)
        local hydrationData = tbl1.hydration_data
        if hydrationData then
            for _, value in hydrationData do
                for _, value2 in value do
                    if FFlagSduiHydrationDataCamelCasePropertyKeys then
                        local tbl2 = {}
                        for value3, value4 in value2 do
                            tbl2[getProtoVariableMapper().mapPropName(value3)] = value4
                        end
                        for value3, value4 in tbl2 do
                            value2[value3] = value4
                        end
                    else
                        for value3, value4 in value2 do
                            value2[getProtoVariableMapper().mapPropName(value3)] = value4
                        end
                    end
                end
            end
            local protoVariableMapper = getProtoVariableMapper()
            local tbl2 = {}
            for value, value2 in hydrationData do
                if value2 then
                    tbl2[protoVariableMapper.mapPropName(value)] = value2
                end
            end
            for value, value2 in tbl2 do
                hydrationData[value] = value2
            end
        end
        return hydrationData
    end,
    parseLocalizedLiteralsFromResponse = function(tbl1)
        return if tbl1.localized_literals then tbl1.localized_literals else nil
    end,
    parseTemplateEntriesFromResponse = function(tbl1, bool1: boolean?)
        local tbl2 = ({})
        local tbl3 = {}
        local tbl4 = {}
        if tbl1.templates then
            for value, value2 in tbl1.templates do
                tbl3[value2.roblox_component] = value2.template
                if bool1 then
                    tbl4[value2.roblox_component] = value
                end
                tbl2[value] = value2.template
            end
        end
        return tbl2, tbl3, tbl4
    end
}
