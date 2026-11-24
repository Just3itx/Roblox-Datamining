-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent
local _Chrome = require(InExperienceSideSheetParent.Chrome)
local Foundation = require(InExperienceSideSheetParent.Foundation)
local React = require(InExperienceSideSheetParent.React)
local _Signals = require(InExperienceSideSheetParent.Signals)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local View = Foundation.View

local VerticalItem = require(InExperienceSideSheet.Components.VerticalItem)
local getDidSideSheetOpenWithPeoplePage = require(InExperienceSideSheet.Utils.getDidSideSheetOpenWithPeoplePage)
local shouldShowInviteFriendsInSideSheet = require(InExperienceSideSheet.Utils.shouldShowInviteFriendsInSideSheet)

local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)
local FFlagAddInviteFriendsIntegration = SharedFlags.FFlagAddInviteFriendsIntegration
local FFlagHidePeoplePageInviteFriends = SharedFlags.FFlagHidePeoplePageInviteFriends
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav
local FFlagSideSheetOpenPeoplePage = require(InExperienceSideSheet.Flags).FFlagSideSheetOpenPeoplePage

return React.memo(function(tbl1) -- name: VerticalList
    local integrationsGetter = tbl1.integrationsGetter
    local var1 = SignalsReact.useSignalState(integrationsGetter)
    local var2 = if FFlagSideSheetOpenPeoplePage then SignalsReact.useSignalState(getDidSideSheetOpenWithPeoplePage) else false
    local bool1 = not (FFlagHidePeoplePageInviteFriends and FFlagAddInviteFriendsIntegration)

    local tbl2 = ({})
    local num1 = 0

    for _, value in var1 do
        if not shouldShowInviteFriendsInSideSheet(value.id, var2, bool1) then
            continue
        end

        num1 += 1
        local id = value.id
        local createElement = React.createElement
        local var3 = VerticalItem
        local tbl3 = {
            label = value.integration.label,
            layoutOrder = num1,
            onActivated = value.activated,
            icon = value.component,
            disableGamepadDirections = if FFlagSideSheetFocusNav then {
                right = not tbl1.allowRightFocusEscape,
                left = true
            } else nil,
            firstIntegrationToFocusCallback = if FFlagSideSheetFocusNav and num1 == 1 then tbl1.firstIntegrationToFocusCallback else nil
        }
        tbl2[id] = createElement(var3, tbl3)
    end

    return React.createElement(View, { tag = "col gap-small size-full-0 auto-y", LayoutOrder = tbl1.layoutOrder }, tbl2)
end)
