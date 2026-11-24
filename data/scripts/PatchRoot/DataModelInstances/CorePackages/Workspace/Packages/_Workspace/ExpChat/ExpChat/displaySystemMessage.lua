-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local List = require(ExpChatParent.llama).List
local var1 = require(ExpChatParent.ExpChatShared).Logger:new("ExpChat/" .. script.Name)

local sanitizeForRichText = require(script.Parent.sanitizeForRichText)

local FFlagEnableClientSummarySystemMessageOnLua = require(ExpChatParent.SharedFlags).FFlagEnableClientSummarySystemMessageOnLua

local function displaySystemMessage(arg1, tbl1, str1: string, arg2, arg3, str2: string?, func1: ((...any) -> (...any))?)
    var1:debug("Display system message: {}", str1)
    local var2 = nil
    if type(arg1) ~= "string" then
        str2 = table.concat(List.map(arg1, function(arg4)
            return arg2:FormatByKey(arg4, tbl1)
        end), "\n")
    elseif arg1 == "" then
        str2 = var2
    else
        local success, result = pcall(function()
            return arg2:FormatByKey(arg1, tbl1)
        end)

        if success then
            str2 = result
        end
    end

    if not arg3 or not str2 then
        return
    end

    if not FFlagEnableClientSummarySystemMessageOnLua then
        arg3:DisplaySystemMessage(sanitizeForRichText(str2), str1)
        return
    end

    local var3 = sanitizeForRichText(str2)
    if func1 then
        var3 = func1(var3)
    end
    arg3:DisplaySystemMessage(var3, str1)
end

return displaySystemMessage
