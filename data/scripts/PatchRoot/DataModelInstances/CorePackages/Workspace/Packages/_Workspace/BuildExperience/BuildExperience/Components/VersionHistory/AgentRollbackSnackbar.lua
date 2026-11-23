-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)

local num1 = game:DefineFastInt("BuildAgentRollbackSnackbarAutoDismissSeconds", 4)

local function AgentRollbackSnackbar(tbl1)
    local var1 = Foundation.Hooks.useOverlay()
    local var2 = Foundation.Hooks.useTokens()

    React.useEffect(function()
        local var3 = task.delay(num1, tbl1.onClose)
        return function()
            task.cancel(var3)
        end
    end, { tbl1.onClose })

    if var1 == nil then
        return nil
    end

    return ReactRoblox.createPortal(
        React.createElement(Foundation.Snackbar, {
            AnchorPoint = Vector2.new(0.5, 1),
            onClose = tbl1.onClose,
            Position = UDim2.new(0.5, 0, 1, -var2.Padding.XLarge),
            testId = "build-agent-rollback-snackbar",
            title = tbl1.title,
            ZIndex = 999
        }),
        var1
    )
end

return AgentRollbackSnackbar
