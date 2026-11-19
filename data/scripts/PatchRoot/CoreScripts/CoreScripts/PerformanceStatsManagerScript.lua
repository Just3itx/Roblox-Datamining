-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local GameSettings = UserSettings().GameSettings
local CoreGui = game:GetService("CoreGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local StatsAggregatorManager = require(CoreGui.RobloxGui.Modules.Stats.StatsAggregatorManager)
local StatsButton = require(CoreGui.RobloxGui.Modules.Stats.StatsButton)
local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local StatsViewer = require(CoreGui.RobloxGui.Modules.Stats.StatsViewer)

local var1 = require(CoreGui.RobloxGui.Modules.Flags.GetFFlagLazyPerfStatsInit)()

local frame = nil
local singleton = nil
local var2 = nil
local tbl1 = ({})
local label = nil

local var3 = nil

if not var1 then
    frame = Instance.new("Frame")
    frame.Name = "PerformanceStats"
    singleton = StatsAggregatorManager.getSingleton()
    var2 = StatsViewer.new()
    for _, value in ipairs(StatsUtils.AllStatTypes) do
        local statsButton = StatsButton.new(value)
        tbl1[value] = statsButton
    end
end

function ShowMasterFrame()
    frame.Visible = true
    frame.Parent = CoreGui.RobloxGui
end

function HideMasterFrame()
    frame.Visible = false
    frame.Parent = nil
end

function ConfigureMasterFrame()
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Selectable = false
    frame.BackgroundTransparency = 1
    frame.Active = false
    frame.ZIndex = 0

    HideMasterFrame()
end

function ConfigureStatButtonsInMasterFrame()
    for i, value in ipairs(StatsUtils.AllStatTypes) do
        AddButton(value, i)
    end
end

function OnButtonToggled(arg1)
    if not tbl1[arg1]._isSelected then
        label = arg1
    else
        label = nil
    end

    UpdateButtonSelectedStates()
    UpdateViewerVisibility()
end

function UpdateButtonSelectedStates()
    for _, value in ipairs(StatsUtils.AllStatTypes) do
        tbl1[value]:SetIsSelected(value == label)
    end
end

function UpdateViewerVisibility()
    if label == nil then
        if var2:GetIsVisible() then
            var2:SetVisible(false)
            var2:SetStatsAggregator(nil)
        end

        return
    end

    local bool1

    if var2:GetIsVisible() then
        bool1 = false
    else
        var2:SetVisible(true)
        bool1 = true
    end

    if label ~= var2:GetStatType() then
        var2:SetStatType(label)
        var2:SetStatsAggregator(singleton:GetAggregator(label))
        bool1 = true
    end

    if bool1 then
        RbxAnalyticsService:TrackEvent("Game", "Enlarge PerfStat", label, 0)
    end
end

function AddButton(arg1, arg2)
    local var4 = tbl1[arg1]

    var4:SetParent(frame)
    var4:SetStatsAggregator(singleton:GetAggregator(arg1))

    local xScale = 1 / StatsUtils.NumButtonTypes
    var4:SetSizeAndPosition(UDim2.new(xScale, 0, 0, StatsUtils.ButtonHeight), UDim2.new(xScale * (arg2 - 1), 0, 0, 0))

    var4:SetToggleCallbackFunction(OnButtonToggled)
end

function ConfigureStatViewerInMasterFrame()
    var2:SetParent(frame)

    local uDim2 = UDim2.new(0, StatsUtils.ViewerWidth, 0, StatsUtils.ViewerHeight)
    local uDim2_2 = UDim2.new(1, -StatsUtils.ViewerWidth, 0, StatsUtils.ButtonHeight + StatsUtils.ViewerTopMargin)

    var2:SetSizeAndPosition(uDim2, uDim2_2)
end

if var1 then
    function CreatePerformanceStatsUI()
        singleton = StatsAggregatorManager.getSingleton()
        singleton:StartListening()

        frame = Instance.new("Frame")
        frame.Name = "PerformanceStats"

        tbl1 = {}
        for _, value in StatsUtils.AllStatTypes do
            local statsButton = StatsButton.new(value)
            tbl1[value] = statsButton
        end

        var2 = StatsViewer.new()
        label = nil

        ConfigureMasterFrame()
        ConfigureStatButtonsInMasterFrame()
        ConfigureStatViewerInMasterFrame()

        UpdateButtonSelectedStates()
        UpdateViewerVisibility()

        ShowMasterFrame()
    end

    function DestroyPerformanceStatsUI()
        if var2 then
            var2:OnPerformanceStatsShouldBeVisibleChanged()
        end
        for _, value in ipairs(StatsUtils.AllStatTypes) do
            local var4 = tbl1[value]
            if var4 then
                var4:OnPerformanceStatsShouldBeVisibleChanged()
            end
        end

        if frame then
            frame:Destroy()
            frame = nil
        end

        var2 = nil
        tbl1 = {}
        label = nil

        if singleton then
            singleton:StopListening()
        end
    end

    function UpdatePerformanceStatsVisibility()
        local var4 = StatsUtils.PerformanceStatsShouldBeVisible()

        if var4 == (frame ~= nil) then
            return
        end

        if var4 then
            CreatePerformanceStatsUI()
        else
            DestroyPerformanceStatsUI()
        end

        RbxAnalyticsService:TrackEvent("Game", if var4 then "Show PerfStats" else "Hide PerfStats", "", 0)

        if var4 then
            var3 = time()
            RbxAnalyticsService:ReportCounter("OpenPerformanceProfiler", 1)
        elseif var3 then
            local var5 = time() - var3
            RbxAnalyticsService:ReportStats("TimeOpenPerformanceProfiler", var5)
        end
    end
else
    function UpdatePerformanceStatsVisibility()
        local var4 = StatsUtils.PerformanceStatsShouldBeVisible()

        if var4 == frame.Visible then
            return
        end

        if var4 then
            ShowMasterFrame()
        else
            HideMasterFrame()
        end

        var2:OnPerformanceStatsShouldBeVisibleChanged()
        for _, value in ipairs(StatsUtils.AllStatTypes) do
            tbl1[value]:OnPerformanceStatsShouldBeVisibleChanged()
        end

        RbxAnalyticsService:TrackEvent("Game", if var4 then "Show PerfStats" else "Hide PerfStats", "", 0)

        if var4 then
            var3 = time()
            RbxAnalyticsService:ReportCounter("OpenPerformanceProfiler", 1)
        elseif var3 then
            local var5 = time() - var3
            RbxAnalyticsService:ReportStats("TimeOpenPerformanceProfiler", var5)
        end
    end
end

GameSettings.PerformanceStatsVisibleChanged:connect(UpdatePerformanceStatsVisibility)

if not var1 then
    ConfigureMasterFrame()
    ConfigureStatButtonsInMasterFrame()
    ConfigureStatViewerInMasterFrame()

    UpdateButtonSelectedStates()
    UpdateViewerVisibility()
    UpdatePerformanceStatsVisibility()
end

spawn(function()
    local localPlayer = Players.LocalPlayer
    while not localPlayer do
        Players.PlayerAdded:wait()
        localPlayer = Players.LocalPlayer
    end
    UpdatePerformanceStatsVisibility()
end)
