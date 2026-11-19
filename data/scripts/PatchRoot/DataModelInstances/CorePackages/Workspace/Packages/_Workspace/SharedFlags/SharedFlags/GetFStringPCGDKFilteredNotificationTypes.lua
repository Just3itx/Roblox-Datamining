-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastString("PCGDKFilteredNotificationTypes", "ExperienceInvitation,SquadExperienceInvitation")

return function()
    local fastString = game:GetFastString("PCGDKFilteredNotificationTypes")
    if fastString == "" then
        return {}
    end

    local result = ({})
    local tbl1 = string.split(fastString, ",")
    for _, value in ipairs(tbl1) do
        local var1 = value:match("^%s*(.-)%s*$")
        if var1 ~= "" then
            result[var1] = true
        end
    end

    return result
end
