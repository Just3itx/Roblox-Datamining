-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    if type(arg1) == "table" then
        if arg1.itemLicensingInfo == nil then
            return arg1.license
        end

        return arg1.itemLicensingInfo
    end

    return nil
end
