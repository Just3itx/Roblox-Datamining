-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1, languageCode: string?)
    if tbl1 == nil or languageCode == nil then
        return nil
    end

    for _, value in pairs(tbl1) do
        local locale = value.locale
        if locale and locale.language and locale.language.languageCode == languageCode then
            return locale.language.name
        end
    end

    return nil
end
