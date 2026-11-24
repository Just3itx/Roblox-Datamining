-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local useGuiState = require(script.Parent.useGuiState)

local function usePressState(tbl1): boolean
    return useGuiState(tbl1) == Enum.GuiState.Press
end

return usePressState
