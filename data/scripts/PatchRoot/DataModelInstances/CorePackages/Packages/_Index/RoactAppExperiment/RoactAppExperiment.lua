-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local IXPService = game:GetService("IXPService")

local Roact = require(script.Parent.Roact)
local t = require(script.Parent.t)
local Cryo = require(script.Parent.Cryo)
local Symbol = require(script.Symbol)

local ExperimentContext = require(script.ExperimentContext)
local IxpServiceProp = Symbol.named("IxpServiceProp")

local function connect(str1: string, str2: string, str3: string, str4: string, str5: string)
    assert(t.string(str1))
    assert(t.string(str2))
    assert(t.string(str3))
    assert(t.string(str4))
    assert(t.string(str5))

    return function(arg1, arg2, bool1: boolean?)
        if bool1 == nil then
            bool1 = true
        end

        local var1 = debug.traceback()
        assert(type(arg1) == "table", "connect expects layerNames to be a list of layers")
        assert(type(arg2) == "function", "connect expects mapLayersToProps to be a function")

        return function(arg3)
            if arg3 == nil then
                local str6 = string.format("connect returns a function that must be passed a component.\n Check the connection at:\n %s", var1)

                error(str6, 2)
            end

            local str6 = ("AppExperiment(%s)"):format(tostring(arg3))
            local var2 = Roact.PureComponent:extend(str6)

            function var2.init(arg4)
                arg4.onLoadingStatusChangeConnection = nil
                arg4.state = {
                    layerToVariables = {},
                    layerLoadingStatus = Enum.IXPLoadingStatus.None
                }

                function arg4.updateStateLayerData(layerLoadingStatus)
                    local prop = arg4.props[IxpServiceProp]

                    if prop == nil then
                        return
                    end

                    local layerToVariables = ({})
                    for _, value in ipairs(arg1) do
                        layerToVariables[value] = prop[str3](prop, value)
                    end

                    arg4:setState({ layerToVariables = layerToVariables, layerLoadingStatus = layerLoadingStatus })
                end

                function arg4.logAllLayersExposure(ixpLoadingStatus)
                    local prop = arg4.props[IxpServiceProp]

                    if prop == nil or ixpLoadingStatus ~= Enum.IXPLoadingStatus.Initialized or not bool1 then
                        return
                    end

                    for _, value in ipairs(arg1) do
                        if prop[str5](prop, value) == Enum.IXPLoadingStatus.Initialized then
                            prop[str4](prop, value)
                        end
                    end
                end

                local prop = arg4.props[IxpServiceProp]

                if prop ~= nil then
                    local var3 = prop[str2](prop)
                    arg4.updateStateLayerData(var3)
                end
            end

            function var2.render(arg4)
                local var3 = Cryo.Dictionary.join(arg4.props, { [IxpServiceProp] = Cryo.None })

                local var4 = arg2(arg4.state.layerToVariables, var3)
                local var5 = Cryo.Dictionary.join(var3, var4)
                return Roact.createElement(arg3, var5)
            end

            function var2.didMount(arg4)
                local prop = arg4.props[IxpServiceProp]

                if prop == nil then
                    return
                end

                arg4.onLoadingStatusChangeConnection = prop[str1]:Connect(function(_)
                    local var3 = prop[str2](prop)
                    if arg4.state.layerLoadingStatus ~= var3 then
                        arg4.updateStateLayerData(var3, str3)
                        arg4.logAllLayersExposure(var3)
                    end
                end)

                local var3 = prop[str2](prop)
                if arg4.state.layerLoadingStatus ~= var3 then
                    arg4.updateStateLayerData(var3, str3)
                end

                arg4.logAllLayersExposure(var3)
            end

            function var2.willUnmount(arg4)
                if arg4.onLoadingStatusChangeConnection ~= nil then
                    arg4.onLoadingStatusChangeConnection:Disconnect()
                end
            end

            return function(arg4)
                return Roact.createElement(ExperimentContext.Consumer, {
                    render = function(arg5)
                        assert(arg4[IxpServiceProp] == nil, "Symbol 'IxpServiceProp' should never exist in the incoming props.")

                        local var3 = Cryo.Dictionary.join(arg4, { [IxpServiceProp] = arg5 })

                        return Roact.createElement(var2, var3)
                    end
                })
            end
        end
    end
end

local connectBrowserTrackerLayer = connect(
    "OnBrowserTrackerLayerLoadingStatusChanged",
    "GetBrowserTrackerLayerLoadingStatus",
    "GetBrowserTrackerLayerVariables",
    "LogBrowserTrackerLayerExposure",
    "GetBrowserTrackerStatusForLayer"
)

local connectUserLayer = connect(
    "OnUserLayerLoadingStatusChanged",
    "GetUserLayerLoadingStatus",
    "GetUserLayerVariables",
    "LogUserLayerExposure",
    "GetUserStatusForLayer"
)

return {
    Provider = ExperimentContext.Provider,
    Consumer = ExperimentContext.Consumer,
    Context = ExperimentContext,
    registerUserLayers = function(tbl1)
        assert(t.table(tbl1))
        if IXPService == nil then
            return
        end

        if RunService:IsStudio() then
            IXPService:ClearUserLayers()
        end

        local userLayers = {}
        for _, value in pairs(tbl1) do
            table.insert(userLayers, value)
        end

        IXPService:RegisterUserLayers(userLayers)
    end,
    initializeUserLayers = function(userId: number)
        if IXPService ~= nil then
            IXPService:InitializeUserLayers(userId)
        end
    end,
    clearUserLayers = function()
        if IXPService ~= nil then
            IXPService:ClearUserLayers()
        end
    end,
    useBrowserTrackerExperiment = require(script.useBrowserTrackerExperiment),
    useUserExperiment = require(script.useUserExperiment),
    useIXPService = require(script.useIXPService),
    connectBrowserTrackerLayer = connectBrowserTrackerLayer,
    connectUserLayer = connectUserLayer,
    MockIXPService = require(script.MockIXPService)
}
