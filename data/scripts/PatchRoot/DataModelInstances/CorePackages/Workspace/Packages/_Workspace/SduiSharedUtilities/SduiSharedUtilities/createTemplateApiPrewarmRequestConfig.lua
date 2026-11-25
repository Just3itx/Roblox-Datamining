-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local _SduiApiRequestConfig = require(SduiSharedUtilities.SduiApiRequestConfig)
local SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local SduiProtobufResponseHelpers = require(SduiSharedUtilities.SduiProtobufResponseHelpers)
local SduiTemplateApi = require(SduiSharedUtilities.SduiTemplateApi)

local function createTemplateApiPrewarmRequestConfig(tbl1)
    local request = SduiTemplateApi.createRequest(
        {
            surfaceKeys = tbl1.surfaceKeys,
            locale = tbl1.locale,
            capabilities = tbl1.capabilities
        }
    )

    if request == nil then
        return nil
    end

    return {
        responseType = SduiIntegrationTypes.SduiResponseType.Protobuf,
        url = request.url,
        surfaceKey = "TemplatePrewarm",
        configKey = tbl1.configKey or request.cacheKey,
        loadTimer = tbl1.loadTimer,
        apiProto = request.responseProto,
        postConfig = request.postConfig,
        allowNoConfigsBuilt = true,
        parsePageEntriesFromResponse = function()
            return {}
        end,
        parseTemplateEntriesFromResponse = function(arg1)
            SduiTemplateApi.storeResponse(arg1, request)
            return {}, {}, {}
        end,
        parseLocalizedLiteralsFromResponse = SduiProtobufResponseHelpers.parseLocalizedLiteralsFromResponse
    }
end

return createTemplateApiPrewarmRequestConfig
