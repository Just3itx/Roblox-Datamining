-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local SharedFlags = require(AvatarExperienceCatalogParent.SharedFlags)
local _createAXShoppingCartStore = require(AvatarExperienceCatalog.Stores.createAXShoppingCartStore)
local useTimedOptionsFtux = require(AvatarExperienceCatalog.Hooks.useTimedOptionsFtux)

local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagAXDurables2Option = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXDurables2Option
local num1 = game:DefineFastInt("2OptionOfferPillTooltipTimeout", 5)

local function useCheckoutRowItemCardViewModel(arg1)
    local selectedTimedOptionPrice, setSelectedTimedOptionPrice = React.useState(function()
        if arg1.timedOptions then
            for _, timedOption in arg1.timedOptions do
                if timedOption.selected then
                    return timedOption.price
                end
            end
        end
        return nil
    end)

    React.useEffect(function()
        if arg1.selectedTimedOptionIndexInReducer ~= nil then
            local timedOption = arg1.timedOptions and arg1.timedOptions[arg1.selectedTimedOptionIndexInReducer]
            if timedOption then
                setSelectedTimedOptionPrice(timedOption.price)
            end

            return
        end
        if not FFlagAXMISWithBlackbird or not arg1.timedOptions then
            return
        end
        for _, timedOption in arg1.timedOptions do
            if timedOption.selected then
                setSelectedTimedOptionPrice(timedOption.price)
                return
            end
        end
    end, { arg1.selectedTimedOptionIndexInReducer, if FFlagAXMISWithBlackbird then arg1.timedOptions else nil })

    local var3 = nil
    local var4 = nil
    if FFlagAXDurables2Option then
        local var5 = useTimedOptionsFtux()

        var3, var4 = React.useState(var5.shouldShow2OptionOfferPillTooltip())

        React.useEffect(function()
            local var6 = if var3 then task.delay(num1, function()
                var4(false)
                var5.hide2OptionOfferPillTooltip()
            end) else nil

            return function()
                if var6 then
                    task.cancel(var6)
                end
            end
        end, { var3, var4, var5 })
    end

    return {
        selectedTimedOptionPrice = selectedTimedOptionPrice,
        setSelectedTimedOptionPrice = setSelectedTimedOptionPrice,
        showOfferPillTooltip = if FFlagAXDurables2Option then var3 else nil
    }
end

return useCheckoutRowItemCardViewModel
