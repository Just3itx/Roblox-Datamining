-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function decodeBuildSuggestionsResponse(arg1)
    local chips = if typeof(arg1) == "table" then arg1.chips else nil
    local options = if typeof(chips) == "table" then chips.options else nil

    if typeof(options) ~= "table" then
        error("build suggestions response is missing chips.options")
    end

    local tbl1 = {}
    for _, option in options do
        if typeof(option) == "table" and typeof(option.value) == "string" and option.value ~= "" then
            table.insert(tbl1, { value = option.value })
        end
    end

    return {
        prompt = if typeof(arg1.prompt) == "string" then arg1.prompt else nil,
        chips = tbl1
    }
end
return decodeBuildSuggestionsResponse
