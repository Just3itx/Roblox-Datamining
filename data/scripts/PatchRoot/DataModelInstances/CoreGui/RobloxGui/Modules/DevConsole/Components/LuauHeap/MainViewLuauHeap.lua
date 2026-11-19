-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local _ScriptContext = game:GetService("ScriptContext")
local HttpService = game:GetService("HttpService")
local HeapProfilerService = game:GetService("HeapProfilerService")
local Players = game:GetService("Players")

local AppCommonLib = require(CorePackages.Workspace.Packages.AppCommonLib)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local memoize = AppCommonLib.memoize

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)
local UtilAndTab = require(Components.UtilAndTab)
local BoxButton = require(Components.BoxButton)
local LuauHeapView = require(script.Parent.LuauHeapView)
local _LuauHeapTypes = require(script.Parent.LuauHeapTypes)

local Actions = script.Parent.Parent.Parent.Actions
local SetLuauHeapState = require(Actions.SetLuauHeapState)
local SetLuauHeapProfileTarget = require(Actions.SetLuauHeapProfileTarget)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local var1 = Roact.PureComponent:extend("MainViewLuauHeap")

local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local function filterNode(arg1, str1: string?)
    if str1 == nil then
        return false
    end

    local var2 = table.clone(arg1)
    local bool1 = not (var2.Name == nil) and string.find(string.lower(var2.Name), string.lower(str1), 1, true) ~= nil

    if var2.Source ~= nil then
        local bool2 = string.find(string.lower(var2.Source), string.lower(str1), 1, true) ~= nil
        bool1 = bool1 or bool2
    end

    if var2.Paths ~= nil then
        for _, path in var2.Paths do
            for _, value in path do
                local bool2 = string.find(string.lower(value), string.lower(str1), 1, true) ~= nil
                bool1 = bool1 or bool2
            end
        end
    end

    if var2.Roots ~= nil then
        local roots = {}
        for _, root in var2.Roots do
            local var3 = table.clone(root)
            local var4 = filterNode(var3, str1)
            if var4 then
                table.insert(roots, var3)
            end

            bool1 = bool1 or var4
        end

        var2.Roots = roots
    end

    if var2.Children ~= nil then
        local children = {}
        for _, child in var2.Children do
            local var3 = table.clone(child)
            local var4 = filterNode(var3, str1)
            if var4 then
                table.insert(children, child)
            end

            bool1 = bool1 or var4
        end

        var2.Children = children
    end

    return if bool1 then var2 else nil
end

local function filterHeapReportsStatEntryList(tbl1, str1: string?)
    if str1 == nil then
        return tbl1
    end

    local result = {}
    for _, value in tbl1 do
        if string.find(string.lower(value.Name), string.lower(str1), 1, true) ~= nil then
            table.insert(result, (table.clone(value)))
        end
    end

    return result
end

local function filterHeapReportGraph(arg1, str1: string?, num1: number)
    if str1 == nil then
        return arg1
    end
    arg1 = table.clone(arg1)
    local children = {}
    for _, child in arg1.Children do
        local var2 = filterHeapReportGraph(child, str1, num1 + 1)
        if var2 then
            table.insert(children, var2)
        end
    end
    arg1.Children = children

    if num1 == 0 then
        return arg1
    end

    local bool1 = #children > 0

    if string.find(string.lower(arg1.Name), string.lower(str1), 1, true) ~= nil then
        bool1 = true
    end

    return if bool1 then arg1 else nil
end

local function filterUniqueRefEntryPath(arg1, str1: string?)
    if str1 == nil then
        return arg1
    end

    local tbl1 = {}
    for _, value in arg1 do
        if string.find(string.lower(value), string.lower(str1), 1, true) ~= nil then
            table.insert(tbl1, value)
        end
    end
    return if #tbl1 > 0 then tbl1 else nil
end

local function filterUniqueRefEntryPathList(paths, str1: string?)
    if str1 == nil then
        return paths
    end

    local result = {}
    for _, path in paths do
        local var2 = filterUniqueRefEntryPath(path, str1)
        if var2 then
            table.insert(result, var2)
        end
    end

    return result
end

local function filterUniqueRefEntry(arg1, str1: string?)
    if str1 == nil then
        return arg1
    end
    local var2 = table.clone(arg1)

    local bool1 = string.find(string.lower(var2.Name), string.lower(str1), 1, true) ~= nil

    local paths = filterUniqueRefEntryPathList(var2.Paths, str1)

    var2.Paths = paths

    if #paths > 0 then
        bool1 = true
    end

    return if bool1 then var2 else nil
end

local function filterUniqueRefReport(arg1, str1: string?)
    if str1 == nil or arg1 == nil then
        return arg1
    end
    arg1 = table.clone(arg1)
    local roots = {}
    for _, root in arg1.Roots do
        local var2 = filterUniqueRefEntry(root, str1)
        if var2 then
            table.insert(roots, var2)
        end
    end
    arg1.Roots = roots
    return arg1
end

local function filterSnapshots(tbl1, str1: string?, _: number)
    if str1 == nil then
        return tbl1
    end

    local result = {}
    for _, value in tbl1 do
        local var2 = table.clone(value)

        var2.TagBreakdown = filterHeapReportsStatEntryList(var2.TagBreakdown, str1)

        var2.MemcatBreakdown = filterHeapReportsStatEntryList(var2.MemcatBreakdown, str1)

        var2.UserdataBreakdown = filterHeapReportsStatEntryList(var2.UserdataBreakdown, str1)

        var2.Graph = filterHeapReportGraph(var2.Graph, str1, 0)

        if var2.Refs then
            var2.Refs = filterUniqueRefReport(var2.Refs, str1)
        end

        table.insert(result, var2)
    end
    return result
end

function var1.getState(tbl1, bool1: boolean)
    return if bool1 then tbl1.props.client else tbl1.props.server
end

function var1.getActiveState(arg1)
    return arg1.props.isClientView, arg1:getState(arg1.props.isClientView)
end

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    arg1.version = 0

    function arg1.dispatchSetLuauHeapState(bool1: boolean, arg2)
        arg1.version += 1
        arg1.props.dispatchSetLuauHeapState(bool1, arg2)
    end
    function arg1.onClientButton()
        arg1.props.dispatchSetLuauHeapProfileTarget(true)
    end

    function arg1.onServerButton()
        arg1.props.dispatchSetLuauHeapProfileTarget(false)
    end

    arg1.filterSnapshots = memoize(filterSnapshots)

    function arg1.onCreateSnapshot()
        local var2, var3 = arg1:getActiveState()
        local success, result

        if var2 then
            success, result = pcall(HeapProfilerService.ClientRequestDataAsync, HeapProfilerService, Players.LocalPlayer)
        else
            success, result = pcall(HeapProfilerService.ServerRequestDataAsync, HeapProfilerService)
        end

        if not success then
            warn(result)
            return
        end

        local var4 = HttpService:JSONDecode(result)
        local report = var4.Report
        report.Refs = var4.Refs

        local var5 = table.clone(var3)

        table.insert(var5.snapshots, report)

        var5.active = #var5.snapshots

        arg1.dispatchSetLuauHeapState(var2, var5)
    end

    function arg1.onClearSnapshots()
        local var2, var3 = arg1:getActiveState()

        local var4 = table.clone(var3)

        table.clear(var4.snapshots)
        var4.active = 0

        arg1.dispatchSetLuauHeapState(var2, var4)
    end

    arg1.utilRef = Roact.createRef()

    arg1.state = { searchTerm = nil, utilTabHeight = 0 }

    function arg1.onSearchTermChanged(searchTerm: string?)
        if searchTerm == nil or searchTerm == "" then
            arg1:setState({ searchTerm = Roact.None })
            return
        end

        arg1:setState({ searchTerm = searchTerm })
    end
end

function var1.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })
end

function var1.willUnmount(_) end

function var1.didUpdate(arg1)
    local currentSize = arg1.utilRef.current.Size
    if currentSize.Y.Offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = currentSize.Y.Offset })
    end
end

function var1.render(arg1)
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList

    local utilTabHeight = arg1.state.utilTabHeight

    local isClientView, var3 = arg1:getActiveState()

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
            UtilAndTab = Roact.createElement(UtilAndTab, {
                windowWidth = size.X.Offset,
                formFactor = formFactor,
                tabList = tabList,
                layoutOrder = 1,
                isClientView = isClientView,
                onClientButton = arg1.onClientButton,
                onServerButton = arg1.onServerButton,
                refForParent = arg1.utilRef,
                onHeightChanged = arg1.onUtilTabHeightChanged,
                onSearchTermChanged = arg1.onSearchTermChanged
            }, { Roact.createElement(BoxButton, { text = "Create Snapshot", onClicked = arg1.onCreateSnapshot }), Roact.createElement(BoxButton, { text = "Clear Snapshots", onClicked = arg1.onClearSnapshots }) }),
            LuauHeapView = Roact.createElement(LuauHeapView, {
                size = UDim2.new(1, 0, 1, -utilTabHeight),
                layoutOrder = 2,
                data = arg1.filterSnapshots(var3.snapshots, arg1.state.searchTerm, arg1.version),
                activeSnapshot = var3.active,
                compareSnapshot = var3.compare
            })
        }
    )
end
return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        isClientView = arg1.LuauHeap.isClientView,
        client = arg1.LuauHeap.client,
        server = arg1.LuauHeap.server
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetLuauHeapState = function(bool1: boolean, arg1)
            callback(SetLuauHeapState(bool1, arg1))
        end,
        dispatchSetLuauHeapProfileTarget = function(bool1: boolean)
            callback(SetLuauHeapProfileTarget(bool1))
        end
    }
end)(DataConsumer(var1, "LuauHeapData"))
