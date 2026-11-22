-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local _FeedTypes = require(script.Parent.FeedTypes)

local function matches(moment, published): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if published == nil then
        return false
    end
    local feedItemId = published.recommendationMetadata.feedItemId

    return moment.momentId == published.momentId
        or not (feedItemId == nil or feedItemId == "") and moment.recommendationMetadata.feedItemId == feedItemId
end

local function createPendingFeedOverlay()
    local tbl1 = {}
    local tbl2 = {}

    local function identity(arg1)
        if arg1.kind ~= "moment" then
            return nil
        end
        for value, value2 in tbl1 do
            if arg1.moment.momentId == value or matches(arg1.moment, value2.published) then
                return value
            end
        end
        return arg1.moment.momentId
    end

    return {
        update = function(arg1, tbl3): boolean
            local bool1 = false
            tbl2 = arg1
            for _, value in tbl2 do
                local moment = value.moment
                local tbl4 = tbl1[moment.momentId]
                if tbl4 == nil then
                    tbl4 = { retired = false, admitted = false }
                    tbl1[moment.momentId] = tbl4
                    bool1 = true
                end

                if value.publishedMoment ~= nil then
                    tbl4.published = value.publishedMoment
                end
            end

            for _, value in tbl1 do
                if value.published ~= nil and table.find(tbl3, value.published.momentId) ~= nil then
                    value.retired = true
                end
            end
            return bool1
        end,
        retireMissing = function(tbl3)
            local tbl4 = ({})
            for _, value in tbl3 do
                local var1 = identity(value)
                if var1 ~= nil then
                    tbl4[var1] = true
                end
            end
            for value, value2 in tbl1 do
                if value2.admitted and not tbl4[value] then
                    value2.retired = true
                end
            end
        end,
        merge = function(tbl3)
            for _, value in tbl1 do
                value.admitted = false
            end
            local tbl4 = {}
            for _, value in tbl2 do
                tbl4[value.moment.momentId] = true
            end
            local tbl5 = ({})
            for _, value in tbl3 do
                local var1 = identity(value)
                if var1 == nil then
                    continue
                end

                tbl5[var1] = true
                local var2 = tbl1[var1]
                if var2 ~= nil and value.kind == "moment" and value.moment.momentId ~= var1 then
                    var2.published = value.moment
                end
            end

            local result = {}
            local tbl6 = ({})
            local function append(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
                local var1 = identity(arg1)
                if var1 ~= nil then
                    if tbl6[var1] then
                        return
                    end
                    tbl6[var1] = true
                end
                table.insert(result, arg1)
            end

            for _, value in tbl2 do
                local moment = value.moment
                local momentId = moment.momentId
                local var1 = tbl1[momentId]
                if tbl5[momentId] or var1.retired then
                    continue
                end

                append({ kind = "moment", moment = var1.published or moment })
                var1.admitted = true
            end

            for _, value in tbl3 do
                local var1 = identity(value)
                local var2 = if var1 == nil then nil else tbl1[var1]

                if var2 == nil or value.kind ~= "moment" then
                    append(value)
                elseif not var2.retired and (tbl4[var1] or value.moment.momentId ~= var1) then
                    local moment = var2.published or value.moment

                    append(moment ~= value.moment and { kind = "moment", moment = moment } or value)
                    var2.admitted = true
                end
            end

            return result
        end,
        identity = identity
    }
end
return createPendingFeedOverlay
