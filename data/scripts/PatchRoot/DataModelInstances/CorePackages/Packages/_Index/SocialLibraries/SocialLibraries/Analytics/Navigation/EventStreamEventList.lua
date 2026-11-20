-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EventNames = require(script.Parent.EventNames)
local Enums = require(script.Parent.Parent.Enums)
local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes
local SubPages = Enums.SubPages
local Pages = Enums.Pages
local BtnValues = require(script.Parent.BtnValues)

local function uid(arg1): string
    return tostring(arg1)
end

return {
    [EventNames.HomePage_Carousel_LuaProfile] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.PlayerProfile,
            subpage = SubPages.PeekView,
            page = Pages.PlayerProfile
        },
        formatRulesForAdditionalInfo = { uid = uid }
    },
    [EventNames.HomePage_Carousel_FriendsLanding] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.FriendsLanding
        },
        formatRulesForAdditionalInfo = { uid = uid }
    },
    [EventNames.MorePage_FriendsLanding] = {
        context = Contexts.HomePage,
        eventType = EventTypes.ButtonClick,
        additionalInfo = {
            btn = BtnValues.FriendsLanding
        },
        formatRulesForAdditionalInfo = { uid = uid }
    }
}
