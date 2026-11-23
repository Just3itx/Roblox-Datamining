-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local AvatarExperienceFlags = require(AvatarExperienceTimedOptionsParent.AvatarExperienceFlags)

local React = require(AvatarExperienceTimedOptionsParent.React)
local Foundation = require(AvatarExperienceTimedOptionsParent.Foundation)
local Localization = require(AvatarExperienceTimedOptionsParent.Localization)
local Localization2 = require(AvatarExperienceTimedOptionsParent.RobloxAppLocales).Localization
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local _AvatarExperienceCommon = require(AvatarExperienceTimedOptionsParent.AvatarExperienceCommon)

local FFlagAXDurablesForMIS = AvatarExperienceFlags.FFlagAXDurablesForMIS

local function getPermanentPrice(options) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, option in options do
        if option.days == 0 then
            return option.price
        end
    end

    return 0
end

local function useWearTimeSelectedOptionViewModel(tbl1)
    local tokens = useTokens()

    local localization = React.useMemo(function()
        return Localization2.new(LocalizationService.RobloxLocaleId)
    end, {})

    local selectedIndex, setSelectedIndex = React.useState(nil)

    React.useEffect(function()
        if FFlagAXDurablesForMIS and tbl1.selectedTimedOptionIndexInReducer ~= nil then
            setSelectedIndex(tbl1.selectedTimedOptionIndexInReducer)
            return
        end
        for k, option in tbl1.options do
            if option.selected then
                setSelectedIndex(k)
                return
            end
        end
    end, { tbl1.options, if FFlagAXDurablesForMIS then tbl1.selectedTimedOptionIndexInReducer else nil })

    local selectedOption = if selectedIndex then tbl1.options[selectedIndex] else nil
    local var5 = if selectedOption then selectedOption.days else 0
    local localizedText = useLocalization({
        infinite = "Feature.Durables.ItemDetails.WearTimeOptions.Button.Infinite",
        xDay = { "Feature.Durables.BottomBar.RentalDuration", num = var5 },
        xDays = { "Feature.Durables.BottomBar.RentalDurationPlural", num = var5 },
        xDayList = { "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDay", num = var5 },
        xDaysList = { "Feature.Durables.ItemDetails.WearTimeOptions.Button.XDays", num = var5 }
    })

    local isOpen, setIsOpen = React.useState(false)
    local anchorRef = React.useRef(nil)
    local price = if selectedOption then selectedOption.price else getPermanentPrice(tbl1.options)
    local var11, var12

    if var5 == 0 then
        var11 = localizedText.infinite
        var12 = localizedText.infinite
    elseif var5 == 1 then
        var11 = localizedText.xDay
        var12 = localizedText.xDayList
    else
        var11 = localizedText.xDays
        var12 = localizedText.xDaysList
    end

    return {
        tokens = tokens,
        localization = localization,
        selectedIndex = selectedIndex,
        setSelectedIndex = setSelectedIndex,
        selectedOption = selectedOption,
        days = var5,
        localizedText = localizedText,
        isOpen = isOpen,
        setIsOpen = setIsOpen,
        anchorRef = anchorRef,
        price = price,
        subLabelText = var11,
        listLabelText = var12,
        handleOptionActivated = React.useCallback(function(num1: number)
            setSelectedIndex(num1)
            if tbl1.onOptionActivated then
                tbl1.onOptionActivated(num1)
            end
            setIsOpen(false)
        end, { tbl1.onOptionActivated }),
        updatedOptions = React.useMemo(function()
            local result = ({})
            for k, option2 in tbl1.options do
                local tbl2 = {
                    days = option2.days,
                    price = option2.price,
                    selected = k == selectedIndex,
                    discountInformation = option2.discountInformation
                }
                result[k] = tbl2
            end

            return result
        end, { tbl1.options, selectedIndex }),
        disableOptionSelection = tbl1.disableOptionSelection
    }
end

return useWearTimeSelectedOptionViewModel
