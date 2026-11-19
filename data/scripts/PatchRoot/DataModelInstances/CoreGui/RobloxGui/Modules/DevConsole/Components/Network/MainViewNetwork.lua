-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Components = script.Parent.Parent.Parent.Components
local ClientNetwork = require(Components.Network.ClientNetwork)
local ServerNetwork = require(Components.Network.ServerNetwork)
local UtilAndTab = require(Components.UtilAndTab)

local Actions = script.Parent.Parent.Parent.Actions
local ClientNetworkUpdateSearchFilter = require(Actions.ClientNetworkUpdateSearchFilter)
local ServerNetworkUpdateSearchFilter = require(Actions.ServerNetworkUpdateSearchFilter)
local SetActiveTab = require(Actions.SetActiveTab)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local var1 = Roact.Component:extend("MainViewNetwork")

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onClientButton()
        arg1.props.dispatchSetActiveTab("Network", true)
    end

    function arg1.onServerButton()
        arg1.props.dispatchSetActiveTab("Network", false)
    end

    function arg1.onSearchTermChanged(arg2)
        if arg1.props.isClientView then
            arg1.props.dispatchClientNetworkUpdateSearchFilter(arg2, {})
            return
        end
        arg1.props.dispatchServerNetworkUpdateSearchFilter(arg2, {})
    end

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

function var1.render(arg1)
    local tbl1 = ({})
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList
    local isClientView = arg1.props.isClientView

    local utilTabHeight = arg1.state.utilTabHeight
    local searchTerm = isClientView and arg1.props.clientSearchTerm or arg1.props.serverSearchTerm

    tbl1.UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) })

    tbl1.UtilAndTab = Roact.createElement(UtilAndTab, {
        windowWidth = size.X.Offset,
        formFactor = formFactor,
        tabList = tabList,
        isClientView = isClientView,
        searchTerm = searchTerm,
        layoutOrder = 1,
        refForParent = arg1.utilRef,
        onHeightChanged = arg1.onUtilTabHeightChanged,
        onClientButton = arg1.onClientButton,
        onServerButton = arg1.onServerButton,
        onSearchTermChanged = arg1.onSearchTermChanged
    })

    if utilTabHeight > 0 then
        if isClientView then
            tbl1.ClientNetwork = Roact.createElement(
                ClientNetwork,
                {
                    size = UDim2.new(1, 0, 1, -utilTabHeight),
                    searchTerm = searchTerm,
                    layoutOrder = 2
                }
            )
        else
            tbl1.ServerNetwork = Roact.createElement(
                ServerNetwork,
                {
                    size = UDim2.new(1, 0, 1, -utilTabHeight),
                    searchTerm = searchTerm,
                    layoutOrder = 2
                }
            )
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
        isClientView = arg1.MainView.isClientView,
        clientSearchTerm = arg1.NetworkData.clientSearchTerm,
        serverSearchTerm = arg1.NetworkData.serverSearchTerm
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchClientNetworkUpdateSearchFilter = function(arg1, arg2)
            callback(ClientNetworkUpdateSearchFilter(arg1, arg2))
        end,
        dispatchServerNetworkUpdateSearchFilter = function(arg1, arg2)
            callback(ServerNetworkUpdateSearchFilter(arg1, arg2))
        end,
        dispatchSetActiveTab = function(arg1, arg2)
            callback(SetActiveTab(arg1, arg2))
        end
    }
end)(var1)
