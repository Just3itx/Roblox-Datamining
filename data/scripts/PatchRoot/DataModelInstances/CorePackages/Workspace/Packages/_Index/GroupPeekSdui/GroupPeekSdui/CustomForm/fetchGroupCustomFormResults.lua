-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupPeekSduiParent = script:FindFirstAncestor("GroupPeekSdui").Parent

local _CustomForms = require(GroupPeekSduiParent.CustomForms)

local getGroupCustomFormUrl = require(script.Parent.getGroupCustomFormUrl)
local groupsFetch = require(script.Parent.groupsFetch)
local toCustomFormData = require(script.Parent.toCustomFormData)

return function(arg1)
    local var1 = getGroupCustomFormUrl.results(arg1.entityId, arg1.formId, arg1.cfVertical)
    return groupsFetch(var1, "GET"):andThen(function(arg2)
        return toCustomFormData(arg1.formId, arg2.responseBody, arg1.current)
    end)
end
