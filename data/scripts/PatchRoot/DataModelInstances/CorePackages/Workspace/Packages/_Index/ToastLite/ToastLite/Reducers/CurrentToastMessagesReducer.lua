-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ToastLiteParent = script:FindFirstAncestor("ToastLite").Parent

local Cryo = require(ToastLiteParent.Cryo)
local Rodux = require(ToastLiteParent.Rodux)
local ToastRodux = require(ToastLiteParent.ToastRodux)

local function messagesAreEqual(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.toastTitle == arg2.toastTitle and arg1.toastSubtitle == arg2.toastSubtitle and arg1.toastType == arg2.toastType
end

local function messageIsAlreadyPresent(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in ipairs(arg1) do
        if messagesAreEqual(value, arg2) then
            return true
        end
    end
    return false
end

local num1 = 0

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ToastRodux.Actions.SetCurrentToastMessage.name] = function(arg1, arg2)
    local var1 = Cryo.Dictionary.join(arg2.toastMessage, { sequenceNumber = num1 })
    num1 += 1

    if messageIsAlreadyPresent(arg1, var1) then
        return arg1
    end

    return Cryo.List.join(arg1, { var1 })
end

tbl1[ToastRodux.Actions.RemoveCurrentToastMessage.name] = function(arg1, _)
    if #arg1 == 0 then
        return arg1
    end

    return Cryo.List.removeIndex(arg1, 1)
end

tbl1[ToastRodux.Actions.RemoveAllToastMessages.name] = function(_, _)
    return {}
end

return createReducer({}, tbl1)
