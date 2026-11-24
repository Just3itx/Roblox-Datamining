-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local Constants = require(ExpChat.PresetChat.Constants)
local PresetSearch = require(ExpChat.Autocomplete.PresetSearch)

local getEnableChatInputBarConfigurationAutocompleteEnabled = require(ExpChat.Flags.getEnableChatInputBarConfigurationAutocompleteEnabled)

local ExtendedStandardizedFields = Constants.Analytics.ExtendedStandardizedFields

local tbl1 = {}

local function usePresetAutocompleteAnalytics(tbl2)
    local autocompleteDropdownReducer = tbl2.autocompleteDropdownReducer
    local var1 = if autocompleteDropdownReducer ~= nil then autocompleteDropdownReducer.results else tbl1
    local var2

    if autocompleteDropdownReducer == nil then
        var2 = false
    else
        var2 = autocompleteDropdownReducer.activated

        if var2 then
            if autocompleteDropdownReducer.autocompleteType == "presets" and #var1 > 0 then
                var2 = tbl2.isFocused

                if var2 then
                    if tbl2.autocompleteEnabled == true then
                        var2 = getEnableChatInputBarConfigurationAutocompleteEnabled()
                    else
                        var2 = false
                    end
                end
            else
                var2 = false
            end
        end
    end

    local var3 = React.useRef(nil)

    local var4 = React.useRef({})
    local var5 = React.useRef({})

    local var6 = React.useRef({})
    local var7 = React.useRef(nil)

    local var8 = React.useCallback(function()
        local current = var3.current
        if current == nil then
            return
        end

        local tbl3 = ({})
        for value, value2 in var6.current do
            tbl3[value2] = value - 1
        end

        local input = {}
        for _, presetId in var4.current do
            local var8 = tbl3[presetId]
            table.insert(
                input,
                {
                    preset_id = presetId,
                    index = if var8 == nil then -1 else var8,
                    click = if var7.current == presetId then 1 else 0
                }
            )
        end
        var3.current = nil
        var4.current = {}
        var5.current = {}
        var6.current = {}
        var7.current = nil

        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Dismiss,
                component = Constants.Analytics.Components.AutocompleteDropdown,
                autocomplete_session_id = current,
                preset_items = HttpService:JSONEncode(input)
            },
            ExtendedStandardizedFields
        )
    end, {})

    local recordPresetChosen = React.useCallback(function(str1: string)
        if var3.current == nil then
            return
        end
        local current = PresetSearch.getPresetIdForValue(GetPresetChatStore(false), str1)
        if current == nil then
            return
        end
        var7.current = current
    end, {})

    React.useEffect(function()
        if not var2 then
            return
        end

        local presetChatStore = GetPresetChatStore(false)
        local current = {}
        for _, value in var1 do
            local presetIdForValue = PresetSearch.getPresetIdForValue(presetChatStore, value)
            if presetIdForValue == nil then
                continue
            end

            table.insert(current, presetIdForValue)
            if not var5.current[presetIdForValue] then
                var5.current[presetIdForValue] = true
                table.insert(var4.current, presetIdForValue)
            end
        end

        var6.current = current
    end, { var2, var1 })

    React.useEffect(function()
        if not var2 then
            var8()
            return
        end

        if var3.current ~= nil then
            return
        end

        local str1 = HttpService:GenerateGUID(false)
        var3.current = str1

        ExpChatShared.Analytics:TelemetryLogEvent(
            ExpChatShared.Analytics.ExpChatPresetActionConfig,
            {
                event_type = Constants.Analytics.EventTypes.Show,
                component = Constants.Analytics.Components.AutocompleteDropdown,
                autocomplete_session_id = str1
            },
            ExtendedStandardizedFields
        )
    end, { var2, var8 })

    React.useEffect(function()
        return function()
            var8()
        end
    end, { var8 })

    return { recordPresetChosen = recordPresetChosen }
end

return usePresetAutocompleteAnalytics
