-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local Constants = require(script.Parent.Constants)
local _Types = require(script.Parent.Types)

local function fetchSmartSuggestions(str1: string)
    return AppChatNetworking.http.GetSuggestions(nil, str1, Constants.SUGGESTION_TYPES, Constants.MAX_SUGGESTIONS):andThen(
        function(arg1)
            local responseBody = arg1 and arg1.responseBody
            local suggestions

            if responseBody then
                suggestions = responseBody.suggestions

                if not suggestions then
                    return {}
                end
            else
                suggestions = {}
            end

            return suggestions
        end
    )
end
return fetchSmartSuggestions
