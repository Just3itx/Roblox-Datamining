-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toUserId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) == "table" then
        arg1 = arg1.userId or arg1.user_id
    end

    local var1 = tonumber(arg1)
    if var1 then
        return string.format("%d", var1)
    end

    return nil
end

local function buildSocialProofTextEventParams(tbl1): {namedUserId: number, page: number, placeId: number, shownUserCount: number, shownUserIds: number, totalConnections: number, universeId: number}?
    if tbl1.universeId == nil then
        return nil
    end

    local tbl2 = {}
    if typeof(tbl1.users) == "table" then
        for _, user in tbl1.users do
            local var1 = toUserId(user)

            if var1 then
                table.insert(tbl2, var1)
            end
        end
    end

    local tbl3 = { table.unpack(tbl2, 1, math.min(tonumber(tbl1.avatarMax) or 2, #tbl2)) }
    local totalConnections = tonumber(tbl1.totalConnections) or #tbl2

    local tbl4 = {
        universeId = tostring(tbl1.universeId),
        placeId = if tbl1.placeId == nil then "" else tostring(tbl1.placeId),
        totalConnections = totalConnections,
        shownUserIds = table.concat(tbl3, ","),
        shownUserCount = #tbl3,
        namedUserId = tbl2[1] or "",
        page = tbl1.page or ""
    }
    return tbl4
end

return buildSocialProofTextEventParams
