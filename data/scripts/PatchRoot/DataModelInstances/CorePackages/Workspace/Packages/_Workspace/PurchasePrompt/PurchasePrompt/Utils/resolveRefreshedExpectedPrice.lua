-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resolveRefreshedExpectedPrice(arg1, arg2, collectibleItemInstanceId: string?, days: number?)
    local price = nil

    if collectibleItemInstanceId and collectibleItemInstanceId ~= "" then
        if arg2 ~= nil and arg2.data ~= nil then
            for _, value in ipairs(arg2.data) do
                if value.collectibleItemInstanceId == collectibleItemInstanceId then
                    price = value.price
                    break
                end
            end
        end

        if price == nil and arg1 ~= nil then
            return arg1.lowestResalePrice
        end
    elseif days and days ~= 0 then
        if arg1 ~= nil and arg1.timedOptions then
            for _, timedOption in ipairs(arg1.timedOptions) do
                if timedOption.days == days then
                    return timedOption.price
                end
            end

            return price
        end
    elseif arg1 ~= nil then
        price = arg1.price
    end

    return price
end

return resolveRefreshedExpectedPrice
