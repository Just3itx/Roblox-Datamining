-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local parseSectionsFromData = require(ProfilePlatform.Components.About).parseSectionsFromData

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local Description = require(ProfilePlatform.Components.Description)
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage

local NavigateDown = NavigationRodux.Thunks.NavigateDown
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil

local function ContactDescriptionContainer(tbl1)
    local var1 = useDispatch()
    local var2 = useProfileJsonComponent(Enums.Components.ContactDescription)
    local contactsProfileDescription = useLocalization({ contactsProfileDescription = { TextKeys.ContactsProfileBody, contactName = var2.contactName } }).contactsProfileDescription

    local sections = React.useMemo(function()
        return parseSectionsFromData({ description = contactsProfileDescription }, Enums.ProfileTypes.Contact)
    end, { contactsProfileDescription })

    local onActivateMoreButton = React.useCallback(function()
        local tbl2 = {
            name = AppPage.AboutDetailsSheet,
            extraProps = { sections = sections }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, { var1, sections })

    return React.createElement(Description, {
        description = contactsProfileDescription,
        layoutOrder = tbl1.layoutOrder,
        onActivateMoreButton = onActivateMoreButton
    })
end

return ContactDescriptionContainer
