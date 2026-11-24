-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Workspace = game:GetService("Workspace")

return function(tbl1)
    if tbl1 ~= nil and tbl1.Created ~= nil then
        local dateTime = DateTime.fromIsoDate(tbl1.Created)
        if dateTime then
            local unixTimestampMillis = dateTime.UnixTimestampMillis
            if Workspace:GetServerTimeNow() * 1000 - unixTimestampMillis > 604800000 then
                return true
            end
        end
    end

    return false
end
