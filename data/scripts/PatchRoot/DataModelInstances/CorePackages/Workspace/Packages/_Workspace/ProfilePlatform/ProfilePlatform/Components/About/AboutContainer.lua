-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local useAboutSections = require(ProfilePlatform.Hooks.useAboutSections)
local Enums = require(ProfilePlatform.Common.Enums)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local Description = require(ProfilePlatform.Components.Description)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local parseSectionsFromData = require(script.Parent.parseSectionsFromData)

local NavigateDown = NavigationRodux.Thunks.NavigateDown
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local FFlagProfilePlatformNewProfileHeader = SharedFlags.FFlagProfilePlatformNewProfileHeader
local FFlagProfileAboutDetailsUseSheet = SharedFlags.FFlagProfileAboutDetailsUseSheet
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil

local function AboutDescriptionContainer(tbl1)
    local var1 = useDispatch()
    local var2, var3

    if FFlagProfilePlatformNewProfileHeader then
        local var4 = useAboutSections()
        var2 = var4.aboutDetails
        var3 = var4.aboutSections
    else
        local profileType = useProfileWrapperContext().profileType
        var2 = useProfileJsonComponent(Enums.Components.About)
        var3 = React.useMemo(function()
            return parseSectionsFromData(
                var2,
                profileType,
                if profileType == Enums.ProfileTypes.User then `@{var2.name}` else var2.name
            )
        end, { var2, profileType, var2.name })
    end

    local profileName = if FFlagProfileAboutDetailsUseSheet then if useProfileWrapperContext().profileType == Enums.ProfileTypes.User then `@{var2.name}` else var2.name else nil
    local description = var2.description
    local var5 = useLocalization({ noBioYet = TextKeys.NoBioYet })

    if description == nil or description == "" then
        if FFlagProfilePlatformNewProfileHeader then
            description = nil
        else
            description = var5.noBioYet
        end
    end

    local onActivateMoreButton = React.useCallback(function()
        local tbl2 = {
            name = AppPage.AboutDetailsSheet,
            extraProps = { sections = var3, profileName = profileName }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, { var1, var3, profileName })

    return React.createElement(
        Description,
        {
            description = description,
            layoutOrder = tbl1.layoutOrder,
            onActivateMoreButton = onActivateMoreButton
        }
    )
end
return AboutDescriptionContainer
