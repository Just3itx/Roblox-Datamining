-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    if not arg1.existing then
        return false
    end

    if arg1.new.lastUpdated
        and arg1.existing.lastUpdated
        and math.floor((arg1.existing.lastUpdated:GetUnixTimestamp())) < math.floor((arg1.new.lastUpdated:GetUnixTimestamp()))
    then
        return true
    end

    return not not (arg1.new.hasUnreadMessages and not arg1.existing.hasUnreadMessages)
end
