-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Components = script.Parent.Parent.Components
local LogData = require(Components.Log.LogData)
local ClientMemoryData = require(Components.Memory.ClientMemoryData)
local ServerMemoryData = require(Components.Memory.ServerMemoryData)
local NetworkData = require(Components.Network.NetworkData)
local ServerScriptsData = require(Components.Scripts.ServerScriptsData)
local DataStoresData = require(Components.DataStores.DataStoresData)
local ServerStatsData = require(Components.ServerStats.ServerStatsData)
local ActionBindingsData = require(Components.ActionBindings.ActionBindingsData)
local ServerJobsData = require(Components.ServerJobs.ServerJobsData)
local DebugVisualizationsData = require(Components.DebugVisualizations.DebugVisualizationsData)
local LuauHeapData = require(Components.LuauHeap.LuauHeapData)
local VoiceChatData = require(Components.VoiceChat.VoiceChatData)
local VoiceDebugData = require(Components.VoiceDebug.VoiceDebugData)
local GetFFlagVoiceDebugConsoleV2 = require(Components.VoiceDebug.GetFFlagVoiceDebugConsoleV2)
local DataContext = require(Components.DataContext)

local var1 = Roact.Component:extend("DataProvider")

local engineFeature = game:GetEngineFeature("VoiceChatDevConsoleTabEnabled")
local bool1 = game:DefineFastFlag("DevConsoleStartDataOnMount", false)

function var1.init(arg1)
    local tbl1 = {
        DevConsoleData = {
            ClientLogData = LogData.new(true),
            ServerLogData = LogData.new(false),
            ClientMemoryData = ClientMemoryData.new(),
            ServerMemoryData = ServerMemoryData.new(),
            ClientNetworkData = NetworkData.new(true),
            ServerNetworkData = NetworkData.new(false),
            ServerScriptsData = ServerScriptsData.new(),
            DataStoresData = DataStoresData.new(),
            ServerStatsData = ServerStatsData.new(),
            ActionBindingsData = ActionBindingsData.new(),
            ServerJobsData = ServerJobsData.new(),
            DebugVisualizationsData = DebugVisualizationsData.new(),
            LuauHeapData = LuauHeapData.new(),
            VoiceChatData = if engineFeature and not GetFFlagVoiceDebugConsoleV2() then VoiceChatData.new() else nil,
            VoiceDebugData = if engineFeature and GetFFlagVoiceDebugConsoleV2() then VoiceDebugData.new() else nil
        }
    }
    arg1:setState(tbl1)
end

function var1.didMount(arg1)
    arg1.state.DevConsoleData.ClientLogData:start()
    arg1.state.DevConsoleData.ClientMemoryData:start()

    if engineFeature then
        if GetFFlagVoiceDebugConsoleV2() then
            arg1.state.DevConsoleData.VoiceDebugData:start()
        else
            arg1.state.DevConsoleData.VoiceChatData:start()
        end
    end

    if not bool1 or not arg1.props.isDeveloperView then
        return
    end

    for _, value in pairs(arg1.state.DevConsoleData) do
        if not value:isRunning() then
            value:start()
        end
    end
end

function var1.willUpdate(arg1, arg2, _)
    if not arg2.isDeveloperView or arg1.props.isDeveloperView then
        return
    end

    for _, value in pairs(arg1.state.DevConsoleData) do
        if not value:isRunning() then
            value:start()
        end
    end
end

function var1.render(arg1)
    return Roact.createElement(
        DataContext.Provider,
        {
            value = arg1.state.DevConsoleData
        },
        Roact.oneChild(arg1.props[Roact.Children])
    )
end
return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        isDeveloperView = arg1.MainView.isDeveloperView
    }
end, nil)(var1)
