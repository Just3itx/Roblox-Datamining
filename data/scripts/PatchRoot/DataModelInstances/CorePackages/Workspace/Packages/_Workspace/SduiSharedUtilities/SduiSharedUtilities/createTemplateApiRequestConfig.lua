-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")

local _SduiApiRequestConfig = require(SduiSharedUtilities.SduiApiRequestConfig)
local SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)
local _SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local SduiProtobufResponseHelpers = require(SduiSharedUtilities.SduiProtobufResponseHelpers)
local SduiTemplateApi = require(SduiSharedUtilities.SduiTemplateApi)

local function createTemplateApiRequestConfig(tbl1)
    local request = SduiTemplateApi.createRequest(
        {
            surfaceKeys = { tbl1.surfaceKey },
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
        surfaceKey = tbl1.surfaceKey,
        configKey = tbl1.configKey or `template-api-page:{tbl1.surfaceKey}:{request.cacheKey}`,
        loadTimer = tbl1.loadTimer,
        apiProto = request.responseProto,
        allowNoConfigsBuilt = tbl1.allowNoConfigsBuilt,
        onSuccess = tbl1.onSuccess,
        enableTemplateCache = true,
        postConfig = request.postConfig,
        parsePageEntriesFromResponse = function()
            return tbl1.pageEntries
        end,
        parseTemplateEntriesFromResponse = function(arg1)
            return SduiTemplateApi.parseResponseForSurface(arg1, tbl1.surfaceKey)
        end,
        parseLocalizedLiteralsFromResponse = SduiProtobufResponseHelpers.parseLocalizedLiteralsFromResponse
    }
end

return createTemplateApiRequestConfig
