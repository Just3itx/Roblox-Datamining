-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local HttpClient = require(BuildExperienceParent.HttpClient)
local Promise = require(BuildExperienceParent.Promise)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local UniverseSearch = require(BuildExperienceParent.DataHydration.UniverseSearch)
local UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)
local UrlBuilder = require(BuildExperienceParent.UrlBuilder).UrlBuilder
local GetBuildExperienceRefreshStore = require(BuildExperience.Stores.GetBuildExperienceRefreshStore)
local rehydrateGameMetadata = require(BuildExperience.utils.rehydrateGameMetadata)
local FFlagBuildExperienceActionOutcomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceActionOutcomeTelemetry)

local num1 = game:DefineFastInt("BuildExperienceSetAudiencesMaxRetries", 3)
local num2 = game:DefineFastInt("BuildExperienceSetAudiencesRetryDelayMs", 3000)

local bool1 = game:DefineFastFlag("BuildExperienceSecondActivateAfterSetAudiences", false)

local debug2 = CreatorAgentChat.debug

local string2 = UrlBuilder.fromString("create:dashboard/creations/experiences/{universeId}/configure")

local string3 = UrlBuilder.fromString("create:dashboard/creations/experiences/{universeId}/experience-questionnaire")

local function saveAndPublishPlace(arg1)
    debug2.log("info", "GameConfigurationActions save_and_publish started", { placeId = arg1.placeId })

    local var1 = CreatorAgentChat.getCreatorAgentChatStore().sessionSaveAndPublish(arg1)
    return HttpClient.asPromise(var1)
end

local function buildPublicAudiences(audiences)
    local publicAudiences = {}
    for _, value in audiences do
        if value ~= UniverseActivation.Audience.Public and value ~= UniverseActivation.Audience.Friends then
            table.insert(publicAudiences, value)
        end
    end
    table.insert(publicAudiences, UniverseActivation.Audience.Public)
    return publicAudiences
end

local function updateCachedAudience(num3: number, audiences, isActive: boolean?)
    local privacyType = UniverseConfiguration.getPrivacyTypeForAudiences(audiences)
    local universeConfigurationStore = UniverseConfiguration.getUniverseConfigurationStore()
    universeConfigurationStore.updateConfiguration(num3, { privacyType = privacyType, audiences = audiences })

    universeConfigurationStore.updateSummary(
        num3,
        { isActive = isActive, privacyType = privacyType, audiences = audiences }
    )
end

local function hasPublicAudience(audiences): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (audiences == nil) and table.find(audiences, UniverseActivation.Audience.Public) ~= nil
end

local function audienceFailure(cause, publishResult)
    local tbl1 = {
        stage = "set_audience",
        errorMessage = if typeof(cause) == "table" and cause.errorMessage ~= nil then tostring(cause.errorMessage) else tostring(cause),
        publishResult = publishResult,
        cause = 0
    }

    if not FFlagBuildExperienceActionOutcomeTelemetry then
        cause = nil
    end

    tbl1.cause = cause
    return tbl1
end

local function setAudiencesForPublish(universeActivationStore, universeId: number, audiences)
    local publicAudiences = buildPublicAudiences(audiences)
    return Promise.retryWithDelay(function()
        return universeActivationStore.setAudiences(universeId, publicAudiences)
    end, num1, num2 / 1000):andThen(function(arg1)
        updateCachedAudience(universeId, arg1.audiences, true)

        if hasPublicAudience(arg1.audiences) then
            return arg1
        end

        debug2.log("warn", "GameConfigurationActions set audience missing Public", { universeId = universeId })

        return Promise.reject({ errorMessage = "setAudiences did not return a Public audience" })
    end)
end

return {
    PublishFailureStage = { SetAudience = "set_audience" },
    getCreatorHubConfigureUrl = function(universeId: number)
        return string2({ universeId = universeId })
    end,
    getCreatorHubAnalyticsUrl = function(universeId: number, str1: string, rangeType: string?)
        local var1 = UrlBuilder.fromString(`create:dashboard/creations/experiences/\{universeId}/{str1}`)(
            { universeId = universeId }
        )
        if rangeType ~= nil then
            var1 = UrlBuilder.addQueryString(var1, { rangeType = rangeType })
        end
        return var1
    end,
    publishExperience = function(tbl1)
        local function publishPlace() -- Luacid: Inlined by compiler; 1 call site recovered
            return saveAndPublishPlace({ placeId = tbl1.placeId, title = tbl1.title, description = tbl1.description })
        end

        local var1

        if tbl1.isActive then
            local universeActivationStore = UniverseActivation.getUniverseActivationStore()

            var1 = publishPlace():andThen(function(publishResult)
                return setAudiencesForPublish(universeActivationStore, tbl1.universeId, tbl1.audiences):andThen(function()
                    return publishResult
                end, function(arg1)
                    return Promise.reject((audienceFailure(arg1, publishResult)))
                end)
            end)
        else
            local universeActivationStore = UniverseActivation.getUniverseActivationStore()
            debug2.log(
                "info",
                "GameConfigurationActions publish activate-and-set-audience started",
                {
                    universeId = tbl1.universeId,
                    placeId = tbl1.placeId
                }
            )

            local function setPublicAudience() -- Luacid: Inlined by compiler; 1 call site recovered
                return setAudiencesForPublish(universeActivationStore, tbl1.universeId, tbl1.audiences):andThen(function()
                    if not bool1 then
                        return nil
                    end

                    return universeActivationStore.activate(tbl1.universeId):catch(function(arg1)
                        debug2.log(
                            "warn",
                            "GameConfigurationActions second activate failed",
                            {
                                error = tostring(arg1),
                                universeId = tbl1.universeId
                            }
                        )
                    end)
                end)
            end

            var1 = universeActivationStore.activate(tbl1.universeId):andThen(function()
                return publishPlace()
            end):andThen(function(publishResult)
                return setPublicAudience():andThen(function()
                    return publishResult
                end, function(arg1)
                    return Promise.reject((audienceFailure(arg1, publishResult)))
                end)
            end)
        end

        return var1:finally(function()
            rehydrateGameMetadata(tbl1.universeId)
            return var1
        end)
    end,
    getExperienceQuestionnaireUrl = function(universeId: number)
        return string3({ universeId = universeId })
    end,
    saveAndPublishPlace = saveAndPublishPlace,
    archiveGame = function(universeId: number)
        debug2.log("info", "GameConfigurationActions archive started", { universeId = universeId })

        return UniverseConfiguration.getUniverseConfigurationStore().patchConfiguration(universeId, { isArchived = true }):andThen(
            function()
                debug2.log("info", "GameConfigurationActions archive succeeded", { universeId = universeId })

                UniverseSearch.getUniverseSearchStore().invalidateAll()
                GetBuildExperienceRefreshStore().bumpRefreshTick()
            end
        ):catch(
            function(arg1)
                debug2.log("warn", "GameConfigurationActions archive failed", { error = tostring(arg1), universeId = universeId })

                if FFlagBuildExperienceActionOutcomeTelemetry then
                    return Promise.reject(arg1)
                end
            end
        )
    end,
    updateCachedAudience = updateCachedAudience,
    updateTitleDescription = function(universeId: number, name: string, description: string)
        debug2.log("info", "GameConfigurationActions title and description update started", { universeId = universeId })

        return UniverseConfiguration.getUniverseConfigurationStore().patchConfiguration(
            universeId,
            { name = name, description = description }
        ):andThen(
            function(arg1)
                UniverseSearch.getUniverseSearchStore().updateSearchItem(universeId, { name = name, description = description })

                local gameInfoStore = DataHydration.Game.getGameInfoStore(false)
                if gameInfoStore.updateGameInfo == nil then
                    debug2.log(
                        "warn",
                        "GameConfigurationActions updateGameInfo unavailable",
                        { universeId = universeId, source = "updateTitleDescription" }
                    )
                else
                    gameInfoStore.updateGameInfo(tostring(universeId), { name = name, description = description })
                end

                return arg1
            end
        )
    end
}
