-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local Signals = require(AvatarExperienceCommonParent.Signals)
local Constants = require(AvatarExperienceCommon.Constants)
local SafeAppStorageService = require(AvatarExperienceCommon.Lib.SafeAppStorageService)

local str1 = game:DefineFastString("AXTooltipAllowedTooltips", "")

local bool1 = game:DefineFastFlag("AXTooltipUseMemStorage", false)

local num1 = game:DefineFastInt("AXTooltipMaxNumberOfTimesSeen", 2)

local function deserializeSeenTooltips(item: string)
    local result = ({})
    for _, value in (item:split(",")) do
        result[value] = if result[value] then result[value] + 1 else 1
    end

    return result
end

local function serializeSeenTooltips(tbl1): string
    local tbl2 = {}
    for value, value2 in tbl1 do
        for _ = 1, math.min(num1, value2) do
            table.insert(tbl2, value)
        end
    end

    return table.concat(tbl2, ",")
end

local function createAXTooltipStore()
    local tbl1 = str1:split(",")

    local item = SafeAppStorageService.getItem(Constants.AX_TOOLTIP_STORAGE_KEY, bool1)
    local tbl2 = deserializeSeenTooltips(item)

    local tbl3 = ({})
    local tbl4 = ({})

    for _, value in tbl1 do
        local var1 = tbl2[value] or 0
        if var1 < num1 then
            tbl3[value] = true
        end

        tbl4[value] = var1
    end

    SafeAppStorageService.setItem(Constants.AX_TOOLTIP_STORAGE_KEY, serializeSeenTooltips(tbl4), bool1)

    SafeAppStorageService.flush()

    local var1, var2 = Signals.createSignal(tbl3)
    local var3, var4 = Signals.createSignal(tbl4)

    local tbl5 = ({})

    return {
        getIsTooltipAllowedToBeShown = function(str2: string) -- name: getIsTooltipAllowedToBeShownSignal
            if tbl5[str2] == nil then
                tbl5[str2] = Signals.createComputed(function(arg1): boolean
                    return var1(arg1)[str2] == true
                end)
            end
            return tbl5[str2]
        end,
        dismissTooltip = function(str2: string, bool2: boolean?)
            local var5 = table.clone(var1(false))

            if var5[str2] ~= true then
                return
            end

            var5[str2] = false
            var2(var5)

            local var6 = var3(false)

            local var7 = var6[str2] or 0
            if not bool2 or num1 <= var7 then
                var6[str2] = num1
            else
                var6[str2] = var7 + 1
            end

            SafeAppStorageService.setItem(Constants.AX_TOOLTIP_STORAGE_KEY, serializeSeenTooltips(var6), bool1)

            SafeAppStorageService.flush()

            var4(var6)
        end
    }
end
return createAXTooltipStore
