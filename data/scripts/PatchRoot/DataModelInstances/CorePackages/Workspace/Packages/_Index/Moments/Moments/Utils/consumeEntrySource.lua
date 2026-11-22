-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function consumeEntrySource(arg1, tbl1)
    if not (arg1 and arg1.getParam) then
        return "watch_tab"
    end

    local param = arg1.getParam("extraProps")
    if type(param) == "table" and type(param.source) == "string" then
        local str1 = `extraProps:{tostring(param)}:{param.source}`
        if not tbl1[str1] then
            tbl1[str1] = true
            return param.source
        end
    end

    local param2 = arg1.getParam("source")
    if type(param2) == "string" then
        local state = arg1.state
        if type(state) == "table" and state.params ~= nil then
            state = state.params
        end

        local str1 = `params:{tostring(state)}:{param2}`
        if not tbl1[str1] then
            tbl1[str1] = true
            return param2
        end
    end

    return "watch_tab"
end

return consumeEntrySource
