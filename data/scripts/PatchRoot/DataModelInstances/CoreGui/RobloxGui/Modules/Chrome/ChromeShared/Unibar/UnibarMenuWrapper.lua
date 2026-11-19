-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")

local ReactUtils = require(CorePackages.Packages.ReactUtils)
local React = require(CorePackages.Packages.React)
local UnibarMenu = require(ChromeShared.Unibar.UnibarMenu)
local UnibarStyle = require(CorePackages.Workspace.Packages.Chrome).UnibarStyle
local TooltipProvider = require(ChromeShared.Unibar.Tooltips.TooltipProvider)
local RoactAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy).RoactAppPolicy
local AppFeaturePolicies = require(CorePackages.Workspace.Packages.UniversalAppPolicy).AppFeaturePolicies

local FFlagTokenizeUnibarConstantsWithStyleProvider = require(ChromeShared.Flags).FFlagTokenizeUnibarConstantsWithStyleProvider

local function UnibarMenuWrapper(arg1)
    local createElement = React.createElement
    local contextStack = ReactUtils.ContextStack
    local tbl1 = {
        providers = { React.createElement(RoactAppPolicy.Provider, { policy = { AppFeaturePolicies } }), React.createElement(TooltipProvider), if FFlagTokenizeUnibarConstantsWithStyleProvider then React.createElement(UnibarStyle.Provider) else nil }
    }
    return createElement(contextStack, tbl1, { UnibarMenu = React.createElement(UnibarMenu, arg1) })
end

return UnibarMenuWrapper
