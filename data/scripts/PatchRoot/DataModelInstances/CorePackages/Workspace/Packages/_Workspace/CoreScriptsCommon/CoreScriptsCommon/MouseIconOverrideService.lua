-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local tbl1 = {}

local function update() -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tbl1[#tbl1]
    if var1 then
        UserInputService.OverrideMouseIconBehavior = var1[2]
        return
    end
    UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
end

return {
    push = function(str1: string, enumItem: EnumItem)
        assert(type(str1) == "userdata" or type(str1) == "string", "key")
        assert(typeof(enumItem) == "EnumItem", "behavior")
        assert(enumItem.EnumType == Enum.OverrideMouseIconBehavior, "behavior.EnumType")

        for i, value in ipairs(tbl1) do
            if value[1] == str1 then
                table.remove(tbl1, i)
                break
            end
        end

        table.insert(tbl1, { str1, enumItem })
        update()
    end,
    pop = function(arg1)
        assert(type(arg1) == "userdata" or type(arg1) == "string", "key")

        local var1 = nil

        for i, value in ipairs(tbl1) do
            if value[1] == arg1 then
                var1 = i
                break
            end
        end

        if var1 then
            table.remove(tbl1, var1)
        end

        update()
    end
}
