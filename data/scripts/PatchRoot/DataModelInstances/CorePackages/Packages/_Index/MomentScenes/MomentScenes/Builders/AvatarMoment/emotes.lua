-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = table.freeze({
    wave = table.freeze({ r6 = 128777973, r15 = 507770239 }),
    point = table.freeze({ r6 = 128853357, r15 = 507770453 }),
    dance = table.freeze({ r6 = 182435998, r15 = 507771019 }),
    dance2 = table.freeze({ r6 = 182436842, r15 = 507776043 }),
    dance3 = table.freeze({ r6 = 182436935, r15 = 507777268 }),
    laugh = table.freeze({ r6 = 129423131, r15 = 507770818 }),
    cheer = table.freeze({ r6 = 129423030, r15 = 507770677 })
})

local tbl1 = ({})
for value in var1 do
    tbl1[value] = true
end
table.freeze(tbl1)

return {
    resolve = function(str1: string, humanoidRigType)
        local var2 = var1[str1]
        return if humanoidRigType == Enum.HumanoidRigType.R6 then var2.r6 else var2.r15
    end,
    isName = function(arg1): boolean
        return typeof(arg1) == "string" and tbl1[arg1] == true
    end
}
