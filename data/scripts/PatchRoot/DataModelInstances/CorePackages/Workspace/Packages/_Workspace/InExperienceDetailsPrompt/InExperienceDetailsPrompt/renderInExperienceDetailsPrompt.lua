-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")
local InExperienceDetailsPrompt = script:FindFirstAncestor("InExperienceDetailsPrompt")
local InExperienceDetailsPromptParent = InExperienceDetailsPrompt.Parent

local Provider = require(InExperienceDetailsPromptParent.FocusNavigationUtils).FocusNavigableSurfaceRegistry.Provider
local Foundation = require(InExperienceDetailsPromptParent.Foundation)
local FoundationProvider = Foundation.FoundationProvider
local LocalizationProvider = require(InExperienceDetailsPromptParent.Localization).LocalizationProvider
local Localization = require(InExperienceDetailsPromptParent.InExperienceLocales).Localization
local React = require(InExperienceDetailsPromptParent.React)
local ReactFocusNavigation = require(InExperienceDetailsPromptParent.ReactFocusNavigation)
local ReactRoblox = require(InExperienceDetailsPromptParent.ReactRoblox)

local InExperienceDetailsPromptApp = require(InExperienceDetailsPrompt.InExperienceDetailsPromptApp)

local FFlagLuaAppIedpOverlayAndNavigationFix = require(InExperienceDetailsPromptParent.SharedFlags).FFlagLuaAppIedpOverlayAndNavigationFix

local DisplayOrder = game:DefineFastInt("InExperienceDetailsPromptDisplayOrder", -1)

local function createFocusNavigationService() -- Luacid: Inlined by compiler; 1 call site recovered
    return ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)
end

local function renderInExperienceDetailsPrompt()
    local folder = Instance.new("Folder")
    folder.Name = if FFlagLuaAppIedpOverlayAndNavigationFix then "InExperienceDetailsPromptApp" else "InExperienceDetailsPrompt"

    folder.Parent = CoreGui
    local screenGui

    if FFlagLuaAppIedpOverlayAndNavigationFix then
        screenGui = Instance.new("ScreenGui")
        screenGui.Parent = folder
        screenGui.Name = "InExperienceDetailsPromptOverlay"
        screenGui.DisplayOrder = DisplayOrder
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui.Enabled = true
        screenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
        screenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
        screenGui.ClipToDeviceSafeArea = false
    else
        screenGui = nil
    end

    local value = createFocusNavigationService()

    local createElement = React.createElement
    local var1 = LocalizationProvider
    local tbl1 = {
        localization = Localization.new(LocalizationService.RobloxLocaleId)
    }
    local tbl2 = {
        FoundationProvider = React.createElement(FoundationProvider, {
            colorMode = Foundation.Enums.ColorMode.Dark,
            overlayGui = if FFlagLuaAppIedpOverlayAndNavigationFix then screenGui else nil
        }, {
            FocusNavigationProvider = React.createElement(
                ReactFocusNavigation.FocusNavigationContext.Provider,
                { value = value },
                {
                    FocusNavigationRegistryProvider = React.createElement(Provider, nil, { InExperienceDetailsPromptApp = React.createElement(InExperienceDetailsPromptApp) })
                }
            )
        })
    }
    local element = createElement(var1, tbl1, tbl2)

    local createRoot = ReactRoblox.createRoot

    if FFlagLuaAppIedpOverlayAndNavigationFix then
        folder = screenGui
    end

    local root = createRoot(folder)
    root:render(element)
    return root
end

return renderInExperienceDetailsPrompt
