-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Style = require(InExperienceShopParent.Style)
local Foundation = require(InExperienceShopParent.Foundation)
local Localization = require(InExperienceShopParent.AppLocales).Localization
local LocalizationProvider = require(InExperienceShopParent.Localization).LocalizationProvider

local function ContextProviders(tbl1)
    return React.createElement(Foundation.FoundationProvider, {
        colorMode = tbl1.theme,
        overlayGui = tbl1.overlayGui
    }, {
        AppStyleProvider = React.createElement(
            Style.AppStyleProvider,
            {
                style = {
                    themeName = tbl1.theme,
                    fontName = "Gotham"
                }
            },
            {
                LocalizationProvider = React.createElement(
                    LocalizationProvider,
                    {
                        localization = Localization.new(LocalizationService.RobloxLocaleId)
                    },
                    tbl1.children
                )
            }
        )
    })
end

return ContextProviders
