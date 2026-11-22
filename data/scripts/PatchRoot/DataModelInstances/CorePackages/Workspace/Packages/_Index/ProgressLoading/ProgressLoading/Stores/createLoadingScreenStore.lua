-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")
local ProgressLoadingParent = ProgressLoading.Parent

local ExperienceService = game:GetService("ExperienceService")
local GuiService = game:GetService("GuiService")

local DataHydration = require(ProgressLoadingParent.DataHydration)
local Signals = require(ProgressLoadingParent.Signals)

local createDataCache = DataHydration.createDataCache
local createDataResolver = DataHydration.createDataResolver

local fetchPlayerLocalizationChoice = require(script.Parent.fetchPlayerLocalizationChoice)
local LoadingScreenTelemetry = require(ProgressLoading.LoadingScreenTelemetry)

local QueueExperimentation = require(ProgressLoadingParent.SocialExperiments).QueueExperimentation

local var1 = game:GetEngineFeature("PlaceJoinStateEnabled")
    and (QueueExperimentation.getIsJoinNewServerButtonEnabled() or QueueExperimentation.getIsAutoJoinNewServerEnabled())

local function createLoadingScreenStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        logError = function(arg1)
            if type(arg1) == "table" then
                LoadingScreenTelemetry.countPlayerLocalizationChoiceFailed(
                    {
                        responseCode = arg1.responseCode,
                        errorType = arg1.errorType
                    }
                )
                return
            end

            LoadingScreenTelemetry.countPlayerLocalizationChoiceFailed({ errorType = "PlayerLocalizationChoiceFetchError" })
        end,
        fetchFn = function(universeId: string, _)
            return fetchPlayerLocalizationChoice(universeId):andThen(function(arg1)
                if not (arg1 and arg1.responseBody) then
                    error({
                        responseCode = arg1 and arg1.responseCode,
                        errorType = "PlayerLocalizationChoiceResponseError",
                        errorMessage = if arg1 then "Missing response body" else "No response",
                        customFields = { universeId = universeId }
                    })
                end

                local responseBody = arg1.responseBody

                if responseBody.IsPlayerChoiceEnabled == nil then
                    error({
                        responseCode = arg1.responseCode,
                        errorType = "PlayerLocalizationChoiceMissingKey",
                        errorMessage = "Missing IsPlayerChoiceEnabled in response body",
                        customFields = { universeId = universeId, responseBody = responseBody }
                    })
                end

                return responseBody
            end):catch(function(arg1)
                error(arg1)
            end)
        end
    })

    local connection = nil
    local connection2 = nil
    local var2 = nil
    local var3 = nil
    local var4 = nil
    local var5 = nil
    if var1 then
        local var6
        var2, var6 = Signals.createSignal(ExperienceService:GetPlaceJoinState() or "")
        var3 = var6
        connection2 = ExperienceService.PlaceJoinStateChanged:Connect(function(state: string)
            var3(state)
        end)

        local var7
        var4, var7 = Signals.createSignal(GuiService:GetUiMessage() or "")
        var5 = var7

        connection = GuiService.UiMessageChanged:Connect(function(msgType: Enum.UiMessageType, newUiMessage: string)
            if msgType == Enum.UiMessageType.UiMessageInfo then
                var5(newUiMessage)
            end
        end)
    end

    return {
        getJoinState = var2,
        getServerStatusText = var4,
        getAndFetchPlayerLocalizationChoice = dataResolver.getAndFetchItem,
        getCachedPlayerLocalizationChoice = dataResolver.getCachedItem,
        clear = function()
            cache.clear()
            dataResolver.clear()
        end,
        dispose = function()
            dataResolver.dispose()

            if var1 then
                connection2:Disconnect()
                connection:Disconnect()
            end
        end
    }
end

return createLoadingScreenStore
