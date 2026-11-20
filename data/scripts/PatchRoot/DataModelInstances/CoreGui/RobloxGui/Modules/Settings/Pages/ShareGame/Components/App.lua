-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local Modules = CoreGui.RobloxGui.Modules

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local RoactAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy).RoactAppPolicy

local ShareGame = Modules.Settings.Pages.ShareGame
local Constants = require(ShareGame.Constants)

local AppFeaturePolicies = require(CorePackages.Workspace.Packages.UniversalAppPolicy).AppFeaturePolicies
local EventStream = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventStream

local LayoutProvider = require(ShareGame.Components.LayoutProvider)

local ShareGameContainer = require(ShareGame.Components.ShareGameContainer)

local var1 = Roact.PureComponent:extend("App")

local function wrapWithProviders(tbl1: {any})
    return Roact.createElement(
        LayoutProvider,
        nil,
        {
            PolicyProvider = Roact.createElement(RoactAppPolicy.Provider, { policy = { AppFeaturePolicies } }, tbl1)
        }
    )
end

function var1.render(arg1)
    local analytics = arg1.props.analytics
    local pageTarget = arg1.props.pageTarget
    local shareGamePageFrame = if arg1.props.isPageOpen then Roact.createElement(ShareGameContainer, { analytics = analytics, zIndex = Constants.SHARE_GAME_Z_INDEX }) else nil
    return wrapWithProviders(
        { Roact.createElement(Roact.Portal, { target = pageTarget }, { ShareGamePageFrame = shareGamePageFrame }) }
    )
end

function var1.didMount(arg1)
    arg1.eventStream = EventStream.new(RbxAnalyticsService)
end

function var1.willUnmount(arg1)
    arg1.eventStream:releaseRBXEventStream()
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isPageOpen = arg1.Page.IsOpen
    }
end)(var1)
