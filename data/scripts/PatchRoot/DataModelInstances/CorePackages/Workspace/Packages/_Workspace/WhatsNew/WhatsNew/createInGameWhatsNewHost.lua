-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local WhatsNewParent = script:FindFirstAncestor("WhatsNew").Parent

local Foundation = require(WhatsNewParent.Foundation)
local Localization = require(WhatsNewParent.InExperienceLocales).Localization
local LocalizationProvider = require(WhatsNewParent.Localization).LocalizationProvider
local React = require(WhatsNewParent.React)
local ReactRoblox = require(WhatsNewParent.ReactRoblox)
local ensureWhatsNewStoreInitialized = require(script.Parent.store.ensureWhatsNewStoreInitialized)
local _ScopeActions = require(script.Parent.registry.ScopeActions)
local WhatsNewScreenHost = require(script.Parent.components.WhatsNewScreenHost)

local LocalizationService = game:GetService("LocalizationService")

local InGameWhatsNew = Instance.new("ScreenGui")
InGameWhatsNew.Name = "InGameWhatsNew"
InGameWhatsNew.DisplayOrder = 16
InGameWhatsNew.IgnoreGuiInset = true
InGameWhatsNew.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
InGameWhatsNew.ResetOnSpawn = false
InGameWhatsNew.Parent = game:GetService("CoreGui")

local var1 = nil

return {
    createInGameWhatsNewHost = function(tbl1)
        if var1 ~= nil then
            return var1
        end

        ensureWhatsNewStoreInitialized.ensureWhatsNewStoreInitialized({ scopeActions = tbl1.scopeActions })

        local element = React.createElement(Foundation.FoundationProvider, {
            colorMode = Foundation.Enums.ColorMode.Dark
        }, {
            LocalizationProvider = React.createElement(
                LocalizationProvider,
                {
                    localization = Localization.new(LocalizationService.RobloxLocaleId)
                },
                {
                    Overlay = React.createElement(Foundation.OverlayProvider, {
                        gui = InGameWhatsNew
                    }, {
                        Host = React.createElement(
                            WhatsNewScreenHost,
                            {
                                screenScopeId = "InGame",
                                scopeActions = tbl1.scopeActions,
                                isEnabled = true
                            }
                        )
                    })
                }
            )
        })
        local root = ReactRoblox.createRoot(InGameWhatsNew)
        local success, result = pcall(function()
            root:render(element)
        end)
        if not success then
            warn(`WhatsNew createInGameWhatsNewHost render failed: {result}`)
        end
        var1 = root
        return root
    end,
    resetForTests = function()
        var1 = nil
    end
}
