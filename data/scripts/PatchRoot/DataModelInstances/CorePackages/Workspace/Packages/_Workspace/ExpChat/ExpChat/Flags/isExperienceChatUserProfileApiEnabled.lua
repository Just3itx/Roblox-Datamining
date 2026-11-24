-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

game:DefineFastInt("ExperienceChatUserProfileApiRollout_v1", 0)
game:DefineFastFlag("ExperienceChatUserProfileApiEnabledForAll_v1", false)

local function func1(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local item = (tbl1 or AppStorageService):GetItem("AppInstallationId")

    local str1 = typeof(item)

    if str1 == "number" then
        return item
    end

    if str1 ~= "string" then
        return nil
    end

    if string.len(item) <= 0 then
        return nil
    end

    return tonumber(string.sub(item, -2))
end

local function func2(func3: (...any) -> (...any), tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = func3()
    local var2 = func1(tbl1)

    if var2 == nil then
        return var1 >= 100
    end

    return var2 % 100 + 1 <= var1
end

local function _(func4: (...any) -> (...any), tbl1): () -> boolean -- Luacid: unused: defined but never referenced
    local bool1 = func2(func4, tbl1)

    return function()
        return bool1
    end
end

local function func3(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastInt("ExperienceChatUserProfileApiRollout_v1")
end

local function func4(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastFlag("ExperienceChatUserProfileApiEnabledForAll_v1")
end

local num1 = func3()
local var1 = func1(false)
local bool1 = if var1 == nil then num1 >= 100 else var1 % 100 + 1 <= num1

local function func5()
    return bool1
end

return function(): boolean
    return func4() or func5()
end
