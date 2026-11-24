-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local createLazyComponent = require(scriptParent.RoactUtils).Components.createLazyComponent

local toggleSideSheet = require(script.Utils.toggleSideSheet)
local getSideSheetVisibility = require(script.Utils.getSideSheetVisibility)
local registerInGameMenuPeoplePageActions = require(script.Utils.registerInGameMenuPeoplePageActions)
local registerSideSheetIntegrations = require(script.Utils.registerSideSheetIntegrations)
local setIsRespawnEnabled = require(script.Utils.setIsRespawnEnabled)
local module = {
    Enums = require(script.Common.Enums),
    Constants = require(script.Common.Constants),
    Flags = require(script.Flags),
    SideSheet = require(script.SideSheet),
    AccountUpsell = require(script.Components.AccountUpsell),
    RobuxWidget = createLazyComponent(function()
        return require(script.RobuxWidget)
    end),
    toggleSideSheet = toggleSideSheet
}

function module.getDidSideSheetOpenWithPeoplePage(arg1)
    return require(script.Utils.getDidSideSheetOpenWithPeoplePage)(arg1)
end

function module.getHasRoomForPeoplePage()
    return require(script.Utils.getHasRoomForPeoplePage)()
end

function module.getIsPeoplePageOpen(arg1)
    return require(script.Utils.getIsPeoplePageOpen)(arg1)
end

function module.getSideSheetAnimationDuration()
    return require(script.Utils.getSideSheetAnimationDuration)()
end

function module.getSideSheetDrawerWidth(arg1)
    return require(script.Utils.getSideSheetDrawerWidth)(arg1)
end

function module.getSideSheetMenuPageHeight(arg1, arg2)
    return require(script.Utils.getSideSheetMenuPageHeight)(arg1, arg2)
end

function module.getSideSheetMenuPageWidth(arg1, arg2, arg3)
    return require(script.Utils.getSideSheetMenuPageWidth)(arg1, arg2, arg3)
end

module.getSideSheetVisibility = getSideSheetVisibility
module.registerInGameMenuPeoplePageActions = registerInGameMenuPeoplePageActions
module.registerSideSheetIntegrations = registerSideSheetIntegrations

function module.setupInGameMenuPeoplePageActions(arg1)
    require(script.Utils.setupInGameMenuPeoplePageActions)(arg1)
end

function module.setupPeoplePageOpenTracking(arg1)
    require(script.Utils.setupPeoplePageOpenTracking)(arg1)
end

function module.closePeoplePageWhenNoRoomBesideSideSheet(arg1)
    return require(script.Utils.closePeoplePageWhenNoRoomBesideSideSheet)(arg1)
end

module.setIsRespawnEnabled = setIsRespawnEnabled

module["jest.config"] = script["jest.config"]
return module
