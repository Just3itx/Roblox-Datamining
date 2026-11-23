-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local FIntBuildExperienceVersionHistoryLoadMoreViewportPercent = require(BuildExperience.Flags.FIntBuildExperienceVersionHistoryLoadMoreViewportPercent)
local LatestVersionCardView = require(script.Parent.LatestVersionCard.LatestVersionCardView)
local LiveVersionCardView = require(script.Parent.LiveVersionCard.LiveVersionCardView)
local RestoreVersionDialog = require(script.Parent.RestoreVersionDialog)
local VersionHistoryCard = require(script.Parent.VersionHistoryCard)
local VersionHistorySection = require(script.Parent.VersionHistorySection)
local useScrollEndReached = require(script.Parent.useScrollEndReached)
local useScrollPerformanceTracker = require(BuildExperience.Telemetry.useScrollPerformanceTracker)

local Checkbox = Foundation.Checkbox
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View
local useScaledValue = Foundation.Hooks.useScaledValue

local VERSION_HISTORY_VERSIONS_TITLE = LocalizationStrings.VERSION_HISTORY_VERSIONS_TITLE

local function VersionHistoryContent(tbl1)
    useScrollPerformanceTracker("LuaApp_Build_VersionHistory_Scroll", tbl1.scrollingFrameRef)
    useScrollEndReached(
        tbl1.scrollingFrameRef,
        FIntBuildExperienceVersionHistoryLoadMoreViewportPercent / 100,
        tbl1.onEndReached
    )

    return React.createElement(Sheet.Content, { scrollingFrameRef = tbl1.scrollingFrameRef }, tbl1.children)
end

local function VersionHistoryBottomSheet(tbl1)
    local testId = tbl1.testId or "version-history-bottom-sheet"
    local var1 = React.useRef(nil)
    local scrollingFrameRef = tbl1.scrollingFrameRef or var1
    local var3, var4 = React.useState(nil)
    local isLoading, var6 = React.useState(false)
    local isChecked, onActivated = React.useState(true)
    local var9 = useLocalization({
        allVersions = LocalizationStrings.VERSION_HISTORY_ALL_VERSIONS,
        hideAutosaved = LocalizationStrings.VERSION_HISTORY_HIDE_AUTOSAVED,
        published = LocalizationStrings.VERSION_HISTORY_PUBLISHED,
        title = VERSION_HISTORY_VERSIONS_TITLE
    })
    local hideAutosaved = var9.hideAutosaved
    local title = var9.title
    local onClose = React.useCallback(function()
        var4(nil)
        tbl1.onClose()
    end, { tbl1.onClose })

    local var11 = React.useCallback(function(tbl2)
        var4(tbl2)
    end, {})

    local onCancel = React.useCallback(function()
        if isLoading then
            return
        end
        var4(nil)
    end, { isLoading })

    local onRestore = React.useCallback(function()
        if var3 == nil or tbl1.isRestoreDisabled or isLoading then
            return
        end

        var6(true)
        local var13 = tbl1.onRestore(var3)
        if var13 == nil then
            var6(false)
            return
        end

        var13:andThen(function()
            var6(false)
            var4(nil)
            if tbl1.onRestoreStarted ~= nil then
                tbl1.onRestoreStarted()
            end
        end):catch(function()
            var6(false)
        end)
    end, {
        var3,
        tbl1.isRestoreDisabled,
        tbl1.onRestore,
        tbl1.onRestoreStarted,
        isLoading
    })

    local var14 = React.useMemo(function()
        local result = {}

        local bool1 = tbl1.latestVersion ~= nil
        if bool1 then
            result.LatestVersionCard = React.createElement(LatestVersionCardView, tbl1.latestVersion)
        end
        for layoutOrder, value2 in tbl1.entries do
            if bool1 and layoutOrder == 1 or isChecked and value2.isAutosaved then
                continue
            end

            local str1 = `{testId}-card-{value2.id}`
            local id = value2.id
            local createElement = React.createElement
            local var14 = VersionHistoryCard
            local tbl2 = {
                layoutOrder = layoutOrder,
                versionLabel = value2.versionLabel,
                title = value2.title,
                description = value2.description,
                badgeText = value2.badgeText,
                isRestoreDisabled = tbl1.isRestoreDisabled,
                onRestore = 0,
                testId = 0
            }

            function tbl2.onRestore()
                var11(value2)
            end
            tbl2.testId = str1
            result[id] = createElement(var14, tbl2)
        end

        return result
    end, {
        tbl1.entries,
        tbl1.isRestoreDisabled,
        tbl1.latestVersion,
        isChecked,
        var11,
        testId
    })

    local tbl2 = {
        AutosaveFilter = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row size-full-0 auto-y"
        }, {
            Checkbox = React.createElement(Checkbox, {
                label = hideAutosaved,
                isChecked = isChecked,
                onActivated = onActivated,
                testId = `{testId}-autosave-filter`
            })
        }),
        Status = if tbl1.statusText then React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl1.statusText,
            tag = "size-full-0 auto-y padding-bottom-medium text-body-medium text-wrap text-align-x-left content-default"
        }) else nil,
        Cards = React.createElement(View, { LayoutOrder = 3, tag = "col gap-medium size-full-0 auto-y padding-bottom-large" }, var14)
    }

    local allVersions = var9.allVersions
    local published = var9.published
    local offset = useScaledValue(32)
    local tbl3 = {
        Sections = React.createElement(View, {
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, offset)
            },
            tag = "col size-full-0 auto-y",
            testId = `{testId}-sections`
        }, {
            Published = if tbl1.liveVersion then React.createElement(
                VersionHistorySection,
                {
                    layoutOrder = 1,
                    title = published,
                    testId = `{testId}-published`
                },
                {
                    LiveVersionCard = React.createElement(LiveVersionCardView, tbl1.liveVersion)
                }
            ) else nil,
            AllVersions = React.createElement(
                VersionHistorySection,
                {
                    layoutOrder = 2,
                    title = allVersions,
                    testId = `{testId}-all-versions`
                },
                tbl2
            )
        })
    }

    return React.createElement(React.Fragment, nil, {
        Sheet = React.createElement(Sheet.Root, {
            isOpen = tbl1.isOpen == nil or tbl1.isOpen,
            snapPoints = { 0.5, 1 },
            defaultSnapPointIndex = 2,
            onClose = onClose,
            testId = testId
        }, {
            Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
                Title = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = title,
                    tag = {
                        ["shrink auto-xy text-wrap text-align-x-left content-emphasis"] = true,
                        ["text-heading-medium"] = true
                    }
                })
            }),
            Content = React.createElement(
                VersionHistoryContent,
                {
                    scrollingFrameRef = scrollingFrameRef,
                    onEndReached = tbl1.onEndReached
                },
                tbl3
            )
        }),
        RestoreDialog = if var3 then React.createElement(RestoreVersionDialog, {
            isOpen = true,
            title = var3.versionLabel,
            description = var3.description,
            isLoading = isLoading,
            onRestore = onRestore,
            onCancel = onCancel
        }) else nil
    })
end

return VersionHistoryBottomSheet
