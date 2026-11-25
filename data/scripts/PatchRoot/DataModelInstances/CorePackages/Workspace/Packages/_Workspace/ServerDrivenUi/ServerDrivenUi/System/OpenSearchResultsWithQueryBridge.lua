-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Signal = require(ServerDrivenUiParent.AppCommonLib).Signal
local FFlagLuaAppSduiSearchAutocomplete = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiSearchAutocomplete

local signal = Signal.new()

local tbl1 = {}

return {
    run = function(str1: string, str2: string, bool1: boolean?, str3: string?)
        if not FFlagLuaAppSduiSearchAutocomplete then
            signal:fire(str1, str2)

            return
        end

        if bool1 and str3 then
            for i = #tbl1, 1, -1 do
                if tbl1[i].confirmSearch(str1, str2, str3) then
                    return
                end
            end
        end
        signal:fire(str1, str2, bool1 == true, str3)
    end,
    connect = function(func1: (...any) -> (...any))
        return signal:connect(func1)
    end,
    connectAutocompleteHost = FFlagLuaAppSduiSearchAutocomplete and function(confirmSearch: (...any) -> (...any), suggestionClicked: ((...any) -> (...any))?) -- name: connectAutocompleteHost
        local tbl2 = { confirmSearch = confirmSearch, suggestionClicked = suggestionClicked }
        table.insert(tbl1, tbl2)
        return {
            disconnect = function(_)
                local var1 = table.find(tbl1, tbl2)
                if var1 then
                    table.remove(tbl1, var1)
                end
            end
        }
    end or nil,
    runSuggestionClicked = FFlagLuaAppSduiSearchAutocomplete and function(str1: string, str2: string, str3: string, num1: number) -- name: runSuggestionClicked
        for i = #tbl1, 1, -1 do
            local suggestionClicked = tbl1[i].suggestionClicked
            if suggestionClicked and suggestionClicked(str1, str2, str3, num1) then
                return
            end
        end
    end or nil
}
