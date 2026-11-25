-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local bool1 = game:DefineFastFlag("IECFunnelContextIds", false)

local module = {
    ItemType = { Asset = "Asset", Outfit = "Outfit" },
    Section = {
        BuyCreationPage = "buy_creation_page",
        BuyItemModal = "buy_item_modal",
        ProcessCompleteModal = "process_complete_modal"
    },
    Action = {
        FieldTouched = "field_touched",
        ButtonClicked = "button_clicked",
        PageLoad = "page_load"
    },
    Element = {
        Name = "name",
        Description = "description",
        X = "x",
        Expand = "expand",
        Buy = "buy",
        Cancel = "cancel"
    }
}

local var1 = nil
local var2 = nil

local function sendEvent(section: string, action: string, element: string?)
    local rbxAnalyticsService = RbxAnalyticsService
    local target = "client"
    local eventContext = "publish_avatar_prompt"
    local eventName = "iec_funnel_user_creation"
    local additionalArgs = {
        section = section,
        action = action,
        element = element,
        itemType = var1,
        itemSubType = var2,
        universeid = if bool1 then tostring(game.GameId) else nil,
        placeid = if bool1 then tostring(game.PlaceId) else nil,
        sessionid = if bool1 then RbxAnalyticsService:GetSessionId() else nil
    }
    rbxAnalyticsService:SendEventDeferred(target, eventContext, eventName, additionalArgs)
end

function module.setItemDetails(str1: string?, str2: string?)
    var1 = str1
    var2 = str2
end

function module.sendPageLoad(section)
    sendEvent(section, module.Action.PageLoad)
end

function module.sendFieldTouched(section, element)
    sendEvent(section, module.Action.FieldTouched, element)
end

function module.sendButtonClicked(section, element)
    sendEvent(section, module.Action.ButtonClicked, element)
end

return module
