-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Cryo = require(scriptParentParent.Cryo)
local Foundation = require(scriptParentParent.Foundation)
local React = require(scriptParentParent.React)

local AltTextCard = require(scriptParent.Components).AltTextCard.AltTextCard
local CardComponent = require(scriptParent.utils).CardsHelper.CardComponent
local _CardsType = require(scriptParent.CardsType)

local useTokens = Foundation.Hooks.useTokens

local tbl1 = {
    anchorPoint = Vector2.new(0, 0),
    layoutOrder = 1,
    position = UDim2.fromScale(0, 0)
}

local function renderCard(arg1, conversationId: string?, tbl2, arg2)
    local tbl3 = {}

    for _, component in ipairs(arg1.components) do
        if not CardComponent[component.type] then
            tbl3 = { React.createElement(AltTextCard, { altText = arg1.alt_text }) }
            break
        end

        local var1 = Cryo.Dictionary.join(component.data, { conversationId = conversationId })
        if tbl2 then
            var1 = Cryo.Dictionary.join(var1, tbl2)
        end

        table.insert(tbl3, React.createElement(CardComponent[component.type], var1))
    end

    return React.createElement(Foundation.View, {
        AutomaticSize = Enum.AutomaticSize.XY,
        backgroundStyle = arg2.Color.Shift.Shift_200,
        cornerRadius = UDim.new(0, arg2.Radius.Large)
    }, tbl3)
end

local function Cards(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2 = useTokens()

    local tbl3 = {}

    for _, card in pairs(var1.cards) do
        local func1 = renderCard
        local conversationId = var1.conversationId
        local analyticsInfo = var1.analyticsInfo
        table.insert(tbl3, func1(card, conversationId, analyticsInfo, var2))
    end

    return React.createElement(Foundation.View, {
        AutomaticSize = Enum.AutomaticSize.XY,
        AnchorPoint = var1.anchorPoint,
        Position = var1.position,
        LayoutOrder = var1.layoutOrder
    }, tbl3)
end

return Cards
