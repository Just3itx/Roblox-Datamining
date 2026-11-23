-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local DataHydration = require(BuildExperienceParent.DataHydration)
local Localization = require(BuildExperienceParent.Localization)
local PlaceVersionHistory = require(BuildExperienceParent.DataHydration.PlaceVersionHistory)
local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local Time = require(BuildExperienceParent.Time)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local GetAgentRollbackRequestStore = require(BuildExperience.Stores.GetAgentRollbackRequestStore)
local GetPlaytestLoadingStore = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.GetPlaytestLoadingStore)
local AgentRollbackSnackbar = require(script.Parent.AgentRollbackSnackbar)
local useLatestVersionCardViewModel = require(script.Parent.LatestVersionCard.useLatestVersionCardViewModel)
local useLiveVersionCardViewModel = require(script.Parent.LiveVersionCard.useLiveVersionCardViewModel)
local useNextHistoryPage = require(script.Parent.useNextHistoryPage)
local VersionHistoryBottomSheet = require(script.Parent.VersionHistoryBottomSheet)
local VersionHistoryUtils = require(script.Parent.VersionHistoryUtils)
local useScrollToTopAfterRestore = require(script.Parent.useScrollToTopAfterRestore)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)

local DataStatus = DataHydration.DataStatus
local DateHelper = Time.DateHelper
local useLocalization = Localization.Hooks.useLocalization

local function formatLocalizedVersionNumber(versionNumber: number, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = if versionNumber < 10 then LocalizationStrings.VERSION_HISTORY_VERSION_PADDED else LocalizationStrings.VERSION_HISTORY_VERSION_COMPACT
    return arg1:Format(var1, { VERSION_NUMBER = versionNumber })
end

local function formatLocalizedCreatedDate(createdTime: string?, tbl1, arg1)
    local var1, day, year = VersionHistoryUtils.getCreatedDateParts(createdTime)
    assert(tbl1[var1] ~= nil, `No localized month found for month {var1}`)

    return arg1:Format(LocalizationStrings.VERSION_HISTORY_CREATED_DATE, { MONTH = tbl1[var1], DAY = day, YEAR = year })
end

local function formatLocalizedBadge(arg1, badgeKind: string?, arg2)
    if badgeKind == "published" then
        return arg2:Format(LocalizationStrings.VERSION_HISTORY_PUBLISHED)
    elseif badgeKind == "previouslyPublished" then
        return arg2:Format(LocalizationStrings.VERSION_HISTORY_PREVIOUSLY_PUBLISHED)
    elseif badgeKind == "restored" and arg1.parentAssetVersionId ~= nil then
        return arg2:Format(
            LocalizationStrings.VERSION_HISTORY_RESTORED_BADGE,
            {
                VERSION = formatLocalizedVersionNumber(arg1.parentAssetVersionId, arg2)
            }
        )
    elseif badgeKind == "autosaved" then
        return arg2:Format(LocalizationStrings.VERSION_HISTORY_AUTOSAVED)
    end
    return nil
end

local function mapLocalizedVersionToEntry(arg1, tbl1, description: string, arg2)
    local versionNumber = VersionHistoryUtils.getVersionNumber(arg1)
    local title = if arg1.title ~= nil and arg1.title ~= "" then arg1.title else arg2:Format(LocalizationStrings.VERSION_HISTORY_VERSION_TITLE, { VERSION = versionNumber })

    if arg1.description ~= nil and arg1.description ~= "" then
        description = arg1.description
    end
    local createdDate = formatLocalizedCreatedDate(arg1.createdTime, tbl1, arg2)
    local badgeKind = VersionHistoryUtils.getBadgeKind(arg1)

    return {
        id = tostring(versionNumber),
        versionNumber = versionNumber,
        versionLabel = arg2:Format(
            LocalizationStrings.VERSION_HISTORY_VERSION_LABEL,
            {
                VERSION = formatLocalizedVersionNumber(versionNumber, arg2),
                CREATED_DATE = createdDate
            }
        ),
        title = title,
        description = description,
        noteTitle = arg1.title,
        noteDescription = arg1.description,
        badgeText = formatLocalizedBadge(arg1, badgeKind, arg2),
        isAutosaved = badgeKind == "autosaved"
    }
end

local function mapLocalizedHistoryToEntries(arg1, tbl1, fallbackDescription: string, arg2)
    if arg1 == nil or arg1.placeVersions == nil then
        return {}
    end

    local result = {}
    for _, placeVersion in arg1.placeVersions do
        table.insert(result, (mapLocalizedVersionToEntry(placeVersion, tbl1, fallbackDescription, arg2)))
    end

    return result
end

local function getStatusText(str1: string, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if str1 == DataStatus.NotReady then
        return LocalizationStrings.VERSION_HISTORY_LOADING
    end

    if str1 == DataStatus.Failed then
        return LocalizationStrings.VERSION_HISTORY_LOAD_FAILED
    end

    if #tbl1 == 0 then
        return LocalizationStrings.VERSION_HISTORY_EMPTY
    end

    return nil
end

local function localizeStatusText(statusText: string?, loading: string, loadFailed: string, empty: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if statusText == LocalizationStrings.VERSION_HISTORY_LOADING then
        return loading
    end

    if statusText == LocalizationStrings.VERSION_HISTORY_LOAD_FAILED then
        return loadFailed
    end

    if statusText == LocalizationStrings.VERSION_HISTORY_EMPTY then
        return empty
    end

    return statusText
end

local function useAgentRollbackRestore(tbl1, restoreFailed: string, bool1: boolean)
    local errorText, var2 = React.useState(nil)
    local var3 = React.useRef(false)
    local agentRollbackRequestStore = GetAgentRollbackRequestStore(false)
    local isPendingForPlaceId = agentRollbackRequestStore.getIsPendingForPlaceId(tbl1.placeId)
    local isPending = SignalsReact.useSignalState(isPendingForPlaceId)

    React.useEffect(function()
        var3.current = true
        return function()
            var3.current = false
        end
    end, {})

    return {
        clearError = React.useCallback(function()
            var2(nil)
        end, {}),
        errorText = errorText,
        isPending = isPending,
        onRestore = React.useCallback(function(arg1)
            if isPendingForPlaceId(false) or bool1 then
                return
            end

            var2(nil)
            local var5 = agentRollbackRequestStore.request(
                {
                    universeId = tbl1.universeId,
                    placeId = tbl1.placeId
                },
                {
                    versionNumber = arg1.versionNumber,
                    noteTitle = arg1.noteTitle,
                    noteDescription = arg1.noteDescription
                }
            )

            var5:catch(function()
                if var3.current then
                    var2(restoreFailed)
                end
            end)
            return var5
        end, {
            bool1,
            isPendingForPlaceId,
            agentRollbackRequestStore,
            tbl1.universeId,
            tbl1.placeId,
            restoreFailed
        })
    }
end

local function VersionHistoryContainer(tbl1)
    local var1 = useLocalization(DateHelper.MonthsLocalizationKeys)
    local var2 = useLocalization({
        empty = LocalizationStrings.VERSION_HISTORY_EMPTY,
        fallbackDescription = LocalizationStrings.VERSION_HISTORY_FALLBACK_DESCRIPTION,
        loadFailed = LocalizationStrings.VERSION_HISTORY_LOAD_FAILED,
        loading = LocalizationStrings.VERSION_HISTORY_LOADING,
        restoreFailed = LocalizationStrings.VERSION_HISTORY_RESTORE_FAILED
    })
    local var3 = React.useContext(Localization.LocalizationRoactContext)
    local restoreFailed = var2.restoreFailed
    local fallbackDescription = var2.fallbackDescription
    local var4 = React.useMemo(function()
        return tbl1.store or PlaceVersionHistory.getPlaceVersionHistoryStore()
    end, { tbl1.store })
    local var5 = React.useMemo(function()
        return var4.fetchHistory(tbl1.placeId)
    end, { var4, tbl1.placeId })
    local var6 = SignalsReact.useSignalState(var5.data)
    local var7 = SignalsReact.useSignalState(var5.status)
    local onEndReached = useNextHistoryPage(var4, tbl1.placeId, var6)
    local var9 = useScrollToTopAfterRestore()
    local var10 = React.useCallback(function(arg1): boolean
        return GetPlaytestLoadingStore(arg1).getAgentStatusForPlaceId(tbl1.placeId)(arg1) == "Loading"
    end, { tbl1.placeId })
    local var11 = SignalsReact.useSignalState(var10)
    local liveVersion = useLiveVersionCardViewModel({
        placeId = tbl1.placeId,
        universeId = tbl1.universeId,
        testId = if tbl1.testId then `{tbl1.testId}-live-version-card` else nil
    })
    local tbl2 = useAgentRollbackRestore(tbl1, restoreFailed, var11)

    local entries = React.useMemo(function()
        return (mapLocalizedHistoryToEntries(var6, var1, fallbackDescription, var3))
    end, {
        var6,
        var1,
        fallbackDescription,
        var3,
        var2[Localization.RobloxLocaleIdKey]
    })

    local permissions = if FFlagBuildCheckGamePermissions then useGamePermissions({ universeId = tbl1.universeId }) else nil
    local var15 = not FFlagBuildCheckGamePermissions or permissions.canEditOnBuild
    local latestVersion = useLatestVersionCardViewModel({
        entry = entries[1],
        placeId = tbl1.placeId,
        universeId = tbl1.universeId,
        onClose = tbl1.onClose,
        permissions = permissions,
        layoutOrder = 0,
        testId = if tbl1.testId then `{tbl1.testId}-latest-version-card` else nil
    })

    local statusText = localizeStatusText(getStatusText(var7, entries), var2.loading, var2.loadFailed, var2.empty)

    return React.createElement(React.Fragment, nil, {
        BottomSheet = React.createElement(VersionHistoryBottomSheet, {
            isOpen = tbl1.isOpen,
            entries = entries,
            statusText = statusText,
            isRestoreDisabled = tbl2.isPending or var11 or not var15,
            onClose = tbl1.onClose,
            onRestore = tbl2.onRestore,
            onRestoreStarted = tbl1.onAgentRollbackStarted,
            scrollingFrameRef = var9.scrollingFrameRef,
            onEndReached = onEndReached,
            testId = tbl1.testId,
            liveVersion = liveVersion,
            latestVersion = latestVersion
        }),
        RestoreErrorSnackbar = if tbl2.errorText == nil then nil else React.createElement(AgentRollbackSnackbar, { title = tbl2.errorText, onClose = tbl2.clearError })
    })
end

return VersionHistoryContainer
