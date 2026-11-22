-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function func1(arg1, arg2): boolean
    if arg1.eventDate == "" or arg1.eventDate == nil or arg2.eventDate == "" or arg2.eventDate == nil then
        return true
    end

    local dateTime = DateTime.fromIsoDate(arg1.eventDate) or nil
    local dateTime2 = DateTime.fromIsoDate(arg2.eventDate) or nil

    return dateTime == nil or dateTime2 == nil or dateTime.UnixTimestampMillis > dateTime2.UnixTimestampMillis
end

return function(arg1)
    local success, result = pcall(function()
        local var1 = table.clone(arg1)
        table.sort(var1, func1)
        return var1
    end)

    return if success then result else arg1
end
