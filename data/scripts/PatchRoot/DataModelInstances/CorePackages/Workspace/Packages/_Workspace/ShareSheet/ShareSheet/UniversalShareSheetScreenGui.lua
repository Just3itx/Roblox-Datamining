-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local AppCommonLib = require(ShareSheetParent.AppCommonLib)
local Foundation = require(ShareSheetParent.Foundation)
local InExperienceLocales = require(ShareSheetParent.InExperienceLocales)
local Localization = require(ShareSheetParent.Localization)
local React = require(ShareSheetParent.React)
local ReactRoblox = require(ShareSheetParent.ReactRoblox)
local SignalsReact = require(ShareSheetParent.SignalsReact)

local FFlagShareSheetFoundationDevice = require(script.Parent.Flags.FFlagShareSheetFoundationDevice)
local UniversalShareSheetHost = require(script.Parent.Components.UniversalShareSheet.UniversalShareSheetHost)

local GetLocalizationServiceStore = Localization.GetLocalizationServiceStore
local Localization2 = InExperienceLocales.Localization
local LocalizationProvider = Localization.LocalizationProvider

local function UniversalShareSheetScreenGui()
    local gui, ref = React.useState(nil)
    local localizationServiceStore = GetLocalizationServiceStore()
    local var3 = SignalsReact.useSignalState(localizationServiceStore.getRobloxLocaleId)
    local localization = React.useMemo(function()
        return Localization2.new(var3)
    end, { var3 })

    local createElement = React.createElement
    local str1 = "ScreenGui"
    local tbl1 = {
        DisplayOrder = 15,
        IgnoreGuiInset = true,
        Name = "UniversalShareSheetScreenGui",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ref = ref
    }
    local tbl2 = { FoundationProvider = 0 }
    local createElement2 = React.createElement
    local foundationProvider = Foundation.FoundationProvider
    local tbl3 = {
        colorMode = Foundation.Enums.ColorMode.Dark,
        device = if FFlagShareSheetFoundationDevice then AppCommonLib.getDeviceType() else nil
    }
    local tbl4 = {
        LocalizationProvider = React.createElement(LocalizationProvider, {
            localization = localization
        }, {
            OverlayProvider = if gui == nil then nil else React.createElement(Foundation.OverlayProvider, { gui = gui }, { Host = React.createElement(UniversalShareSheetHost) })
        })
    }
    tbl2.FoundationProvider = createElement2(foundationProvider, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

return {
    mount = function(parent)
        local universalShareSheetScreenGuiRoot = Instance.new("Folder")
        universalShareSheetScreenGuiRoot.Name = "UniversalShareSheetScreenGuiRoot"
        universalShareSheetScreenGuiRoot.Parent = parent

        local root = ReactRoblox.createRoot(universalShareSheetScreenGuiRoot)
        root:render(React.createElement(UniversalShareSheetScreenGui))

        return root
    end
}
