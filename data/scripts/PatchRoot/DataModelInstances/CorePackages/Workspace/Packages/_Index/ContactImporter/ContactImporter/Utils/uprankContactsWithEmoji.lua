-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent
local Cryo = require(ContactImporterParent.Cryo)

local function isEmoji(num1: number): boolean
    return num1 >= 9728 and num1 <= 9983
        or num1 >= 9984 and num1 <= 10175
        or num1 >= 127744 and num1 <= 128511
        or num1 >= 128512 and num1 <= 128591
        or num1 >= 128640 and num1 <= 128767
        or num1 >= 128768 and num1 <= 128895
        or num1 >= 129280 and num1 <= 129535
        or num1 >= 127462 and num1 <= 127487
        or num1 >= 127344 and num1 <= 127569
        or num1 >= 129536 and num1 <= 129791
end

local function getStringHasEmoji(contactName: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in utf8.codes(contactName) do
        if isEmoji(value) then
            return true
        end
    end
    return false
end

local function uprankContactsWithEmoji(arg1)
    return Cryo.List.sort(arg1, function(arg2, arg3)
        if arg2.contactName and arg3.contactName then
            local stringHasEmoji = getStringHasEmoji(arg2.contactName)
            if stringHasEmoji ~= getStringHasEmoji(arg3.contactName) then
                return stringHasEmoji
            end
            if arg2.contactName ~= arg3.contactName then
                return string.upper(arg2.contactName) < string.upper(arg3.contactName)
            end
        end
        return (arg2.contactId or "") < (arg3.contactId or "")
    end)
end

return uprankContactsWithEmoji
