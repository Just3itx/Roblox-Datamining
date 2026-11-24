-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local InExperienceOverlayParent = script:FindFirstAncestor("InExperienceOverlay").Parent

local CoreGuiCommon = require(InExperienceOverlayParent.CoreGuiCommon)
local Foundation = require(InExperienceOverlayParent.Foundation)
local Localization = require(InExperienceOverlayParent.InExperienceLocales).Localization
local Localization2 = require(InExperienceOverlayParent.Localization)
local React = require(InExperienceOverlayParent.React)
local ReactRoblox = require(InExperienceOverlayParent.ReactRoblox)
local Songbird = require(InExperienceOverlayParent.Songbird)

local Components = CoreGuiCommon.Components
local View = Foundation.View

local FFlagEnableUISelector = CoreGuiCommon.Flags.FFlagEnableUISelector

local function renderInExperienceOverlay()
    local inExperienceOverlay = Instance.new("ScreenGui")
    inExperienceOverlay.Name = "InExperienceOverlay"
    inExperienceOverlay.DisplayOrder = 6
    inExperienceOverlay.IgnoreGuiInset = true
    inExperienceOverlay.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    inExperienceOverlay.ClipToDeviceSafeArea = false
    inExperienceOverlay.ScreenInsets = Enum.ScreenInsets.None
    inExperienceOverlay.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    inExperienceOverlay.Parent = CoreGui

    local createElement = React.createElement
    local foundationProvider = Foundation.FoundationProvider
    local tbl1 = {
        colorMode = Foundation.Enums.ColorMode.Dark
    }
    local tbl2 = { LocalizationProvider = 0 }
    local createElement2 = React.createElement
    local localizationProvider = Localization2.LocalizationProvider
    local tbl3 = {
        localization = Localization.new(LocalizationService.RobloxLocaleId)
    }
    local tbl4 = {
        Popups = React.createElement(View, { tag = "size-full" }, {
            HeadsetDisconnectDialog = React.createElement(Components.HeadsetDisconnectDialog),
            HurtOverlay = React.createElement(Components.HurtOverlay),
            InExperienceUiSelector = if FFlagEnableUISelector then React.createElement(Components.InExperienceUiSelector) else nil
        }),
        Binders = React.createElement(React.Fragment, {}, { SongbirdDebugAudio = React.createElement(Songbird.DebugAudioEmitters) })
    }
    tbl2.LocalizationProvider = createElement2(localizationProvider, tbl3, tbl4)
    local element = createElement(foundationProvider, tbl1, tbl2)

    local root = ReactRoblox.createRoot(inExperienceOverlay)
    root:render(element)

    return root
end

return renderInExperienceOverlay
