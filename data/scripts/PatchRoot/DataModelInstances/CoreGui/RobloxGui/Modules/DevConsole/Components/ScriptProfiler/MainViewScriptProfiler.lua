-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local ScriptProfilerService = game:GetService("ScriptProfilerService")
local Players = game:GetService("Players")

local Immutable = require(script.Parent.Parent.Parent.Immutable)

local Components = script.Parent.Parent.Parent.Components
local UtilAndTab = require(Components.UtilAndTab)
local BoxButton = require(Components.BoxButton)
local DropDown = require(Components.DropDown)
local ProfilerView = require(script.Parent.ProfilerView)
local ProfilerFunctionsView = require(script.Parent.ProfilerFunctionsView)
local _ProfilerDataFormatV2 = require(script.Parent.ProfilerDataFormatV2)
local ProfilerExportView = require(script.Parent.ProfilerExportView)
local MobileSettingsView = require(script.Parent.MobileSettingsView)

local ProfilerUtil = require(script.Parent.ProfilerUtil)
local getPluginFlag = ProfilerUtil.getPluginFlag
local getDurations = ProfilerUtil.getDurations
local formatFrequency = ProfilerUtil.formatFrequency

local Actions = script.Parent.Parent.Parent.Actions
local SetScriptProfilerState = require(Actions.SetScriptProfilerState)
local SetIsProfiling = require(script.Parent.Actions.SetIsProfiling)
local SetData = require(script.Parent.Actions.SetData)
local SetThreads = require(script.Parent.Actions.SetThreads)
local SetTimerState = require(script.Parent.Actions.SetTimerState)
local ClearStateForNewProfilingSession = require(script.Parent.Actions.ClearStateForNewProfilingSession)
local SetAverage = require(script.Parent.Actions.SetAverage)
local SetFrequency = require(script.Parent.Actions.SetFrequency)
local SetDataView = require(script.Parent.Actions.SetDataView)
local SetLiveUpdate = require(script.Parent.Actions.SetLiveUpdate)
local SetShowPlugins = require(script.Parent.Actions.SetShowPlugins)
local SetShowGC = require(script.Parent.Actions.SetShowGC)
local SetSearchData = require(script.Parent.Actions.SetSearchData)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding
local SmallFrameHeight = Constants.UtilityBarFormatting.SmallFrameHeight

local MainWindowHeader = Constants.Font.MainWindowHeader
local MainWindowHeader2 = Constants.DefaultFontSize.MainWindowHeader
local ConstantsColorText = Constants.Color.Text
local UnselectedGray = Constants.Color.UnselectedGray

local var1 = Roact.PureComponent:extend("MainViewScriptProfiler")

local bool1 = game:DefineFastFlag("ScriptProfilerShowPlugins2", false)

local num1 = game:DefineFastInt("ScriptProfilerLiveUpdateIntervalMS", 1000)

local dropDownList = { "Callgraph", "Functions" }

local function annotateSearchFilterNodes(arg1, tbl2, tbl3, num2: number, num3: number, bool2: boolean)
    local var2 = arg1.Nodes[num3]

    if not var2.Children then
        if num2 > 0 then
            bool2 = tbl2[num2] or bool2
        end

        tbl3[num3] = bool2
        return num2 > 0 and tbl2[num2]
    end

    local children = var2.Children

    local bool3 = false

    if not (num2 > 0 and tbl2[num2]) then
        for k, child in pairs(children) do
            local var3 = annotateSearchFilterNodes(arg1, tbl2, tbl3, k, child, bool2)
            bool3 = bool3 or var3
        end

        if bool3 or bool2 then
            tbl3[num3] = true
        end

        return bool3
    end

    local bool4 = true

    tbl3[num3] = true

    for k, child in pairs(children) do
        tbl3[child] = true

        annotateSearchFilterNodes(arg1, tbl2, tbl3, k, child, true)
    end

    return bool4
end

local function generateSearchFilters(arg1, searchTerm: string)
    if searchTerm == "" then
        return nil, nil
    end

    local data = arg1.data
    if not data then
        return nil, nil
    end

    local tbl2 = table.create(#data.Functions, false)

    for k, _function in data.Functions do
        local name = ProfilerUtil.getName(data, _function)

        if name and string.find(name, searchTerm, 1, true) then
            tbl2[k] = true
        end
    end

    local tbl3 = table.create(#data.Nodes, false)

    for _, value in data.Categories do
        local nodeId = value.NodeId
        local var2 = data.Nodes[nodeId]

        if not var2.Children then
            tbl3[nodeId] = false
        else
            local children = var2.Children

            local bool2 = false

            for k, child in pairs(children) do
                local var3 = annotateSearchFilterNodes(data, tbl2, tbl3, k, child, false)
                bool2 = bool2 or var3
            end

            if bool2 then
                tbl3[nodeId] = true
            end
        end
    end
    for k, _function in data.Functions do
        if tbl2[k] == true or ProfilerUtil.getName(data, _function) then
            continue
        end

        local sourceName = ProfilerUtil.getSourceName(data, _function)
        if sourceName and string.find(sourceName, searchTerm, 1, true) then
            tbl2[k] = true
        end
    end

    return tbl2, tbl3
end

local function generatePluginDurationOffsets(gcNodeOffsets, data)
    if not data then
        return {}, {}
    end

    assert(data.Version == 2)

    local tbl2 = table.create(#data.Categories, 0)
    local tbl3 = table.create(#data.Categories, 0)

    local num2 = 0
    local num3 = 0
    for value, value2 in data.Categories do
        local num4 = 0
        local num5 = 0
        local children = data.Nodes[value2.NodeId].Children
        if children then
            for k, child in pairs(children) do
                local _function = data.Functions[k]

                if not getPluginFlag(data, data.Functions[k]) then
                    continue
                end

                num4 += getDurations(data, child)

                if #gcNodeOffsets > 0 then
                    num5 += gcNodeOffsets[child]
                end
            end
        end

        tbl2[value] = num4
        tbl3[value] = num5
        num2 += num4
        num3 += num5
    end

    tbl2.Total = num2
    tbl3.Total = num2
    return tbl2, tbl3
end

local function getGCOverhead(tbl2, tbl3, arg1, arg2, arg3)
    local var2 = arg1.Nodes[arg2]
    local num2 = 0

    if var2.Children then
        for k, child in pairs(var2.Children) do
            local var3 = if k == arg3 then arg1.Nodes[child].TotalDuration else getGCOverhead(tbl2, tbl3, arg1, child, arg3)
            tbl2[k] += var3
            tbl3[child] = var3
            num2 += var3
        end
    end

    return num2
end

local function generateGCOverheadOffsets(data)
    if not (data and data.GCFuncId) then
        return {}, {}
    end

    local gcFuncId = data.GCFuncId

    local tbl2 = table.create(#data.Functions, 0)
    local tbl3 = table.create(#data.Nodes, 0)

    local num2 = 0

    for _, value in data.Categories do
        local nodeId = value.NodeId

        local gCOverhead = getGCOverhead(tbl2, tbl3, data, nodeId, gcFuncId)
        num2 += gCOverhead

        tbl3[nodeId] = gCOverhead
    end

    tbl3.Total = num2

    return tbl2, tbl3
end

function var1.getActiveState(arg1)
    local isClientView = arg1.props.isClientView

    if arg1.props.isClientView then
        return isClientView, arg1.props.client
    end

    return isClientView, arg1.props.server
end

function var1.getState(arg1, arg2)
    return if arg2 then arg1.props.client else arg1.props.server
end

function var1.UpdateState(arg1, arg2, arg3)
    if arg2 then
        arg1.props.dispatchSetScriptProfilerState(nil, nil, arg3, nil)
        return
    end
    arg1.props.dispatchSetScriptProfilerState(nil, nil, nil, arg3)
end

local function OnNewProfilingData(tbl2, state, jsonString: string?)
    tbl2.serializedData = jsonString
    tbl2.data = ScriptProfilerService:DeserializeJSON(jsonString)

    local gcFunctionOffsets, gcNodeOffsets = generateGCOverheadOffsets(tbl2.data)
    tbl2.gcFunctionOffsets = gcFunctionOffsets
    tbl2.gcNodeOffsets = gcNodeOffsets

    if bool1 then
        local pluginOffsets, pluginGcOffsets = generatePluginDurationOffsets(tbl2.gcNodeOffsets, tbl2.data)
        tbl2.pluginOffsets = pluginOffsets
        tbl2.pluginGCOffsets = pluginGcOffsets
    end

    local nodesLen = tbl2.data and #tbl2.data.Nodes or 0
    local nodesLen2 = state.data and #state.data.Nodes or 0
    local tbl1 = table.create(nodesLen, false)
    local expandedNodes = state.expandedNodes
    table.move(expandedNodes, 1, nodesLen2, 1, tbl1)
    tbl2.expandedNodes = tbl1
end

function var1.init(arg1)
    local function StartScriptProfiling(arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
        if arg2 then
            ScriptProfilerService:ClientStart(Players.LocalPlayer, arg3.frequency)
            return
        end
        ScriptProfilerService:ServerStart(arg3.frequency)
    end

    local function StopScriptProfiling(arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
        if arg2 then
            ScriptProfilerService:ClientStop(Players.LocalPlayer)
        else
            ScriptProfilerService:ServerStop()
        end
        return nil
    end

    local function RequestNewData(arg2) -- Luacid: Inlined by compiler; 4 call sites recovered
        if arg2 then
            ScriptProfilerService:ClientRequestData(Players.LocalPlayer)
            return
        end
        ScriptProfilerService:ServerRequestData()
    end

    local function StopTimedProfiling(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        if arg1:getState(arg2).isProfiling then
            StopScriptProfiling(arg2)
            arg1.props.dispatchSetIsProfiling(arg2, false)
            RequestNewData(arg2)
        end
    end

    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    local function UpdateTimedProfilingTimer(arg2)
        while task.wait(0.5) do
            local timedProfilingCountdown = arg1:getState(arg2).timedProfilingCountdown

            if timedProfilingCountdown <= 0 then
                break
            end

            arg1.props.dispatchSetTimer(arg2, { timedProfilingCountdown = timedProfilingCountdown - 0.5 })
        end
    end

    local function LiveUpdate(arg2)
        while task.wait(num1 / 1000) do
            if arg1:getState(arg2).liveUpdate then
                RequestNewData(arg2)
            end
        end
    end

    function arg1.onBeginProfile()
        local var2, var3 = arg1:getActiveState()
        StartScriptProfiling(var2, var3)
        arg1.props.dispatchSetIsProfiling(var2, true)
        arg1.props.dispatchClearStateForNewSession(var2)

        local tbl2 = {}

        if var3.timedProfilingDuration > 0 then
            arg1.props.dispatchSetTimer(var2, { timedProfilingCountdown = var3.timedProfilingDuration })

            tbl2.timedProfilingThread = task.delay(var3.timedProfilingDuration, function()
                StopTimedProfiling(var2)
            end)

            tbl2.timedProfilingTimerThread = task.spawn(function()
                UpdateTimedProfilingTimer(var2)
            end)
        end

        tbl2.liveUpdateThread = task.spawn(LiveUpdate, var2)

        arg1.props.dispatchSetThreads(var2, tbl2)
    end

    function arg1.onEndProfile()
        local var2, var3 = arg1:getActiveState()
        StopScriptProfiling(var2)
        local tbl2 = {}

        if var3.timedProfilingThread then
            task.cancel(var3.timedProfilingThread)
            tbl2.timedProfilingThread = nil
        end

        if var3.timedProfilingTimerThread then
            task.cancel(var3.timedProfilingTimerThread)
            tbl2.timedProfilingTimerThread = nil
        end

        if var3.liveUpdateThread then
            task.cancel(var3.liveUpdateThread)
            tbl2.liveUpdateThread = nil
        end

        arg1.props.dispatchSetThreads(var2, {})
        arg1.props.dispatchSetIsProfiling(var2, false)
        RequestNewData(var2)
    end

    function arg1.toggleTimedProfiling()
        local var2, var3 = arg1:getActiveState()

        local timedProfilingDuration = var3.timedProfilingDuration

        arg1.props.dispatchSetTimer(var2, {
            timedProfilingDuration = if timedProfilingDuration == 0 then 60 elseif timedProfilingDuration == 60 then 300 elseif timedProfilingDuration == 300 then 600 else 0
        })
    end
    function arg1.toggleAverage()
        local var2, var3 = arg1:getActiveState()

        local average = var3.average

        arg1.props.dispatchSetAverage(
            var2,
            if average == 0 then 1 elseif average == 1 then 60 elseif average == 60 then 300 elseif average == 300 then 600 else 0
        )
    end
    function arg1.toggleUnits()
        arg1.props.dispatchSetScriptProfilerState(nil, not arg1.props.usePercentages, nil, nil)
    end

    function arg1.toggleFrequency()
        local var2, var3 = arg1:getActiveState()

        local num2 = if var3.frequency == 1000 then 10000 else 1000

        arg1.props.dispatchSetFrequency(var2, num2)
    end

    function arg1.onClientButton()
        arg1.props.dispatchSetScriptProfilerState(true)
    end

    function arg1.onServerButton()
        arg1.props.dispatchSetScriptProfilerState(false)
    end

    function arg1.dataViewDropDownCallback(arg2)
        local var2, var3 = arg1:getActiveState()

        local isFunctionsView = var3.isFunctionsView

        if arg2 == 1 then
            isFunctionsView = false
        elseif arg2 == 2 then
            isFunctionsView = true
        end

        arg1.props.dispatchSetDataView(var2, isFunctionsView)
    end

    function arg1.onCheckboxChanged(arg2, arg3)
        local isClientView = arg1.props.isClientView

        if arg2 == "Live" then
            arg1.props.dispatchSetLiveUpdate(isClientView, arg3)
        elseif arg2 == "Plugins" then
            arg1.props.dispatchSetShowPlugins(isClientView, arg3)
        elseif arg2 == "GC" then
            arg1.props.dispatchSetShowGC(isClientView, arg3)
        end
    end

    function arg1.onSearchTermChanged(searchTerm)
        local var2, var3 = arg1:getActiveState()

        local searchFilterFlat, searchFilterGraph = generateSearchFilters(var3, searchTerm)

        arg1.props.dispatchSetSearchData(
            var2,
            {
                searchTerm = searchTerm,
                searchFilterFlat = searchFilterFlat or {},
                searchFilterGraph = searchFilterGraph or {}
            }
        )
    end
    arg1.utilRef = Roact.createRef()

    arg1.state = { utilTabHeight = 0 }
end

function var1.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })

    arg1.scriptProfilerConnection = ScriptProfilerService.OnNewData:Connect(function(player: Player, jsonString: string)
        local bool2 = player ~= nil

        local state = arg1:getState(bool2)
        local tbl2 = {}

        OnNewProfilingData(tbl2, state, jsonString)

        arg1.props.dispatchSetData(bool2, tbl2)
    end)
end

function var1.willUnmount(arg1)
    arg1.scriptProfilerConnection:Disconnect()
    arg1.scriptProfilerConnection = nil
end

function var1.didUpdate(arg1)
    local currentSize = arg1.utilRef.current.Size
    if currentSize.Y.Offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = currentSize.Y.Offset })
    end
end

local function formatTimer(num2: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = ProfilerUtil.formatTimer(num2)

    return if var2 == "" then var2 else ": " .. var2
end

function var1.renderUtilButtons(arg1, arg2, arg3, arg4)
    local isProfiling = arg2.isProfiling

    local result = {}

    table.insert(
        result,
        Roact.createElement(
            BoxButton,
            {
                text = if isProfiling then "Stop" else "Start",
                onClicked = isProfiling and arg1.onEndProfile or arg1.onBeginProfile
            }
        )
    )

    if not arg4 then
        table.insert(
            result,
            Roact.createElement(
                BoxButton,
                {
                    text = if arg1.props.usePercentages then "Unit: %" else "Unit: ms",
                    onClicked = arg1.toggleUnits
                }
            )
        )
    end

    if not arg4 then
        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl2 = {
            Text = "Freq: " .. formatFrequency(arg2.frequency),
            TextSize = MainWindowHeader2,
            TextColor3 = ConstantsColorText,
            Font = MainWindowHeader,
            AutoButtonColor = true,
            BackgroundColor3 = if isProfiling then Constants.Color.InactiveBox else UnselectedGray,
            BackgroundTransparency = 0
        }
        tbl2[Roact.Event.Activated] = function()
            if not isProfiling then
                arg1.toggleFrequency()
            end
        end

        table.insert(result, createElement(str1, tbl2))
    end

    if not arg4 then
        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl2 = {}
        local str2 = "Time"
        local var2 = if isProfiling then arg2.timedProfilingCountdown else arg2.timedProfilingDuration
        tbl2.Text = str2 .. formatTimer(var2)

        tbl2.TextSize = MainWindowHeader2
        tbl2.TextColor3 = ConstantsColorText
        tbl2.Font = MainWindowHeader

        tbl2.AutoButtonColor = true
        tbl2.BackgroundColor3 = if isProfiling then Constants.Color.InactiveBox else UnselectedGray
        tbl2.BackgroundTransparency = 0

        tbl2[Roact.Event.Activated] = function()
            if not isProfiling then
                arg1.toggleTimedProfiling()
            end
        end

        table.insert(result, createElement(str1, tbl2))
    end

    if not arg4 then
        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl2 = {
            Text = "Average" .. formatTimer(arg2.average),
            TextSize = MainWindowHeader2,
            TextColor3 = ConstantsColorText,
            Font = MainWindowHeader,
            AutoButtonColor = true,
            BackgroundColor3 = if isProfiling then Constants.Color.InactiveBox else UnselectedGray,
            BackgroundTransparency = 0
        }
        tbl2[Roact.Event.Activated] = function()
            if not isProfiling then
                arg1.toggleAverage()
            end
        end

        table.insert(result, createElement(str1, tbl2))
    end

    if not arg4 then
        table.insert(result, Roact.createElement(BoxButton, { text = "Export", onClicked = arg1.props.dispatchStartExport }))
    end

    if not arg4 then
        table.insert(
            result,
            Roact.createElement(DropDown, {
                buttonSize = UDim2.new(0, 100, 0, SmallFrameHeight),
                dropDownList = dropDownList,
                selectedIndex = if arg2.isFunctionsView then 2 else 1,
                onSelection = arg1.dataViewDropDownCallback
            })
        )
    end

    if arg3 then
        table.insert(result, Roact.createElement(BoxButton, {
            text = "More...",
            onClicked = function()
                arg1.props.dispatchShowMobileSettings()
            end
        }))
    end

    return result
end

function var1.renderUtilAndTab(tbl2, tbl3, tbl4)
    local size = tbl2.props.size
    local formFactor = tbl2.props.formFactor
    local tabList = tbl2.props.tabList

    return Roact.createElement(
        UtilAndTab,
        Immutable.JoinDictionaries({
            windowWidth = size.X.Offset,
            formFactor = formFactor,
            tabList = tabList,
            layoutOrder = 1,
            refForParent = tbl2.utilRef,
            onHeightChanged = tbl2.onUtilTabHeightChanged
        }, tbl3),
        tbl4
    )
end

function var1.renderExportView(arg1)
    local size = arg1.props.size
    local utilTabHeight = arg1.state.utilTabHeight

    return Roact.createElement(
        "Frame",
        {
            Size = size,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            LayoutOrder = 3
        },
        {
            UIListLayout = Roact.createElement("UIListLayout", { Padding = UDim.new(0, MainRowPadding), SortOrder = Enum.SortOrder.LayoutOrder }),
            UtilAndTab = arg1:renderUtilAndTab(
                {},
                { Roact.createElement(BoxButton, { text = "Exit", onClicked = arg1.props.dispatchFinishedExporting }) }
            ),
            ExportView = Roact.createElement(ProfilerExportView, { size = UDim2.new(1, 0, 1, -utilTabHeight) })
        }
    )
end

function var1.renderMobileSettingsUI(arg1)
    local size = arg1.props.size
    local utilTabHeight = arg1.state.utilTabHeight

    return Roact.createElement(
        "Frame",
        {
            Size = size,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            LayoutOrder = 3
        },
        {
            UIListLayout = Roact.createElement("UIListLayout", { Padding = UDim.new(0, MainRowPadding), SortOrder = Enum.SortOrder.LayoutOrder }),
            UtilAndTab = arg1:renderUtilAndTab({}, { Roact.createElement(BoxButton, { text = "Export", onClicked = arg1.props.dispatchStartExport }), Roact.createElement(BoxButton, { text = "Exit", onClicked = arg1.props.dispatchHideMobileSettings }) }),
            MobileSettingsView = Roact.createElement(MobileSettingsView, { size = UDim2.new(1, 0, 1, -utilTabHeight) })
        }
    )
end

function var1.renderProfilerView(arg1, isClientView, arg2, arg3, orderedCheckboxState)
    local isProfiling = arg2.isProfiling
    local data = arg2.data
    local usePercentages = arg1.props.usePercentages
    local isFunctionsView = arg2.isFunctionsView
    local rootNode = arg2.rootNode
    local rootNodeName = arg2.rootNodeName
    local rootFunc = arg2.rootFunc

    local size = arg1.props.size
    local utilTabHeight = arg1.state.utilTabHeight
    local sessionLength = if data and data.SessionStartTime and data.SessionEndTime then data.SessionEndTime - data.SessionStartTime else nil
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = size,
        BackgroundColor3 = Constants.Color.BaseGray,
        BackgroundTransparency = 1,
        LayoutOrder = 3
    }

    local tbl3 = {
        UIListLayout = Roact.createElement("UIListLayout", { Padding = UDim.new(0, MainRowPadding), SortOrder = Enum.SortOrder.LayoutOrder }),
        UtilAndTab = arg1:renderUtilAndTab({
            isClientView = isClientView,
            onClientButton = arg1.onClientButton,
            onServerButton = arg1.onServerButton,
            orderedCheckboxState = orderedCheckboxState,
            onCheckboxChanged = arg1.onCheckboxChanged,
            onSearchTermChanged = arg1.onSearchTermChanged,
            searchTerm = arg2.searchTerm
        }, arg3),
        ProfilerView = Roact.createElement(if isFunctionsView then ProfilerFunctionsView else ProfilerView, {
            size = UDim2.new(1, 0, 1, -utilTabHeight),
            searchFilter = if isFunctionsView then arg2.searchFilterFlat else arg2.searchFilterGraph,
            layoutOrder = 2,
            data = data,
            profiling = isProfiling,
            showAsPercentages = usePercentages,
            sessionLength = sessionLength,
            rootNode = rootNode,
            rootFunc = rootFunc,
            rootNodeName = rootNodeName,
            average = arg2.average,
            showPlugins = arg2.showPlugins or not bool1,
            pluginOffsets = arg2.pluginOffsets,
            showGC = arg2.showGC,
            gcFunctionOffsets = arg2.gcFunctionOffsets,
            gcNodeOffsets = arg2.gcNodeOffsets,
            pluginGCOffsets = arg2.pluginGCOffsets,
            expandedNodes = if isFunctionsView then nil else arg2.expandedNodes
        })
    }
    return createElement(str1, tbl2, tbl3)
end

function var1.render(arg1)
    if arg1.props.isExporting then
        return arg1:renderExportView()
    end

    if arg1.props.isShowingMobileSettings then
        return arg1:renderMobileSettingsUI()
    end

    local formFactor = arg1.props.formFactor

    local var2, var3 = arg1:getActiveState()

    local tbl2 = { nil }
    local num2 = 1

    local bool2 = formFactor == Constants.FormFactor.Small

    if not bool2 then
        tbl2[1] = {
            name = "Live",
            state = var3.liveUpdate
        }
        if bool1 then
            num2 += 1
            tbl2[num2] = {
                name = "Plugins",
                state = var3.showPlugins
            }
        end
        tbl2[num2 + 1] = {
            name = "GC",
            state = var3.showGC
        }
    end
    return arg1:renderProfilerView(var2, var3, arg1:renderUtilButtons(var3, bool2, bool2), tbl2)
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        isClientView = arg1.ScriptProfiler.isClientView,
        usePercentages = arg1.ScriptProfiler.usePercentages,
        isExporting = arg1.ScriptProfiler.isExporting,
        isShowingMobileSettings = arg1.ScriptProfiler.isShowingMobileSettings,
        client = arg1.ScriptProfiler.client,
        server = arg1.ScriptProfiler.server
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetScriptProfilerState = function(arg1, arg2, arg3, arg4)
            callback(SetScriptProfilerState(arg1, arg2, arg3, arg4))
        end,
        dispatchSetIsProfiling = function(arg1, arg2)
            callback(SetIsProfiling(arg1, arg2))
        end,
        dispatchSetData = function(arg1, arg2)
            callback(SetData(arg1, arg2))
        end,
        dispatchSetThreads = function(arg1, arg2)
            callback(SetThreads(arg1, arg2))
        end,
        dispatchSetTimer = function(arg1, arg2)
            callback(SetTimerState(arg1, arg2))
        end,
        dispatchClearStateForNewSession = function(arg1)
            callback(ClearStateForNewProfilingSession(arg1))
        end,
        dispatchSetAverage = function(arg1, arg2)
            callback(SetAverage(arg1, arg2))
        end,
        dispatchSetFrequency = function(arg1, arg2)
            callback(SetFrequency(arg1, arg2))
        end,
        dispatchSetDataView = function(arg1, arg2)
            callback(SetDataView(arg1, arg2))
        end,
        dispatchSetLiveUpdate = function(arg1, arg2)
            callback(SetLiveUpdate(arg1, arg2))
        end,
        dispatchSetShowPlugins = function(arg1, arg2)
            callback(SetShowPlugins(arg1, arg2))
        end,
        dispatchSetShowGC = function(arg1, arg2)
            callback(SetShowGC(arg1, arg2))
        end,
        dispatchSetSearchData = function(arg1, arg2)
            callback(SetSearchData(arg1, arg2))
        end,
        dispatchStartExport = function()
            callback(SetScriptProfilerState(nil, nil, nil, nil, true))
        end,
        dispatchFinishedExporting = function()
            callback(SetScriptProfilerState(nil, nil, nil, nil, false))
        end,
        dispatchShowMobileSettings = function()
            callback(SetScriptProfilerState(nil, nil, nil, nil, nil, true))
        end,
        dispatchHideMobileSettings = function()
            callback(SetScriptProfilerState(nil, nil, nil, nil, nil, false))
        end
    }
end)(var1)
