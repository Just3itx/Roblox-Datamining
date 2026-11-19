-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local InspectAndBuyReducer = require(scriptParentParent.Reducers.InspectAndBuyReducer)
local Constants = require(scriptParentParent.Constants)
local CompactView = require(scriptParentParent.CompactView)
local WideView = require(scriptParentParent.WideView)
local renderWithCoreScriptsStyleProvider = require(scriptParentParentParent.Common.renderWithCoreScriptsStyleProvider)

local InspectAndBuyContext = require(scriptParentParent.Components.InspectAndBuyContext)

local var1 = Roact.Component:extend("TestContainer")

function var1.init(arg1)
    arg1.store = arg1.props.overrideStore or Rodux.Store.new(InspectAndBuyReducer, {}, { Rodux.thunkMiddleware })

    arg1.views = {}
    arg1.views[Constants.View.Compact] = CompactView
    arg1.views[Constants.View.Wide] = WideView
end

function var1.render(arg1)
    local num1 = 0
    for _, _ in arg1.props[Roact.Children] do
        num1 += 1
    end
    assert(num1 > 0, "TestContainer: no children provided, nothing will be tested")

    return Roact.createElement(InspectAndBuyContext.Provider, {
        value = arg1.views
    }, { Roact.createElement(RoactRodux.StoreProvider, {
            store = arg1.store
        }, {
            ThemeProvider = renderWithCoreScriptsStyleProvider({ InspectMenu = Roact.createElement("ScreenGui", {}, arg1.props[Roact.Children]) })
        }) })
end

return var1
