-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    ToastEvents = {
        AttemptDisplay = "ToastNotifications.displayToastNotification",
        Display = "ToastNotifications.displayedToastNotification",
        Update = "ToastNotifications.updatedToastNotification",
        UserAction = "ToastNotifications.UserActionOnToastNotification"
    },
    RegisteredCallbacks = {}
}
function module.DispatchEvent(tbl1, str1: string, str2: string, tbl2)
    local var1 = tbl1.RegisteredCallbacks[str2] and tbl1.RegisteredCallbacks[str2][str1]
    if not var1 then
        return
    end

    for value in var1 do
        task.spawn(value, tbl2)
    end
end

function module.RemoveCallback(tbl1, str1: string, str2: string, func1: (...any) -> (...any))
    local var1 = tbl1.RegisteredCallbacks[str2] and tbl1.RegisteredCallbacks[str2][str1]
    if not var1 then
        return
    end
    var1[func1] = nil
    if next(var1) then
        return
    end

    tbl1.RegisteredCallbacks[str2][str1] = nil
    if not next(tbl1.RegisteredCallbacks[str2]) then
        tbl1.RegisteredCallbacks[str2] = nil
    end
end

function module.RegisterCallback(tbl1, str1: string, str2: string, func1: (...any) -> (...any))
    if not tbl1.RegisteredCallbacks[str2] then
        tbl1.RegisteredCallbacks[str2] = {}
    end
    if not tbl1.RegisteredCallbacks[str2][str1] then
        tbl1.RegisteredCallbacks[str2][str1] = {}
    end
    tbl1.RegisteredCallbacks[str2][str1][func1] = true
    return function()
        tbl1:RemoveCallback(str1, str2, func1)
    end
end

return module
