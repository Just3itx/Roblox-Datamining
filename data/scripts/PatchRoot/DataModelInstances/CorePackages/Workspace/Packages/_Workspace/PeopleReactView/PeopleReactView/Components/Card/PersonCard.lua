-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalPlayer = game:GetService("Players").LocalPlayer

local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local ReactIs = require(PeopleReactViewParent.ReactIs)
local Signals = require(PeopleReactViewParent.Signals)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local View = require(PeopleReactViewParent.Foundation).View

local PeopleService = require(PeopleReactViewParent.PeopleService)

local CardDetails = require(PeopleReactView.Components.Card.CardDetails)
local CardThumbnail = require(PeopleReactView.Components.Card.CardThumbnail)
local CardTooltip = require(PeopleReactView.Components.Card.CardTooltip)

local service = PeopleService.getService("Flags")
local GetFFlagPeoplePageEnablePersonSignalStore = service.GetFFlagPeoplePageEnablePersonSignalStore
local GetFFlagPeoplePageLazyRenderCards = service.GetFFlagPeoplePageLazyRenderCards
local GetFFlagFixPeoplePageCardTooltip = service.GetFFlagFixPeoplePageCardTooltip
local FFlagPeopleCardsEnableVirtualizedGrid = service.FFlagPeopleCardsEnableVirtualizedGrid

return React.memo(function(tbl1) -- name: PersonCard
    local var1 = if GetFFlagPeoplePageEnablePersonSignalStore() then SignalsReact.useSignalBinding(Signals.createComputed(function(arg1)
        if type(tbl1.layoutOrder) == "function" then
            return tbl1.layoutOrder(arg1)
        end
        return tbl1.layoutOrder or 0
    end)) else nil

    local var2 = if ReactIs.isBinding(tbl1.width) then tbl1.width:map(function(xOffset: number): UDim2
        return UDim2.new(0, xOffset, 0, 0)
    end) else UDim2.new(0, tbl1.width, 0, 0)

    local var3, var4 = React.useState(not FFlagPeopleCardsEnableVirtualizedGrid and tbl1.showTooltip)

    if FFlagPeopleCardsEnableVirtualizedGrid then
        React.useEffect(function()
            local var5 = var4
            local showTooltip = tbl1.showTooltip

            if showTooltip then
                if LocalPlayer == nil then
                    showTooltip = false
                else
                    showTooltip = tbl1.person.UserId == LocalPlayer.UserId
                end
            end

            var5(showTooltip)
        end, { tbl1.showTooltip, tbl1.person })
    end

    local action = React.useCallback(function()
        var4(false)
        tbl1.onDismissTooltip()
    end, {})

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        tag = "auto-y",
        Size = var2,
        ZIndex = if var3 then 2 else 1,
        LayoutOrder = 0
    }

    if not GetFFlagPeoplePageEnablePersonSignalStore() then
        var1 = tbl1.layoutOrder
    end

    tbl2.LayoutOrder = var1
    local tbl3 = { CardContent = 0, CardTooltip = 0 }
    local createElement2 = React.createElement
    local var7 = View
    local tbl4 = {
        tag = if GetFFlagFixPeoplePageCardTooltip() then "size-full-0 auto-y col bg-surface-100 radius-medium" else "size-full col bg-surface-100 radius-medium"
    }

    local tbl5 = {
        CardThumbnail = React.createElement(CardThumbnail, {
            person = tbl1.person,
            shouldShowMenu = if GetFFlagPeoplePageLazyRenderCards() then tbl1.shouldShowMenu else nil,
            layoutOrder = 1,
            isCompactCardLayout = tbl1.isCompactCardLayout
        }),
        CardDetails = React.createElement(
            CardDetails,
            {
                person = tbl1.person,
                layoutOrder = 2,
                isCompactCardLayout = tbl1.isCompactCardLayout
            }
        )
    }
    tbl3.CardContent = createElement2(var7, tbl4, tbl5)

    tbl3.CardTooltip = if var3 then React.createElement(CardTooltip, { action = action }) else nil
    return createElement(var6, tbl2, tbl3)
end)
