-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSduiParent = script:FindFirstAncestor("GroupPeekSdui").Parent

local HttpService = game:GetService("HttpService")
local Http = require(GroupPeekSduiParent.Http)
local Promise = require(GroupPeekSduiParent.Promise)
local _CustomForms = require(GroupPeekSduiParent.CustomForms)

local getGroupCustomFormUrl = require(script.Parent.getGroupCustomFormUrl)
local groupsFetch = require(script.Parent.groupsFetch)

return function(arg1)
    local values = ({})
    for _, answer in arg1.answers do
        local fieldId = answer.fieldId
        local tbl2 = if answer.fieldType == "Radio" then {
            choiceOptionId = answer.optionIds[1]
        } else {
            multiChoiceOptionIds = answer.optionIds
        }
        values[fieldId] = tbl2
    end

    return groupsFetch(
        getGroupCustomFormUrl.responses(arg1.entityId, arg1.formId),
        "POST",
        {
            postBody = HttpService:JSONEncode({ responseSpecs = { values = values }, cfVertical = arg1.cfVertical })
        }
    ):andThen(
        function()
            return nil
        end,
        function(arg2)
            if type(arg2) == "table" and arg2.StatusCode == Http.StatusCodes.CONFLICT then
                return nil
            end
            return Promise.reject(arg2)
        end
    )
end
