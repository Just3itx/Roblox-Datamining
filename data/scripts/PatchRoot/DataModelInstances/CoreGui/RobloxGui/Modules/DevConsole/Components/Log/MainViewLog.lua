-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Components = script.Parent.Parent.Parent.Components
local ClientLog = require(Components.Log.ClientLog)
local ServerLog = require(Components.Log.ServerLog)
local UtilAndTab = require(Components.UtilAndTab)
local DataConsumer = require(Components.DataConsumer)

local Actions = script.Parent.Parent.Parent.Actions
local SetActiveTab = require(Actions.SetActiveTab)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local MsgTypeNamesOrdered = Constants.MsgTypeNamesOrdered

local var1 = Roact.PureComponent:extend("MainViewLog")

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onClientButton()
        arg1.props.dispatchSetActiveTab("Log", true)
    end

    function arg1.onServerButton()
        arg1.props.dispatchSetActiveTab("Log", false)
    end

    function arg1.onCheckboxChanged(arg2, arg3)
        if arg1.props.isClientView then
            arg1.props.ClientLogData:setFilter(arg2, arg3)
            return
        end
        arg1.props.ServerLogData:setFilter(arg2, arg3)
    end

    function arg1.filterUpdated()
        if arg1.forceUpdate then
            arg1:forceUpdate()
            return
        end
        arg1:setState({})
    end

    function arg1.onSearchTermChanged(arg2)
        if arg1.props.isClientView then
            arg1.props.ClientLogData:setSearchTerm(arg2)
            return
        end
        arg1.props.ServerLogData:setSearchTerm(arg2)
    end

    arg1.clientFilterConnection = arg1.props.ClientLogData:filterUpdatedSignal():Connect(arg1.filterUpdated)

    arg1.serverFilterConnection = arg1.props.ServerLogData:filterUpdatedSignal():Connect(arg1.filterUpdated)

    arg1.utilRef = Roact.createRef()

    arg1.state = { utilTabHeight = 0 }
end

function var1.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })
end

function var1.didUpdate(arg1)
    local currentSize = arg1.utilRef.current.Size
    if currentSize.Y.Offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = currentSize.Y.Offset })
    end
end

function var1.willUnmount(arg1)
    if arg1.clientFilterConnection then
        arg1.clientFilterConnection:Disconnect()
        arg1.clientFilterConnection = nil
    end
    if arg1.serverFilterConnection then
        arg1.serverFilterConnection:Disconnect()
        arg1.serverFilterConnection = nil
    end
end

function var1.render(arg1)
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local isDeveloperView = arg1.props.isDeveloperView
    local tabList = arg1.props.tabList
    local isClientView = arg1.props.isClientView

    local utilTabHeight = arg1.state.utilTabHeight
    local searchTerm = if isClientView then arg1.props.ClientLogData:getSearchTerm() else arg1.props.ServerLogData:getSearchTerm()
    local tbl1 = ({})

    tbl1.UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) })
    local filters = if isClientView then arg1.props.ClientLogData:getFilters() else arg1.props.ServerLogData:getFilters()
    local orderedCheckboxState = ({})
    for i, name in ipairs(MsgTypeNamesOrdered) do
        local tbl3 = {
            name = name,
            state = filters[name]
        }
        orderedCheckboxState[i] = tbl3
    end

    tbl1.UtilAndTab = Roact.createElement(UtilAndTab, {
        windowWidth = size.X.Offset,
        formFactor = formFactor,
        tabList = tabList,
        orderedCheckboxState = orderedCheckboxState,
        isClientView = isClientView,
        searchTerm = searchTerm,
        layoutOrder = 1,
        refForParent = arg1.utilRef,
        onClientButton = isDeveloperView and arg1.onClientButton,
        onServerButton = isDeveloperView and arg1.onServerButton,
        onCheckboxChanged = arg1.onCheckboxChanged,
        onSearchTermChanged = arg1.onSearchTermChanged
    })

    if utilTabHeight > 0 then
        if isClientView then
            tbl1.ClientLog = Roact.createElement(ClientLog, { size = UDim2.new(1, 0, 1, -utilTabHeight), layoutOrder = 2 })
        else
            tbl1.ServerLog = Roact.createElement(ServerLog, { size = UDim2.new(1, 0, 1, -utilTabHeight), layoutOrder = 2 })
        end
    end

    return Roact.createElement(
        "Frame",
        {
            Size = size,
            BackgroundColor3 = Constants.Color.BaseGray,
            BackgroundTransparency = 1,
            LayoutOrder = 3
        },
        tbl1
    )
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        isClientView = arg1.MainView.isClientView
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetActiveTab = function(arg1, arg2)
            callback(SetActiveTab(arg1, arg2))
        end
    }
end)(DataConsumer(var1, "ClientLogData", "ServerLogData"))
