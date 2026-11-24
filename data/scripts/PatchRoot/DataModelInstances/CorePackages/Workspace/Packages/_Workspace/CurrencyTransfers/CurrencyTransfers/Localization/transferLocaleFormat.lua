-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    substituteAmount = function(str1: string, str2: string)
        local var1, _ = string.gsub(str1, "{amount}", tostring(str2))
        return var1
    end,
    substituteReceiverNotAllowed = function(str1: string, str2: string)
        local str3 = tostring(str2)
        local var1, _ = string.gsub(str1, "{userName}", str3)
        local var2, _ = string.gsub(var1, "{username}", str3)
        return var2
    end,
    substituteUsername = function(str1: string, str2: string)
        local var1, _ = string.gsub(str1, "{username}", tostring(str2))
        return var1
    end,
    substituteMinAmount = function(str1: string, str2: string)
        local var1, _ = string.gsub(str1, "{minAmount}", tostring(str2))
        return var1
    end,
    substituteMaxAmount = function(str1: string, str2: string)
        local var1, _ = string.gsub(str1, "{maxAmount}", tostring(str2))
        return var1
    end
}
