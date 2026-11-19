-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:34Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function createBrickColorsFromIds(tbl1)
    local brickColorsFromIds = {}
    for _, value in tbl1 do
        local success, result = pcall(BrickColor.new, value)
        if success and result then
            table.insert(brickColorsFromIds, result)
        else
            warn(`createBrickColorsFromIds: Failed to create BrickColor with ID {value}`)
        end
    end
    return brickColorsFromIds
end

return createBrickColorsFromIds
