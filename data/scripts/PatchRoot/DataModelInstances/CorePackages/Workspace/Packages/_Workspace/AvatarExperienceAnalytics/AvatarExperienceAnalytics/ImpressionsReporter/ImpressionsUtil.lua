-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.writeItemAttributes(tbl1, arg1, tbl2)
    if not tbl1 then
        warn("Impressions schema is nil")
        return
    end

    for value, value2 in tbl1.mapping do
        local var1 = tbl2[value]
        if var1 then
            arg1:SetAttribute(value2.attribute, var1)
        end
    end
end

function module.buildSchema(str1: string, tbl1)
    local mapping = ({})
    local groupBy = tbl1.groupBy

    for _, value in tbl1.mapping do
        local isGrouping = if groupBy then table.find(groupBy, value.out) ~= nil else false
        local prop = value.prop
        mapping[prop] = {
            attribute = string.format("%s_%s", str1, value.prop),
            out = value.out,
            isGrouping = isGrouping
        }
    end

    if groupBy then
        for _, value in groupBy do
            local bool1 = false
            for _, value2 in tbl1.mapping do
                if value2.out == value then
                    bool1 = true
                end

                if bool1 then
                    break
                end
            end

            if not bool1 then
                error(string.format("Impression schema groupBy field '%s' not specified in output mapping", value))
            end
        end
    end

    return {
        mapping = mapping,
        enumMap = tbl1.enumMap,
        surfaceSpecificAnalyticsMetadata = tbl1.surfaceSpecificAnalyticsMetadata
    }
end

function module.packEvents(tbl1, tbl2)
    if not tbl1 then
        warn("Impressions schema nil")
        return
    end

    local tbl3 = ({})
    local result = {}

    for value, value2 in tbl2 do
        local attributes = value2:GetAttributes()
        local str1 = ""

        for _, value3 in tbl1.mapping do
            if value3.isGrouping then
                str1 ..= attributes[value3.attribute] or "_"
            end
        end

        local var1 = tbl3[str1] or {}
        tbl3[str1] = var1

        for _, value3 in tbl1.mapping do
            local var2 = attributes[value3.attribute]
            local out = value3.out

            if value3.isGrouping then
                var1[out] = var2
            else
                local var3 = var1[out] or {}
                var1[out] = var3
                var3[value] = var2 or ""

                if tbl1.enumMap and tbl1.enumMap[out] then
                    var3[value] = tbl1.enumMap[out][var2]
                end
            end
        end
    end

    for _, value in tbl3 do
        local tbl4 = ({})
        table.insert(result, tbl4)

        for _, value2 in tbl1.mapping do
            local out = value2.out
            local var1 = value[out]

            if typeof(var1) == "table" then
                for _, value3 in var1 do
                    if tbl4[out] then
                        tbl4[out] ..= "," .. tostring(value3)
                    else
                        tbl4[out] = tostring(value3)
                    end
                end
            else
                tbl4[out] = var1
            end
        end
    end

    return result
end

return module
