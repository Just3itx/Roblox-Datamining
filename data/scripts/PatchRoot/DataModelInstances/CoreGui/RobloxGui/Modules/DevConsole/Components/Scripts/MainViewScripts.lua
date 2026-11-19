-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Components = script.Parent.Parent.Parent.Components
local ServerScripts = require(Components.Scripts.ServerScripts)
local UtilAndTab = require(Components.UtilAndTab)

local Actions = script.Parent.Parent.Parent.Actions
local ServerScriptsUpdateSearchFilter = require(Actions.ServerScriptsUpdateSearchFilter)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local tbl1 = { "Active", "Inactive" }

local var1 = Roact.PureComponent:extend("MainViewScripts")

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onCheckboxChanged(arg2, arg3)
        local tbl2 = {
            [arg2] = arg3
        }
        arg1.props.dispatchServerScriptsUpdateSearchFilter(nil, tbl2)
    end

    function arg1.onSearchTermChanged(arg2)
        arg1.props.dispatchServerScriptsUpdateSearchFilter(arg2, {})
    end

    arg1.utilRef = Roact.createRef()

    arg1.state = { utilTabHeight = 0, isClientView = true }
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
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList
    local serverTypeFilters = arg1.props.serverTypeFilters

    local utilTabHeight = arg1.state.utilTabHeight

    local serverSearchTerm = arg1.props.serverSearchTerm

    local orderedCheckboxState = ({})
    for i, name in ipairs(tbl1) do
        local serverTypeFilter = serverTypeFilters[name]
        if serverTypeFilter == nil then
            serverTypeFilter = true
        end

        orderedCheckboxState[i] = { name = name, state = serverTypeFilter }
    end

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
                orderedCheckboxState = orderedCheckboxState,
                searchTerm = serverSearchTerm,
                layoutOrder = 1,
                refForParent = arg1.utilRef,
                onHeightChanged = arg1.onUtilTabHeightChanged,
                onCheckboxChanged = arg1.onCheckboxChanged,
                onSearchTermChanged = arg1.onSearchTermChanged
            }),
            ServerScripts = utilTabHeight > 0
                and Roact.createElement(ServerScripts, {
                    size = UDim2.new(1, 0, 1, -utilTabHeight),
                    searchTerm = serverSearchTerm,
                    scriptFilters = serverTypeFilters,
                    layoutOrder = 2
                })
        }
    )
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        serverSearchTerm = arg1.ScriptsData.serverSearchTerm,
        serverTypeFilters = arg1.ScriptsData.serverTypeFilters
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchServerScriptsUpdateSearchFilter = function(arg1, arg2)
            callback(ServerScriptsUpdateSearchFilter(arg1, arg2))
        end
    }
end)(var1)
