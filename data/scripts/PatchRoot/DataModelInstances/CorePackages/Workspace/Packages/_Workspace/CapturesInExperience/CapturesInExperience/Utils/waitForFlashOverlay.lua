-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local function waitForFlashOverlay(arg1)
    if not arg1:getState()[Constants.RoduxKey].IsOverlayFlashActive then
        return
    end

    local startTime = tick()

    while arg1:getState()[Constants.RoduxKey].IsOverlayFlashActive and not (tick() - startTime > Constants.FlashTimeout) do
        task.wait()
    end
end

return waitForFlashOverlay
