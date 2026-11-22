-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local Cryo = require(MomentsParent.Cryo)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local tbl1 = { shareCount = 0, hasShared = false }

local function createShareCountsStore()
    local getShareInfoByMomentId, var2 = createSignal({})

    local tbl2 = ({})

    return {
        getShareInfoByMomentId = getShareInfoByMomentId,
        getShareInfo = function(str1: string)
            if tbl2[str1] == nil then
                tbl2[str1] = createComputed(function(arg1)
                    return getShareInfoByMomentId(arg1)[str1] or tbl1
                end)
            end
            return tbl2[str1]
        end,
        setBatchShareCounts = function(tbl3)
            var2(function(arg1)
                local var3 = table.clone(arg1)
                for value, value2 in tbl3 do
                    local var4 = arg1[value]
                    if var4 ~= nil and var4.hasShared and not value2.hasShared then
                        local tbl4 = {
                            shareCount = math.max(var4.shareCount, value2.shareCount),
                            hasShared = true
                        }
                        var3[value] = tbl4
                    else
                        var3[value] = value2
                    end
                end
                return var3
            end)
        end,
        setShareCount = function(str1: string, shareCount: number, hasShared: boolean)
            var2(function(arg1)
                return (Cryo.Dictionary.union(arg1, { [str1] = { shareCount = shareCount, hasShared = hasShared } }))
            end)
        end,
        markShared = function(str1: string)
            local var3 = getShareInfoByMomentId(false)
            local var4 = var3[str1] or tbl1
            if var4.hasShared then
                return
            end
            var2((Cryo.Dictionary.union(var3, { [str1] = { shareCount = var4.shareCount + 1, hasShared = true } })))
        end,
        clear = function()
            var2({})
            table.clear(tbl2)
        end
    }
end
return createShareCountsStore
