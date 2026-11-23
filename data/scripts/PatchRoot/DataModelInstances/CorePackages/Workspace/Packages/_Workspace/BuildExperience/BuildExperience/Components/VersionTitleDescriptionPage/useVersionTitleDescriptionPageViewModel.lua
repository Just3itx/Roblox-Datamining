-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)

local GetVersionInformationStore = require(BuildExperience.Stores.GetVersionInformationStore)
local ConfigurationActionTelemetry = require(BuildExperience.Telemetry.ConfigurationActionTelemetry)
local FFlagBuildExperienceActionOutcomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceActionOutcomeTelemetry)
local _VersionTitleDescriptionPageView = require(script.Parent.VersionTitleDescriptionPageView)

local DataStatus = DataHydration.DataStatus

local function useVersionTitleDescriptionPageViewModel(tbl1)
    local versionInformationStore = GetVersionInformationStore()
    local placeVersionHistoryStore = PlaceVersionHistory.getPlaceVersionHistoryStore()
    local var1 = React.useMemo(function()
        return placeVersionHistoryStore.fetchHistory(tbl1.placeId)
    end, { tbl1.placeId, placeVersionHistoryStore })
    local var2 = SignalsReact.useSignalState(var1.data)
    local var3 = SignalsReact.useSignalState(var1.status)
    local var4 = SignalsReact.useSignalState(versionInformationStore.getDraft)
    if var4 == nil or var4.placeId ~= tbl1.placeId then
        var4 = nil
    end

    local placeVersion = if var2 == nil then nil else var2.placeVersions[1]
    local title = if placeVersion == nil then nil else placeVersion.title
    local description = if placeVersion == nil then nil else placeVersion.description
    local current = var4 == nil and (title or "") or var4.title
    local var5 = var4 == nil and (description or "") or var4.description
    local bool1 = var3 == DataStatus.Ready or var3 == DataStatus.Failed
    local bool2 = var4 ~= nil or bool1

    local titleText, onTitleChanged = React.useBinding("")
    local descriptionText, onDescriptionChanged = React.useBinding("")
    local var11 = React.useRef("")
    local var12 = React.useRef("")
    local var13, var14 = React.useState(nil)

    React.useEffect(function()
        if not bool2 then
            return
        end

        local bool3 = titleText:getValue() ~= var11.current or descriptionText:getValue() ~= var12.current
        if var13 == tbl1.placeId and bool3 then
            return
        end

        var11.current = current
        var12.current = var5
        onTitleChanged(current)
        onDescriptionChanged(var5)
        var14(tbl1.placeId)
    end, {
        descriptionText,
        var5,
        current,
        var13,
        bool2,
        tbl1.placeId,
        titleText
    })

    local onFocusLost = React.useCallback(function()
        if var13 ~= tbl1.placeId then
            return
        end

        local value = titleText:getValue()
        local value2 = descriptionText:getValue()
        if value == var11.current and value2 == var12.current then
            return
        end

        versionInformationStore.setDraft(tbl1.placeId, value, value2)
        if FFlagBuildExperienceActionOutcomeTelemetry then
            ConfigurationActionTelemetry.sendSuccess(
                ConfigurationActionTelemetry.Action.VersionDetailsSave,
                {
                    placeId = tbl1.placeId
                },
                nil,
                {
                    changedFields = ConfigurationActionTelemetry.getChangedFields(value ~= var11.current, value2 ~= var12.current)
                }
            )
        end

        var11.current = value
        var12.current = value2
    end, {
        descriptionText,
        var13,
        tbl1.placeId,
        titleText,
        versionInformationStore
    })

    React.useEffect(function()
        return onFocusLost
    end, { onFocusLost })

    local onBack = React.useCallback(function()
        onFocusLost()
        tbl1.onBack()
    end, { tbl1.onBack, onFocusLost })

    return {
        isReady = var13 == tbl1.placeId,
        onBack = onBack,
        onDescriptionChanged = onDescriptionChanged,
        onFocusLost = onFocusLost,
        onTitleChanged = onTitleChanged,
        titleText = titleText,
        descriptionText = descriptionText,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }
end

return useVersionTitleDescriptionPageViewModel
