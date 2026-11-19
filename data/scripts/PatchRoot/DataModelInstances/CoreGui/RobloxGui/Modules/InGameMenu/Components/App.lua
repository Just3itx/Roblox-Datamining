-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux

local scriptParentParent = script.Parent.Parent
local InGameMenuPolicy = require(scriptParentParent.InGameMenuPolicy)

local ViewportOverlay = require(script.Parent.ViewportOverlay)
local SideNavigation = require(script.Parent.SideNavigation)
local LeaveGameDialog = require(script.Parent.LeaveGameDialog)
local PageContainer = require(script.Parent.PageContainer)
local RespawnDialog = require(script.Parent.RespawnDialog)
local ReportDialog = require(script.Parent.ReportPage.ReportDialog)
local ReportSentDialog = require(script.Parent.ReportPage.ReportSentDialog)
local ControlLayoutSetter = require(script.Parent.ControlsPage.ControlLayoutSetter)
local Connection = require(script.Parent.Connection)
local EducationalPopup = require(script.Parent.EducationalPopup)
local MenuIconTooltip = require(script.Parent.MenuIconTooltip)
local FullscreenTitleBar = require(script.Parent.FullscreenTitleBar)

local Flags = scriptParentParent.Flags
local FFlagLuaMenuPerfImprovements = require(Flags.FFlagLuaMenuPerfImprovements)

local Constants = require(scriptParentParent.Resources.Constants)

local var1 = InGameMenuPolicy.connect(function(arg1, _)
    return {
        enableFullscreenTitleBar = arg1.enableFullscreenTitleBar(),
        isEducationalPopupEnabled = arg1.enableEducationalPopup()
    }
end)(function(arg1) -- name: App
    local fullscreenTitleBar = if arg1.enableFullscreenTitleBar then Roact.createElement(FullscreenTitleBar, { displayOrder = Constants.DisplayOrder.FullscreenTitleBar }) else nil

    if FFlagLuaMenuPerfImprovements then
        return Roact.createFragment({
            Content = arg1.isMenuOpen
                and Roact.createFragment({
                    Overlay = Roact.createElement(ViewportOverlay),
                    SideNavigation = Roact.createElement(SideNavigation),
                    LeaveGameDialog = Roact.createElement(LeaveGameDialog),
                    PageContainer = Roact.createElement(PageContainer),
                    RespawnDialog = Roact.createElement(RespawnDialog),
                    ReportDialog = Roact.createElement(ReportDialog),
                    ReportSentDialog = Roact.createElement(ReportSentDialog),
                    ControlLayoutSetter = Roact.createElement(ControlLayoutSetter)
                })
                or nil,
            Connection = Roact.createElement(Connection),
            EducationalPopup = arg1.isEducationalPopupEnabled and Roact.createElement(EducationalPopup) or nil,
            MenuIconTooltip = arg1.isEducationalPopupEnabled and Roact.createElement(MenuIconTooltip) or nil,
            FullscreenTitleBar = fullscreenTitleBar
        })
    end
    return Roact.createFragment({
        Overlay = Roact.createElement(ViewportOverlay),
        SideNavigation = Roact.createElement(SideNavigation),
        LeaveGameDialog = Roact.createElement(LeaveGameDialog),
        PageContainer = Roact.createElement(PageContainer),
        RespawnDialog = Roact.createElement(RespawnDialog),
        ReportDialog = Roact.createElement(ReportDialog),
        ReportSentDialog = Roact.createElement(ReportSentDialog),
        ControlLayoutSetter = Roact.createElement(ControlLayoutSetter),
        Connection = Roact.createElement(Connection),
        EducationalPopup = arg1.isEducationalPopupEnabled and Roact.createElement(EducationalPopup) or nil,
        MenuIconTooltip = arg1.isEducationalPopupEnabled and Roact.createElement(MenuIconTooltip) or nil,
        FullscreenTitleBar = fullscreenTitleBar
    })
end)

return RoactRodux.connect(function(arg1, _) -- name: mapStateToProps
    return {
        isMenuOpen = arg1.isMenuOpen
    }
end, nil)(var1)
