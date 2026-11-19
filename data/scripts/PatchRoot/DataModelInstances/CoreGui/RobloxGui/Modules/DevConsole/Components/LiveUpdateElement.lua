-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local DataConsumer = require(script.Parent.Parent.Components.DataConsumer)

local Actions = script.Parent.Parent.Actions
local SetActiveTab = require(Actions.SetActiveTab)

local Constants = require(script.Parent.Parent.Constants)
local MsgTypeNamesOrdered = Constants.MsgTypeNamesOrdered

local TopBar = Constants.DefaultFontSize.TopBar
local ConstantsColorText = Constants.Color.Text
local TopBar2 = Constants.Font.TopBar

local uDim2 = UDim2.new(0, TopBar, 0, TopBar)

local vector2 = TextService:GetTextSize("Client Mem:", TopBar, TopBar2, Vector2.new(0, 0))

local vector2_2 = TextService:GetTextSize("Client Memory Usage:", TopBar, TopBar2, Vector2.new(0, 0))

local vector2_3 = TextService:GetTextSize("Avg. Data Ping:", TopBar, TopBar2, Vector2.new(0, 0))

local var1 = Roact.PureComponent:extend("LiveUpdateElement")

function var1.didMount(arg1)
    arg1.totalMemConnector = arg1.props.ClientMemoryData:totalMemSignal():Connect(function(totalClientMemory)
        arg1:setState({ totalClientMemory = totalClientMemory })
    end)

    arg1.avgPingConnector = arg1.props.ServerStatsData:avgPing():Connect(function(averagePing)
        arg1:setState({ averagePing = averagePing })
    end)

    arg1.logWarningErrorConnector = arg1.props.ClientLogData:errorWarningSignal():Connect(function(numErrors, numWarnings)
        arg1:setState({ numErrors = numErrors, numWarnings = numWarnings })
    end)

    arg1:doSizeCheck()
end

function var1.didUpdate(arg1)
    arg1:doSizeCheck()
end

function var1.doSizeCheck(arg1)
    if not arg1.ref.current then
        return
    end

    local isSmallerThanFormFactorThreshold = arg1.state.formFactorThreshold > arg1.ref.current.AbsoluteSize.X

    if isSmallerThanFormFactorThreshold ~= arg1.state.isSmallerThanFormFactorThreshold then
        arg1:setState({ isSmallerThanFormFactorThreshold = isSmallerThanFormFactorThreshold })
    end
end

function var1.willUnmount(arg1)
    arg1.totalMemConnector:Disconnect()
    arg1.totalMemConnector = nil

    arg1.avgPingConnector:Disconnect()
    arg1.avgPingConnector = nil

    arg1.logWarningErrorConnector:Disconnect()
    arg1.logWarningErrorConnector = nil
end

function var1.init(arg1)
    local numErrors, numWarnings = arg1.props.ClientLogData:getErrorWarningCount()
    function arg1.onLogWarningButton()
        local tbl1 = ({})
        for _, value in pairs(MsgTypeNamesOrdered) do
            tbl1[value] = false
        end

        tbl1.Warning = true
        arg1.props.ClientLogData:setFilters(tbl1)
        arg1.props.dispatchChangeTabClientLog()
    end

    function arg1.onLogErrorButton()
        local tbl1 = ({})
        for _, value in pairs(MsgTypeNamesOrdered) do
            tbl1[value] = false
        end

        tbl1.Error = true
        arg1.props.ClientLogData:setFilters(tbl1)
        arg1.props.dispatchChangeTabClientLog()
    end

    arg1.ref = Roact.createRef()

    arg1.state = {
        numErrors = numErrors,
        numWarnings = numWarnings,
        totalClientMemory = 0,
        averagePing = 0,
        formFactorThreshold = 380,
        isSmallerThanFormFactorThreshold = false
    }
end

function var1.render(arg1)
    local size = arg1.props.size
    local position = arg1.props.position
    local formFactor = arg1.props.formFactor

    local numErrors = arg1.state.numErrors
    local numWarnings = arg1.state.numWarnings
    local totalClientMemory = arg1.state.totalClientMemory
    local averagePing = arg1.state.averagePing
    local isSmallerThanFormFactorThreshold = arg1.state.isSmallerThanFormFactorThreshold

    local vector22X = vector2_2.X
    local center = Enum.HorizontalAlignment.Center
    local bool1

    if formFactor == Constants.FormFactor.Small or isSmallerThanFormFactorThreshold then
        position += UDim2.new(0, 12, 0, 0)
        vector22X = vector2.X

        center = Enum.HorizontalAlignment.Left
        bool1 = true
    else
        bool1 = false
    end

    local string2 = string.format("%d", numErrors)
    local vector2_4 = TextService:GetTextSize(string2, TopBar, TopBar2, Vector2.new(0, 0))

    local string3 = string.format("%d", numWarnings)
    local vector2_5 = TextService:GetTextSize(string3, TopBar, TopBar2, Vector2.new(0, 0))

    local string4 = string.format("%d MB", totalClientMemory)
    local vector2_6 = TextService:GetTextSize(string4, TopBar, TopBar2, Vector2.new(0, 0))

    local string5 = string.format("%d ms", averagePing)
    local vector2_7 = TextService:GetTextSize(string5, TopBar, TopBar2, Vector2.new(0, 0))

    if formFactor == Constants.FormFactor.Small or isSmallerThanFormFactorThreshold then
        position += UDim2.new(0, 12, 0, 0)
        vector22X = vector2.X

        center = Enum.HorizontalAlignment.Left
        bool1 = true
    end

    local bool2 = averagePing > 0

    local vector2_8 = vector2_3

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Position = position,
        Size = size,
        BackgroundTransparency = 1,
        [Roact.Ref] = arg1.ref
    }
    local tbl2 = {
        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0, 6),
            HorizontalAlignment = center,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        LogErrorIcon = Roact.createElement("ImageButton", {
            Image = Constants.Image.Error,
            Size = uDim2,
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            [Roact.Event.Activated] = arg1.onLogErrorButton
        }),
        LogErrorCount = Roact.createElement("TextButton", {
            Text = string2,
            TextSize = TopBar,
            TextColor3 = ConstantsColorText,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = TopBar2,
            Size = UDim2.new(0, vector2_4.X, 1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            [Roact.Event.Activated] = arg1.onLogErrorButton
        }),
        ErrorWarningPad = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 3 }),
        LogWarningIcon = Roact.createElement("ImageButton", {
            Image = Constants.Image.Warning,
            Size = uDim2,
            BackgroundTransparency = 1,
            LayoutOrder = 4,
            [Roact.Event.Activated] = arg1.onLogWarningButton
        }),
        LogWarningCount = Roact.createElement("TextButton", {
            Text = string3,
            TextSize = TopBar,
            TextColor3 = ConstantsColorText,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = TopBar2,
            Size = UDim2.new(0, vector2_5.X, 1, 0),
            BackgroundTransparency = 9,
            LayoutOrder = 5,
            [Roact.Event.Activated] = arg1.onLogWarningButton
        }),
        WarningMemoryPad = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 6 }),
        MemoryUsage = Roact.createElement("TextButton", {
            Text = if bool1 then "Client Mem:" else "Client Memory Usage:",
            TextSize = TopBar,
            TextColor3 = Constants.Color.WarningYellow,
            TextXAlignment = Enum.TextXAlignment.Right,
            Font = TopBar2,
            Size = UDim2.new(0, vector22X, 1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 7,
            [Roact.Event.Activated] = arg1.props.dispatchChangeTabClientMemory
        }),
        MemoryUsage_MB = Roact.createElement("TextButton", {
            Text = string4,
            TextSize = TopBar,
            TextColor3 = ConstantsColorText,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = TopBar2,
            Size = UDim2.new(0, vector2_6.X, 1, 0),
            BackgroundTransparency = 1,
            LayoutOrder = 8,
            [Roact.Event.Activated] = arg1.props.dispatchChangeTabClientMemory
        }),
        MemoryPingPad = Roact.createElement("Frame", { BackgroundTransparency = 1, LayoutOrder = 9 }),
        AvgPing = 0,
        AvgPing_ms = 0
    }

    local bool3 = not bool1

    if bool3 then
        if bool2 then
            bool3 = Roact.createElement("TextButton", {
                Text = "Avg. Data Ping:",
                TextSize = TopBar,
                TextColor3 = Constants.Color.WarningYellow,
                TextXAlignment = Enum.TextXAlignment.Right,
                Font = TopBar2,
                Size = UDim2.new(0, vector2_8.X, 1, 0),
                BackgroundTransparency = 1,
                LayoutOrder = 10,
                [Roact.Event.Activated] = arg1.props.dispatchChangeTabNetworkPing
            })
        else
            bool3 = bool2
        end
    end

    tbl2.AvgPing = bool3

    local bool4 = not bool1

    if bool4 then
        if bool2 then
            bool2 = Roact.createElement("TextButton", {
                Text = string5,
                TextSize = TopBar,
                TextColor3 = ConstantsColorText,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = TopBar2,
                Size = UDim2.new(0, vector2_7.X, 1, 0),
                BackgroundTransparency = 1,
                LayoutOrder = 11,
                [Roact.Event.Activated] = arg1.props.dispatchChangeTabNetworkPing
            })
        end
    else
        bool2 = bool4
    end

    tbl2.AvgPing_ms = bool2
    return createElement(str1, tbl1, tbl2)
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback) -- name: mapDispatchToProps
    return {
        dispatchChangeTabClientLog = function()
            callback(SetActiveTab("Log", true))
        end,
        dispatchChangeTabClientMemory = function()
            callback(SetActiveTab("Memory", true))
        end,
        dispatchChangeTabNetworkPing = function()
            callback(SetActiveTab("ServerStats", true))
        end
    }
end)(DataConsumer(var1, "ServerStatsData", "ClientMemoryData", "ClientLogData"))
