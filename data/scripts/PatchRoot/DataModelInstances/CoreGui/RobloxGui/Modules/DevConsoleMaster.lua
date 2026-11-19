-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local DevConsole = script.Parent.DevConsole
local Constants = require(DevConsole.Constants)

local Components = DevConsole.Components
local DevConsoleWindow = require(Components.DevConsoleWindow)
local DataProvider = require(Components.DataProvider)
local MainViewLog = require(Components.Log.MainViewLog)
local MainViewMemory = require(Components.Memory.MainViewMemory)
local MainViewNetwork = require(Components.Network.MainViewNetwork)
local MainViewScripts = require(Components.Scripts.MainViewScripts)
local MainViewDataStores = require(Components.DataStores.MainViewDataStores)
local MainViewServerStats = require(Components.ServerStats.MainViewServerStats)
local MainViewActionBindings = require(Components.ActionBindings.MainViewActionBindings)
local MainViewServerJobs = require(Components.ServerJobs.MainViewServerJobs)
local MainViewMicroProfiler = require(Components.MicroProfiler.MainViewMicroProfiler)
local MainViewScriptProfiler = require(Components.ScriptProfiler.MainViewScriptProfiler)
local MainViewDebugVisualizations = require(Components.DebugVisualizations.MainViewDebugVisualizations)
local MainViewLuauHeap = require(Components.LuauHeap.MainViewLuauHeap)
local MainViewVoiceChat = require(Components.VoiceChat.MainViewVoiceChat)
local MainViewVoiceDebug = require(Components.VoiceDebug.MainViewVoiceDebug)
local GetFFlagVoiceDebugConsoleV2 = require(Components.VoiceDebug.GetFFlagVoiceDebugConsoleV2)
local MainViewRequestOrchestrator = require(Components.RequestOrchestrator.MainViewRequestOrchestrator)

local RCCProfilerDataCompleteListener = require(Components.MicroProfiler.RCCProfilerDataCompleteListener)
local getClientReplicator = require(DevConsole.Util.getClientReplicator)

local MainView = require(DevConsole.Reducers.MainView)
local DevConsoleReducer = require(DevConsole.Reducers.DevConsoleReducer)

local Actions = DevConsole.Actions
local SetDevConsoleVisibility = require(Actions.SetDevConsoleVisibility)
local SetTabList = require(Actions.SetTabList)

local MiddleWare = DevConsole.MiddleWare
local DevConsoleAnalytics = require(MiddleWare.DevConsoleAnalytics)

local PlayerPermissionsModule = require(CoreGui.RobloxGui.Modules.PlayerPermissionsModule)

local engineFeature = game:GetEngineFeature("ScriptProfiler")

local isEnabled = game:DefineFastFlag("DevConsoleRequestOrchestratorTab2", false)
local bool2 = game:DefineFastFlag("DevConsoleAdminSeesDevTabs", false)

local default = require(CoreGui.RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

local bool1 = false

local tbl1 = {
    Log = { tab = MainViewLog, layoutOrder = 1, hasClientServer = true },
    Memory = { tab = MainViewMemory, layoutOrder = 2, hasClientServer = true },
    Network = { tab = MainViewNetwork, layoutOrder = 3, hasClientServer = true },
    Scripts = { tab = MainViewScripts, layoutOrder = 4 },
    DataStores = { tab = MainViewDataStores, layoutOrder = 5 },
    ServerStats = { tab = MainViewServerStats, layoutOrder = 6 },
    ActionBindings = { tab = MainViewActionBindings, layoutOrder = 7 },
    ServerJobs = { tab = MainViewServerJobs, layoutOrder = 8 },
    MicroProfiler = { tab = MainViewMicroProfiler, layoutOrder = 9 },
    DebugVisualizations = { tab = MainViewDebugVisualizations, layoutOrder = 10 },
    ScriptProfiler = engineFeature and { tab = MainViewScriptProfiler, layoutOrder = 11 } or nil,
    LuauHeap = { tab = MainViewLuauHeap, layoutOrder = 12 }
}

local tbl2 = {
    Log = { tab = MainViewLog, layoutOrder = 1 },
    Memory = { tab = MainViewMemory, layoutOrder = 2 },
    ScriptProfiler = engineFeature and { tab = MainViewScriptProfiler, layoutOrder = 3 } or nil,
    LuauHeap = { tab = MainViewLuauHeap, layoutOrder = 4 },
    VoiceChat = not GetFFlagVoiceDebugConsoleV2()
        and game:GetEngineFeature("VoiceChatDevConsoleTabEnabled")
        and default
        and default:canUseService()
        and { tab = MainViewVoiceChat, layoutOrder = 5 }
        or nil
}

local tabList = {
    Log = { tab = MainViewLog, layoutOrder = 1 },
    Memory = { tab = MainViewMemory, layoutOrder = 2 }
}

local tbl4 = {
    VoiceChat = {
        tab = MainViewVoiceChat,
        layoutOrder = 13,
        isEnabled = function()
            local engineFeature2 = not GetFFlagVoiceDebugConsoleV2() and game:GetEngineFeature("VoiceChatDevConsoleTabEnabled")
            return engineFeature2 and default ~= nil and default:canUseService()
        end
    },
    VoiceDebug = {
        tab = MainViewVoiceDebug,
        layoutOrder = 14,
        isEnabled = function()
            return bool1
        end
    },
    RequestOrchestrator = {
        tab = MainViewRequestOrchestrator,
        layoutOrder = 100,
        isEnabled = function()
            return isEnabled
        end
    }
}

local Klass = {}
Klass.__index = Klass

local tbl6 = {
    [Enum.Platform.Windows] = Constants.FormFactor.Large,
    [Enum.Platform.OSX] = Constants.FormFactor.Large,
    [Enum.Platform.IOS] = Constants.FormFactor.Small,
    [Enum.Platform.Android] = Constants.FormFactor.Small,
    [Enum.Platform.XBoxOne] = Constants.FormFactor.Console,
    [Enum.Platform.PS4] = Constants.FormFactor.Console,
    [Enum.Platform.PS3] = Constants.FormFactor.Console,
    [Enum.Platform.XBox360] = Constants.FormFactor.Console,
    [Enum.Platform.WiiU] = Constants.FormFactor.Console,
    [Enum.Platform.NX] = Constants.FormFactor.Console,
    [Enum.Platform.Ouya] = Constants.FormFactor.Console,
    [Enum.Platform.AndroidTV] = Constants.FormFactor.Console,
    [Enum.Platform.Chromecast] = Constants.FormFactor.Console,
    [Enum.Platform.Linux] = Constants.FormFactor.Large,
    [Enum.Platform.SteamOS] = Constants.FormFactor.Console,
    [Enum.Platform.WebOS] = Constants.FormFactor.Large,
    [Enum.Platform.DOS] = Constants.FormFactor.Large,
    [Enum.Platform.BeOS] = Constants.FormFactor.Large,
    [Enum.Platform.UWP] = Constants.FormFactor.Large,
    [Enum.Platform.None] = Constants.FormFactor.Large
}

local function isAdminAsync() -- Luacid: Inlined by compiler; 2 call sites recovered
    return PlayerPermissionsModule.IsPlayerAdminAsync(Players.LocalPlayer)
end

local function getAdminTabList()
    local var1 = table.clone(tbl1)

    for k, value in pairs(tbl4) do
        if value.isEnabled ~= nil and not value.isEnabled() then
            continue
        end

        local tbl7 = {
            tab = value.tab,
            layoutOrder = value.layoutOrder
        }
        var1[k] = tbl7
    end

    return var1
end

function Klass.new()
    local result = {}
    setmetatable(result, Klass)

    result.init = false

    result.isDeveloperTabListActive = false
    result.isEmployee = false

    result.waitForStart = true
    result.waitForStartBindable = Instance.new("BindableEvent")
    coroutine.wrap(function()
        result:SetupDevConsole()
    end)()

    return result
end

function Klass:SetupDevConsole()
    local platform = UserInputService:GetPlatform()
    local formFactor = tbl6[platform]

    local tbl7 = {
        MainView = MainView(nil, SetTabList(tabList, "Log"))
    }

    self.store = Rodux.Store.new(DevConsoleReducer, tbl7, { DevConsoleAnalytics })

    local isVisible = self.store:getState().DisplayOptions.isVisible

    self.root = Roact.createElement(RoactRodux.StoreProvider, {
        store = self.store
    }, {
        DataProvider = Roact.createElement(DataProvider, { isDeveloperView = false }, {
            App = Roact.createElement("ScreenGui", { OnTopOfCoreBlur = true, DisplayOrder = 10 }, {
                DevConsoleWindow = Roact.createElement(DevConsoleWindow, {
                    formFactor = formFactor,
                    isDeveloperView = false,
                    isVisible = isVisible,
                    isMinimized = false,
                    position = Constants.MainWindowInit.Position,
                    size = Constants.MainWindowInit.Size,
                    tabList = tabList,
                    onCloseCallback = function(arg1)
                        self:SetServerStatsConnection(arg1)
                    end
                }),
                RCCProfilerDataCompleteListener = Roact.createElement(RCCProfilerDataCompleteListener)
            })
        })
    })

    self.waitForStart = false
    self.waitForStartBindable:Fire()
end

local var1 = Klass.new()

function Klass:refreshTabList()
    if self.isEmployee then
        self.store:dispatch(SetTabList(getAdminTabList(), "Log", true))
    elseif self.isDeveloperTabListActive then
        self.store:dispatch(SetTabList(tbl1, "Log", true))
    end
end

function Klass:refreshVoiceDevConsoleAvailability()
    if not GetFFlagVoiceDebugConsoleV2() or not game:GetEngineFeature("VoiceChatDevConsoleTabEnabled") or not default then
        return
    end

    local function apply()
        local var2 = default:VoiceChatAvailable()
        if var2 == bool1 then
            return
        end
        bool1 = var2

        self:refreshTabList()
    end

    default:asyncInit():andThen(apply):catch(apply)
end

function Klass:Start()
    if self.init then
        return
    end

    if self.waitForStart then
        self.waitForStartBindable.Event:Wait()
    end
    self.init = true
    self.element = Roact.mount(self.root, CoreGui, "DevConsoleMaster")
    local clientReplicator = getClientReplicator()

    task.spawn(function()
        if bool2 then
            if isAdminAsync() then
                self.isEmployee = true
                self:refreshTabList()
            end
        elseif isAdminAsync() and not self.isDeveloperTabListActive then
            self.store:dispatch(SetTabList(tbl2, "Log", false))
        end
    end)

    task.spawn(function()
        self:refreshVoiceDevConsoleAvailability()
    end)

    if not clientReplicator then
        return
    end

    self._statsConnector = clientReplicator.StatsReceived:connect(function(_)
        if not self._statsConnector then
            return
        end
        self._statsConnector:Disconnect()
        self._statsConnector = nil

        self.isDeveloperTabListActive = true

        if bool2 then
            self:refreshTabList()
            return
        end
        self.store:dispatch(SetTabList(tbl1, "Log", true))
    end)

    self:SetServerStatsConnection(true)
end

function Klass:ToggleVisibility()
    if not self.init then
        if GetFFlagVoiceDebugConsoleV2() then
            self:Start()
        else
            var1:Start()
        end
    end

    self:SetVisibility(not self.store:getState().DisplayOptions.isVisible)
end

function Klass:GetVisibility()
    if not self.init then
        return false
    end

    local state = self.store:getState()
    return if state and state.DisplayOptions then state.DisplayOptions.isVisible and not state.DisplayOptions.isMinimized else false
end

function Klass:SetServerStatsConnection(arg1)
    local clientReplicator = getClientReplicator()
    if clientReplicator then
        clientReplicator:RequestServerStats(arg1)
    end
end

function Klass:SetVisibility(arg1)
    if type(arg1) ~= "boolean" then
        return
    end

    if not self.init and arg1 then
        if GetFFlagVoiceDebugConsoleV2() then
            self:Start()
        else
            var1:Start()
        end
    elseif GetFFlagVoiceDebugConsoleV2() and arg1 then
        self:refreshVoiceDevConsoleAvailability()
    end

    self:SetServerStatsConnection(arg1)

    self.store:dispatch(SetDevConsoleVisibility(arg1))
end

StarterGui:RegisterGetCore("DevConsoleVisible", function()
    return var1:GetVisibility()
end)

StarterGui:RegisterSetCore("DevConsoleVisible", function(arg1)
    if type(arg1) ~= "boolean" then
        error("DevConsoleVisible must be given a boolean value.")
    end

    var1:SetVisibility(arg1)
end)

if GetFFlagVoiceDebugConsoleV2() then
    var1.Klass = Klass
end

return var1
