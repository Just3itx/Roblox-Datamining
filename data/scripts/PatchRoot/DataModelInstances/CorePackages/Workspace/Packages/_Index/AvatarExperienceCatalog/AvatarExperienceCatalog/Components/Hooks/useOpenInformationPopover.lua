-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local useDispatch = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useNavigation = require(AvatarExperienceCatalogParent.Navigation).useNavigation
local AvatarScreen = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).Enums.AvatarScreen
local OpenInfoPeekView = require(AvatarExperienceCatalogParent.DiscoveryRouting).OpenInfoPeekView
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local useIsSpatial = require(AvatarExperienceCatalogParent.Responsive).useIsSpatial

local function useOpenInformationPopover(titleText: string?, bodyText: string?)
    local var1 = useDispatch()
    local var2 = useNavigation()
    local var3 = useIsSpatial()

    local var4 = useLocalization({ gotIt = "Feature.Avatar.Action.GotIt" })

    local var5 = React.useCallback(function()
        if not var3 then
            var1(OpenInfoPeekView(titleText or "", bodyText or ""))

            return
        end

        var2.navigate(AvatarScreen.GenericPrompt, { titleText = titleText, bodyText = bodyText, buttonText = var4.gotIt })
    end, {
        titleText,
        bodyText,
        var4.gotIt,
        var1,
        var2,
        var3
    })
    return if bodyText == nil or bodyText == "" then nil else var5
end

return useOpenInformationPopover
