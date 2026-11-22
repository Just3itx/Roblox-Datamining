-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)
local Signals = require(MomentsParent.Signals)

local function createPostStatusCardStore()
    local getCards, var2 = Signals.createSignal({})
    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = ({})
    local tbl5 = {}
    local tbl6 = {}
    local tbl7 = ({})

    local function add(tbl8)
        if tbl5[tbl8.id] then
            return
        end
        tbl5[tbl8.id] = true
        if tbl8.cardType == "Live" then
            tbl6[tbl8.id] = true
        end
        tbl1[tbl8.id] = nil
        tbl2[tbl8.id] = nil
        local var3 = table.clone(getCards(false))
        table.insert(var3, 1, tbl8)
        var2(var3)
    end

    return {
        getCards = getCards,
        add = add,
        markUploading = function(str1: string)
            if not tbl5[str1] then
                tbl2[str1] = true
            end
        end,
        isUploading = function(str1: string): boolean
            return tbl2[str1] == true
        end,
        awaitLiveCard = function(str1: string)
            tbl2[str1] = nil
            if not tbl5[str1] then
                tbl1[str1] = true
            end
        end,
        isAwaitingLiveCard = function(str1: string): boolean
            return tbl1[str1] == true
        end,
        markToastHiddenFor = function(str1: string)
            tbl3[str1] = true
        end,
        hadToastHidden = function(str1: string): boolean
            return tbl3[str1] == true
        end,
        markToastProbablySpentFor = function(str1: string)
            tbl4[str1] = true
        end,
        hadToastProbablySpent = function(str1: string): boolean
            return tbl4[str1] == true
        end,
        stopAwaitingLiveCard = function(str1: string, tbl8)
            tbl2[str1] = nil
            if not tbl1[str1] then
                return
            end
            tbl1[str1] = nil
            if tbl8 ~= nil and tbl3[str1] then
                add(tbl8)
            end
        end,
        dismiss = function(id: string)
            local tbl8 = {}
            for _, value in getCards(false) do
                if value.id ~= id then
                    table.insert(tbl8, value)
                end
            end
            var2(tbl8)
        end,
        hasHadLiveCard = function(str1: string): boolean
            return tbl6[str1] == true
        end,
        markShown = function(str1: string): boolean
            if tbl7[str1] then
                return false
            end
            tbl7[str1] = true
            return true
        end,
        reset = function()
            tbl1 = {}
            tbl2 = {}
            tbl3 = {}
            tbl4 = {}
            tbl5 = {}
            tbl6 = {}
            tbl7 = {}
            var2({})
        end
    }
end
return createPostStatusCardStore
