-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local ReactRoblox = require(scriptParentParent.ReactRoblox)
local InExperienceLocales = require(scriptParentParent.InExperienceLocales)
local Localization = require(scriptParentParent.Localization)
local Foundation = require(scriptParentParent.Foundation)
local Roact = require(scriptParentParent.Roact)

local DisclosureButtonListenerComponent = require(scriptParent.DisclosureButtonListenerComponent)
local AdsInteractivityControls = require(scriptParent.AdsInteractivityControls)

local LocalizationProvider = Localization.LocalizationProvider
local FoundationProvider = Foundation.FoundationProvider

local function initializeImmersiveAds()
    local adGuiInteractivityControls = Instance.new("Folder")
    adGuiInteractivityControls.Name = "AdGuiInteractivityControls"
    adGuiInteractivityControls.Parent = CoreGui

    local tbl1 = ({})

    AdService.adGuiRegisterUI:Connect(function(adGui: Instance)
        if not adGui:IsA("AdGui") or tbl1[adGui] then
            return
        end

        local element = Roact.createElement(AdsInteractivityControls, { adGui = adGui })
        local element2 = Roact.createElement("Folder", nil, element)

        tbl1[adGui] = Roact.mount(element2, adGuiInteractivityControls, "AdsInteractivityControls")

        adGui.Destroying:Connect(function()
            Roact.unmount(tbl1[adGui])
            tbl1[adGui] = nil
        end)
    end)

    AdService:SetAdGuiInteractivityHandlerInitialized()
end

local function initializeImmersiveBrandedAds()
    local immersiveBrandedAds = Instance.new("ScreenGui")
    immersiveBrandedAds.Name = "ImmersiveBrandedAds"
    immersiveBrandedAds.ResetOnSpawn = false
    immersiveBrandedAds.IgnoreGuiInset = true
    immersiveBrandedAds.Parent = CoreGui

    ReactRoblox.createRoot(immersiveBrandedAds):render({
        localizationProvider = React.createElement(
            LocalizationProvider,
            {
                localization = InExperienceLocales.Localization.new(LocalizationService.RobloxLocaleId)
            },
            {
                foundationProvider = React.createElement(
                    FoundationProvider,
                    {
                        colorMode = Foundation.Enums.ColorMode.Dark
                    },
                    {
                        disclosureButtonListener = React.createElement(DisclosureButtonListenerComponent)
                    }
                )
            }
        )
    })
end

return function()
    initializeImmersiveAds()
    initializeImmersiveBrandedAds()
end
