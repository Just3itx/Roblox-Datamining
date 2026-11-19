-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local var1 = Roact.PureComponent:extend("PageNavigationWatcher")
var1.validateProps = t.strictInterface({
    desiredPage = t.string,
    onNavigateTo = t.optional(t.callback),
    onNavigateAway = t.optional(t.callback),
    currentPage = t.string,
    menuOpen = t.boolean
})

function var1.init(arg1, arg2)
    arg1:setState({ lastPage = arg2.currentPage, lastMenuOpen = arg2.menuOpen })
end

function var1.render(arg1)
    return Roact.createFragment(arg1.props[Roact.Children])
end

function var1.didUpdate(arg1)
    local lastPage = arg1.state.lastPage
    local lastMenuOpen = arg1.state.lastMenuOpen
    local currentPage = arg1.props.currentPage
    local menuOpen = arg1.props.menuOpen

    if lastPage == currentPage and lastMenuOpen == menuOpen then
        return
    end

    arg1:setState({ lastPage = currentPage, lastMenuOpen = menuOpen })

    if currentPage == arg1.props.desiredPage and menuOpen and arg1.props.onNavigateTo ~= nil then
        arg1.props.onNavigateTo()
    elseif lastPage == arg1.props.desiredPage and lastMenuOpen and arg1.props.onNavigateAway ~= nil then
        arg1.props.onNavigateAway()
    elseif lastMenuOpen and not menuOpen and arg1.props.onNavigateAway ~= nil then
        arg1.props.onNavigateAway()
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1)
    return {
        currentPage = arg1.menuPage,
        menuOpen = arg1.isMenuOpen
    }
end)(var1)
