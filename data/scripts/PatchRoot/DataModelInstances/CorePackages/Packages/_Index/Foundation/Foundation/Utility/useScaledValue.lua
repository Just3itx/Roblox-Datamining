-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:30:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local Logger = require(Foundation.Utility.Logger)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function useScaledValue(num1: number)
    local var1 = useTokens()

    local var2 = num1 * var1.Config.UI.Scale

    if var2 <= var1.Size.Size_3000 then
        Logger:warning(
            "useScaledValue should be used for values larger than Size tokens. For smaller values, please align to a Size or derivative token."
        )
    end

    return var2
end

return useScaledValue
