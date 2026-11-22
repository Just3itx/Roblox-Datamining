-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)
local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)

local getLocalUserId = require(Moments.Utils.getLocalUserId)
local GetPostStatusCardStore = require(Moments.Stores.GetPostStatusCardStore)
local useMomentsTabIsVisible = require(Moments.Hooks.useMomentsTabIsVisible)
local sendrPostStatusToast = require(script.Parent.sendrPostStatusToast)
local var1 = if SharedFlags.FFlagMomentsPostFeedback then require(MomentsParent.Loggers).Logger:new("Moments.Upload") else nil

local function shouldHidePostStatusToast()
    local postStatusCardStore = GetPostStatusCardStore(false)
    local bool1 = false
    local bool2 = false

    local tbl1 = ({})
    local function noteLiveCardPost(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        bool1 = true
        if postStatusCardStore.hadToastHidden(str1) then
            return
        end

        if postStatusCardStore.hadToastProbablySpent(str1) then
            bool2 = true
        else
            tbl1[str1] = true
        end
    end
    for _, value in postStatusCardStore.getCards(false) do
        if value.cardType == "Live" then
            noteLiveCardPost(value.id)
        end
    end
    local localUserId = getLocalUserId()
    local var2 = if localUserId == nil then nil else MomentsGetMomentsUserStore(false).getPendingUserMoments(false)[localUserId]
    local tbl2 = {}
    if var2 ~= nil then
        for _, value in var2 do
            local momentId = value.moment.momentId
            if postStatusCardStore.hasHadLiveCard(momentId) then
                noteLiveCardPost(momentId)
            elseif value.status ~= "Moderated"
                and not (postStatusCardStore.hadToastHidden(momentId) or postStatusCardStore.isUploading(momentId))
            then
                if postStatusCardStore.hadToastProbablySpent(momentId) then
                    bool2 = true
                else
                    if value.publishedMoment ~= nil or not postStatusCardStore.isAwaitingLiveCard(momentId) then
                        return false, nil, false
                    end
                    table.insert(tbl2, momentId)
                end
            end
        end
    end
    local var3 = nil
    local num1 = 0
    for value in tbl1 do
        num1 += 1
        var3 = value
    end
    if #tbl2 > 0 then
        if num1 > 0 then
            return false, nil, false
        elseif #tbl2 == 1 then
            return true, tbl2[1], bool2
        end
        return true, tbl2[#tbl2], true
    elseif not bool1 then
        return false, nil, false
    elseif num1 == 1 then
        return true, var3, true
    else
        return true, nil, false
    end
end

local function useHidePostStatusToast()
    local var2 = useMomentsTabIsVisible()
    React.useEffect(function()
        if not var2 then
            return nil
        end
        return sendrPostStatusToast.listen(function(arg1)
            if sendrPostStatusToast.isFailure(arg1) then
                if var1 ~= nil then
                    var1:debug("event=post_status_toast decision=shown reason=failure")
                end
                return
            end
            local bool1, var3, bool2 = shouldHidePostStatusToast()
            if var1 ~= nil then
                var1:debug(
                    "event=post_status_toast decision={} creditedMomentId={} guess={}",
                    if bool1 then "hidden" else "shown",
                    var3 or "nil",
                    tostring(bool2)
                )
            end
            if not bool1 then
                return
            end

            sendrPostStatusToast.dismiss(arg1)
            if var3 == nil then
                return
            end

            if bool2 then
                GetPostStatusCardStore(false).markToastProbablySpentFor(var3)
                return
            end

            GetPostStatusCardStore(false).markToastHiddenFor(var3)
        end)
    end, { var2 })
end

return useHidePostStatusToast
