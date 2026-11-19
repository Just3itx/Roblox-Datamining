-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Components = script.Parent.Parent.Parent.Components
local ActionBindingsChart = require(Components.ActionBindings.ActionBindingsChart)
local UtilAndTab = require(Components.UtilAndTab)

local Actions = script.Parent.Parent.Parent.Actions
local ActionBindingsUpdateSearchFilter = require(Actions.ActionBindingsUpdateSearchFilter)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding

local var1 = Roact.Component:extend("MainViewActionBindings")

function var1.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onSearchTermChanged(arg2)
        arg1.props.dispatchActionBindingsUpdateSearchFilter(arg2, {})
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
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList
    local bindingsSearchTerm = arg1.props.bindingsSearchTerm

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
            UtilAndTab = Roact.createElement(UtilAndTab, {
                windowWidth = size.X.Offset,
                formFactor = formFactor,
                tabList = tabList,
                searchTerm = bindingsSearchTerm,
                layoutOrder = 1,
                refForParent = arg1.utilRef,
                onHeightChanged = arg1.onUtilTabHeightChanged,
                onSearchTermChanged = arg1.onSearchTermChanged
            }),
            ActionBindings = utilTabHeight > 0
                and Roact.createElement(
                    ActionBindingsChart,
                    {
                        size = UDim2.new(1, 0, 1, -utilTabHeight),
                        searchTerm = bindingsSearchTerm,
                        layoutOrder = 2
                    }
                )
        }
    )
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        bindingsSearchTerm = arg1.ActionBindingsData.bindingsSearchTerm
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchActionBindingsUpdateSearchFilter = function(arg1, arg2)
            callback(ActionBindingsUpdateSearchFilter(arg1, arg2))
        end
    }
end)(var1)
